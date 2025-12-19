% ILIAS KOROMPILIS

classdef thesi
   properties
      x {mustBeNumeric}
      y {mustBeNumeric}
  end
   methods (Static)
      function obj = thesi(x0,y0)
         assert(and(x0<=10, x0>=0),'Error:  x should be in range of [0,(10)]');
         assert(and(y0<=4, y0>=0),'Error:  y should be in range of [0, (4)]');
         obj.x = x0;
         obj.y = y0;
         return
      end
   end
end
