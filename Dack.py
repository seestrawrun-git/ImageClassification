import cv2
import os 
from PIL import Image
import datetime
import time


#from pythonosc.dispatcher import Dispatcher
#from pythonosc import osc_server
#from examples.simple_server import print_compute_handler, print_volume_handler
#from simple_server import print_compute_handler, print_volume_handler


import time

def your_function():
    # Your script here
    print(datetime.datetime.now())    
    directory = 'C:\\echodraw\\'

    for filename in os.listdir(directory):
        f = os.path.join(directory, filename)
        # checking if it is a file
        if os.path.isfile(f):
            print(f)
       

            image = cv2.imread(f)

            qrCodeDetector = cv2.QRCodeDetector()
 
            decodedText, points, _ = qrCodeDetector.detectAndDecode(image)

   
            points = points[0]
 
            if points is not None:
                print(decodedText)       

                # Importing Image module from PIL package
            
                # creating a image object (main image)
                im1 = Image.open(f)
                # save a image using extension
                im1 = im1.save('c:\\zImages\\' + decodedText + "_" + filename)
 
                # Source path
                source = f
                # Destination path
                #destination = "C:\EchoDrawDocs\Old"
                # source to destination
                #dest = shutil.move(source, destination)


                os.remove(f)



                key = cv2.waitKey(10)
             

        else:
                print("QR code not detected")
    



    # parser = argparse.ArgumentParser()
    # parser.add_argument("--ip",default="127.0.0.1", help="The ip to listen on")
    # parser.add_argument("--port",type=int, default=5005, help="The port to listen on")
    # args = parser.parse_args()

    # dispatcher = Dispatcher()
    # dispatcher.map("/filter", print)
    # dispatcher.map("/volume", print_volume_handler, "Volume")
    # dispatcher.map("/logvolume", print_compute_handler, "Log volume", math.log)

    # server = osc_server.ThreadingOSCUDPServer(
    #     (args.ip, args.port), dispatcher)
    # print("Serving on {}".format(server.server_address))
    # server.serve_forever()



while True:
    your_function()
    time.sleep(30)











        
 
