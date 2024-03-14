function [AMatrix] = getAmatrix(angleTheta,anglePsi,angleGamma)

AMatrix=[
   cos(angleTheta)*cos(anglePsi), sin(angleTheta)*cos(anglePsi), -sin(anglePsi);
  -cos(angleGamma)*sin(angleTheta)+sin(angleGamma)*sin(anglePsi)*cos(angleTheta), cos(angleGamma)*cos(angleTheta)+sin(angleGamma)*sin(anglePsi)*sin(angleTheta), sin(angleGamma)*cos(anglePsi);   
   cos(angleGamma)*sin(anglePsi)*cos(angleTheta)+sin(angleGamma)*sin(angleTheta), cos(angleGamma)*sin(anglePsi)*sin(angleTheta)-sin(angleGamma)*cos(angleTheta), cos(angleGamma)*cos(anglePsi)
];
end