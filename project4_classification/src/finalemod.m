format compact
clear ;
close all ;
clc
dir = [ pwd , '\figures' ] ; 
mkdir( dir )
epillepticdata = unique( table2array( readtable( 'epilleptic.xlsx' ) ) , 'rows' ) ;
S = size( epillepticdata , 2 ) ; 
aklas = unique( epillepticdata( : , end ) ) ;
[ trainD , checkD , testD ] = split_scale ( epillepticdata , 1 ) ;
save( 'partiton2.mat' , 'trainD' , 'checkD' , 'testD' )
load partiton2.mat
[ RANK2 , ~ ] = relieff( epillepticdata( : , 1 : end - 1 ) , epillepticdata( : , end ) , 100 ) ;
save( 'RANK2.mat' , 'RANK2' )
load RANK.mat
%FS = 12 ;
%RS = 0.7 ;
FS = 16 ;
RS = 0.75 ;
x = trainD( trainD( : , end ) == 1 , : ) ;  
[ c1 , sig1 ] = subclust( x ( : , [ RANK2( 1 : FS ) , S ] ) , RS ) ;
x = trainD( trainD( : , end ) == 2 , : ) ;    
[ c2 , sig2 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
x = trainD( trainD( : , end ) == 3 , : ) ;     
[ c3 , sig3 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
x = trainD( trainD( : , end ) == 4 , :  ) ;     
[ c4 , sig4 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
x = trainD( trainD( : , end ) == 5 , : ) ;     
[ c5 , sig5 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
modelfis = fisakia( FS + 1 , c1 , c2 , c3 , c4 , c5 , sig1 , sig2 , sig3 , sig4 , sig5 ) ;
mdl = struct( 'Radius' , RS , 'Features' , FS , 'Type' , 'Class-Dependent' ) ;    
[ trnFis , trnError , ~ , valFis , valError ] = anfis( trainD( : , [ RANK( 1 : FS ) , S ] ) , ...
    modelfis , [ 400 0 0.01 0.9 1.1 ] , [ ] , checkD( : , [ RANK( 1 : FS ) , S ] ) ) ;
figure( )
plot( [ trnError , valError ] , 'LineWidth' , 1 ) ;
grid on;
xlabel( 'num of Iterations' ) ; 
ylabel( 'Error' ) ;
legend( 'Training Error' , 'Validation Error' ) ;
title( 'Learning Curve' ) ;
saveas( gcf , fullfile( dir , [ 'final' , num2str( RS ) , '_learningcurve.png' ] ) )
tsYhat = evalfis( valFis , testD( : , RANK( 1 : FS ) ) ) ;
figure( )
plot( 1 : size( testD , 1 ) , testD( : , end ) , 'ok' , 1 : size( testD , 1 ) , tsYhat , '.r' ) ;
title( 'Estimation Error' ) ;
legend( 'Reference Outputs' , 'Model Outputs' ) ;
saveas( gcf , fullfile( dir , 'Instances.png' ) )

for j = 1 : size( testD , 1 )
    
    if tsYhat( j ) < 1.5
          tsYhat( j ) = 1 ;
    elseif tsYhat( j ) < 2.5
          tsYhat( j ) = 2 ;
    elseif tsYhat( j ) < 3.5
          tsYhat( j ) = 3 ;
    elseif tsYhat( j ) < 4.5
          tsYhat( j ) = 4 ;
    else
          tsYhat( j ) = 5 ;
    end
end

figure( )
plot( 1 : size( testD , 1 ) , testD( : , end ) , 'ok' , 1 : size( testD , 1 ) , tsYhat , '.r' ) ;
title( 'Estimation Error' ) ;
legend( 'Reference Outputs' , 'Model Outputs' ) ;
saveas( gcf , fullfile( dir , 'Instances.png' ) )

for k = [ 1 , 4 , 8 , 12 ]
    
      figure( )
      subplot( 2 , 1 , 1 )
      [ x , mf ] = plotmf( modelfis , 'input' , k ) ;
      plot( x , mf )
      title( [ 'Initial MFs for Feature-Input ' , num2str( k ) ] )
      subplot( 2 , 1 , 2 )
      [ x , mf ] = plotmf( valFis , 'input' , k ) ;
      plot( x , mf )
      title( [ 'Tuned MFs for Feature-Input ' , num2str( k ) ] ) 
      saveas( gcf , fullfile( dir , [ 'Model_' , 'Final' , 'CompMfs' , num2str( j ) , '.png' ] ) )
      
end

Emm = zeros( 5 , 5 ) ;

for z = 1 : size( testD , 1 )
    
   Emm( tsYhat( z ) , testD( z , end ) ) = Emm( tsYhat( z ) , testD( z , end ) ) + 1 ;
   
end 

ola = sum( diag( Emm( : , : ) ) ) / size( testD , 1 ) ;
mdl.('Num_Rules') = length( valFis.Rule ) ;
mdl.('ErrorMatrix') = Emm ;
mdl.('OverallAcc') = sum( diag( Emm ) ) / size( testD , 1 ) ;
mdl.('UserAcc') = diag( Emm )./sum( Emm , 2 ) ;
mdl.('ProducerAcc') = diag( Emm )'./sum( Emm , 1 ) ;
mdl.('k_hat')=(size(testD, 1)*sum(diag(Emm))-sum(Emm, 1 )*sum(Emm, 2))/(size(testD, 1)^2-sum(Emm, 1)*sum(Emm, 2));

   fprintf( "Model evaluation\n" ) ;
   fprintf( "Type: %s\n" , mdl.Type ) ;
   fprintf( "Radius: %.2f\n" , mdl.Radius ) ;
   fprintf( "Number of Rules: %d\n" , mdl.Num_Rules) ;
   disp( 'Error Matrix: ' ) ;
   disp( mdl.ErrorMatrix )
   disp( 'Overall Accuracy: ' )
   disp( mdl.OverallAcc )
   disp( 'User Accuracy: ' )
   disp( mdl.UserAcc )
   disp( 'Producer Accuracy: ' )
   disp( mdl.ProducerAcc )
   disp( 'Kappa Coefficient: ' )
   disp( mdl.k_hat )
   fprintf( "----------------------------------\n" ) ;