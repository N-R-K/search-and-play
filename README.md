# Search And Play

[![CodeBerg](https://img.shields.io/badge/Hosted_at-Codeberg-%232185D0?style=flat-square&logo=CodeBerg)](https://codeberg.org/NRK/search-and-play)

Shell scripts to search and play youtube videos from the terminal using only
core-utilities.

The script scrapes search results from [Invidious] and parses them with awk.

[Invidious]: https://github.com/iv-org/invidious

## Preview

![preview.gif](preview.gif)

## Installation and Usage

Cone the repo.

```
git clone https://codeberg.org/NRK/search-and-play.git
```

Then just copy/move the files into your $PATH. `chmod +x` them if needed.
Instead of copying, you can also create a symlink. This way you can do a git pull to get updates.

Run `s --help` or `p --help` to see usage.

## Dependencies

* Curl

All other utilities used are defined by POSIX and should be available on all
unix-like systems.

### Optional

* Mpv (+youtube-dl) - For streaming the video.

You can change the `$PLAYER` variable inside the script to whatever else you want.

## F.A.Q

**Q: Why is the script not outputting any results?**

A: The most likely scenario is that the invidious instance is down/blocked. Try
changing the "INSTANCE" variable inside the script. Here's a list of
[public invidious instances].

[public invidious instances]: https://github.com/iv-org/documentation/blob/master/Invidious-Instances.md

## Similar projects

This script is meant to be minimal/barebones. If you want something more
featureful take a look into [ytfzf] or [script-yt].

[ytfzf]: https://github.com/pystardust/ytfzf
[script-yt]: https://github.com/sayan01/scripts/blob/master/yt
