% ILIAS KOROMPILIS

format compact
clear ;
close all;
clc
%mytable = readtable( 'epilleptic.csv' ) 
%MP = vartype( 'numeric' ) ;
%epilleptictable = mytable{ : , MP } ;
epillepticdata = unique( table2array( readtable( 'epilleptic.xlsx' ) ) , 'rows' ) ;
S = size( epillepticdata , 2 ) ; 
emklas = unique( epillepticdata( : , end ) ) ;
[ trainD , checkD , testD ] = split_scale( epillepticdata , (2-1) ) ;
save( 'partiton.mat' , 'trainD' , 'checkD' , 'testD' )
load partiton.mat
[ RANK , ~ ] = relieff( epillepticdata( : , 1 : end - 1 ) , epillepticdata( : , end ) , 100 ) ;
save( 'RANK.mat' , 'RANK')
load RANK.mat
mdl = [ ] ;

 %1
fs = [4 4 4 8 8 8 12 12 12];
rs = [0.35 0.55 0.75 0.35 0.55 0.75 0.35 0.55 0.75];

%2
%fs = [16 16 16 20 20 20 24 24 24];
%radius = [0.35 0.55 0.75 0.35 0.55 0.75 0.35 0.55 0.75];

%3
%fs = [10 10 10 14 14 14 18 18 18];
%rs = [0.65 0.8 0.95 0.65 0.8 0.95 0.65 0.8 0.95];


for j = 1 : length( fs )
    FS = fs( j ) ;
    RS = rs( j ) ;
   partiton = cvpartition( trainD( : , end ) , 'KFold' , 5 ) ;
   x = trainD( trainD( : , end ) == 1 , : ) ;
   [ c1 , sig1 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
   x = trainD( trainD( : , end ) == 2 , : ) ;
   [ c2 , sig2 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
   x = trainD( trainD( : , end ) == 3 , : ) ;
   [ c3 , sig3 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
   x = trainD( trainD( : , end ) == 4 , : ) ;
   [ c4 , sig4 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
   x = trainD( trainD( : , end ) == 5 , : ) ;     
   [ c5 , sig5 ] = subclust( x( : , [ RANK( 1 : FS ) , S ] ) , RS ) ;
   modelfis = fisakia ( FS + 1 , c1 , c2 , c3 , c4 , c5 , sig1 , sig2 , sig3 , sig4 , sig5 ) ;
   Emm = zeros( 5 , 5 , 5 ) ;
   Model = struct( 'Radius' , RS , 'Features' , FS ) ;
    ola = zeros( 5 , 1 ) ;
    MTT = - 1 ;
    if length( modelfis.Rule ) < 2
       Model.( 'State' ) = 'Only 1 Rule' ;
    elseif length( modelfis.Rule ) > 150
       Model.( 'State' ) = 'Over 150 Rules' ;
    else
       Model.( 'State' ) = 'Accepted Model' ;
       MTT = 0 ;
       for Z = 1 : 5
          disp( [ 'modl: ' , num2str( FS ) , ' features ' , num2str( RS ) , ' radius, ' , 'Fold ' , num2str( Z ) ] )
          BEGIN = tic ;  
          [ trnFis , trnError , ~ , valFis , valError ] = anfis( trainD( partiton.training( Z ) , [ RANK( 1 : FS ) , S ] ) , ...
             modelfis , [ 400 0 0.01 0.9 1.1 ] , [ ] , trainD( partiton.test( Z ) , [ RANK( 1 : FS ) , S ] ) ) ;
          MTT = MTT + toc( BEGIN ) / 5 ;
          tsYhat = evalfis( valFis , testD( : , RANK( 1 : FS ) ) ) ;
          for V = 1 : size( testD , 1 )
             if tsYhat( V ) < 1.5
                tsYhat( V ) = 1 ;
             elseif tsYhat( V ) < 2.5
                tsYhat( V ) = 2 ;
             elseif tsYhat( V ) < 3.5
                tsYhat( V ) = 3 ;
             elseif tsYhat( V ) < 4.5
                tsYhat( V ) = 4 ;
             else
                tsYhat( V ) = 5 ;
             end
          end
          for V = 1 : size( testD , 1 ) 
             Emm( tsYhat( V ) , testD( V , end ) , Z ) = Emm( tsYhat( V ) , testD( V , end ) , Z ) + 1 ;
          end
          ola ( Z ) = sum( diag( Emm( : , : , Z ) ) ) / size( testD , 1 ) ;
       end
    end
    Model.( 'ErrorMatrix' ) = sum( Emm( : , : , 5 ) , 3 ) / 5 ;
       Model.( 'MTT' ) = MTT ;
       ACCU = sum( ola ) / 5 ;
       Model.( 'overallAccuracy' ) = ACCU ;
       Model.( 'num_Rules' ) = length( modelfis.Rule ) ;
    mdl = [mdl Model];
end