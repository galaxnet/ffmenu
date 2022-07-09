@ECHO OFF
IF "%%1"=="/?" ECHO Drag one or more files to the batch file and they become & ECHO the input for the ffmpeg command executed through the software. & GOTO EOF
CLS
COLOR BD

:MAINMENU
CALL :FLAIR
ECHO 1 - Convert File
ECHO 2 - Play File
ECHO 3 - Other Features
ECHO 4 - Install
ECHO e - Exit
SET /P M1=Type a number then press ENTER:
IF %M1%==1 CALL :CONVERT %*
IF %M1%==2 ffplay %*
IF %M1%==3 CALL :MENU %*
IF %M1%==4 CALL :INSTALL
GOTO MAINMENU

:MENU
CALL :FLAIR
ECHO OTHER FEATURES
ECHO.
ECHO 1 - Audio Editing and Conversions
ECHO 2 - Photo Editor
ECHO 3 - Normalize Video Color
ECHO 4 - Join all Mp4 in Directory
ECHO 5 - Extract All Frames to JPG
ECHO 6 - Create Mp4 from Frames (PNG)
ECHO 7 - JPEG Slideshow (4 second per image)
ECHO 8 - Scaling Menu
ECHO 9 - Crossfade
ECHO 10 - Add Credits
ECHO 11 - Bump Generator
ECHO 12 - Deshake Video
ECHO 13 - Stabilize Video
ECHO 14 - GIF Conversions
ECHO 15 - Split to Scenes
ECHO 16 - Test LUTs on Video (from lut folder)
ECHO 17 - Apply LUT to video
ECHO 18 - Extract All Frames to PNG
ECHO 19 - Burn Subtitles
ECHO 20 - ZoomPan > Image
ECHO 21 - Portrait to Landscape w/ Blurred Background
ECHO e - EXIT
ECHO.
SET /P M2=Type a number then press ENTER:
IF %M2%==1 CALL :AUDIOMENU %*
IF %M2%==2 CALL :PHOTOEDIT %*
IF %M2%==3 CALL :NORMAL %*
IF %M2%==4 CALL :JOINALLMP4 %*
IF %M2%==5 CALL :EXRACTJPG %*
IF %M2%==6 CALL :MP4SLIDESHOW %*
IF %M2%==7 CALL :JPEGSLIDESHOW %*
IF %M2%==8 CALL :SCALINGMENU %*
IF %M2%==9 CALL :CROSSFADE %*
IF %M2%==10 CALL :ADDCREDITS %*
IF %M2%==11 CALL :BUMPGEN %*
IF %M2%==12 CALL :DESHAKE %*
IF %M2%==13 CALL :STABILIZE %*
IF %M2%==14 CALL :GIFMENU %*
IF %M2%==15 CALL :SCENEDETECT %*
IF %M2%==16 CALL :TESTLUT %*
IF %M2%==17 CALL :APPLYLUT %*
IF %M2%==18 CALL :EXTRACTPNG %*
IF %M2%==19 CALL :SUBTITLEBURN %*
IF %M2%==20 CALL :ZOOMPANIMG %*
IF %M2%==21 CALL :NEWSSTYLE %*
IF %M2%==e GOTO EOF
GOTO MENU

:INSTALL
CALL :FLAIR
MD c:\FFmenu
COPY ffmpeg.exe c:\FFmenu
COPY ffplay.exe c:\FFmenu
COPY ffprobe.exe c:\FFmenu
COPY ffmenu.bat c:\FFmenu
ECHO CALL c:\FFmenu\ffmenu %* > "%HOMEPATH%\AppData\Roaming\Microsoft\Windows\SendTo\ffmenu_.bat"
EXIT /B 0

:AUDIOMENU
CALL :FLAIR
ECHO AUDIO MENU
ECHO.
ECHO 1 - Extract Video Audio to Mp3
ECHO 2 - Convert Audio File to Mp4
ECHO 3 - Combine Audio from Mp3
ECHO 4 - Remove Audio from Mp4
ECHO 5 - Add Audio from 2nd Mp4 to First
ECHO 6 - Normalize Audio (without video reencode)
ECHO 7 - Convert MP3 to Vaporwave
ECHO e - EXIT
ECHO.
SET /P M3=Type a number then press ENTER:
IF %M3%==1 CALL :EXTRACTAUDIO %*
IF %M3%==2 CALL :ADDAUDIO %*
IF %M3%==3 CALL :COMBINEAUDIO %*
IF %M3%==4 CALL :REMOVEAUDIO %*
IF %M3%==5 CALL :COMBINEMP4AUDIO %*
IF %M3%==6 CALL :NORMALIZEAUDIO %*
IF %M3%==7 CALL :VAPORWAVE %*
IF %M3%==e GOTO EOF
EXIT /B 0

