--// load all files in current directory
for file in io.popen([[dir "data/lib/core" /b /aa /s]]):lines() do
	if not file:match("core%.lua") and file:match("(%.lua)") then
		dofile(file)
	end
end