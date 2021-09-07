# gm82appsurf
This is an application_surface wrapper extension for Game Maker 8.2.

It automatically manages a surface, providing a post-draw callback entrypoint for composing the screen with it.

Requires [Core](https://github.com/omicronrex/gm82core) version 1.3.2 or newer.

## Usage
1. Install Core and AppSurf, and add both to your project.
2. Create a script that will be used as a screen composing callback.
3. At game start, surface_init(...) with your callback script's id.
4. Write screen composition code in the script. application_surface contains the surface handle, and the projection is set to the size of the surface.
5. If need be, you can resize the application_surface.
6. When using other surfaces during the draw event, make sure to utilize surface_disengage() instead of surface_reset_target() to properly reset the draw stack. Using surfaces during other events is fine.
