from PIL import Image
import sys

filename = sys.argv[1]
path = sys.argv[2]

# Open the JPG image
input_image_path = path + filename + ".jpg"
img = Image.open(input_image_path)

# Save the image in PNG format
output_image_path = path + filename + ".png"
img.save(output_image_path)
