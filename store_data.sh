# Changing current directory to AACM Project directory
cd /Users/shyam/Desktop/AACM\ Project/
# Copying the downloaded webm file from Downloads and move to AACM Project folder
cp  /Users/shyam/Downloads/$1 /Users/shyam/Desktop/AACM\ Project/
# Converting .webm file to .mp4 file
ffmpeg -i $1 video.mp4

# Converting mp4 to mp3 file
ffmpeg -i video.mp4 -ac 1 -ab 64000 -ar 22050 audio.mp3

# Creating video file with no audio in this mp4 
ffmpeg -i video.mp4 -vcodec copy -an video_without_audio.mp4

# Extracting metadata from the video
ffprobe -v quiet -print_format json -show_format -show_streams video.mp4 > output_file.json 

# Remove already existing audio file from hdfs
hdfs dfs -rm -r /audio.mp3
# Remove already existing video without audio file from hdfs
hdfs dfs -rm -r /video_without_audio.mp4
# Upload the audio extracted to hdfs
hadoop fs -put audio.mp3 /
# Upload the video without audio to hdfs
hadoop fs -put video_without_audio.mp4 /
# Run the below python index.py file to store the metadata in MongoDB
python index.py
