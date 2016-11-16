# ChasenHandle_3DSpiralTrochoid
G-Code generator for 3D printer with simple model viewer.
The program is written as a Processing 3 sketch.

# Chasen Handle made from 3D trochoid spiral
This program generates a single path (no layer sliced spiral up) 3D printing model and g-code for handle of Chasen (tea whisk) a utensil for Japanese way of tea.
This program is intending to find out appropriate parameters (such as printing speed and temperature) for making natural feel in 3D printed surface.

# Target 3D printer
This program generates g-code file as an output.
The target 3D printer is Rapman 3.1 from "Bits From Bytes (currently 3D SYSTEMS)".
There file extention ".bfb" is used for g-code files, and also header part of g-code may include the machine specific codes.
Used material is PLA, used nozzle size is 0.4 mm.

# Final Master Project at TU/e ID
This is a part of Shigeru Yamada's Final Master Project (Graduation project of Master course, Industrial Design) at Technical University Eindhoven, The Netherlands, 2015-2016.
The Project title is as follows.
* New Craftsmanship towards aesthetics in the imperfection
 * - Crafting with new techniques for the experience of “wabi”, aesthetics in the imperfection -

# Operation
After running the program,
* Mouse movement is for view point change.
* Mouse scroll and Key 1,2,3,5 are for model view magnification.
* Key s and w are for saving (writing) output g-code file (file name is specified in the code).
