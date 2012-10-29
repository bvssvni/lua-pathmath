--[[

lua-pathmath - Math methods for dealing with paths, such as length, boundaries etc.
BSD license.
by Sven Nilsen, 2012
http://www.cutoutpro.com

Version: 0.000 in angular degrees version notation
http://isprogrammingeasy.blogspot.no/2012/08/angular-degrees-versioning-notation.html

--]]

--[[
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied, of the FreeBSD Project.
--]]

--[[

This file contains math functions for dealing with paths.

--]]

local pathmath_NUMBER_MAXIMUM = 8.98846567431158e307
local pathmath_NUMBER_MINIMUM = -8.98846567431158e307

-- Returns the length of a path.
function pathmath_Length(path)
  local length = 0
  local dx, dy
  
  for i = 1, #path-2, 2 do
    dx = path[i+2] - path[i]
    dy = path[i+3] - path[i+1]
    length = length + math.sqrt(dx * dx + dy * dy)
  end
  
  return length
end

-- Finds the bounds of a path, returns x,y,w,h.
function pathmath_Bounds(path)
  local minx = pathmath_NUMBER_MAXIMUM
  local miny = pathmath_NUMBER_MAXIMUM
  local maxx = pathmath_NUMBER_MINIMUM
  local maxy = pathmath_NUMBER_MINIMUM
  
  for i = 1, #path, 2 do
    minx = math.min(path[i], minx)
    miny = math.min(path[i+1], miny)
    maxx = math.max(path[i], maxx)
    maxy = math.max(path[i+1], maxy)
  end
  
  return minx, miny, (maxx-minx), (maxy-miny)
end

function test_pathmath_Length_1()
  local path = {0, 0}
  local length = pathmath_Length(path)
  
  assert(length == 0, length)
end

function test_pathmath_Length_2()
  local path = {0, 0, 0, 0}
  local length = pathmath_Length(path)
  
  assert(length == 0, length)
end

function test_pathmath_Length_3()
  local path = {0, 0, 1, 0}
  local length = pathmath_Length(path)
  
  assert(length == 1, length)
end

function test_pathmath_Bounds_1()
  local path = {0, 0, 10, 20}
  local x, y, w, h = pathmath_Bounds(path)
  
  assert(x == 0, x)
  assert(y == 0, y)
  assert(w == 10, w)
  assert(h == 20, h)
end

function test_pathmath()
  test_pathmath_Length_1()
  test_pathmath_Length_2()
  test_pathmath_Length_3()
  test_pathmath_Bounds_1()
end