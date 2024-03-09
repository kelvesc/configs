
require 'cairo'

-- Setup Global variables
if tonumber(conky_parse('${updates}')) < 2 then
    previousEpoch = os.time()
end

--[[AUX FUNCTIONS]]--------------------------------------------------
function epoch()
    --FIXME: this function looks like doing nothing
    --???: make this local function in main?
    local newEpoch = os.time()

    if previousEpoch < newEpoch then
        -- Collect data in global variables here
    end

    if previousEpoch < newEpoch then
        previousEpoch = newEpoch
    else
        print("Error: epoch warning:" .. previousEpoch .. " new:" .. newEpoch)
    end

end

function hex_to_rgb(color, alpha)
    --TODO: finish this
    return
end

--[[DRAWING FUNCTIONS]]----------------------------------------------
--[[
--cairo_close_path:
--  draws a line from the stopped point to the begining
--cairo_stroke:
--  draws a line
--cairo_fill:
--  used for filling the shape
--if an outlined shape is desired:
--  cairo_fill_preserve (cr) draws the shape and preserve it
--  and then cairo_set_source_rgba and cairo_stroke does the outline
--line width, line cap type and line join type do not affect the fill command
]]

function draw_rectangle()
--    local line_width =  5
    local top_left_x =  20
    local top_left_y =  20
    local rec_width  =  100
    local rec_height =  100
    local red   = 0.8
    local green = 0.2
    local blue  = 0.4
    local alpha = 1

    cairo_set_line_width (cr, line_width)
    cairo_rectangle (cr, top_left_x, top_left_y, rec_width, rec_height)
    cairo_set_source_rgba (cr, red, green, blue, alpha)

    cairo_fill (cr)

end

function draw_triangle()
-----LINE------------------------------------------------------------
--    local line_cap  =   CAIRO_LINE_CAP_BUTT
--    local line_join =   CAIRO_LINE_JOIN_ROUND
--    local line_width = 1
    local red       = 0.2
    local green     = 0.5
    local blue      = 1
    local alpha     = 1
    local startx    = 0
    local starty    = 0
    local pointx    = startx + 100
    local pointy    = starty + 100
    local endx      = pointx - 100
    local endy      = pointy
-----DRAWING---------------------------------------------------------
    cairo_set_line_width (cr, line_width)
    cairo_set_line_cap (cr, line_cap)
    cairo_set_source_rgba (cr, red, green, blue, alpha)

    cairo_move_to (cr, startx, starty)
    cairo_line_to (cr, pointx, pointy)
    cairo_line_to (cr, endx, endy)
    cairo_line_to (cr, startx, starty)

    cairo_set_line_join (cr, line_join)
    cairo_close_path (cr)
    cairo_fill (cr)

end

function draw_ring_cw()
    --clockwise circle/arc
    --cairo_arc (cr, center_x, center_y, radius, start_angle, end_angle)
    local red   = 0.9
    local green  = 0.5
    local blue   = 0.1
    local alpha   = 1
    local radius = 40
    local center_x   = 70
    local center_y   = 150
    local start_angle = 0
    local end_angle = 2 * math.pi

    cairo_arc (cr, center_x, center_y, radius, start_angle, end_angle)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_fill (cr)

end

function draw_ring_acw()
    --ANTIclockwise circle/arc
    --cairo_arc_negative (cr, center_x, center_y, rad, start_angle, end_angle)
    local red   = 1
    local green  = 0.1
    local blue   = 0.1
    local alpha   = 1
    local radius = 40
    local center_x   = 100
    local center_y   = 200
    local start_angle = math.pi / 7
    local end_angle = math.pi * 1.2

    local line_width = 20
    local line_cap = CAIRO_LINE_CAP_BUTT
    local line_join = CAIRO_LINE_JOIN_ROUND

    cairo_arc (cr, center_x, center_y, radius, start_angle, end_angle)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_fill (cr)

end

function draw_hex()
-----LINE------------------------------------------------------------
    local line_cap  =   CAIRO_LINE_CAP_BUTT
    local line_join =   CAIRO_LINE_JOIN_ROUND
    local line_width = 1
    local red       = 0.3
    local green     = 0.4
    local blue      = 0.8
    local alpha     = 0.8
    local startx    = 23
    local starty    = 45
-----DRAWING---------------------------------------------------------
    cairo_set_line_width (cr, line_width)
    cairo_set_line_cap (cr, line_cap)
    cairo_set_source_rgba (cr, red, green, blue, alpha)

    cairo_move_to (cr, startx, starty)
    cairo_line_to (cr, startx, starty + 120)
    cairo_line_to (cr, startx + 64, starty + 120 + 36)
    cairo_line_to (cr, startx + 64 + 64, starty + 120)
    cairo_line_to (cr, startx + 64 + 64, starty)
    cairo_line_to (cr, startx + 64, starty - 36)

    cairo_set_line_join (cr, line_join)
    cairo_close_path (cr)
    cairo_fill (cr)
--   cairo_stroke (cr)

end

function destroy_all()
--[[
-- DESTROYING
-- always destroy:
-- cairo_xlib_surface_create;
-- cairo_create;
-- cairo_pattern_create_radial; and etc,
-- because they can cause memory leaks
--]]

    cairo_destroy (cr)
    cairo_surface_destroy (cs)
    cr = nil

end

--[[MAIN FUNCTION]]--------------------------------------------------
function conky_main()

    if conky_window == nil then
        return
    end

    local cs  = cairo_xlib_surface_create   (conky_window.display,
                                             conky_window.drawable,
                                             conky_window.visual,
                                             conky_window.width,
                                             conky_window.height)

    cr = cairo_create (cs)

--    draw_rectangle ()
--    draw_triangle ()
--    draw_ring_cw ()
--    draw_ring_acw ()
    draw_hex()

    destroy_all ()

--[[DEBUGGING----------------------------------------------------------
    local function is_running()
        local updates = tonumber (conky_parse ('${updates}'))
        if updates > 5 then
            --print (conky_window.display)
            --print (conky_window.drawable)
            --print (conky_window.visual)
            print (conky_window.width)
            print (conky_window.height)
        end
    end
    is_running ()

]]---------------------------------------------------------------------

end
