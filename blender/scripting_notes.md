# blender scripting

# Scripting
## Rotate Bone
- Use rotation_euler
```python
bones = bpy.data.objects["object"].pose.bones
bones.rotation_mode = 'XYZ' # This is very important.
bones["bone"].rotation_euler[0] # Rotate based on X, such as up or down.
bones["bone"].rotation_euler[1] # Rotate based on Z, such as left or right.
bones["bone"].rotation_euler[2] # Rotate based on Y, such as rotate on a plane.
```
## Move Bone
- Use location
```python
bones = bpy.data.objects["object"].pose.bones
bones["bone"].location[0] # Rotate based on X, such as left or right.
bones["bone"].location[1] # Rotate based on Y, such as forward or backward.
bones["bone"].location[2] # Move based on Z, such as up or down.
```

# References
- [FacialMotionCapture](https://github.com/srleohung/FacialMotionCapture) - Real-time facial motion capture in Blender 2.8 using OpenCV and a webcam. This uses python scripting directly in Blender.