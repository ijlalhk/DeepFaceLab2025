to extract frames from source
```
python3 main.py videoed extract-video --input-file /DeepFaceLab/workspace/data_src.mp4 --output-dir /DeepFaceLab/workspace/data_src
```
to extract frames from destination
```
python3 main.py videoed extract-video --input-file /DeepFaceLab/workspace/data_dst.mp4 --output-dir /DeepFaceLab/workspace/data_dst
```
the next step is to extract faces from the frames

to extract faces from the source video frames:
```
python3 main.py extract --input-dir /DeepFaceLab/workspace/data_src --output-dir /DeepFaceLab/workspace/aligned_src
```

to extract faces from the destination video frames:
```
python3 main.py extract --input-dir /DeepFaceLab/workspace/data_dst --output-dir /DeepFaceLab/workspace/aligned_dst
```

