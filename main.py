import os
import sys
import numpy as np
import shutil
import threading
import time
import random
import tkinter as tk
from tkinter import filedialog
from PIL import Image, ImageTk
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from queue import Queue
from tkinter import messagebox
from pathlib import Path


import tensorflow as tf
import keras
from keras.models import load_model
from keras import applications
from keras.preprocessing import image
from keras.preprocessing.image import ImageDataGenerator
from keras import layers


# ########### baseline stuff ###########
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
keras.DisablePySysConsoleLog=True
DEFAULT_IMAGE_PATH = 'assets/Init.png'
event_queue = Queue()

if getattr(sys, 'frozen', False):
    application_path = sys._MEIPASS
else:
    application_path = os.path.dirname(os.path.abspath(__file__))

def process_queue():
    while not event_queue.empty():
        event = event_queue.get()
        try:
            classify_image(event)
        except Exception as e:
            messagebox.showerror("Error", str(e))
    window.after(100, process_queue)

def initial_image_path(relative_path):
    base_path = getattr(sys, '_MEIPASS', os.path.dirname(os.path.abspath(__file__)))
    return os.path.join(base_path, relative_path)

hard_image_path = initial_image_path('assets/Init.png')

def resource_path(relative_path):
    base_path = getattr(sys, '_MEIPASS', os.path.dirname(os.path.abspath(__file__)))
    return os.path.join(base_path, relative_path)

model_path = resource_path('assets/mercer.h5')
model = keras.models.load_model(model_path)



# ############# Input directory watcher ######################

class Watcher:
    def __init__(self, directory_to_watch):
        self.observer = Observer()
        self.DIRECTORY_TO_WATCH = directory_to_watch

    def run(self):
        event_handler = Handler()
        self.observer.schedule(event_handler, self.DIRECTORY_TO_WATCH, recursive=True)
        self.observer.start()
        try:
            # The observer runs on its own thread, so we don't need a while loop here
            pass
        except Exception as e:
            print(f"Error when watching directory: {e}")
            self.observer.stop()

    def stop(self):
        self.observer.stop()
        self.observer.join()

def start_watching():
    directory_path = filedialog.askdirectory()
    if directory_path:
        watcher = Watcher(directory_path)
        # Run the watcher in a separate thread to prevent blocking the Tkinter main loop
        watch_thread = threading.Thread(target=watcher.run)
        watch_thread.start()
        # You should also keep track of the watcher and the thread to be able to stop them later



class Handler(FileSystemEventHandler):
    def on_created(self, event):
        if not event.is_directory:
            # Generate an absolute path from the normalized path
            time.sleep(1)
            normalized_path = os.path.normpath(event.src_path)
            unmixed_path = str(Path(normalized_path))
            print(f"Received created event - {unmixed_path}")
            event_queue.put(unmixed_path)

    #def on_any_event(self, event):
        #if event.is_directory:
          #  return None

      #  if event.event_type == 'created':
           # # Assuming you want to print to the console, make sure you have the correct indentation
            #print(f"Received created event - {event.src_path}")
            # Call the classify_image function with the path of the created file
            #classify_image(event.src_path)


#global output dir
output_directory = None

def set_output():
    global output_directory
    output_directory = filedialog.askdirectory()
    if output_directory:
        output_dir_button['text'] = f'Output directory: {output_directory}'
    else:
        output_dir_button['text'] = 'No output directory selected'


# Function to load and preprocess the image
def load_image(img_path, target_size=(1024, 791)):
    img = image.load_img(img_path, target_size=target_size, color_mode='rgb')
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)  # Add batch dimension
    img_array /= 255.0  # Normalize
    return img_array


# ############ Class Names - set index to name ###############################
#class_names = ['Ducky', 'Froggy', 'Mushroom', 'Piggy', 'Turtle', 'Unicorn']
class_names = ['Birdo', 'Chimera', 'Dino', 'Fox', 'Panda', 'Penguin', 'Wolf']

# ########### Main Utility #####################
# Load the model
#model = keras.models.load_model('assets/mercer.h5')



# #################### Create a window ###################


window = tk.Tk()



window.title('Mercer Labs Classifier - Two Soups Studios')
window.geometry('800x395')
canvas = tk.Canvas(window, bg='skyblue')
canvas.place(relwidth=1, relheight=1)  # Make the canvas expand to the full window





