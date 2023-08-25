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
  nextlayerid = 11,
  nextobjectid = 44,
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
        1, 1, 1, 1, 1, 1, 3, 1, 1, 1,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74,
        1, 1, 1, 1, 1, 74, 74, 74, 1, 1,
        23, 23, 23, 23, 1, 74, 74, 74, 1, 23,
        23, 23, 23, 23, 1, 74, 18, 74, 1, 23,
        23, 23, 23, 23, 1, 1, 18, 1, 1, 23
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
        0, 0, 0, 0, 0, 0, 68, 0, 0, 0,
        0, 0, 0, 0, 181, 0, 0, 0, 181, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 5,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "Game Walls",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 0,
          y = 48,
          width = 80,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 128,
          y = 48,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 160,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 80,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 112,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 132,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 68,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "Draw",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 31,
          name = "door",
          type = "draw",
          shape = "rectangle",
          x = 96,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "Collision Regions",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 15,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 0,
          y = 48,
          width = 80,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 128,
          y = 48,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 96,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "torch",
          type = "detect",
          shape = "rectangle",
          x = 68,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "door",
          type = "detect",
          shape = "rectangle",
          x = 92,
          y = 96,
          width = 24,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "Room 1 teleport",
          type = "detect",
          shape = "rectangle",
          x = 96,
          y = 112,
          width = 16,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 80,
          y = 96,
          width = 12,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 116,
          y = 96,
          width = 12,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "Room 3 teleport",
          type = "detect",
          shape = "rectangle",
          x = 160,
          y = 16,
          width = 4,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "torch",
          type = "detect",
          shape = "rectangle",
          x = 132,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "Room 4 teleport",
          type = "detect",
          shape = "rectangle",
          x = -4,
          y = 16,
          width = 4,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 112,
          y = 0,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "text",
          type = "detect",
          shape = "rectangle",
          x = 96,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "Moving Walls",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 29,
          name = "door",
          type = "movingWall",
          shape = "rectangle",
          x = 96,
          y = 100,
          width = 16,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["Door-open"] = false
          }
        }
      }
    }
  }
}
