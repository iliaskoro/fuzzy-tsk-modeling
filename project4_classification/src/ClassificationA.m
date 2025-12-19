% ILIAS KOROMPILIS

clear ;
close all ;
dir = [ pwd , '\diagrammata' ] ;
mkdir( dir )
habermandata = unique( load( 'haberman.data' ) , 'rows' ) ;
haberclass = unique ( habermandata( : , end ) ) ;
[ trnData , chkData , tstData ] = split_scale( habermandata , (2-1) ) ;
save('partitioning.mat','trnData','chkData','tstData')
load partitioning.mat
haber = [ ] ; 
trn = [ ] ; 
val = [ ] ; 
te = [ ] ; 
ve = [ ] ; 
mdl = [ ] ; 
begin = tic ;
ra = [ 0.15 0.85 ] ; 
checker = 1 ; 

for k = ra 
   [ c , sig ] = subclust( trnData , k ) ;
   modelfis = fisaki( size( trnData , 2 ) , c , [ ] , sig , [ ] ) ; 
   [trnFis, trnError, ~, valFis, valError]=anfis(trnData , modelfis, [600 0 0.01 0.9 1.1 ], [ ] , chkData);
   figure( )
   plot( [ trnError , valError ] , 'LineWidth' , 1 ) ;
   grid on;
   xlabel( 'NUMBEROFIterations' ) ;
   ylabel( 'Error' ) ;
   legend( 'Training Error' , 'Validation Error' ) ;
   title( 'Learning Curve' ) ;
   saveas( gcf , fullfile ( dir , [ 'C_Ind' , num2str(k) , '_learningcurve.png' ] ) )

for j = 1 : length( trnFis.Inputs ) 
      figure( )
      subplot( 2 , 1 , 1 )
      [ x , mf ] = plotmf( modelfis , 'input' , j ) ;
      plot( x , mf )
      title( [ 'Initial MFs for Feature-Input ' , num2str( j ) ] )
      subplot( 2 , 1 , 2 )
      [ x , mf ] = plotmf( valFis , 'input' , j ) ;
      plot( x , mf )
      title( [ 'Tuned MFs for Feature-Input ' , num2str( j ) ] )
      saveas( gcf , fullfile ( dir , [ 'mdl_' , num2str( checker ) , '_memfuns_' , num2str( j ) , '.png' ] ) )
end
   figure( )
   [ x , y , z ] = sphere( ) ;
   x = x * k ;
   y = y * k ;
   z = z * k ;
      for j = 1 : size( c , 1 )
         surface = surf ( x + c( j , 1 ) , y + c( j , 2 ) , z + c( j , 3 ) ) ; %hs=surface
         set( surface , 'FaceAlpha' , 0.5 )
         hold on
         if c( j , 4 ) == 1
            set( surface , 'FaceColor' , [ 0.635 , 0.078 , 0.184 ] ) 
         else 
            set( surface , 'FaceColor' , [ 0.466 , 0.674 , 0.188 ] )
         end 
      end
   hold off
   daspect( [ 1 1 1 ] )
   view( 30 , 10 )
   axis equal
   title( 'Clusts' ) ;
   saveas( gcf , fullfile( dir , [ 'c_' , num2str( k ) , '_clusts.png' ] ) )
   Model = struct( 'Type' , 'ClassDependent' , 'radius' , k ) ; 
   haber = [ haber modelfis ] ;
   trn = [ trn trnFis ] ;
   val = [ val valFis] ;
   te = [ te trnError ] ;
   ve = [ ve valError] ;
   mdl = [ mdl Model ] ;
   checker = checker + 1 ;
end
for k = ra 
   x = trnData( trnData( : , end ) == 1 , : ) ;     
   [ c1 , sig1 ] = subclust( x , k ) ;
   x = trnData( trnData( : , end ) == 2 , : ) ;     
   [ c2 , sig2 ] = subclust( x , k ) ;
   modelfis = fisaki(size(trnData , 2 ) , c1 , c2 , sig1 , sig2 ) ;
   [trnFis, trnError, ~, valFis, valError]=anfis(trnData, modelfis, [600 0 0.01 0.9 1.1], [ ], chkData); 
   figure( )
   plot( [ trnError , valError ] , 'LineWidth' , 1 ) ;
   grid on;
   xlabel( 'NUMBEROFIterations' ) ; 
   ylabel( 'Error' ) ;
   legend( 'Training Error' , 'Validation Error' ) ;
   title( 'Learning Curve' ) ;
   saveas( gcf , fullfile( dir , [ 'C_Dep' , num2str( k ) , '_learningcurve.png' ] ) )
     
