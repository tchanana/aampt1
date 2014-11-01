function [ output_args ] = Find_distances( plotted_data )
k_dim_data = csvread('C:\Users\TonyHunt\Documents\MATLAB\data\X.csv');
output_args = zeros(1,size(k_dim_data,2));
r = size(k_dim_data,2);
final_distance = zeros(1,size(k_dim_data,1));
for i=1:size(k_dim_data,1)
    final_distance = 0;
        for k=1:r
            final_distance = final_distance + (k_dim_data(i,k)-plotted_data(k))^2; 
        end
        output_args(i) = sqrt(final_distance);
end

end

