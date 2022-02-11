@ECHO OFF
IF "%%1"=="/?" ECHO Drag one or more files to the batch file and they become & ECHO the input for the ffmpeg command executed through the software. & GOTO EOF
CLS
COLOR BD

:FLAIR
ECHO  ______ ______ __    __  ______  __   __  __  __   
ECHO /\  ___/\  ___/\ "-./  \/\  ___\/\ "-.\ \/\ \/\ \  
ECHO \ \  __\ \  __\ \ \-./\ \ \  __\\ \ \-.  \ \ \_\ \ 
ECHO  \ \_\  \ \_\  \ \_\ \ \_\ \_____\ \_\\"\_\ \_____\
ECHO   \/_/   \/_/   \/_/  \/_/\/_____/\/_/ \/_/\/_____/

:MAINMENU
ECHO 1 - Convert File
ECHO 2 - Play File
ECHO 3 - Generate Content
ECHO 4 - Install
ECHO e - Exit
SET /P M=Type a number then press ENTER:
IF %M%==1 CLS & SET /P EXT=What file extension do you want?(PRESS ENTER) & FFmpeg -i %* %HOMEPATH%\downloads\%~n1_converted%EXT% & explorer %homepath%\downloads & GOTO EOF
IF %M%==2 ffplay -i %*
IF %M%==3 - CALL :MENU %*
IF %M%==4 - CALL :INSTALL %*
GOTO EOF

:MENU
ECHO.
REM DATE /T
REM TIME /T
ECHO MAIN MENU
ECHO.
ECHO 1 - Audio Conversions
ECHO 2 - Extract All Frames to PNG
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
ECHO e - EXIT
ECHO.
SET /P M=Type a number then press ENTER:
IF %M%==1 CALL :AUDIOMENU %*
IF %M%==2 CALL :EXTRACTPNG %*
IF %M%==3 CALL :NORMAL %*
IF %M%==4 CALL :JOINALLMP4 %*
IF %M%==5 CALL :EXRACTJPG %*
IF %M%==6 CALL :MP4SLIDESHOW %*
IF %M%==7 CALL :JPEGSLIDESHOW %*
IF %M%==8 CALL :SCALINGMENU %*
IF %M%==9 CALL :CROSSFADE %*
IF %M%==10 CALL :ADDCREDITS %*
IF %M%==11 CALL :BUMPGEN %*
IF %M%==12 CALL :DESHAKE %*
IF %M%==13 CALL :STABILIZE %*
IF %M%==14 CALL :GIFMENU %*
IF %M%==e GOTO EOF
GOTO MENU

:INSTALL
COPY ffmpeg.exe %ProgramFiles%\FFmenu
COPY ffplay.exe %ProgramFiles%\FFmenu
COPY ffprobe.exe %ProgramFiles%\FFmenu
COPY ffmenu.bat %ProgramFiles%\FFmenu
ECHO CALL %ProgramFiles%\FFmenu\ffmenu %* > %HOMEPATH%\AppData\Roaming\Microsoft\Windows\SendTo\ffmenu_.bat
GOTO :MAINMENU

:AUDIOMENU
CLS
ECHO AUDIO MENU
ECHO.
ECHO 1 - Extract Video Audio to Mp3
ECHO 2 - Convert Audio File to Mp4
ECHO 3 - Combine Audio from Mp3
ECHO 4 - Remove Audio from Mp4
ECHO 5 - Add Audio from 2nd Mp4 to First
ECHO e - EXIT
ECHO.
SET /P M=Type a number then press ENTER:
IF %M%==1 CALL :EXTRACTAUDIO %*
IF %M%==2 CALL :ADDAUDIO %*
IF %M%==3 CALL :COMBINEAUDIO %*
IF %M%==4 CALL :REMOVEAUDIO %*
IF %M%==5 CALL :COMBINEMP4AUDIO %*
IF %M%==e GOTO EOF
EXIT /B 0

:GIFMENU
CLS
ECHO ANIMATED GIFS MENU
ECHO.
ECHO 1 - Convert GIF to Mp4
ECHO 2 - Convert Video to GIF (Fast)
ECHO 3 - Convert Video to GIF (High Quality)
ECHO 4 - Split GIF to Frames (PNG)
ECHO e - EXIT
ECHO.
SET /P M=Type a number then press ENTER:
IF %M%==1 CALL :GIF2VID
IF %M%==2 CALL :VID2GIFFAST %*
IF %M%==3 CALL :VID2GIFHIGH %*
IF %M%==4 CALL :GIF2FRAMES %*
IF %M%==e GOTO EOF
EXIT /B 0

:SCALINGMENU
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
SET /P M=Type a number then press ENTER:
IF %M%==1 ffmpeg -i %* -vf scale=1920x1080:flags=lanczos %~n1_1080p%~x1
IF %M%==2 ffmpeg -i %* -vf scale=1280x720:flags=lanczos %~n1_720p%~x1
IF %M%==3 ffmpeg -i %* -vf scale=960x720:flags=lanczos %~n1_720%~x1
IF %M%==4 ffmpeg -i %* -vf scale=640x480:flags=lanczos %~n1_640%~x1 
IF %M%==5 ffmpeg -i %* -vf scale=480x360:flags=lanczos %~n1_360%~x1
IF %M%==6 ffmpeg -i %* -vf scale=640x360:flags=lanczos %~n1_360p%~x1
IF %M%==7 ffmpeg -i %* -vf "scale=(iw*sar)*max(720/(iw*sar)\,480/ih):ih*max(720/(iw*sar)\,480/ih), crop=720:480" -c:a copy "%~n1_CenterCrop%~x1"
IF %M%==m GOTO MENU
IF %M%==e GOTO EOF
EXIT /B 0

:EXTRACTAUDIO
ffmpeg -i %* %~n1_audio.mp3
EXIT /B 0

:EXTRACTPNG
SET FOLDERNAME=%date:~10%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%
MD %FOLDERNAME%
FFMPEG -i %* %FOLDERNAME%\frame%%04d.png -hide_banner
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

:VID2GIFFAST
ffmpeg -ss 61.0 -t 2.5 -i %* -filter_complex "[0:v] fps=12,scale=480:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" %~n1_fast.gif
EXIT /B 0

:VID2GIFHIGH
ffmpeg -ss 61.0 -t 2.5 -i %* -filter_complex "[0:v] fps=12,scale=w=480:h=-1,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1" %~n1_high.gif
EXIT /B 0

:GIF2FRAMES
ffmpeg -i %* -vsync 0 temp%d.png
EXIT /B 0

:EOF
EXIT