image_label = tk.Label(window)
image_label.pack(pady=10)

# ############# Initialize Placeholder image for window #################
def init_image(image_path=hard_image_path, size=(250, 250)):
    if image_path:
        # Load an existing image
        img = Image.open(image_path)
    else:
        # Create a placeholder image
        img = Image.new('RGB', size, color='grey')
    img = img.resize(size, Image.Resampling.LANCZOS)
    img_tk = ImageTk.PhotoImage(img)
    image_label.config(image=img_tk)
    image_label.image = img_tk  # Keep a reference



init_image(size=(256, 198))  # Specify the size you want or provide a path to an existing image


# ################# Create a label to display the instructions #############

# Create a label to display the result
result_label = tk.Label(
    window,
    text='Result will be shown here',
    font=("Helvetica", 12),
    bg='skyblue',
    fg='white')
result_label.pack(pady=5)
instruction_label = tk.Label(
    window,
    text='Set the Watch and Output Directories to Populate Incoming Scans into Unreal Watch Folder',
    font=("Helvetica", 12),
    bg='skyblue',
    fg='white')
instruction_label.pack(pady=5)

# Create a label to display the image
#image_label = tk.Label(window)
#image_label.pack()



# Function to make a prediction and display the image


# ################### Main Classification Loop ###########################

def classify_image(path):
    try:
        # If a path is not provided, open a file dialog to allow the user to select a file
        if path is None:
            path = filedialog.askopenfilename()
            if not path:  # If the user cancelled the operation, do nothing.
                return

        # Load the image from the provided path
        img_array = load_image(path)
        predictions = model.predict(img_array)
        predicted_class_index = np.argmax(predictions, axis=1)[0]
        predicted_class_name = class_names[predicted_class_index]

        # Update the result label in the GUI with the predicted class
        result_label['text'] = f'Exported predicted class: {predicted_class_name}'

        # Check if an output directory has been set, otherwise use a default path
        target_directory = output_directory if output_directory else r'C:\Default\Path'
        if not os.path.exists(target_directory):
            os.makedirs(target_directory)

        # Create a new filename for the classified image
        base_filename = os.path.basename(path)
        filename_without_ext, ext = os.path.splitext(base_filename)
        new_filename = f"{filename_without_ext}-{predicted_class_name}{ext}"
        save_path = os.path.join(target_directory, new_filename)

        # Attempt to save the classified image to the target directory
        try:
            shutil.copy(path, save_path)
            #result_label['text'] += f'\nImage saved as {new_filename} to {save_path}'
        except PermissionError as perm_err:
            # Handle the permission error
            result_label['text'] += f'\nPermission denied error: {perm_err}'
            # Here you might want to log the error or provide a message to the user
        except Exception as e:
            # Handle other exceptions that might occur
            result_label['text'] += f'\nAn error occurred: {e}'

        # Display the image in the GUI
        # ... Inside classify_image function, after shutil.copy(path, save_path)

        # Display the new classified image in the GUI
        img = Image.open(path)
        img = img.resize((256, 198), Image.Resampling.LANCZOS)  # Resize for display
        img_tk = ImageTk.PhotoImage(img)
        image_label.config(image=img_tk)
        image_label.image = img_tk  # Keep a reference to avoid garbage collection


    except Exception as e:
        result_label['text'] = f'Error: {e}'





# ######################## GUI Buttons ################################

def on_enter_output(e):
    output_dir_button['background'] = 'green'

def on_leave_output(e):
    output_dir_button['background'] = 'white'

def on_enter_watch(e):
    watch_button['background'] = 'green'

def on_leave_watch(e):
    watch_button['background'] = 'white'

output_dir_button = tk.Button(window, text='Set Output Directory', highlightcolor='red', command=set_output)
output_dir_button.pack(fill=tk.X, pady=5)
output_dir_button.bind("<Enter>", on_enter_output)
output_dir_button.bind("<Leave>", on_leave_output)

watch_button = tk.Button(window, text='Start Watching Directory', command=start_watching)
watch_button.pack(fill=tk.X, pady=5)
watch_button.bind("<Enter>", on_enter_watch)
watch_button.bind("<Leave>", on_leave_watch)


classify_button = tk.Button(window, text='Classify Image', command=classify_image)
classify_button.pack(fill=tk.X, pady=5)



# Start the GUI event loop
window.after(100, process_queue)
window.mainloop()
