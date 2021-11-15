classdef KUKA_robot_interface < matlab.apps.AppBase

  % Properties that correspond to app components
  properties (Access = public)
    UIFigure       matlab.ui.Figure
    HomeButton     matlab.ui.control.Button
    A1SliderLabel  matlab.ui.control.Label
    A1Slider       matlab.ui.control.Slider
    A7SliderLabel  matlab.ui.control.Label
    A7Slider       matlab.ui.control.Slider
    A6SliderLabel  matlab.ui.control.Label
    A6Slider       matlab.ui.control.Slider
    A5SliderLabel  matlab.ui.control.Label
    A5Slider       matlab.ui.control.Slider
    A4SliderLabel  matlab.ui.control.Label
    A4Slider       matlab.ui.control.Slider
    A3SliderLabel  matlab.ui.control.Label
    A3Slider       matlab.ui.control.Slider
    A2SliderLabel  matlab.ui.control.Label
    A2Slider       matlab.ui.control.Slider
    UIAxes         matlab.ui.control.UIAxes
  end

  
  methods (Access = private)
    
    function update_robot(app,value,k)
          syms q1 q2 q3 q4 q5 q6 real
          MF=0.120;
          L4(1) = Link('revolute'   ,'alpha',      0,  'a',  0,     'd',    0.340 , 'offset',     0, 'qlim',  [-170*pi/180 170*pi/180],   'modified');
          L4(2) = Link('revolute'  ,'alpha',   pi/2,  'a',  0, 'd',    0 , 'offset',    0, 'qlim',       [-120*pi/180 120*pi/180],   'modified');
          L4(3) = Link('revolute'   ,'alpha',  -pi/2,  'a',  0,     'd',    0.400 , 'offset',     0, 'qlim',  [-170*pi/180 170*pi/180],   'modified');
          L4(4) = Link('revolute'   ,'alpha',  pi/2,  'a',  0,     'd',    0 , 'offset',     0, 'qlim',  [-120*pi/180 120*pi/180],   'modified');
          L4(5) = Link('revolute'   ,'alpha',  -pi/2,  'a',  0,     'd',    0.400 , 'offset',     0, 'qlim',  [-170*pi/180 170*pi/180],   'modified');
          L4(6) = Link('revolute'   ,'alpha',  pi/2,  'a',  0,     'd',    0 , 'offset',     0, 'qlim',  [-120*pi/180 120*pi/180],   'modified');
          L4(7) = Link('revolute'   ,'alpha',  -pi/2,  'a',  0,     'd',    MF , 'offset',     0, 'qlim',  [-175*pi/180 175*pi/180],   'modified');
          
          ws=[-5 2 -4 4 -2 5];
          
          plot_options = {'workspace',ws,'scale',.4,'view',[125 25],'trail','-','jaxes','basewidth',10};
          RKuka = SerialLink(L4,'name','Kuka','plotopt',plot_options)
          T0tcp=RKuka.fkine([0,0,0,0,0,0,0]);
          %Determinar la posición del último sistema coordenado dado q:
          q=[pi/3 pi/6 pi/2 pi/4 3*pi/4 3*pi/4 3*pi/4];
          
          %update value
          q(k)=value;
          
          transformRCV=RKuka.fkine(q);
          
          app.UIFigure.HandleVisibility = 'callback';
          
          plot(RKuka,q)
          
          app.UIFigure.HandleVisibility = 'off';
    end
  end
  

  % Callbacks that handle component events
  methods (Access = private)

    % Value changed function: A2Slider
    function A2SliderValueChanged(app, event)
      value = app.A2Slider.Value;
       update_robot(app,value,2);

    end

    % Value changed function: A3Slider
    function A3SliderValueChanged(app, event)
      value = app.A3Slider.Value;
       update_robot(app,value,3);

    end

    % Value changed function: A1Slider
    function A1SliderValueChanged(app, event)
      value = app.A1Slider.Value;
      update_robot(app,value,1);

    end

    % Value changed function: A4Slider
    function A4SliderValueChanged(app, event)
      value = app.A4Slider.Value;
      update_robot(app,value,4);

    end

    % Value changed function: A5Slider
    function A5SliderValueChanged(app, event)
      value = app.A5Slider.Value;
      update_robot(app,value,5);

    end

    % Value changed function: A6Slider
    function A6SliderValueChanged(app, event)
      value = app.A6Slider.Value;
      update_robot(app,value,6);

    end

    % Value changed function: A7Slider
    function A7SliderValueChanged(app, event)
      value = app.A7Slider.Value;
      update_robot(app,value,7);

    end

    % Button pushed function: HomeButton
    function HomeButtonPushed(app, event)
      value=zeros(1,7);
      update_robot(app,value,1:7);
      
      app.A1Slider.Value=value(1);
      app.A2Slider.Value=value(2);
      app.A3Slider.Value=value(3);
      app.A4Slider.Value=value(4);
      app.A5Slider.Value=value(5);
      app.A6Slider.Value=value(6);
      app.A7Slider.Value=value(7);
      
    end
  end

  % Component initialization
  methods (Access = private)

    % Create UIFigure and components
    function createComponents(app)

      % Create UIFigure and hide until all components are created
      app.UIFigure = uifigure('Visible', 'off');
      app.UIFigure.Position = [100 100 643 553];
      app.UIFigure.Name = 'MATLAB App';

      % Create UIAxes
      app.UIAxes = uiaxes(app.UIFigure);
      title(app.UIAxes, 'Robot KUKA LBR iiwa 7 R800')
      xlabel(app.UIAxes, 'X')
      ylabel(app.UIAxes, 'Y')
      zlabel(app.UIAxes, 'Z')
      app.UIAxes.Position = [45 301 485 221];

      % Create A2Slider
      app.A2Slider = uislider(app.UIFigure);
      app.A2Slider.Limits = [-120 120];
      app.A2Slider.ValueChangedFcn = createCallbackFcn(app, @A2SliderValueChanged, true);
      app.A2Slider.Position = [130 134 150 3];

      % Create A2SliderLabel
      app.A2SliderLabel = uilabel(app.UIFigure);
      app.A2SliderLabel.HorizontalAlignment = 'right';
      app.A2SliderLabel.Position = [84 125 25 22];
      app.A2SliderLabel.Text = 'A2';

      % Create A3Slider
      app.A3Slider = uislider(app.UIFigure);
      app.A3Slider.Limits = [-170 170];
      app.A3Slider.ValueChangedFcn = createCallbackFcn(app, @A3SliderValueChanged, true);
      app.A3Slider.Position = [129 71 150 3];

      % Create A3SliderLabel
      app.A3SliderLabel = uilabel(app.UIFigure);
      app.A3SliderLabel.HorizontalAlignment = 'right';
      app.A3SliderLabel.Position = [83 62 25 22];
      app.A3SliderLabel.Text = 'A3';

      % Create A4Slider
      app.A4Slider = uislider(app.UIFigure);
      app.A4Slider.Limits = [-120 120];
      app.A4Slider.ValueChangedFcn = createCallbackFcn(app, @A4SliderValueChanged, true);
      app.A4Slider.Position = [439 263 150 3];

      % Create A4SliderLabel
      app.A4SliderLabel = uilabel(app.UIFigure);
      app.A4SliderLabel.HorizontalAlignment = 'right';
      app.A4SliderLabel.Position = [393 254 25 22];
      app.A4SliderLabel.Text = 'A4';

      % Create A5Slider
      app.A5Slider = uislider(app.UIFigure);
      app.A5Slider.Limits = [-170 170];
      app.A5Slider.ValueChangedFcn = createCallbackFcn(app, @A5SliderValueChanged, true);
      app.A5Slider.Position = [439 202 150 3];

      % Create A5SliderLabel
      app.A5SliderLabel = uilabel(app.UIFigure);
      app.A5SliderLabel.HorizontalAlignment = 'right';
      app.A5SliderLabel.Position = [393 193 25 22];
      app.A5SliderLabel.Text = 'A5';

      % Create A6Slider
      app.A6Slider = uislider(app.UIFigure);
      app.A6Slider.Limits = [-120 120];
      app.A6Slider.ValueChangedFcn = createCallbackFcn(app, @A6SliderValueChanged, true);
      app.A6Slider.Position = [440 134 150 3];

      % Create A6SliderLabel
      app.A6SliderLabel = uilabel(app.UIFigure);
      app.A6SliderLabel.HorizontalAlignment = 'right';
      app.A6SliderLabel.Position = [394 125 25 22];
      app.A6SliderLabel.Text = 'A6';

      % Create A7Slider
      app.A7Slider = uislider(app.UIFigure);
      app.A7Slider.Limits = [-175 175];
      app.A7Slider.ValueChangedFcn = createCallbackFcn(app, @A7SliderValueChanged, true);
      app.A7Slider.Position = [438 71 150 3];

      % Create A7SliderLabel
      app.A7SliderLabel = uilabel(app.UIFigure);
      app.A7SliderLabel.HorizontalAlignment = 'right';
      app.A7SliderLabel.Position = [392 62 25 22];
      app.A7SliderLabel.Text = 'A7';

      % Create A1Slider
      app.A1Slider = uislider(app.UIFigure);
      app.A1Slider.Limits = [-170 170];
      app.A1Slider.ValueChangedFcn = createCallbackFcn(app, @A1SliderValueChanged, true);
      app.A1Slider.Position = [130 214 150 3];

      % Create A1SliderLabel
      app.A1SliderLabel = uilabel(app.UIFigure);
      app.A1SliderLabel.HorizontalAlignment = 'right';
      app.A1SliderLabel.Position = [84 205 25 22];
      app.A1SliderLabel.Text = 'A1';

      % Create HomeButton
      app.HomeButton = uibutton(app.UIFigure, 'push');
      app.HomeButton.ButtonPushedFcn = createCallbackFcn(app, @HomeButtonPushed, true);
      app.HomeButton.Position = [130 247 86 30];
      app.HomeButton.Text = 'Home';

      % Show the figure after all components are created
      app.UIFigure.Visible = 'on';
    end
  end

  % App creation and deletion
  methods (Access = public)

    % Construct app
    function app = KUKA_robot_interface

      % Create UIFigure and components
      createComponents(app)

      % Register the app with App Designer
      registerApp(app, app.UIFigure)

      if nargout == 0
        clear app
      end
    end

    % Code that executes before app deletion
    function delete(app)

      % Delete UIFigure when app is deleted
      delete(app.UIFigure)
    end
  end
end
