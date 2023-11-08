$avifencPath = "C:\ProgramData\ffmpeg\bin\avifenc.exe"
$folderPath = "C:\xampp\htdocs\images\banners"

$jpgFiles = Get-ChildItem $folderPath -File -Recurse -Filter *.jpg

foreach ($jpgFile in $jpgFiles) {
    $outputFileName = [System.IO.Path]::ChangeExtension($jpgFile.Name, "avif")
    $avifOutputPath = [System.IO.Path]::Combine($jpgFile.DirectoryName, $outputFileName)

    & $avifencPath $jpgFile.FullName $avifOutputPath

    Write-Host "Created AVIF copy for $($jpgFile.Name) at $avifOutputPath"
}
