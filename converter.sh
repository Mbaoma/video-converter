#!/bin/bash
processvideo() {
  filename=$1
  ext=$2
  destination=$3
  pathbase=$4


  encodedfilename="${filename//.$ext/.mp4}"

  echo -e "\e[93m=========================================================="
  echo "Found         $filename"
  echo -e "Converting to $encodedfilename\e[0m"

  if [ -f "$encodedfilename" ]; then
    echo -e "\e[91mFile $encodedfilename already exists. Doing nothing, preserving original file, please resolve manually.\e[0m"
    read -p "Press [Enter] to continue"
  else
    #encode to x264 with ffmpeg
    ffmpeg -i "$filename" -c:v libx264 -crf 23 -preset medium -pix_fmt yuvj420p -map 0:a:0 -map 0:v:0 -movflags +faststart "$encodedfilename"
    res=$?

    if [ $res -eq 0 ]; then

      # take base portion off file path and replace with base portion of destination path
      filenameInNewPath="$destination${filename/$pathbase/}"
      directoryName=$(dirname "$filenameInNewPath")

      # create destination directory for the original file, if not exist
      if [ ! -d "$directoryName" ]; then
        echo -e "\e[93mCreating directory $directoryName\e[0m"
        mkdir -p "$directoryName"
      fi

      echo -e "\e[93mMoving file $filename to $filenameInNewPath\e[0m"

      mv "$filename" "$filenameInNewPath"

      echo -e "\e[92mOK\e[0m"
    else
      echo -e "\e[91mffmpeg returned error code $res."
      if [ -f "$encodedfilename" ]; then
        rm "$encodedfilename"
        echo -e "Removed encoded file $encodedfilename, and preserved original file $filename\e[0m"
      else
        echo -e "Encoded file $encodedfilename was not created, original file $filename preserved.\e[0m"
      fi
      read -p "Press [Enter] to continue"
    fi
  fi


}

export -f processvideo

# parameters, with / at the end trimmed
path=${1%/}
ext=$2
destination=${3%/}
basePortion=${4%/}

if [ "$1" == "" ]; then
  echo -e "\e[0mUsage example:"
  echo "./converter /videos MOV /mov /video"
  echo "Will search for files of type MOV in /videos, and move each original to /videos/<file_relative_location>"
  echo ""
	echo "Syntax:"
  echo "./converter search_path search_extension destination [base_portion_of_search_path]";
  echo "It will search for the files of given extension, in search_path, encode each to x264 (.mp4), then move original file to the destination, maintaining folder structure."
  echo "If need to ignore base portion of search path when creating folder at destination, provide it as an extra parameter"
  echo ""
  echo "NB: All trailing slashes in paths are ignored, so it makes no difference if they are added"


else
  echo -e "\e[93m================== STARTING SCRIPT ======================="
  echo "Finding files of type $ext in: $path"
  echo -e "Moving originals to: $destination"

	find $path -name "*.$ext" \( -exec bash -c "processvideo '{}' '$ext' '$destination' '$basePortion' " \; -o -print \)

  echo -e "\e[93mFinished.\e[0m"
fi
