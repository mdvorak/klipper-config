#!python
# This is PrusaSlicer post-processing script
import os
import sys

file_path = sys.argv[1]
orig_file_path = file_path + ".orig"

try:
    # Rename the original file to have the ".orig" extension
    os.rename(file_path, orig_file_path)
except FileExistsError:
    os.remove(orig_file_path)

# Open the original file for writing
with open(orig_file_path, "r") as orig_file, open(file_path, "w") as new_file:
    for line in orig_file:
        # Reset speed
        if line in ["; CP EMPTY GRID END\n", "; CP TOOLCHANGE END\n"]:
            new_file.write("M220 S100\n")

        # Write original line
        new_file.write(line)

        # Increase speed
        if line in ["; CP EMPTY GRID START\n", "; CP TOOLCHANGE WIPE\n"]:
            new_file.write("M220 S200\n")

# Delete the ".orig" file (if it exists)
if os.path.exists(orig_file_path):
    os.remove(orig_file_path)
