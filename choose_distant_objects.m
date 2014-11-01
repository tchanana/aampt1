function [ Oa,Ob ] = choose_distant_objects( object_distances )

n = size(object_distances,1);
Ob = randi(n);
[~,Oa] = max(object_distances(Ob,:));
[~,Ob] = max(object_distances(Oa,:));


end
