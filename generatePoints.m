
function points = generatePoints(q)
%generatePoints This function generates the points for some q

%q = [1 10; 2 20; 3 30; 4 40; 5 50; 6 60];
syms t
%This is the number of points between viapoints.
T_f = 6;
%values where the path is evaluated at
t_val = 1:T_f;
[NUM_OF_VIAPOINTS, NUM_OF_JOINTS] = size(q);

points = zeros(1+(T_f-1)*NUM_OF_VIAPOINTS, NUM_OF_JOINTS);
%size(points)

for i = 1:NUM_OF_JOINTS % for every joint in the robot
    temp = [];
    for j = 1:NUM_OF_VIAPOINTS-1 %every waypoint
    
        
    curr_angle = q(j,i);
    next_angle = q(j+1,i);
    curr = coeffSolver(curr_angle, next_angle, T_f);
    p(t) = curr*[1; t; t^2; t^3; t^4; t^5];
    
    if size(temp) == [0,0]
        temp = p(0); %Catches the edge case for the first value
    end
    temp = [temp; p(t_val).'];
    %points(t+(6*j), i) = p(t_val)
    end
    points(:,i) = temp
    
end
points(:,1) = 0:30
end
