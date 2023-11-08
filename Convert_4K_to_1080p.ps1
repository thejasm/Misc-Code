Add-Type -Assembly System.Drawing
$ffmpegPath = "C:\ProgramData\ffmpeg\bin\ffmpeg.exe"
$folderPath = "C:\xampp\htdocs\images"

$maxWidth = 1920
$maxHeight = 1280

$jpgFiles = Get-ChildItem $folderPath -File -Recurse -Filter *.jpg

foreach ($jpgFile in $jpgFiles) {
    $image = [System.Drawing.Image]::FromFile($jpgFile.FullName)
    $width = $image.Width
    $height = $image.Height

    if ($width -gt $maxWidth -or $height -gt $maxHeight) {
        $outputFileName = "med_" + $jpgFile.Name

        $subfolder = $jpgFile.DirectoryName.Replace($folderPath, "")

        $outputPath = Join-Path $folderPath $subfolder
        $outputPath = Join-Path $outputPath $outputFileName

        & $ffmpegPath -i $jpgFile.FullName -vf "scale=${maxWidth}:${maxHeight}" $outputPath

        Write-Host "Resized $($jpgFile.Name) to $outputPath"
    }
}n