--need to make a simpleDrawLayer function (copy code that is used in both Dialog.lua and Menu.lua for drawing a simple Layer)

pathsToTilesets = {
    "basictiles",
    "things"
}

function gcd( m, n )
    while n ~= 0 do
        local q = m
        m = n
        n = q % n
    end
    return m
end

function lcm( m, n )
    return ( m ~= 0 and n ~= 0 ) and m * n / gcd( m, n ) or 0
end

Data = {
    quads = {},
    tilesetRanges = {},
    animatedTiles = {},
    timeLimit = 1
}

tileCount = 0

for _,path in ipairs(pathsToTilesets) do
    tileset = require(path)
    for y = 0, tileset.imageheight/tileset.tileheight -1 do
        for x = 0, tileset.imagewidth/tileset.tilewidth -1 do
            local quad = love.graphics.newQuad(
            x * tileset.tilewidth,
            y * tileset.tileheight,
            tileset.tilewidth,
            tileset.tileheight,
            tileset.imagewidth,
            tileset.imageheight
            )
            table.insert(Data.quads, quad)
        end
    end
    for _,tile in ipairs(tileset.tiles)do
        for _,animationTile in ipairs(tile.animation) do
            animationTile.tileid = animationTile.tileid + tileCount
        end
        Data.timeLimit = lcm(Data.timeLimit, #tile.animation)
        table.insert(Data.animatedTiles, tileCount + tile.id, tile)
    end
    tilesetRange = {
        start = tileCount,
        finish = tileCount + tileset.tilecount - 1,
        imagePath = tileset.image
    }
    table.insert(Data.tilesetRanges, tilesetRange)
    tileCount = tileCount + tileset.tilecount
end

return Data