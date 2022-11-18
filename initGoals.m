%% Init goals
%  Sets up goal trajectories for controller to use.

%% Create Simulink message bus. Don't forget to call rosinit before
% Check if the simulink model is open. If not, skip
if ~isempty(gcs)
    ros.createSimulinkBus(gcs)
end

%% Discrete goals
% Initialize left arm of the Baxter robot
states = baxEn();
%  Get starting position from Baxter's current position
bax_sub = rossubscriber('/robot/joint_states', rostype.sensor_msgs_JointState);
%  Get updates for all joints
msg = receive(bax_sub);
states = joint_states(msg,length(msg.Position),states);
initial_position = [0 states'];


%% Goals
%  Setup your goals and interpolate positions here
% goals = initial_position;

pos1 = [0.0, -0.033364082136507746, 0.5832961945934286, 1.342233189399737, 0.29950974883462705, -0.6442719309118737, ...
	-0.5081311359870433, 0.9203884727312482, -3.0595246814374577, 0.30756314797102546, 1.1075341288532687, -1.2931458041874038,... 
	-0.7850146682003605, 0.9426311941555867, 0.6484903780785587, 3.0353644840282623, -12.565987119160338] ;

pos2 = [0.0, -0.03298058693953639, 0.7857816585943032, 1.7767332475682804, -0.25579129637989273, -0.8509758420794333, ...
	-0.7677573843366495, 0.8559612796400609, -3.0591411862404865, 0.07171360183364309, 1.5105875808701612, -0.7386117493668267,... 
	-1.007825377640717, 1.2321700678689587, 0.4601942363656241, 3.0418839023767754, -12.565987119160338];

pos3 = [0.0, -0.0337475773334791, 0.9552865356556414, 1.4227671807637212, -0.46824763550202253, -1.132844811853378, ...
	-0.44753889486556947, 1.3686943579907604, -3.058757691043515, -0.10584467436409355, 1.1336118022473207, -0.5169515255173844, ...
	-1.3065681360814012, 0.9050486648523941, 1.0016894544891752, 3.0418839023767754, -12.565987119160338] ;

pos4 = [0.0, -0.03298058693953639, 0.9694758579435815, 0.4456214188807127, -1.007825377640717, -0.9115680832009071, ...
	-0.5955680408965119, 1.951990552584189, -3.058757691043515, -0.12195147263689039, 0.09242234247009617, ...
	0.05445631796993219, -1.0776215034895031, 1.0653496571864198, 1.6095293416887704, 3.0426508927707183, -12.565987119160338] ;

pos5 = [0.0, -0.03259709174256504, 0.9142525495797066, 1.2532623037023831, -1.4837429170821665, -0.47553404424447826, ...
	-0.8931603137462821, 1.4166312576121796, -3.0579907006495723, -0.056373793954788955, 0.9410972133677014, 0.5537670644266344, ...
	-0.6185777527147931, 1.368310862793789, 1.0289176134741413, 3.0426508927707183, -12.565987119160338] ;

pos6 = [0.0, -0.03259709174256504, 0.5721748338812593, 0.9997719785043184, -1.5301458359157003, 0.20286895919784598, ...
	-1.0162622719740866, 0.5227039534719548, -2.8938547563458332, 0.2688301330769188, 0.654242806033129, 0.5004612320476163, ...
	-0.0395000052880494, 1.4718545659760545, 0.21629129109184334, 2.880432424451836, -12.565987119160338] ;

q = [pos1; pos2; pos3; pos4; pos5; pos6]
goals = generatePoints(q)
% Remember that your theta angles should be saved to a goals variable. The
% goals variable should be an [n by 17] matrix, where n = # of timesteps. 
% Each row of the goals matrix should be formatted as follows:
%   [timestep, left_s0, left_s1, left_e0, left_e1, left_w0, left_w1,...
%       left_w2, right_s0, right_s1, right_e0, right_e1, right_w0,...
%           right_w1, right_w2, left_gripper, right_gripper];

% name: ['head_nod', 'head_pan', 'left_e0', 'left_e1', 'left_s0', 'left_s1', 'left_w0', 'left_w1', 'left_w2', 
% 	'right_e0', 'right_e1', 'right_s0', 'right_s1', 'right_w0', 'right_w1', 'right_w2', 'torso_t0'] 
% -------------------------------------------------------------------------
% % Uncomment this block to test the Simulink model using a set
% % of sample goals. Do not forget to comment this block again when  
% % solving the assignment.

% load('sampleGoals.mat')
% goals = sampleGoals;

% -------------------------------------------------------------------------

