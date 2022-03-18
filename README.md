# video-converter
To write a bash script based off fmpeg, that converts videos in .mov format to .mp4 formats.

### File structure
- Folder from git clone
    - yourvideos (dir)
        - video1.mov (video file)
        - video2.mov (video file)
    - converter (file)
    - install (file)

| File                  |Purpose                           |
| --------------------- | --------------------- | 
| ```install```       | Installs ffmpeg, converts files and saves converted files into a directory - ```mp4videos```                                 
|```converter```     | Converts files and saves the  converted files into a directory - ```mp4videos```          |

### Steps to run this script:
- Clone the repo.

- If this is your first time of running this script, make the install file executable else jump to the nexxt step:
```bash
chmod u+x install
./install <source-folder> <video-type> <destination-folder>
./install videos mov mp4-videos
```

- Make the converter file executable and run it
```bash
chmod u+x converter
./converter <source-folder> <video-type> <destination-folder>
./converter videos mov mp4-videos
```

### Limitations
- Subtitle files for the .mov videos are not copied over to the .mp4 videos.