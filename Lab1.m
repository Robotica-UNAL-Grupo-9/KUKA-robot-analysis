%% 5.1
clf
syms q1 q2 q3 q4 q5 q6 real
MF=0.161;
L4(1) = Link('revolute'   ,'alpha',      0,  'a',  0,     'd',    0.340 , 'offset',     0, 'qlim',  [-170*pi/180 170*pi/180],   'modified');
L4(2) = Link('revolute'  ,'alpha',   pi/2,  'a',  0, 'd',    0 , 'offset',    0, 'qlim',       [-120*pi/180 120*pi/180],   'modified');
L4(3) = Link('revolute'   ,'alpha',  -pi/2,  'a',  0,     'd',    0.400 , 'offset',     0, 'qlim',  [-170*pi/180 170*pi/180],   'modified');
L4(4) = Link('revolute'   ,'alpha',  pi/2,  'a',  0,     'd',    0 , 'offset',     0, 'qlim',  [-120*pi/180 120*pi/180],   'modified');
L4(5) = Link('revolute'   ,'alpha',  -pi/2,  'a',  0,     'd',    0.400 , 'offset',     0, 'qlim',  [-170*pi/180 170*pi/180],   'modified');
L4(6) = Link('revolute'   ,'alpha',  pi/2,  'a',  0,     'd',    0 , 'offset',     0, 'qlim',  [-120*pi/180 120*pi/180],   'modified');
L4(7) = Link('revolute'   ,'alpha',  -pi/2,  'a',  0,     'd',    MF , 'offset',     0, 'qlim',  [-175*pi/180 175*pi/180],   'modified');

ws=[-5 2 -4 4 -2 5];

plot_options = {'workspace',ws,'scale',.4,'view',[125 25],'jaxes','basewidth',10};
RKuka = SerialLink(L4,'name','Kuka','plotopt',plot_options)
T0tcp=RKuka.fkine([0,0,0,0,0,0,0]);
%Determinar la posición del último sistema coordenado dado q:
q=[pi/3 pi/6 pi/2 pi/4 3*pi/4 3*pi/4 3*pi/4];
transformRCV=RKuka.fkine(q)
clf
figure()
RKuka.teach(q)
%axis ([-5 40 -70 70 -7 70])
axis equal
% Efector final.
R = [[0 0 -1]' [0 1 0]' [1 0 0]']; % Orientacion de la tool
Ptool = [0.035 .1 0 1]';
R3.tool = [[R;[0 0 0]],Ptool];  % 

%% 5.2

MF=0.161;
dhparams = [0   	0	0.340   	0;
            0	pi/2       0       0
            0	-pi/2	0.400	0;
            0   	pi/2	0	0;
            0       -pi/2	0.400   	0;
            0       pi/2       0       0;
            0       -pi/2       MF       0];
RkukaRST = rigidBodyTree;     
body1 = rigidBody('body1');
jnt1 = rigidBodyJoint('jnt1','revolute');

setFixedTransform(jnt1,dhparams(1,:),'mdh');
body1.Joint = jnt1;

addBody(RkukaRST,body1,'base')
body2 = rigidBody('body2');
jnt2 = rigidBodyJoint('jnt2','revolute');
body3 = rigidBody('body3');
jnt3 = rigidBodyJoint('jnt3','revolute');
body4 = rigidBody('body4');
jnt4 = rigidBodyJoint('jnt4','revolute');
body5 = rigidBody('body5');
jnt5 = rigidBodyJoint('jnt5','revolute');
body6 = rigidBody('body6');
jnt6 = rigidBodyJoint('jnt6','revolute');
body7 = rigidBody('body7');
jnt7 = rigidBodyJoint('jnt7','revolute');

setFixedTransform(jnt2,dhparams(2,:),'mdh');
setFixedTransform(jnt3,dhparams(3,:),'mdh');
setFixedTransform(jnt4,dhparams(4,:),'mdh');
setFixedTransform(jnt5,dhparams(5,:),'mdh');
setFixedTransform(jnt6,dhparams(6,:),'mdh');
setFixedTransform(jnt7,dhparams(7,:),'mdh');
body2.Joint = jnt2;
body3.Joint = jnt3;
body4.Joint = jnt4;
body5.Joint = jnt5;
body6.Joint = jnt6;
body7.Joint = jnt7;
addBody(RkukaRST,body2,'body1')
addBody(RkukaRST,body3,'body2')
addBody(RkukaRST,body4,'body3')
addBody(RkukaRST,body5,'body4')
addBody(RkukaRST,body6,'body5')
addBody(RkukaRST,body7,'body6')

%test=homeConfiguration(RkukaRST)
q=[pi/3 pi/6 pi/2 pi/4 3*pi/4 3*pi/4 3*pi/4];
qRST = struct('JointName',{'jnt1','jnt2','jnt3','jnt4','jnt5','jnt6','jnt7'},'JointPosition',{q(1),q(2),q(3),q(4),q(5),q(6),q(7)});

%motionModel = taskSpaceMotionModel("RigidBodyTree",RkukaRST)
transformRST = getTransform(RkukaRST,qRST,'body7')
clf
figure()
show(RkukaRST,qRST);



