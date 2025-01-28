# DeepFaceLab Setup and Workflow

## **📌 Prerequisites**
Ensure you have the following installed:
- Python 3.9
- Conda environment set up
- FFmpeg installed
- NVIDIA GPU with CUDA support

---

## **🚀 Step 1: Clone DeepFaceLab**
```bash
git clone https://github.com/iperov/DeepFaceLab.git
cd DeepFaceLab
```

---

## **🚀 Step 2: Install Dependencies**
```bash
pip install -r requirements-cuda.txt  # For GPU users
```

---

## **🚀 Step 3: Modify DeepFaceLab Code for NumPy Compatibility**
DeepFaceLab’s code required a minor modification to support newer versions of NumPy. We updated `S3FDExtractor.py` to replace `int` with `int`.

### **Edit the following file:**
```
DeepFaceLab/facelib/S3FDExtractor.py
```

### **Find and replace this line:**
```python
bboxlist = [ x[:-1].astype(int) for x in bboxlist if x[-1] >= 0.5]
```

### **With:**
```python
bboxlist = [ x[:-1].astype(int) for x in bboxlist if x[-1] >= 0.5]
```

---

## **🚀 Step 4: Extract Frames from Source and Destination Videos**

### **Extract frames from the source video:**
```bash
ffmpeg -i workspace/data_src/data_src.mp4 -q:v 2 -vf scale=1280:720 workspace/data_src/frame_%04d.jpg
```

### **Extract frames from the destination video:**
```bash
ffmpeg -i workspace/data_dst/data_dst.mp4 -q:v 2 -vf scale=1280:720 workspace/data_dst/frame_%04d.jpg
```

---

## **🚀 Step 5: Extract Faces from Frames**

### **Extract faces from the source video frames:**
```bash
python main.py extract --input-dir workspace/data_src --output-dir workspace/data_src/aligned
```

### **Extract faces from the destination video frames:**
```bash
python main.py extract --input-dir workspace/data_dst --output-dir workspace/data_dst/aligned
```

---

## **🚀 Step 6: Train the Model**
```bash
python main.py train --training-data-src-dir workspace/data_src/aligned --training-data-dst-dir workspace/data_dst/aligned --model-dir workspace/model --model SAEHD
```

For training without preview (to save GPU resources):
```bash
python main.py train --training-data-src-dir workspace/data_src/aligned --training-data-dst-dir workspace/data_dst/aligned --model-dir workspace/model --model SAEHD --no-preview
```

---

## **🚀 Step 7: Merge Faces into the Destination Video**
```bash
python main.py merge --input-dir workspace/data_dst/aligned --output-dir workspace/merged --output-mask-dir workspace/merged/masks --aligned-dir workspace/data_dst/aligned --model-dir workspace/model --model SAEHD

```

---

## **🚀 Step 8: Convert Merged Frames into a Video**
```bash
ffmpeg -framerate 30 -i workspace/result/frame_%04d.jpg -c:v libx264 -pix_fmt yuv420p workspace/final_output.mp4
```

---

## **✅ Final Output**
Your final deepfake video will be located at:
```
workspace/final_output.mp4
```

🎬 Enjoy your deepfake video! 🚀


new to check histogram
```
python main.py sort --input-dir workspace/data_dst/aligned --by hist
```
to do the merging
```
python main.py merge --input-dir workspace/data_dst --aligned-dir workspace/data_dst/aligned --output-dir workspace/merged --output-mask-dir workspace/merged/masks --model-dir workspace/model --model SAEHD
```
to make video
``` 
C:\Users\ihk\.conda\envs\deepfacelab\lib\site-packages\imageio_ffmpeg\binaries\ffmpeg-win-x86_64-v7.1.exe -r 30 -i frame_%04d.png -b:v 16M -c:v libx264 -pix_fmt yuv420p ..\result.mp4
```
