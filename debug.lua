require 'cairo'

settings_table = {
    
    {
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x5105DB,
        fg_alpha=1,
        x=50, y=346,
        radius=25,
        thickness=7,
        start_angle=0,
        end_angle=360,
    },
}



function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_percent_bar(cr, x, y, r, g, b, a, percent, max_len)
	print('args', x, y, r, g, b, a, percent, max_len)
	cairo_set_source_rgba(cr, r, g, b, a)
	cairo_set_line_width(cr,2)
	cairo_rectangle(cr, x, y, max_len, 10)
	cairo_stroke(cr)

	cairo_set_source_rgba(cr, r, g, b, a)
	cairo_set_line_width(cr,2)
	cairo_rectangle(cr, x, y, max_len * (percent/100), 10)
	cairo_fill(cr)

end

function conky_dummy()
	print('dummy')
	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	
	local cr=cairo_create(cs)


	-- cairo_select_font_face(cr, 'Monaco')

	mem_percent_str = conky_parse('${memperc}')

	mem_percent_stats_str = string.format('mem usage: %s', mem_percent_str)
	print(mem_percent_stats_str)
	mem_percent_num = tonumber(mem_percent_str)

	cairo_set_font_face(cr, "Monaco")
	cairo_move_to(cr, 10, 20)
	cairo_set_source_rgba(cr, 1, 0, 0, 1)
	cairo_set_font_size(cr, 28)
	cairo_show_text(cr, mem_percent_stats_str)

	max_len = 200
	args = rgb_to_r_g_b(0xff0000, 1)
	print(args, type(args))
	draw_percent_bar(cr, 10, 30, rgb_to_r_g_b(0xff0000, 1), mem_percent_num, max_len)

	-- cpu0_percent_str = conky_parse('${cpu cpu0}')
	-- cpu0_percent_stats = string.format('cpu0: %s%%', cpu0_percent_str)
	-- cpu0_percent_num = tonumber(cpu0_percent_str)
	-- print(cpu0_percent_stats, cpu0_percent_num)

	-- cairo_move_to(cr, 10, 80)
	-- cairo_set_source_rgba(cr, 1, 1, 0, 1)
	-- cairo_set_font_size(cr, 28)
	-- cairo_show_text(cr, cpu0_percent_stats)

	-- draw_percent_bar(cr, 10, 100,rgb_to_r_g_b(0xffff00, 1), cpu0_percent_num, max_len)




	-- cr.font_face()
	-- cairo_font_face(cr, 'Monaco')
	-- cairo_font_size(cr, 14)
	-- cairo_show_text(cr, 'oooooooo')


	-- logics here:
	-- local xc = 50
	-- local yc = 345
	-- local ring_r = 25
	-- local ring_w = 7
	-- local angle_0 = 0*(2*math.pi/360)-math.pi/2
	-- local angle_f = 360*(2*math.pi/360)-math.pi/2
	

	local w,h=conky_window.width,conky_window.height
	
	-- local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	-- local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	-- local xc,yc,ring_r,ring_w,sa,ea=50, 346, 25, 7, 0, 360
	-- local bgc, bga, fgc, fga=0xffffff, 0.2, 0x5105DB, 1
	


	-- local angle_0=sa*(2*math.pi/360)-math.pi/2
	-- local angle_f=ea*(2*math.pi/360)-math.pi/2

	-- local t_arc=t*(angle_f-angle_0)


	-- print(xc, yc, ring_r, angle_0, angle_0)


	-- cairo_arc(cr,0,0,30,0,1.5)
	-- cairo_rectangle(cr, 10, 10, 20, 30)
	-- -- cairo_set_source_rgba(cr, rgb_to_r_g_b(0xFF0000, 1))
	-- cairo_set_source_rgba(cr, 1, 0, 0, 1)
	-- cairo_set_line_width(cr,2)
	-- cairo_stroke(cr)


	-- cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	-- cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	-- cairo_set_line_width(cr,ring_w)
	-- cairo_stroke(cr)

	cairo_surface_destroy(cs)
	cairo_destroy(cr)
end