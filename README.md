# video-converter
To write a bash script based off fmpeg, that converts videos in .mov format to .mp4 formats.

Steps to run this script:
- Clone the repo.
- Change directories into the folder created by the step above.
- Move your video files here.
```bash
cd <folder_name>
```

File structure
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

- If this is your first time of running this script, make the install file executable else jump to the nexxt step:
```bash
chmod u+x install
./install
```

- Make the converter file executable and run it
```bash
chmod u+x converter
./converter
```

### Shortcomings
- The original video, has a Japanese audio with subtitiles but the converted file, does not have subtitiles.
- The converted video is created in the same folder as the the original video in .mov format.