for j = 1 : length( trnFis.Inputs )
      figure( )
      subplot( 2 , 1 , 1 )
      [ x , mf ] = plotmf( modelfis , 'input' , j ) ;
      plot( x , mf )
      title( [ 'Initial MFs for Feature-Input ' , num2str( j ) ] )
      subplot( 2 , 1 , 2 )
      [ x , mf ] = plotmf( valFis , 'input' , j ) ;
      plot( x , mf )
      title( [ 'Tuned MFs for Feature-Input ' , num2str( j ) ] )
      saveas( gcf , fullfile( dir , [ 'mdl_' , num2str( checker ) , '_memfuns_' , num2str( j ) , '.png' ] ) )
end
   figure( )
   [ x , y , z ] = sphere( ) ;
   x = x * k ; 
   y = y * k ; 
   z = z * k ;
   for j = 1 : size( c1 , 1 )
      surface = surf ( x + c1( j , 1 ) , y + c1( j , 2 ) , z + c1(j , 3 ) ) ;
      set( surface , 'FaceAlpha' , 0.5 )
      hold on
      set( surface , 'FaceColor' , [ 0.635 , 0.078 , 0.184 ] )
   end
   for j = 1 : size( c2 , 1 ) 
      surface = surf ( x + c2( j , 1 ) , y + c2( j , 2 ) , z + c2( j , 3 ) ) ;
      set( surface , 'FaceAlpha' , 0.5 )
      hold on
      set(surface , 'FaceColor' , [ 0.466 , 0.674 , 0.188 ] )
   end
   hold off
   axis equal 
   title( 'Clusts' ) ;
   saveas( gcf , fullfile( dir , [ 'C_' , num2str( k ) , '_clusts.png' ] ) )
   Model = struct( 'Type' , 'ClassDependent' , 'radius' , k ) ;
   haber = [ haber modelfis ] ;
   trn = [ trn trnFis ] ;
   val = [ val valFis ] ;
   te = [ te trnError ] ;
   ve = [ ve valError ] ;
   mdl = [ mdl Model ] ;
   checker = checker + 1 ;
end
disp( [ 'Training Done in ' , num2str( toc( begin ) / 60 ) , ' mins\n' ] )
for j = 1 : 4
   valFis = val( j ) ;
   tsYhat = evalfis( tstData ( : , 1 : end - 1 ) , valFis ) ;
   tsYhat = round( tsYhat ) - 1 * double( tsYhat >= 2.5 ) + 1 * double( tsYhat < 0.5 ) ;
   Emm = zeros( 2 , 2 ) ; 
   for l = 1 : size( tstData , 1 ) %k=l
      Emm( tsYhat( l ) , tstData( l , end ) ) = Emm( tsYhat( l ) , tstData( l , end ) ) + 1 ;
   end
   mdl( j ).( 'Num_Rules' ) = length( valFis.Rule ) ;
   mdl( j ).( 'ErrorMatrix' ) = Emm ;
   mdl( j ).( 'OverallAcc' ) = sum( diag( Emm ) ) / size( tstData , 1 ) ;
   mdl( j ).( 'UserAcc' ) = diag( Emm )./ sum( Emm , 2 ) ;
   mdl( j ).( 'ProducerAcc' ) = diag( Emm )'./ sum( Emm , 1 ) ;
   mdl( j ).( 'k_hat' ) = ( size( tstData , 1 ) * sum( diag( Emm ) ) - sum ( Emm , 1 ) * sum( Emm , 2 ) ) / ( size( tstData , 1 )^2 - sum( Emm , 1 ) * sum( Emm , 2 ) ) ;
end
fprintf( "------------------------------------------\n" ) ;
for j = 1 : 4
   fprintf( "Model evaluation %d \n" , j )
   fprintf( "Type: %s\n" , mdl( j ).Type )
   fprintf( "radius: %.2f\n" , mdl(j).radius ) ;
   fprintf( "# of rules: %d\n" , mdl( j ).Num_Rules )
   disp( 'Error Matrix: ' )
   disp( mdl( j ).ErrorMatrix )
   disp( 'overall OverallAccuracy: ' )
   disp( mdl( j ).OverallAcc )
   disp( 'User Accuracy: ' )
   disp( mdl( j ).UserAcc )
   disp( 'producer OverallAccuracy: ' )
   disp( mdl( j ).ProducerAcc )
   disp( 'Kappa Coefficient: ' )
   disp( mdl( j ).k_hat )
   fprintf( "----------------------------------------------\n" ) ;
end
save( 'moda.mat' , 'mdl' )