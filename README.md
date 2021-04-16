# Search And Play
Shell scripts to search and play youtube videos from the terminal without any external dependencies.

The script scrapes search results from [Invidious](https://github.com/iv-org/invidious) and parses them with awk. By default it plays videos in mpv but you can change the $PLAYER to whatever you like.

## Preview
Work in progress (∩｀-´)⊃━☆ﾟ.*･｡ﾟ 

## Installation and Usage
Cone the repo.

```git clone https://github.com/N-R-K/search-and-play.git```

Then just copy/move the files into your $PATH. ```chmod +x``` them if needed.
Instead of copying, you can also create a symlink. This way you can do a git pull to get updates.

Run ```s --help``` or ```p --help``` to see usage.

## Dependencies
Curl, Awk, Head, Printf.

### Optional
Mpv (+youtube-dl) - For streaming the video.

Xclip - For playing from clipboard.

## Similar projects
This script is meant to be minimal/barebones. If you want something more featureful take a look into [ytfzf](https://github.com/pystardust/ytfzf) or [script-yt](https://github.com/sayan01/scripts/blob/master/yt).
