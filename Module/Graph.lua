Graph = {}

function Graph:NewGraph(vertex, directed)
    return dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Graph\\data\\graph.lua").create(vertex, directed)
end

function Graph:NewDijkstra()
    return dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Graph\\shortest_paths\\Dijkstra.lua").create()
end

return Graph