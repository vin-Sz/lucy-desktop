param([string]$Out)
Add-Type -AssemblyName System.Drawing
New-Item -ItemType Directory -Force $Out | Out-Null

$sheets = @(
  @('idle',16,'stand'), @('blink',4,'blink'), @('blink_glitch',4,'blink'), @('mouth',5,'mouth'),
  @('grin',16,'stand'), @('glitch',10,'stand'), @('dangle',24,'stand'), @('sleep',16,'stand'),
  @('wake',13,'stand'), @('walk',12,'stand'), @('arrive',14,'stand'), @('leave',12,'stand'),
  @('perch',16,'perch'), @('perch_blink',4,'pblink'), @('perch_blink_glitch',4,'pblink'),
  @('perch_glitch',10,'perch'), @('perch_arrive',14,'perch'), @('perch_leave',12,'perch')
)
$mouthNames = @('closed','small','small','open','wide')

$border = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(200,120,120,120)), 1
$ground = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(230,230,40,60)), 2
$center = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(160,0,190,210)), 1
$center.DashStyle = 'Dash'
$body = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(170,60,110,230)), 1
$body.DashStyle = 'Dot'
$mouthPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(200,240,140,20)), 1
$text = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(220,90,90,90))
$red = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(230,230,40,60))
$font = New-Object System.Drawing.Font 'Segoe UI', 10
$small = New-Object System.Drawing.Font 'Segoe UI', 8

foreach ($s in $sheets) {
  $name = $s[0]; $count = $s[1]; $kind = $s[2]
  $perch = $kind -eq 'perch' -or $kind -eq 'pblink'
  $fw = if ($perch) { 384 } else { 240 }
  $bmp = New-Object System.Drawing.Bitmap ($fw * $count), 384
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $g.TextRenderingHint = 'AntiAlias'
  for ($i = 0; $i -lt $count; $i++) {
    $x = $i * $fw
    $g.DrawRectangle($border, $x, 0, $fw - 1, 383)
    if ($perch) {
      $g.DrawRectangle($body, $x + 81, 65, 184, 311)
      $g.DrawLine($ground, $x + 85, 303, $x + 145, 303)
      $g.DrawLine($ground, $x + 115, 288, $x + 115, 318)
      $g.FillEllipse($red, $x + 112, 300, 6, 6)
      $g.DrawString('seat', $small, $red, $x + 120, 305)
    } else {
      $g.DrawLine($center, $x + 120, 0, $x + 120, 383)
      $g.DrawRectangle($body, $x + 33, 19, 177, 346)
      $g.DrawLine($ground, $x + 10, 362, $x + 230, 362)
      $g.DrawString('feet', $small, $red, $x + 12, 364)
    }
    if ($kind -eq 'mouth' -or ($name -eq 'idle')) { $g.DrawRectangle($mouthPen, $x + 122, 126, 20, 14) }
    $label = [string]$i
    if ($name -eq 'idle' -and $i -ge 9 -and $i -le 12) { $label = "$i  (blink " + ($i - 9) + ")" }
    if ($name -eq 'perch' -and $i -ge 9 -and $i -le 12) { $label = "$i  (blink " + ($i - 9) + ")" }
    if ($kind -eq 'blink' -or $kind -eq 'pblink') { $label = "$i  = idle " + ($i + 9) }
    if ($kind -eq 'pblink') { $label = "$i  = perch " + ($i + 9) }
    if ($kind -eq 'mouth') { $label = "$i  " + $mouthNames[$i] }
    $g.DrawString($label, $font, $text, $x + 4, 2)
  }
  $g.DrawString($name, $small, $text, 4, 18)
  $g.Dispose()
  $bmp.Save((Join-Path $Out ($name + '.png')), [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
}

$bmp = New-Object System.Drawing.Bitmap 400, 400
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.DrawRectangle($border, 0, 0, 399, 399)
$g.DrawString('face (square portrait)', $font, $text, 4, 2)
$g.Dispose()
$bmp.Save((Join-Path $Out 'face.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
