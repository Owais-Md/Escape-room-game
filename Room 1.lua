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
  nextobjectid = 60,
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
        1, 3, 3, 3, 0, 3, 18, 3, 3, 1,
        1, 74, 74, 74, 74, 74, 18, 74, 74, 1,
        2, 74, 74, 74, 74, 74, 74, 74, 74, 1,
        3, 74, 74, 74, 74, 74, 74, 74, 74, 1,
        1, 74, 74, 74, 74, 74, 74, 74, 74, 1,
        1, 74, 74, 74, 74, 74, 74, 74, 74, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 3,
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
        0, 0, 0, 0, 214, 0, 0, 0, 0, 0,
        0, 169, 0, 0, 0, 0, 0, 0, 169, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 169, 0, 0, 0, 0, 0, 0, 169, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          y = 0,
          width = 16,
          height = 28,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 160,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 144,
          y = 0,
          width = 16,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 24,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 16,
          y = 0,
          width = 72,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 88,
          y = 0,
          width = 4,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 116,
          y = 0,
          width = 4,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 92,
          y = 0,
          width = 4,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 112,
          y = 0,
          width = 4,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 20,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
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
          id = 13,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 132,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 20,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 44,
          y = 20,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 0,
          y = 48,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
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
          id = 30,
          name = "door",
          type = "draw",
          shape = "rectangle",
          x = 96,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "chest",
          type = "draw",
          shape = "rectangle",
          x = 40,
          y = 16,
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
      id = 6,
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
          name = "door",
          type = "detect",
          shape = "rectangle",
          x = 92,
          y = 0,
          width = 24,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "fireplace",
          type = "detect",
          shape = "rectangle",
          x = 64,
          y = 0,
          width = 16,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "torch",
          type = "detect",
          shape = "rectangle",
          x = 20,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
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
          id = 25,
          name = "torch",
          type = "detect",
          shape = "rectangle",
          x = 132,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "torch",
          type = "detect",
          shape = "rectangle",
          x = 20,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "Room 2 teleport",
          type = "detect",
          shape = "rectangle",
          x = 96,
          y = -4,
          width = 16,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "chest",
          type = "detect",
          shape = "rectangle",
          x = 44,
          y = 20,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "wierdWall",
          type = "detect",
          shape = "rectangle",
          x = 0,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 12,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 16,
          y = 0,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 0,
          y = 56,
          width = 16,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 160,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 144,
          y = 0,
          width = 16,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "wall",
          type = "detect",
          shape = "rectangle",
          x = 116,
          y = 0,
          width = 28,
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
      properties = {
        ["Door-open"] = false
      },
      objects = {
        {
          id = 36,
          name = "door",
          type = "movingWall",
          shape = "rectangle",
          x = 96,
          y = 0,
          width = 16,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["Door-open"] = false
          }
        },
        {
          id = 56,
          name = "wierdWall",
          type = "movingWall",
          shape = "rectangle",
          x = 0,
          y = 28,
          width = 16,
          height = 20,
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
