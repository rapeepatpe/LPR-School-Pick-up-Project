import cv2
import os
from PIL import Image
import time
from detect import main as detect_main
from absl import app
def save_all_frames(video_path, dir_path, basename, ext='jpg'):
    print("sav Function")
    cap = cv2.VideoCapture(RTSP_URL, cv2.CAP_FFMPEG)

    if not cap.isOpened():
        print("not opened")
        return

    os.makedirs(dir_path, exist_ok=True)
    base_path = os.path.join(dir_path, basename)

    digit = len(str(int(cap.get(cv2.CAP_PROP_FRAME_COUNT))))

    n = 0

    ret, frame = cap.read()
    if ret:
        #write an image to disk
        cv2.imwrite('{}_{}.{}'.format(base_path, str(n).zfill(digit), ext), frame)
        #call detect.py with saved image
        #python detect.py --weights ./checkpoints/custom-416 --size 416 --model yolov4 --images ./data/images/car11.jpg --plate
        # n += 1
        print("Save")
                

RTSP_URL = 'rtsp://admin:SchoolPickUp2566@192.168.58.214'
os.environ['OPENCV_FFMPEG_CAPTURE_OPTIONS'] = 'rtsp_transport;udp'
# cap = cv2.VideoCapture(RTSP_URL, cv2.CAP_FFMPEG)
print("Running")
save_all_frames('data/temp/sample_video.mp4', 'data/temp/result', 'sample_video_img')
# save_all_frames('data/temp/sample_video.mp4', 'data/temp/result_png', 'sample_video_img', 'png')
# print("saved2")