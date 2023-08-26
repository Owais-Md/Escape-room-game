return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 7,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 4,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "basictiles",
      firstgid = 1,
      filename = "basictiles.tsx"
    },
    {
      name = "things",
      firstgid = 121,
      filename = "things.tsx",
      exportfilename = "things.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 1,
      name = "Floor",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 74, 74, 74, 74, 74, 74, 74, 74, 1,
        1, 74, 74, 74, 74, 74, 74, 74, 74, 1,
        1, 74, 74, 74, 74, 1, 1, 1, 1, 1,
        1, 74, 74, 74, 74, 1, 74, 74, 74, 74,
        1, 74, 74, 74, 74, 1, 74, 74, 74, 74,
        1, 1, 1, 1, 23, 2, 74, 74, 74, 74
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 2,
      name = "Animations",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 181, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 169, 0, 0, 0,
        0, 181, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 3,
      name = "Objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 68, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
