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
  nextlayerid = 3,
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
        4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
        4, 74, 74, 74, 74, 74, 74, 74, 74, 74,
        4, 74, 74, 74, 74, 74, 74, 74, 74, 74,
        4, 74, 74, 74, 74, 4, 4, 4, 4, 4,
        4, 74, 74, 74, 74, 4, 23, 23, 23, 23,
        4, 74, 74, 74, 74, 4, 23, 23, 23, 23,
        4, 74, 74, 74, 74, 4, 23, 23, 23, 23
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 2,
      name = "Torch Animation",
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
        0, 205, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
