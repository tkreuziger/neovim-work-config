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

return M
