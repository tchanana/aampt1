function [ final_distance ] = Eucl( X )

N = size(X,1);
r = size(X,2);
final_distance = zeros(N);


for i=1:N
    for j=1:N
        for k=1:r
            final_distance(i,j) = final_distance(i,j) + (X(i,k)-X(j,k))^2; 
        end
        final_distance(i,j) = sqrt(final_distance(i,j));
       
    end
end

end