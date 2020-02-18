local utils = { _version = "1.0.0" }

local function arquivo(arq)
  archive = "";
  for line in io.lines(arq) do
    archive = archive..line
  end
  return json.decode(archive)
end

local function length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function split(separator, string)
	array = {}
	f=0;
	for index in string.gmatch(string, '([^"'..separator..'"]+)') do
		array[f] = index
		f = f + 1
	end
	return array;
end
