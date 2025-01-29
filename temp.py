from PIL import Image
import os

input_dir = "workspace/data_src"

for filename in os.listdir(input_dir):
    if filename.endswith(".png"):
        img_path = os.path.join(input_dir, filename)
        img = Image.open(img_path).convert("RGB")  # Convert to RGB (fix transparency issues)
        jpg_path = os.path.splitext(img_path)[0] + ".jpg"  # Change extension to .jpg
        img.save(jpg_path, "JPEG", quality=95)  # Save as high-quality JPEG
        print(f"Converted {filename} -> {os.path.basename(jpg_path)}")
