minetest.register_node("item_image_bug:node", {
	paramtype2 = "color4dir",
	tiles = {
		"chesttools_wood_chest_top.png",
		"chesttools_wood_chest_top.png",
		"chesttools_wood_chest_side.png",
		"chesttools_wood_chest_side.png",
		"chesttools_wood_chest_side.png",
		"chesttools_wood_chest_lock.png",
	},
	overlay_tiles = {
		{ name = "chesttools_wood_chest_top_overlay.png", color = "white" },
		{ name = "chesttools_wood_chest_top_overlay.png", color = "white" },
		{ name = "chesttools_wood_chest_side_overlay.png", color = "white" },
		{ name = "chesttools_wood_chest_side_overlay.png", color = "white" },
		{ name = "chesttools_wood_chest_side_overlay.png", color = "white" },
		{ name = "chesttools_wood_chest_lock_overlay.png", color = "white" },
	},
	use_texture_alpha = "clip",
	color = "#4900ff",
	palette = "chesttools_palette_4dir.a.png",
})

local function get_items()
	local item1 = ItemStack("item_image_bug:node")
	local item1_meta = item1:get_meta()
	item1_meta:set_int("palette_index", 16) -- red

	local item2 = ItemStack("item_image_bug:node")
	local item2_meta = item2:get_meta()
	item2_meta:set_int("palette_index", 32) -- green

	return item1, item2
end

minetest.after(0, function()
	local de = minetest.create_detached_inventory("item_image_bug")
	de:set_size("one", 1)
	de:set_size("two", 1)
	local item1, item2 = get_items()
	de:set_stack("one", 1, item1)
	de:set_stack("two", 1, item2)
end)

local f = string.format
local F = minetest.formspec_escape

minetest.register_chatcommand("item_image_bug", {
	func = function(name)
		local item1, item2 = get_items()
		local itemstring1 = item1:to_string()
		local itemstring2 = item2:to_string()
		local parts = {
			"size[4,4]",
			"label[0,1;item_image]",
			f("item_image[1,1;1,1;%s]", F(itemstring1)),
			f("item_image[2,1;1,1;%s]", F(itemstring2)),
			"label[0,2;list]",
			"list[detached:item_image_bug;one;1,2;1,1;]",
			"list[detached:item_image_bug;two;2,2;1,1;]",
		}

		minetest.show_formspec(name, "item_image_bug", table.concat(parts, ""))
	end,
})
