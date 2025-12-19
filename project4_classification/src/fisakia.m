% ILIAS KOROMPILIS

function y = fisakia( m , c1 , c2 , c3 , c4 , c5 , sig1 , sig2 , sig3 , sig4 , sig5 )

b = m - 1 ;
   z1 = size ( c1 , 1 ) ;    
   z2 = size( c2 , 1 ) ;   
   z3 = size( c3 , 1 ) ;    
   z4 = size( c4 , 1 ) ;     
   z5 = size( c5 , 1 ) ;
   rules = z1 + z2 + z3 + z4 + z5 ;
   y = newfis( 'fisakias' , 'sugeno' ) ;
   for j = 1 : b
      y = addvar ( y , 'input' , [ 'in_' , num2str( j ) ] , [ 0 1 ] ) ;
   end
   y = addvar( y , 'output' , 'Output1' , [ 1 2 ] ) ;
   for j = 1 : b
       for k = 1 : z1
           onom = [ 'mf_' , num2str( ( rules ) * ( j - 1 ) + k ) ] ;
           y = addmf( y , 'input' , j , onom , 'gaussmf' , [ sig1( j ) c1( k , j ) ] ) ; 
       end
       for k = 1 : z2
           onom = [ 'mf_' , num2str( ( rules ) * ( j - 1 ) + k + z1 ) ] ;
           y = addmf ( y , 'input' , j , onom , 'gaussmf' , [ sig2( j ) c2( k , j ) ] ) ; 
       end
       for k = 1 : z3
           onom = [ 'mf_' , num2str( ( rules ) * ( j - 1 ) + k + z1 + z2 ) ] ;
           y = addmf( y , 'input' , j , onom , 'gaussmf' , [ sig3( j ) c3( k , j ) ] ) ; 
       end
       for k = 1 : z4
        onom = [ 'mf_' , num2str( ( rules ) * ( j - 1 ) + k + z1 + z2 + z3 ) ] ;
        y = addmf( y , 'input' , j , onom , 'gaussmf' , [ sig4( j ) c4( k , j ) ] ) ;
       end
       for k = 1 : z5
        onom = [ 'mf_' , num2str( ( rules ) * ( j - 1 ) + k + z1 + z2 + z3 + z4 ) ] ;
        y = addmf( y , 'input' , j , onom, 'gaussmf' , [ sig5( j ) c5(k , j ) ] ) ;
       end 
   end
   staths = [ ones( 1 , z1 ) 2*ones( 1 , z2 ) 3*ones( 1 , z3 ) 4*ones( 1 , z4 ) 5*ones( 1 , z5 ) ] ;
   for j = 1 : rules
       onom = [ 'out_' , num2str( j ) ] ;
       y = addmf( y , 'output' , 1 , onom , 'constant' , staths( j ) ) ; 
   end
   listar = zeros( rules , b + 1 ) ;
   for j = 1 : size( listar , 1 )
       listar( j , : ) = j ; 
   end
   listar = [ listar ones( rules , 2 ) ] ;
   y = addrule( y , listar ) ;
end