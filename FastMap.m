function [  ] = FastMap( r,object_distances )

N = size(object_distances,1);
global X;
global PA;
global col;

if r<=0
      return ;
else
    col= col+1;
end

[PA(1,col),PA(2,col)] = choose_distant_objects(object_distances);
 if(object_distances(PA(1,col),PA(2,col)) ~= 0)
     for i=1:N,
         Ai = object_distances(PA(1,col),i);
         Bi = object_distances(PA(2,col),i);
         AB = object_distances(PA(1,col),PA(2,col));
         X(i,col) = projection(Ai,Bi,AB);
     end
 end    
dist_hyper_plane = project_on_hyper_plane(object_distances,X,col);

FastMap(r-1,dist_hyper_plane);


 
end
