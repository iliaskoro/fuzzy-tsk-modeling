function y = fisaki( m , c1 , c2 , sig1 , sig2 )
   b = m - 1 ;
   z1 = size( c1 , 1 ) ;    
   z2 = size( c2 , 1 ) ;
   rules = z1 + z2 ;
   y = newfis( 'fizakis' , 'sugeno' ) ;
   for j = 1 : m - 1 
      y = addvar( y , 'input' , [ 'in_' , num2str( j ) ] , [ 0 1 ] ) ;
   end
   y = addvar( y , 'output' , 'out1' , [ 1 2 ] ) ;
   for j = 1 : b 
       for jb = 1 : z1
           onom = [ 'mf_' , num2str( ( rules ) * ( j - 1 ) + jb ) ] ;
           y = addmf( y , 'input' , j , onom , 'gaussmf' , [ sig1( j ) c1( jb , j ) ] ) ;
       end
       for jb = 1 : z2
           onom = [ 'mf_' , num2str( ( rules ) * ( j - 1 ) + jb + z1 ) ] ;
           y = addmf( y , 'input' , j , onom , 'gaussmf' , [ sig2( j ) c2( jb , j ) ] ) ;  
       end   
   end
   ola = [ ones( 1 , z1 ) 2*ones( 1 , z2 ) ] ;
   
   for j = 1 : rules
       onom = [ 'OUTP_' , num2str( j ) ] ;
       y = addmf ( y , 'output' , 1 , onom , 'constant' , ola( j ) ) ;   
   end
   rulez = zeros( rules , b + 1 ) ;
   for j = 1 : size( rulez , 1 )
       rulez( j , : ) = j ; 
   end
   rulez = [ rulez ones( rules , 2 ) ] ;
   y = addrule( y , rulez ) ;
end