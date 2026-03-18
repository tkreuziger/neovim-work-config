local M = {}

M.str_split = function(inputstr, sep)
   if sep == nil then
      sep = '%s'
   end
   local t = {}

   for str in inputstr:gmatch('([^'..sep..']+)') do
      table.insert(t, str)
   end

   return t
end

M.get_keys = function(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

return M
