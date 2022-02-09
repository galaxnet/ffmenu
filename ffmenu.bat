@ECHO OFF
REM IF "%1"=="/?" ECHO Drag one or more files to the batch file and they become & ECHO the input for the ffmpeg command executed through the software. & GOTO EOF
CLS
COLOR 1F
:MENU
ECHO.
REM DATE /T
REM TIME /T
ECHO MAIN MENU
ECHO.
ECHO 1 - Extract Audio to Mp3
ECHO 2 - Extract All Frames to PNG
ECHO 3 - Normalize Video Color
ECHO 4 - Add Audio to File
ECHO 5 - Combine Audio from Mp3
ECHO 6 - Remove Audio from Mp4
ECHO 7 - Add Audio from 2nd Mp4 to First
ECHO 8 - Join all Mp4 in Directory
ECHO 9 - Extract All Frames to JPG
ECHO 10 - Create Mp4 from Frames
ECHO 11 - JPEG Slideshow (4 second per image)
ECHO 12 - Scaling Menu
ECHO 15 - Crossfade
ECHO 16 - Add Credits
ECHO 17 - Bump Generator
ECHO 18 - Deshake Video
ECHO 19 - Stabilize Video
ECHO 14 - OPTIONS MENU
ECHO E - EXIT
ECHO.
SET /P M=Type a number then press ENTER:
IF %M%==1 CALL EXTRACTAUDIO
IF %M%==2 CALL EXTRACTPNG
IF %M%==3 CALL NORMAL
IF %M%==4 CALL ADDAUDIO 
IF %M%==5 CALL COMBINEAUDIO
IF %M%==6 CALL REMOVEAUDIO
IF %M%==7 CALL COMBINEMP4AUDIO
IF %M%==8 CALL JOINALLMP4
IF %M%==9 CALL EXRACTJPG
IF %M%==10 CALL MP4SLIDESHOW
IF %M%==11 CALL JPEGSLIDESHOW
IF %M%==12 CALL SCALINGMENU
IF %M%==14 CALL OPTIONSMENU
IF %M%==15 CALL CROSSFADE 
IF %M%==16 CALL ADDCREDITS
IF %M%==17 CALL BUMPGEN
IF %M%==18 CALL DESHAKE
IF %M%==19 CALL STABILIZE
IF %M%==E GOTO EOF
GOTO MENU
:OPTIONSMENU
CLS
ECHO OPTIONS MENU
ECHO.
ECHO 1 - BOWIE
ECHO 2 - PRINCE
ECHO 3 - DOOGIE
ECHO 4 - NOIR
ECHO 5 - GOLDSTEIN
ECHO 6 - ZORK
ECHO 7 - MAIN MENU
ECHO E - EXIT
ECHO.
SET /P M=Type a number then press ENTER:
IF %M%==1 CALL COLOR 4E
IF %M%==2 CALL COLOR 5B
IF %M%==3 CALL COLOR 1F
IF %M%==4 CALL COLOR 8E
IF %M%==5 CALL COLOR 06
IF %M%==6 CALL COLOR 0A
IF %M%==7 GOTO MENU
IF %M%==E GOTO EOF
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
ECHO M - MAIN MENU
ECHO E - EXIT
ECHO.
SET /P M=Type a number then press ENTER:
IF %M%==1 ffmpeg -i %* -vf scale=1920x1080:flags=lanczos output_1080p.mp4
IF %M%==2 ffmpeg -i %* -vf scale=1280x720:flags=lanczos output_720p.mp4
IF %M%==3 ffmpeg -i %* -vf scale=960x720:flags=lanczos output_720.mp4
IF %M%==4 ffmpeg -i %* -vf scale=640x480:flags=lanczos output_640.mp4 
IF %M%==5 ffmpeg -i %* -vf scale=480x360:flags=lanczos output_360.mp4
IF %M%==6 ffmpeg -i %* -vf scale=640x360:flags=lanczos output_360p.mp4
IF %M%==7 ffmpeg -i %* -vf "scale=(iw*sar)*max(720/(iw*sar)\,480/ih):ih*max(720/(iw*sar)\,480/ih), crop=720:480" -c:a copy "%~n1-CenterCrop%~x1" & GOTO SCALINGMENU
IF %M%==M GOTO MENU
IF %M%==E GOTO EOF
GOTO MENU
:EXTRACTAUDIO
ffmpeg -i %* audio.mp3
:EXTRACTPNG
SET FOLDERNAME=%date:~10%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%
MD %FOLDERNAME%
FFMPEG -i %* %FOLDERNAME%\frame%%04d.png -hide_banner
:EXTRACTJPG
SET FOLDERNAME=%date:~10%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%
MD %FOLDERNAME%
FFMPEG -i %* %FOLDERNAME%\frame%%04d.jpg -hide_banner
:NORMAL
ffmpeg -i %* -vf "normalize=strength=1" normalized.mp4 
:ADDAUDIO
ffmpeg -i %* -i audio.mp3 -map 0:0 -map 1:a -c:v copy -shortest output.mp4
:COMBINEAUDIO
ffmpeg -i %* -i audio.mp3 -filter_complex "[0:a][1:a]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest combined.mp4
:REMOVEAUDIO
ffmpeg -i %* -c:v copy -an output.mp4
:COMBINEMP4AUDIO
ffmpeg -i video.mp4 -i video2.mp4 -map 0:0 -map 1:1 -c:v copy -shortest output.mp4
:JOINALLMP4
(for %%i in (*.mp4) do @echo file '%%i') > mylist.txt
ffmpeg -f concat -i mylist.txt -c copy output.mp4
del /q mylist.txt
:MP4SLIDESHOW
ffmpeg -i %%* slideshow.mp4
REM (for %%i in (slideshow\*.*) do @echo file '%%i') > mylist.txt
REM ffmpeg -r 1/5 concat -i mylist.txt -c:v libx264 -vf fps=25 -pix_fmt yuv420p out.mp4
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
:TESTPATTERN
ffmpeg -f lavfi \ -i "testsrc=size=320x260[out0];aevalsrc=random(0)/20[out1]" \ -t 0:0:30 -pix_fmt yuv420p \ testpattern.mp4
:COLORSOURCE
ffmpeg -f lavfi -i color=c=darkblue:size=960x720:rate=30 -t 10 colorsource.mp4
ffmpeg -i colorsource.mp4 -filter_complex "drawtext=testtesttest:x=main_w/2 - text_w/2:y=main_h/2 - text_h/2:fontfile=Roboto-Regular.ttf:fontsize=24:fontcolor=000000" colorsource2.mp4
:MANDELBROT
REM Generates a fractal animation. Default is long.
ffmpeg -f lavfi -i mandelbrot mandelbrot.mp4
:CROSSFADE
REM Takes 2 videos dragged and crossfades them. Videos should be 40 seconds, fade starts at 30.
ffmpeg -i %1 -i %2 -filter_complex xfade=transition=fade:duration=10:offset=30 crossfade.mp4
:ADDCREDITS
REM Add upward scrolling text to clip.
ffmpeg -i %1 -vf "drawtext=textfile=credits.txt: x=100: y=h-20*t: fontsize=18:fontcolor=yellow@0.9: box=1: boxcolor=black@0.1" -c:a copy outputCredits.mp4
:BUMPGEN
REM x0 and x1 set the angle of the linear gradient.
REM y0 appears to determine width of c0. y1 appears to be width of gradient effect.
ffmpeg -f lavfi -i "gradients=s=360x240: n=3: c0=darkblue: c1=darkorange: c2=darkorange: r=30: d=30: x0=0: x1=0: y0=50: y1=200: speed=0.00001" output.mp4
ffmpeg -i output.mp4 -i music.mp3 -map 0:0 -map 1:a -c:v copy -shortest output2.mp4
ffmpeg -i output2.mp4 -vf "drawbox=x=iw/10:y=ih/5:w=iw*0.8:h=ih*0.6:color=purple@0.5:t=fill" output3.mp4
ffmpeg -i output3.mp4 -vf "drawtext=textfile=credits.txt: x=w/10: y=h-8*t: fontsize=12:fontcolor=yellow@0.9: box=1: boxcolor=darkblue@0.9" -c:a copy outputcredits.mp4
:BUMPSCROLLER
ffmpeg -f lavfi -i "gradients=s=360x240: n=3: c0=darkblue: c1=darkorange: c2=darkorange: r=30: d=30: x0=160: y0=0: x1=160: y1=240: speed=0.00001" output.mp4
ffmpeg -i output.mp4 -i music.mp3 -map 0:0 -map 1:a -c:v copy -shortest output2.mp4
ffmpeg -i output2.mp4 -vf "drawtext=textfile=credits.txt: x=w/10: y=h-8*t: fontsize=18:fontcolor=yellow@0.9: box=1: boxcolor=darkblue@0.5" -c:a copy outputcredits.mp4
:ENABLETELNET
pkgmgr /iu:"TelnetClient"
:DESHAKE
ffmpeg -i %* -vf deshake %~n1-deshake%~x1
:STABILIZE
ffmpeg -i %* -vf vidstabdetect -f null -
ffmpeg -i %* -vf vidstabtransform,unsharp=5:5:0.8:3:3:0.4 %~n1_stabilized%~x1
:EOF
EXIT
REM ffmpeg -i "%*" -vf "vidstabtransform=smoothing=50:crop=keep:invert=0:relative=0:zoom=0:optzoom=2:zoomspeed=0.2:interpol=bilinear:tripod=0" -map 0 -c:v libx264 -preset fast -crf 9 -c:a aac -b:a 192k "%~n1-BetterDeshake%~x1"
