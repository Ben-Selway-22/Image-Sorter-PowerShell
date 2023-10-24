$path = Read-Host "Enter the path of the folder which contains the photos"

write-host -f yellow "If below is blank script will default to .RAF file extension commonly used with Fujifilm cameras"
$rawFileExtension = Read-Host "Enter the file extension of your raw photos"

#Constants

#Get files only
$itemsFromFolder = Get-ChildItem -Path $path -File

$rawFolderName = "Raw"
$jpegFolderName = "Jpeg"

$rawPath = "$path\$rawFolderName"
$jpegPath = "$path\$jpegFolderName"

$rawFolderExists = Test-Path -Path $rawPath
$jpegFolderExists = Test-Path -Path $jpegPath

#End of Constants


write-host Found $itemsFromFolder.Count items in Path: $path

if($rawFolderExists -eq $False){
	#Make RAW Folder
	New-Item -Path $path -Name $rawFolderName -ItemType "directory"
}
else{
	write-host "$rawFolderName folder already exists not making folder"
}

if($jpegFolderExists -eq $False){
	#Make Jpeg Folder
	New-Item -Path $path -Name $jpegFolderName -ItemType "directory"
}
else{
	write-host "$jpegFolderName folder already exists not making folder"
}

if($itemsFromFolder.Count -Eq 0){
	write-error No items detected in path: $path
	write-host -f red "Stopping script"
	return
}

foreach($item in $itemsFromFolder){
	
	$filePath = "$path\$item"
	
	if($item.Name -Match ".JPG"){
		write-host Moving $item.Name to Jpeg folder
		Move-Item -Path $filePath -Destination $jpegPath
	}
	
	if([string]::IsNullOrWhitespace($rawFileExtension)){
		if($item.Name -Match ".RAF"){
			write-host Moving $item.Name to Raw folder
			Move-Item -Path $filePath -Destination $rawPath
		}
	}
	else {	
		if($item.Name.ToLower() -Match $rawFileExtension.ToLower()){
			write-host Moving $item.Name to Raw folder
			Move-Item -Path $filePath -Destination $rawPath
		}
	}
}