:PHOTOEDIT
ECHO 1 - Preview LUTs on Photo
ECHO 2 - Denoise Photo (hqdn3d - Fast)
ECHO 3 - Supersample + Denoise (nlmeans - Good)
ECHO 4 - Block Matching Denoise (bm3d - Best)
ECHO 5 - Add Grain to Photo
ECHO 6 - Curves Presets (vintage, etc.)
ECHO 7 - Scale + Crop (Landscape)
ECHO.
SET /P MP=Type a number then press ENTER:
IF %MP%==1 CALL :TESTLUTPHOTO %*
IF %MP%==2 CALL :PHOTODENOISE %*
IF %MP%==3 CALL :PHOTODENOISESUPER %*
IF %MP%==4 CALL :PHOTODENOISEBM3D %*
IF %MP%==5 CALL :PHOTOADDNOISE %*
IF %MP%==6 CALL :PHOTOCURVES %*
IF %MP%==7 CALL :SCALECROPL %*
EXIT /B 0

:GIFMENU
CALL :FLAIR
ECHO ANIMATED GIFS MENU
ECHO.
ECHO 1 - Convert GIF to Mp4
ECHO 2 - Convert Video to GIF (Fast)
ECHO 3 - Convert Video to GIF (High Quality)
ECHO 4 - Split GIF to Frames (PNG)
ECHO e - EXIT
ECHO.
SET /P M4=Type a number then press ENTER:
IF %M4%==1 CALL :GIF2VID
IF %M4%==2 CALL :VID2GIFFAST %*
IF %M4%==3 CALL :VID2GIFHIGH %*
IF %M4%==4 CALL :GIF2FRAMES %*
IF %M4%==e GOTO EOF
EXIT /B 0

:SCALINGMENU
CALL :FLAIR
ECHO SCALING MENU
ECHO.
ECHO 1 - Scale to 1080 (16:9)
ECHO 2 - Scale to 720 (16:9)
ECHO 3 - Scale to 720 (4:3)
ECHO 4 - Scale to 480 (4:3)
ECHO 5 - Scale to 360 (4:3)
ECHO 6 - Scale to 360 (16:9)
ECHO 7 - Scale to 720 + Center Crop 
ECHO m - MAIN MENU
ECHO e - EXIT
ECHO.
SET /P M5=Type a number then press ENTER:
IF %M5%==1 ffmpeg -i %* -vf scale=1920x1080:flags=lanczos %~n1_1080p%~x1
IF %M5%==2 ffmpeg -i %* -vf scale=1280x720:flags=lanczos %~n1_720p%~x1
IF %M5%==3 ffmpeg -i %* -vf scale=960x720:flags=lanczos %~n1_720%~x1
IF %M5%==4 ffmpeg -i %* -vf scale=640x480:flags=lanczos %~n1_640%~x1 
IF %M5%==5 ffmpeg -i %* -vf scale=480x360:flags=lanczos %~n1_360%~x1
IF %M5%==6 ffmpeg -i %* -vf scale=640x360:flags=lanczos %~n1_360p%~x1
IF %M5%==7 ffmpeg -i %* -vf "scale=(iw*sar)*max(720/(iw*sar)\,480/ih):ih*max(720/(iw*sar)\,480/ih), crop=720:480" -c:a copy "%~n1_CenterCrop%~x1"
IF %M5%==m GOTO MENU
IF %M5%==e GOTO EOF
EXIT /B 0

:CONVERT
CLS
CALL :FLAIR
SET /P EXT=What file extension do you want? (PRESS ENTER)
FFmpeg -i %* "%~n1_converted.%EXT%"
EXIT /B 0

:EXTRACTAUDIO
ffmpeg -i %* %~n1_audio.mp3
EXIT /B 0

:EXTRACTPNG
SET FOLDERNAME="%date:~10%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%"
MD "%FOLDERNAME%"
FFMPEG -i %* "%FOLDERNAME%\frame%%04d.png" -hide_banner
EXIT /B 0

:EXTRACTJPG
SET FOLDERNAME=%date:~10%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%
MD %FOLDERNAME%
FFMPEG -i %* %FOLDERNAME%\frame%%04d.jpg -hide_banner
EXIT /B 0

