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
  nextlayerid = 9,
  nextobjectid = 26,
  properties = {},
  tilesets = {
    {
      name = "basictiles",
      firstgid = 1,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../Sprites/Lanea Zimmerman's spritesheets/basictiles.png",
      imagewidth = 128,
      imageheight = 240,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 120,
      tiles = {}
    },
    {
      name = "things",
      firstgid = 121,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 12,
      image = "../Sprites/Lanea Zimmerman's spritesheets/things.png",
      imagewidth = 192,
      imageheight = 128,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 96,
      tiles = {
        {
          id = 1,
          animation = {
            {
              tileid = 1,
              duration = 100
            },
            {
              tileid = 13,
              duration = 100
            },
            {
              tileid = 25,
              duration = 100
            },
            {
              tileid = 37,
              duration = 100
            }
          }
        },
        {
          id = 2,
          animation = {
            {
              tileid = 38,
              duration = 100
            },
            {
              tileid = 26,
              duration = 100
            },
            {
              tileid = 14,
              duration = 100
            },
            {
              tileid = 2,
              duration = 100
            }
          }
        },
        {
          id = 7,
          animation = {
            {
              tileid = 7,
              duration = 100
            },
            {
              tileid = 19,
              duration = 100
            },
            {
              tileid = 31,
              duration = 100
            },
            {
              tileid = 43,
              duration = 100
            }
          }
        },
        {
          id = 8,
          animation = {
            {
              tileid = 44,
              duration = 100
            },
            {
              tileid = 32,
              duration = 100
            },
            {
              tileid = 20,
              duration = 100
            },
            {
              tileid = 8,
              duration = 100
            }
          }
        },
        {
          id = 48,
          animation = {
            {
              tileid = 48,
              duration = 100
            },
            {
              tileid = 49,
              duration = 100
            },
            {
              tileid = 50,
              duration = 100
            },
            {
              tileid = 49,
              duration = 100
            }
          }
        },
        {
          id = 60,
          animation = {
            {
              tileid = 60,
              duration = 100
            },
            {
              tileid = 61,
              duration = 100
            },
            {
              tileid = 62,
              duration = 100
            },
            {
              tileid = 61,
              duration = 100
            }
          }
        },
        {
          id = 72,
          animation = {
            {
              tileid = 72,
              duration = 100
            },
            {
              tileid = 73,
              duration = 100
            },
            {
              tileid = 74,
              duration = 100
            },
            {
              tileid = 73,
              duration = 100
            }
          }
        },
        {
          id = 84,
          animation = {
            {
              tileid = 84,
              duration = 100
            },
            {
              tileid = 85,
              duration = 100
            },
            {
              tileid = 86,
              duration = 100
            },
            {
              tileid = 85,
              duration = 100
            }
          }
        }
      }
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
        3, 3, 3, 3, 3, 3, 18, 3, 3, 3,
        3, 74, 74, 74, 74, 74, 18, 74, 74, 3,
        3, 74, 74, 74, 74, 74, 74, 74, 74, 3,
        3, 74, 74, 74, 74, 74, 74, 74, 74, 3,
        3, 74, 74, 74, 74, 74, 74, 74, 74, 3,
        3, 74, 74, 74, 74, 74, 74, 74, 74, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 7,
      name = "Tile Layer 3",
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
      visible = true,
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
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 88,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 40,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 16,
          width = 16,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 144,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 16,
          width = 16,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 0,
          width = 8,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 0,
          width = 8,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = -8,
          width = 16,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
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
          id = 23,
          name = "",
          type = "",
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
          id = 24,
          name = "",
          type = "",
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
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 20,
          y = 80,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 7,
      id = 8,
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
        0, 169, 0, 0, 0, 0, 0, 0, 169, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 169, 0, 0, 0, 0, 0, 0, 169, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
