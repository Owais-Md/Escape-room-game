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
  nextlayerid = 10,
  nextobjectid = 56,
  properties = {},
  tilesets = {
    {
      name = "basictiles",
      firstgid = 1,
      filename = "basictiles.tsx"
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
        3, 1, 1, 1, 18, 1, 1, 1, 1, 3,
        3, 18, 18, 18, 18, 18, 18, 18, 18, 3,
        3, 18, 18, 18, 18, 18, 18, 18, 18, 3,
        3, 18, 18, 18, 18, 18, 18, 18, 18, 3,
        3, 18, 18, 18, 18, 18, 18, 18, 18, 3,
        3, 18, 18, 18, 18, 18, 18, 18, 18, 3,
        3, 1, 1, 1, 1, 1, 12, 2147483706, 1, 3
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 3,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 144,
          y = 0,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 64,
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
          x = 16,
          y = 0,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 117,
          y = 96,
          width = 14,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 128,
          y = 101,
          width = 3,
          height = 7,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 127,
          y = 108,
          width = 4,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 119,
          y = 97,
          width = 12,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 121,
          y = 98,
          width = 10,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 123,
          y = 99,
          width = 8,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 125,
          y = 100,
          width = 6,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 108,
          y = 119,
          width = 14,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 108,
          y = 118,
          width = 12,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 108,
          y = 117,
          width = 10,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 108,
          y = 116,
          width = 8,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 108,
          y = 115,
          width = 6,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 96,
          y = 112,
          width = 12,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 16,
          y = 96,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 128,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 115,
          y = 95,
          width = 16,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 112,
          y = 94,
          width = 16,
          height = 1,
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
      name = "Draw",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 51,
          name = "door",
          type = "draw",
          shape = "rectangle",
          x = 64,
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
      id = 4,
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
          id = 27,
          name = "Room 5 Stair teleport",
          type = "detect",
          shape = "rectangle",
          x = 127,
          y = 101,
          width = 1,
          height = 11,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 44,
          y = 17,
          width = 3,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 44,
          y = 65,
          width = 35,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 81,
          y = 16,
          width = 4,
          height = 26,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 97,
          y = 55,
          width = 18,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 65,
          y = 33,
          width = 16,
          height = 9,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 113,
          y = 58,
          width = 2,
          height = 36,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 76,
          y = 81,
          width = 19,
          height = 3,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 76,
          y = 68,
          width = 3,
          height = 13,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 85,
          y = 40,
          width = 14,
          height = 2,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 92,
          y = 84,
          width = 3,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "Room 5 Drop teleport",
          type = "detect",
          shape = "rectangle",
          x = 97,
          y = 42,
          width = 2,
          height = 13,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "door",
          type = "detect",
          shape = "rectangle",
          x = 64,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "Room 8 teleport",
          type = "detect",
          shape = "rectangle",
          x = 64,
          y = -4,
          width = 16,
          height = 4,
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
          id = 54,
          name = "door",
          type = "movingWall",
          shape = "rectangle",
          x = 64,
          y = 0,
          width = 16,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