:NORMAL
ffmpeg -i %* -vf "normalize=strength=1" %~n1_normalized.mp4 
EXIT /B 0

:ADDAUDIO
ffmpeg -i %* -i audio.mp3 -map 0:0 -map 1:a -c:v copy -shortest %~n1_output.mp4
EXIT /B 0

:COMBINEAUDIO
ffmpeg -i %* -i audio.mp3 -filter_complex "[0:a][1:a]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest %~n1_combined.mp4
EXIT /B 0

:REMOVEAUDIO
ffmpeg -i %* -c:v copy -an %~n1_silent.mp4
EXIT /B 0

:COMBINEMP4AUDIO
ffmpeg -i video.mp4 -i video2.mp4 -map 0:0 -map 1:1 -c:v copy -shortest %~n1_combined.mp4
EXIT /B 0

:JOINALLMP4
(for %%i in (*.mp4) do @echo file '%%i') > mylist.txt
ffmpeg -f concat -i mylist.txt -c copy %~n1_combined.mp4
del /q mylist.txt
EXIT /B 0

REM -- LUTs --
:TESTLUT
REM LUTs as .CUBES stored in LUT subdirectory
mkdir out
for %%f in (lut/*.CUBE) do (
echo Processing %%~nf
ffmpeg -ss 15 -v error -hide_banner -y -i %* -vf lut3d="lut/%%~nxf" -frames:v 1 "out/%%~nf_1.jpg"
rem Uncomment for additional frame
rem ffmpeg -sseof -10 -v error -hide_banner -y -i in.mp4 -vf lut3d = "lut/%%~nxf" -frames:v 1 "out/%%~nf_2.jpg"
)
EXIT /B 0

:APPLYLUT
REM Change "medium" to slow, slower, or veryslow for higher quality video
SET /P LUT=Type the name of the LUT the press ENTER (no extension):
ffmpeg -i %* -vf hqdn3d=6,unsharp=5:5:0.5:7:7:0.5,scale=1920x1080:flags=lanczos,lut3d=file="lut/%LUT%.CUBE" -c:a copy -c:v libx264 -crf 22 -preset medium "%~n1_%LUT%.mp4"
EXIT /B 0

:TESTLUTPHOTO
REM LUTs as .CUBES stored in LUT subdirectory
mkdir out
for %%f in (lut/*.CUBE) do (
echo Processing %%~nf
ffmpeg -hide_banner -y -i %* -vf lut3d="lut/%%~nxf",scale=640x360:flags=lanczos,drawtext=text="%%~nf":x=w*0.75:y=h*0.9:fontsize=18:fontcolor=yellow@1 "out/%%~nf_1.png"
)
EXIT /B 0

:PHOTOADDNOISE
REM Add noise with noise filter
SET /P GRAIN=How much grain to add?(1-200)
ffmpeg -hide_banner -i %* -vf noise=alls=20:allf=t+u -q:v 4 "%~n1_NOISE%~x1"
EXIT /B 0

:PHOTOCURVES
REM Denoise photos with hqdn3d
CLS
ECHO Presets: color_negative, cross_process, darker, lighter, negative, vintage
ECHO increase_contrast, linear_contrast, medium_contrast, strong_contrast
SET /P CURVEPRESET=Which preset?
ffmpeg -hide_banner -i %* -vf curves=%CURVEPRESET% -q:v 2 "%~n1_%CURVEPRESET%%~x1"
EXIT /B 0

:PHOTODENOISE
REM Denoise photos with hqdn3d
SET /P DEN=How much denoise?(1-200)
ffmpeg -hide_banner -i %* -vf hqdn3d=%DEN% -q:v 1 "%~n1_DENOISE%~x1"
EXIT /B 0

:PHOTODENOISEBM3D
REM Denoise photos with bm3d, block matching
SET /P DEN=How much denoise?(1-999)
ffmpeg -hide_banner -i %* -vf split[a][b],[a]nlmeans=s=3:r=7:p=3[a],[b][a]bm3d=sigma=%DEN%:block=4:bstep=2:group=16:estim=final:ref=1 -q:v 1 "%~n1_DENOISE%~x1"
EXIT /B 0

:PHOTODENOISESUPER
REM Denoise photos with hqdn3d
SET /P WEIGHT=nlmeans weight?(1-30)
SET /P SUPER=Supersample rate?(1 for none, 2, or 4)
ffmpeg -hide_banner -i %* -vf scale=(iw*%SUPER%):(ih*%SUPER%) -q:v 1 "denoise1.png"
ffmpeg -hide_banner -i "denoise1.png" -vf nlmeans=%WEIGHT%:51 -q:v 1 "denoise2.png"
ffmpeg -hide_banner -i "denoise2.png" -vf scale=(iw/%SUPER%):(ih/%SUPER%) -q:v 1 "%~n1_DENOISE%~x1"
del /q "denoise1.png"
del /q "denoise2.png"
EXIT /B 0

:SCALECROPL
REM Scale a landscape photo or video by width, the crop the height, all from center.
CLS
SET /P VWIDTH=What Width?
SET /P VHEIGHT=What Height?
ffmpeg -hide_banner -i %* -vf scale=%VWIDTH%:-1:flags=lanczos, crop=%VWIDTH%:%VHEIGHT% out.jpg
EXIT /B 0

:SUBTITLEBURN
SET /P SUBS=Enter subtitle name and extension (Press Enter):
ffmpeg -hide_banner -i "%SUBS%" subtitle.ass
ffmpeg -i %* -vf "ass=subtitle.ass" "%~n1_SUBS%~x1"
EXIT /B 0

:MP4SLIDESHOW
ffmpeg -i %%* slideshow.mp4
REM (for %%i in (slideshow\*.*) do @echo file '%%i') > mylist.txt
REM ffmpeg -r 1/5 concat -i mylist.txt -c:v libx264 -vf fps=25 -pix_fmt yuv420p out.mp4
EXIT /B 0

:JPEGSLIDESHOW
REM Create short format image list
for %%a in (*.jpg) do (
    echo file '%%a' >> images.txt
)
REM Create MP4 at 1 frame every 4 seconds (0.25)
ffmpeg.exe -r 0.25 -f concat -i images.txt -c:v libx264 -pix_fmt yuv420p -r 0.25 slideshow.mp4 -y
del /q images.txt
ffmpeg -i slideshow.mp4 -i audio.mp3 -map 0:0 -map 1:a -c:v copy -shortest slideshow_wmusic.mp4
del /q slideshow.mp4
EXIT /B 0

:NORMALIZEAUDIO
REM Normalize audio, without vide re-encode.
ffmpeg -y -i %* -c:v copy -pass 1 -c:a aac -b:a 256k -f mp4 null
ffmpeg -i %* -c:v copy -pass 2 -c:a aac -b:a 256k %~n1_loudnorm.mp4

:PNGSLIDESHOW
REM Create short format image list
for %%a in (*.png) do (
    echo file '%%a' >> images.txt
)
REM Create MP4 at 24fps
ffmpeg.exe -r 24 -f concat -i images.txt -c:v libx264 -pix_fmt yuv420p -r 24 slideshow.mp4 -y
del /q images.txt
ffmpeg -i slideshow.mp4 -i audio.mp3 -map 0:0 -map 1:a -c:v copy -shortest slideshow_wmusic.mp4
del /q slideshow.mp4
EXIT /B 0

:TESTPATTERN
ffmpeg -f lavfi \ -i "testsrc=size=320x260[out0];aevalsrc=random(0)/20[out1]" \ -t 0:0:30 -pix_fmt yuv420p \ testpattern.mp4
EXIT /B 0

:COLORSOURCE
ffmpeg -f lavfi -i color=c=darkblue:size=960x720:rate=30 -t 10 colorsource.mp4
ffmpeg -i colorsource.mp4 -filter_complex "drawtext=testtesttest:x=main_w/2 - text_w/2:y=main_h/2 - text_h/2:fontfile=Roboto-Regular.ttf:fontsize=24:fontcolor=000000" colorsource2.mp4
EXIT /B 0

:MANDELBROT
REM Generates a fractal animation. Default is long.
ffmpeg -f lavfi -i mandelbrot mandelbrot.mp4
EXIT /B 0

:CROSSFADE
REM Takes 2 videos and crossfades them. Videos should be 40 seconds, fade starts at 30.
ffmpeg -i %1 -i %2 -filter_complex xfade=transition=fade:duration=10:offset=30 %~n1_crossfade.mp4
EXIT /B 0

:ADDCREDITS
REM Add upward scrolling text to clip.
ffmpeg -i %1 -vf "drawtext=textfile=credits.txt: x=100: y=h-20*t: fontsize=18:fontcolor=yellow@0.9: box=1: boxcolor=black@0.1" -c:a copy %~n1_credits.mp4
EXIT /B 0

:BUMPGEN
REM x0 and x1 set the angle of the linear gradient.
REM y0 appears to determine width of c0. y1 appears to be width of gradient effect.
ffmpeg -f lavfi -i "gradients=s=360x240: n=3: c0=darkblue: c1=darkorange: c2=darkorange: r=30: d=30: x0=0: x1=0: y0=50: y1=200: speed=0.00001" output.mp4
ffmpeg -i output.mp4 -i music.mp3 -map 0:0 -map 1:a -c:v copy -shortest output2.mp4
ffmpeg -i output2.mp4 -vf "drawbox=x=iw/10:y=ih/5:w=iw*0.8:h=ih*0.6:color=purple@0.5:t=fill" output3.mp4
ffmpeg -i output3.mp4 -vf "drawtext=textfile=credits.txt: x=w/10: y=h-8*t: fontsize=12:fontcolor=yellow@0.9: box=1: boxcolor=darkblue@0.9" -c:a copy outputcredits.mp4
EXIT /B 0

:BUMPSCROLLER
ffmpeg -f lavfi -i "gradients=s=360x240: n=3: c0=darkblue: c1=darkorange: c2=darkorange: r=30: d=30: x0=160: y0=0: x1=160: y1=240: speed=0.00001" output.mp4
ffmpeg -i output.mp4 -i music.mp3 -map 0:0 -map 1:a -c:v copy -shortest output2.mp4
ffmpeg -i output2.mp4 -vf "drawtext=textfile=credits.txt: x=w/10: y=h-8*t: fontsize=18:fontcolor=yellow@0.9: box=1: boxcolor=darkblue@0.5" -c:a copy outputcredits.mp4
EXIT /B 0

:DESHAKE
ffmpeg -i %* -vf deshake %~n1_deshake%~x1
EXIT /B 0

:STABILIZE
ffmpeg -i %* -vf vidstabdetect -f null -
ffmpeg -i %* -vf vidstabtransform,unsharp=5:5:0.8:3:3:0.4 %~n1_stabilized%~x1
EXIT /B 0

:GIF2VID
REM movflags and faststart optimize for web, math and vf ensure MP4 compatibility.
ffmpeg -i %* -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" %~n1_video.mp4
EXIT /B 0

:SCENEDETECT
ffmpeg -y -i %* -vf yadif -c:v libx264 -profile:v high -preset:v fast -x264opts min-keyint=15:keyint=1000:scenecut=1 -b:v 2000k -c:a aac -b:a 128k -f segment -segment_format mp4 -segment_time 0.01 -segment_format_options movflags=faststart output%%05d.mp4
EXIT /B 0

:VAPORWAVE
ffmpeg -i %* -af atempo=0.75 tempo.mp3
ffmpeg -i tempo.mp3 -af chorus=0.7:0.9:55:0.4:0.25:2 chorus.mp3
ffmpeg -i chorus.mp3 -af aecho=0.8:0.88:60:0.4 "%~n1_vapor.mp3"
del /q tempo.mp3
del /q chorus.mp3
EXIT /B 0

:VID2GIFFAST
ffmpeg -ss 61.0 -t 2.5 -i %* -filter_complex "[0:v] fps=12,scale=480:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" %~n1_fast.gif
EXIT /B 0

:VID2GIFHIGH
ffmpeg -ss 61.0 -t 2.5 -i %* -filter_complex "[0:v] fps=12,scale=w=480:h=-1,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1" %~n1_high.gif
EXIT /B 0

:GIF2FRAMES
ffmpeg -i %* -vsync 0 temp%d.png
EXIT /B 0

:ZOOMPANIMG
REM SET /P ZOOM=Zoom percentage (Press Enter)?
ffmpeg -i %* -filter_complex zoompan=z='zoom+0.002':d=25*4 %~n1.mp4
EXIT /B 0

:NEWSSTYLE
CLS
ffmpeg -i %* -vf "split[original][copy];[copy]scale=ih*16/9:-1,crop=h=iw*9/16,gblur=sigma=20[blurred];[blurred][original]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" %~n1_newsstyle%~x1
EXIT /B 0

:FLAIR
ECHO  ______ ______ __    __  ______  __   __  __  __   
ECHO /\  ___/\  ___/\ "-./  \/\  ___\/\ "-.\ \/\ \/\ \  
ECHO \ \  __\ \  __\ \ \-./\ \ \  __\\ \ \-.  \ \ \_\ \ 
ECHO  \ \_\  \ \_\  \ \_\ \ \_\ \_____\ \_\\"\_\ \_____\
ECHO   \/_/   \/_/   \/_/  \/_/\/_____/\/_/ \/_/\/_____/
ECHO.
EXIT /B 0

:EOF
EXIT
