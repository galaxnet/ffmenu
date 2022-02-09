# ffmenu
FFmenu is a scripted menu for Windows FFmpeg with shell integration.

Every day, creators spend untold quantities of their hard earned cash on video and photo editing suites, some of which are even subscription based! Remarkably, many of these products are based on the same underlying technology: venerable video editing swiss army knife [FFmpeg](https://www.ffmpeg.org/).

FFmpeg is a free command line based software that can edit and convert videos, graphics, and audio files. It's even been used as the basis for an Internet radio station, [DJ Marinara](https://github.com/gorzek/djmarinara).

FFmpeg is also ridiculously powerful, labyrinthine in its filter configuration options, and notoriously underdocumented, like if 'House of Leaves' were a command line video editor. Enter FFmenu.

FFmenu is a basic batch script with many common FFmpeg features pre-configured and organized into easy to navigate menus. You can drag and drop one or more files onto FFmenu and process them seamlessly through FFmpeg. Since FFmenu is just a batch script, it can easily be added to the Windows SendTo folder, giving a context-menu like option anywhere in your filesystem. As a batch file, FFmenu is also an excellent teaching tool, since each FFmpeg function available is laid out in the script in plaintext that anyone can read, edit, or build upon.

FFmenu is not a commercial product riding the coattails of FFmpeg, we do not receive any compensation for this tool other than the satisfaction of a job well done. FFmenu is not exhaustive: it will incorporate a lot of quirky, complex FFmpeg features, but it's not intended to replace command line use of FFmpeg for more complex configuration options.

Cool Stuff FFmenu does:
* Pan-and-Scan (Upscale w/ center crop)
* Crossfade videos
* Bump Generator (90's CGI informational channel)

Stuff we'd like to add:
* Shell integration
* An install option
* A command line help flag

Stuff we probably won't add:
* Any features that cause FFmenu to expand beyond a single file (that's kinda its thing!).

Fabrice if you're reading this, thanks for all your hard work! Thank you also to all the many FFmpeg contributors, documenters, and tinkerers who have made it such an amazing product!
