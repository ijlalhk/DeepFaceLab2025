import cv2
import glob

frame_files = sorted(glob.glob("workspace/merged/frame_*.png"))
frame = cv2.imread(frame_files[0])
height, width, layers = frame.shape

video = cv2.VideoWriter('workspace/final.mp4', cv2.VideoWriter_fourcc(*'mp4v'), 25, (width, height))

for file in frame_files:
    img = cv2.imread(file)
    video.write(img)

video.release()
cv2.destroyAllWindows()
