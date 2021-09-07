#define surface_init
///surface_init(postdraw_compose_script)

//gm82appsurf
//based on envelope engine v5
//renex 2021
//depends on gm82core v1.3.2+

var postdraw;postdraw=argument0
globalvar application_surface;

if (variable_global_get("__gm82core_version")<132) {
    show_error("Game Maker 8.2 AppSurf requires Core version 1.3.2 or newer.",1)
    exit
}

core.__resw=window_get_region_width()
core.__resh=window_get_region_height()
core.depth=-10000000

//enable core interoperability
__gm82core_appsurf_interop=true

application_surface=surface_create(core.__resw,core.__resh)

object_event_add(core,ev_step,ev_step_end,'
    //set target to appsurf at end step, to catch view setup and all draw events.
    if (!surface_exists(application_surface)) {
        application_surface=surface_create(__resw,__resh)
    } else {
        __resw=surface_get_width(application_surface)
        __resh=surface_get_height(application_surface)
    }
    surface_set_target(application_surface)
')
object_event_add(core,ev_draw,0,'
    //finally after all draw events, compose the window.
    d3d_set_depth(0)      
    if (!surface_exists(application_surface)) {
        application_surface=surface_create(__resw,__resh)
    }
    draw_make_opaque()
    surface_reset_target()        
    d3d_set_projection_ortho(0,0,__resw,__resh,0)
    '+script_get_name(postdraw)+'()
')

