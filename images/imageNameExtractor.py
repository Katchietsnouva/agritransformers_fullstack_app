import os

# Specify the directory path
image_dir = r'C:\Users\katchietsnouvaniccur\Documents\FlutterProjects\insta_app\images'

# Create a list to store the import statements
image_filenames = []
# import_statements = []
# image_variables = []

# Initialize a counter
counter = 1

# # List all files in the directory
for filename in os.listdir(image_dir):
    if filename.endswith(('.jpg', '.jpeg', '.png', '.gif', '.bmp', '.svg','.webp')):  # Add more extensions if needed
        image_filenames.append(f"- images/{filename}")
        # import_statements.append(f"import image{counter} from '../src/assets/images/{filename}';")
        # image_variables.append(f"image{counter}")
        # counter += 1

# # Create a text file in the image directory and write the import statements and image variable array
# output_file_path = os.path.join(image_dir, 'image_imports.txt')
# with open(output_file_path, 'w') as file:
#     file.write('\n'.join(import_statements))
#     file.write(f"\n\nconst imageFilenames = [{', '.join(image_variables)}];")

# print(f"Import statements and image variable array have been written to {output_file_path}")


# Create a text file in the image directory and write the import statements and image variable array
output_file_path = os.path.join(image_dir, 'image_imports.txt')
with open(output_file_path, 'w') as file:
    file.write("assets:\n")
    file.write('\n'.join(image_filenames))
    # file.write(f"\n\nconst imageFilenames = [{', '.join(image_variables)}];")

# print(f"Import statements and image variable array have been written to {output_file_path}")
print(f"Image filenames have been written to {output_file_path}")