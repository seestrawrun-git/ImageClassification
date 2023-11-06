// Fill out your copyright notice in the Description page of Project Settings.

#pragma once
#include "Engine/World.h"
#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "PhotoRead.generated.h"

UCLASS()
class ECHO_API APhotoRead : public AActor
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	APhotoRead();
	virtual void Tick(float DeltaTime) override;

	UPROPERTY(EditAnywhere, Category = "Spawning")
	TArray<TSubclassOf<AActor>> ActorsToSpawn;

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

private:
	FString DirectoryToWatch;
	TArray<FString> CurrentFiles;
	
	void CheckForNewImages();
	UTexture2D* CreateTextureFromImage(const FString& ImagePath);
	int32 GetActorIndexToSpawn(const FString& ClassName);

};
