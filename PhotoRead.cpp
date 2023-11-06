// Fill out your copyright notice in the Description page of Project Settings.


#include "PhotoRead.h"
#include "HAL/FileManager.h"
#include "Misc/Paths.h"
#include "Runtime/ImageWrapper/Public/IImageWrapper.h"
#include "Runtime/ImageWrapper/Public/IImageWrapperModule.h"
#include "Runtime/Engine/Classes/Materials/MaterialInstanceDynamic.h"

// Sets default values
APhotoRead::APhotoRead()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

	DirectoryToWatch = FPaths::ProjectDir() / TEXT("ImportedPhotos/");

}

// Called when the game starts or when spawned
void APhotoRead::BeginPlay()
{
	Super::BeginPlay();
	IFileManager::Get().FindFiles(CurrentFiles, *DirectoryToWatch, TEXT("*.png"));

	if (GetWorld())
	{
		GEngine->AddOnScreenDebugMessage(3, 4.f, FColor::Silver, TEXT("Hello"));
	}
	
}

// Called every frame
void APhotoRead::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
	CheckForNewImages();

}

void APhotoRead::CheckForNewImages()
{
	TArray<FString> NewFiles;
	IFileManager::Get().FindFiles(NewFiles, *DirectoryToWatch, TEXT("*.png"));

	for (const FString& File : NewFiles)
	{
		if (!CurrentFiles.Contains(File))
		{
			FString ClassName;
			FString BaseFilename = FPaths::GetBaseFilename(File); // Gets the filename without extension
			BaseFilename.Split(TEXT("-"), nullptr, &ClassName); // Assumes the class name is appended after "-"

			// Find the index corresponding to the ClassName
			int32 ActorIndex = GetActorIndexToSpawn(ClassName);

			if (ActorIndex != INDEX_NONE)
			{
				UWorld* World = GetWorld();
				if (World != nullptr)
				{
					FVector Location(0.f, 0.f, 0.f);
					FRotator Rotation(0.f, 0.f, 0.f);

					// Spawn the actor at the found index
					AActor* SpawnedActor = World->SpawnActor<AActor>(ActorsToSpawn[ActorIndex], Location, Rotation);
					// Additional logic to initialize the actor goes here...

					if (SpawnedActor)
					{
						// Get the Skeletal Mesh Component from the spawned actor
						USkeletalMeshComponent* SkeletalMeshComponent = Cast<USkeletalMeshComponent>(SpawnedActor->GetComponentByClass(USkeletalMeshComponent::StaticClass()));
						if (SkeletalMeshComponent)
						{
							// Get the material from the skeletal mesh component
							UMaterialInterface* Material = SkeletalMeshComponent->GetMaterial(0);
							UMaterialInstanceDynamic* MaterialInstance = UMaterialInstanceDynamic::Create(Material, nullptr);
							if (MaterialInstance)
							{
								UTexture2D* LoadedTexture = CreateTextureFromImage(DirectoryToWatch + File);
								if (LoadedTexture)
								{
									// Set the texture parameter value on the material instance
									MaterialInstance->SetTextureParameterValue(TEXT("Texture"), LoadedTexture);
									// Apply the dynamic material instance to the skeletal mesh component
									SkeletalMeshComponent->SetMaterial(0, MaterialInstance);
								}
							}
						}
					}
				}
			}

			if (GetWorld()) {
				GEngine->AddOnScreenDebugMessage(1, 30.f, FColor::Red, TEXT("New File"));
			}
				UE_LOG(LogTemp, Warning, TEXT("New File"));

				
				CurrentFiles.Add(File);
		}
	}
}

UTexture2D* APhotoRead::CreateTextureFromImage(const FString& ImagePath)
{
	IImageWrapperModule& ImageWrapperModule = FModuleManager::LoadModuleChecked<IImageWrapperModule>(FName("ImageWrapper"));
	TSharedPtr<IImageWrapper> ImageWrapper = ImageWrapperModule.CreateImageWrapper(EImageFormat::PNG);

	TArray<uint8> RawFileData;
	if (FFileHelper::LoadFileToArray(RawFileData, *ImagePath))
	{
		if (ImageWrapper->SetCompressed(RawFileData.GetData(), RawFileData.Num()))
		{
			TArray<uint8> UncompressedData; // Remove const qualifier
			ERGBFormat Format = ERGBFormat::BGRA;
			int32 BitDepth = 8;

			if (ImageWrapper->GetRaw(Format, BitDepth, UncompressedData)) // Remove 'const' qualifier
			{
				UTexture2D* Texture = UTexture2D::CreateTransient(ImageWrapper->GetWidth(), ImageWrapper->GetHeight());
				if (Texture)
				{
					FTexturePlatformData* PlatformData = Texture->GetPlatformData(); // Use GetPlatformData()
					void* TextureData = PlatformData->Mips[0].BulkData.Lock(LOCK_READ_WRITE);
					FMemory::Memcpy(TextureData, UncompressedData.GetData(), UncompressedData.Num()); // Use '.' instead of '->' and provide all arguments
					PlatformData->Mips[0].BulkData.Unlock();

					// Update the texture resource
					Texture->UpdateResource();

					return Texture;
				}
			}
		}
	}

	return nullptr;
}

int32 APhotoRead::GetActorIndexToSpawn(const FString& ClassName)
{
	// Logic to find the index of the actor class based on ClassName
	// For example, you could use a map of class names to indices that you set up in the editor
	for (int32 i = 0; i < ActorsToSpawn.Num(); ++i)
	{
		if (ActorsToSpawn[i]->GetName().Contains(ClassName))
		{
			return i;
		}
	}

	return INDEX_NONE; // Return INDEX_NONE if no matching class name is found
}
