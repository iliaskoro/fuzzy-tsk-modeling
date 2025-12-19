% ILIAS KOROMPILIS

classdef oxima
   properties
      thesiobj
      theta {mustBeNumeric}
   end
   methods (Static)
      function obj = oxima(thesi0,theta0)
         assert(isa(thesi0,'thesi'), ...
            'Error:  Oi syntetagmenes tis thesis prepei na einai object typou thesi kai oxi klasis %s.',class(thesi0));
         assert(abs(theta0)<=180, ...
            'Error:  To theta prepei na einai metaksy [-180,180] moires');
         obj.thesiobj = thesi0;
         obj.theta = theta0;
         return
      end
      function dv = get_sensors_dv(obj)
         switch true
            case obj.thesiobj.x<=5
               dv=obj.thesiobj.y-0;
            case obj.thesiobj.x<=6
               dv=obj.thesiobj.y-1;
            case obj.thesiobj.x<=7
               dv=obj.thesiobj.y-2;
            otherwise
               dv=obj.thesiobj.y-3;
         end
         dv=min(dv,1);
      end
      function dh = get_sensors_dh(obj)
         switch true
            case obj.thesiobj.y<=1
               dh=5-obj.thesiobj.x;
            case obj.thesiobj.y<=2
               dh=6-obj.thesiobj.x;
            case obj.thesiobj.y<=3
               dh=7-obj.thesiobj.x;
            otherwise
               dh=1; 
         end
         dh=min(dh,1);
      end
   end
end


