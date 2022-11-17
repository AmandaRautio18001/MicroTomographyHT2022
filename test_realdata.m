clc 
clear all 
close all 

load surfacePoint11171430.mat ;
% Plot raw data
figure; hold on
for spline_ind = 1:size(surfacePoint,3)
    scatter3(surfacePoint(:,1,spline_ind),surfacePoint(:,2,spline_ind),surfacePoint(:,3,spline_ind))
    view(3)
    drawnow
    
end
%%
% Find minimum 
min_z = min(surfacePoint(:,3,:),[],'all'); 
% find index 
[row_ind, spline_ind] = find(surfacePoint(:,3,:) == min_z);
% Find min Z point 
min_point = surfacePoint(row_ind, : , spline_ind);

% add min point to all splines
for spline_ind = 1:size(surfacePoint,3)
    first_nan = find(isnan (surfacePoint(:,1,spline_ind)),1, 'first');
    surfacePoint(first_nan,:,spline_ind) = min_point;
end

%% Spline interpolation 
% number of equidistant points to use while interpolating. 
n_int_points = 8;

% step size for sampling from splines 
delta_z = 0.5; 
% Sampling in Z dimension 
num_points = round(abs(min_z/delta_z));
z_uniform = linspace(0,min_z,num_points);

points_uniform = zeros(num_points, 3, size(surfacePoint,3));

for spline_ind = 1:size(surfacePoint,3)
    % Choose interpolation points 
    first_nan = find(isnan (surfacePoint(:,1,spline_ind)),1, 'first');
    index_list = round(linspace(1,first_nan-1, n_int_points));

    % Interpolate 
    points_z = surfacePoint(index_list,3,spline_ind);
    points_x = surfacePoint(index_list,1,spline_ind);
    points_y = surfacePoint(index_list,2,spline_ind);
    ppx = spline (points_z,points_x);
    ppy= spline (points_z,points_y);


    % Create Points 
    points_uniform(:,1,spline_ind) = ppval(ppx,z_uniform );
    points_uniform(:,2,spline_ind) = ppval(ppy,z_uniform );
    points_uniform(:,3,spline_ind) = z_uniform;

end
%% Plot results
figure; hold on; 
for i = 1: size(points_uniform, 3)
    plot3(points_uniform(:,1,i),points_uniform(:,2,i),points_uniform(:,3,i),'blue')
    scatter3(points_uniform(:,1,i),points_uniform(:,2,i),points_uniform(:,3,i),'red','*')
    scatter3(surfacePoint(:,1,i),surfacePoint(:,2,i),surfacePoint(:,3,i),'black', 'filled')    
end
legend( 'Splines interpolated', 'Unifrom sample', 'Sampled points')

%%
figure; hold on
for spline_ind = 1:size(surfacePoint,3)
    scatter3(surfacePoint(:,1,spline_ind),surfacePoint(:,2,spline_ind),surfacePoint(:,3,spline_ind))
    view(3)
    drawnow
    
end

%% Clean files from nan Run once to get files in current folder 
% for i = 1:size(surfacePoint,3)
%     FileName=[num2str(i),'points.csv'];
%     %csvwrite(FileName,surfacePoint(:,:,i))
%     data = readtable(FileName);
%     data = table2array(data);
%     B = isnan(data);
%     data(B(:,1),:)= [];
%     csvwrite(FileName,surfacePoint(:,:,i))  
% end
%%
boundary_height = 100;
z_step_size = 0.5;
num_z_step = (boundary_height)/(z_step_size); % number of steps
zz =  linspace(-z_step_size,-boundary_height, num_z_step);

ppoints = zeros(length(zz),3,21);

figure;hold on;
for i = 1:size(surfacePoint,3)
    FileName=[num2str(i),'points.csv'];
    %csvwrite(FileName,surfacePoint(:,:,i))
    data = readtable(FileName);
    data = table2array(data);
    B = isnan(data);
    data(B(:,1),:)= [];
    scatter3(data(:,1),data(:,2),data(:,3))
    ppx = spline_ind (data(:,3),data(:,1));
    ppy= spline_ind (data(:,3),data(:,2));

    ppoints(:,1,i) = ppval(ppx,zz);
    ppoints(:,2,i) = ppval(ppy,zz);
    ppoints(:,3,i) = zz;

end



%%
    figure;hold on;
for i = 1:size(ppoints,3)
    
    scatter3(ppoints(:,1,i),ppoints(:,2,i),ppoints(:,3,i))
    
end

%%
figure;hold on;
for i = 1:size(surfacePoint,3)
    scatter3(points(:,1,i),points(:,2,i),points(:,3,i))
    view(3)
    drawnow
end


