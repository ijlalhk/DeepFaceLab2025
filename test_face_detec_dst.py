from mtcnn import MTCNN
from PIL import Image
import cv2
import os

# Initialize MTCNN detector
detector = MTCNN()

# Directories
input_dir = '/DeepFaceLab/workspace/data_dst'
output_dir = '/DeepFaceLab/workspace/aligned_dst'

# Create output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Process each image in the input directory
for filename in os.listdir(input_dir):
    if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
        img_path = os.path.join(input_dir, filename)
        img = cv2.imread(img_path)
        img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        # Detect faces
        detections = detector.detect_faces(img_rgb)

        for i, detection in enumerate(detections):
            x, y, width, height = detection['box']
            face = img_rgb[y:y+height, x:x+width]
            face_image = Image.fromarray(face)
            output_path = os.path.join(output_dir, f"{os.path.splitext(filename)[0]}_face{i}.png")
            face_image.save(output_path)
