# Code Review for Programming Exercise 2 #

## Peer-reviewer Information

* *name:* Alex Bott
* *email:* ambott@ucdavis.edu

### Description ###

To assess the solution, you will be choosing ONE choice from unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

#### Perfect #### 
    Cannot find any flaws concerning the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    A major flaw and some minor flaws.

#### Satisfactory ####
    A couple of major flaws. Heading towards a solution, however, did not fully realize the solution.

#### Unsatisfactory ####
    Partial work, but not really converging to a solution. Pervasive major flaws. Objective largely unmet.


### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The camera stays locked on the player at all times, and a 5 by 5 unit cross is created when turning draw logic on

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The camera scrolls properly while making sure the player is in the defined box at all times. When draw logic is turned on it properly maps out the retraint box. Although the player's middle section is what collides with the wall not it's respective side. This is not specificied in the stage 2 outline so I would still say perfect.

### Stage 3 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
When traveling at normal speed everything works perfectly, the camera lags behind the player until it reaches a set distance, then it matches the player speed. Upon stopping the camera properly catches up to the players position. However, when traveling at super speed the camera fails to keep up with the player meaning the player leaves the camera's vision until stopping.

### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
Similar to the previous stage the camera works almost perfectly for traveling in normal speed. Leading the players movement and returning when stopped. However there is no period of time when stopped that the camera doesn't move before returning. And when traveling in super speed the player moves to fast for the camera to lead and leaves the vision after a short time period.

### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The camera is almost perfect. The camera has set speed up periods for all 4 sides, properly speeding up when the player is in the zone and only moving if the player is moving in the correlated direction. On top of that the outer box properly makes sure if the player reaches this barrier the camera matches the player's speed to not fall behind (For both normal and super speed). However the corner movement is a bit janky. When moving in a corner, for example both up and right in the speed up zone the camera doesn't smoothly move in that diagonal direction. Rather, it jumps between moving up and moving left.

## Code Style ##

### Description ###
Check the scripts to see if the student code follows the Godot style guide.

If sections don't adhere to the style guide, please permalink the line of code from GitHub and justify why the line of code has infractions of the style guide.

### Code Style Review ###

* The code is extremely well written and easy to read. Only very minor style guid infractions here and there.

#### Style Guide Infractions ####

* [Only one line between functions](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/position_lock.gd#L23) - There should be two lines of whitespace between functions.

* [Could use a line of whitespace for different side logic](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/speed_up_pz.gd#L33) - This is definitely nitpicky, but the individual logic for each side of the speed up push box zone could have a line of whitespace between the logic to improve readability.

#### Style Guide Exemplars ####

* [Proper whitespace for comments](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/position_lock.gd#L19) - There is one space after the '#' character

* [Proper whitespace between seperate logic](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/framing_has.gd#L30) - There is one line of whitespace between different branches of logic

* [Decleration of local variable as close to use as possible](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/lerp_smooth.gd#L47) - The variable "speed" is declared and initialized one line before it is used.

* [Declared export variables above functions](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/framing_has.gd#L6) - Export variables should be declared at top of class

* [Proper naming conventions for function, variable, and class names](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/framing_has.gd#L6) - snake case for functions and variables, and camel case for class names

## Best Practices ##

### Description ###

If the student has followed best practices as seen in the style guide lecture, then feel free to point at these segments of code as examples. 

If the student has breached the best practices and has done something that should be noted, please add the infracture.

### Best Practices Review ###

* Like the code style review, extremely well written code, with included comments that properly explain the logic below.

#### Best Practices Infractions ####

* [Draws an full line instead of line segments with focus around a center point](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/position_lock.gd#L31) - Although this has literally no effect on the code, using 4 lines each originating at a center point and going up, left, right, and down could improve the ability to reuse the for different crosshair line lengths. Or more accurately changing the hardcoded 5 units of length to a editable variable.

* [Uses -variable_name versus -1 * variable name](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/speed_up_pz.gd#L31) - Using -1 * variable_name would improve readability by making a more clear negation to the variable instead of prepending a minus sign infront of the variable_name.

#### Best Practices Exemplars ####

* [Declares public variables staticly and initializes with a value](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/speed_up_pz.gd#L8) - This allows for code resilincy

* [Aptly named variables](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/speed_up_pz.gd#L26) - Makes code readable and improves clarity.

* [Uses a local variable instead of hardcoding](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/position_lock.gd#L20) - Using the variable "tpos" instead of simple entering the target's global position within that line, not only improves readability but also allows for changes to be made with much more ease than if it were hardcoded.

* [Makes sure upon camera intatiation that the camera is looking directly down onto the character](https://github.com/ensemble-ai/exercise-2-camera-control-qjb12/blob/923174a917e0b5d8ce505c6e9849a7c80fd66be4/Obscura/scripts/camera_controllers/speed_up_pz.gd#L15) - This extra step in every camera_controller script's _ready() function is not necessary for the given objective. However, this student took the extra step further improving code resilincy and allowed for expansion later on that could have an effect on the camera's rotation. Making sure the rotation is reset when the camera_controller is selected.