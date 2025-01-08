classdef GraphPlot_Code < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        DPlotTab                        matlab.ui.container.Tab
        Label                           matlab.ui.control.Label
        xmaxSpinner                     matlab.ui.control.Spinner
        ClearButton                     matlab.ui.control.Button
        xmaxSpinnerLabel                matlab.ui.control.Label
        CustomFunctionEditField         matlab.ui.control.EditField
        CustomFunctionEditFieldLabel    matlab.ui.control.Label
        xminSpinner                     matlab.ui.control.Spinner
        DFunctionDropDown               matlab.ui.control.DropDown
        PlotButton                      matlab.ui.control.Button
        DFunctionDropDownLabel          matlab.ui.control.Label
        xminSpinnerLabel                matlab.ui.control.Label
        UIAxes                          matlab.ui.control.UIAxes
        DPlotTab_2                      matlab.ui.container.Tab
        ymaxSpinner                     matlab.ui.control.Spinner
        ymaxSpinnerLabel                matlab.ui.control.Label
        yminSpinner                     matlab.ui.control.Spinner
        yminSpinnerLabel                matlab.ui.control.Label
        CustomFunctionEditField_2       matlab.ui.control.EditField
        CustomFunctionEditField_2Label  matlab.ui.control.Label
        DFunctionDropDown_2             matlab.ui.control.DropDown
        DFunctionLabel                  matlab.ui.control.Label
        xmaxSpinner_2                   matlab.ui.control.Spinner
        xmaxSpinner_2Label              matlab.ui.control.Label
        xminSpinner_2                   matlab.ui.control.Spinner
        xminSpinner_2Label              matlab.ui.control.Label
        Label_2                         matlab.ui.control.Label
        ClearButton_2                   matlab.ui.control.Button
        PlotButton_2                    matlab.ui.control.Button
        UIAxes_2                        matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function: PlotButton, UIAxes
        function PlotButtonPushed(app, event)
            if app.xminSpinner.Value<app.xmaxSpinner.Value
                x=linspace(app.xminSpinner.Value,app.xmaxSpinner.Value);
            else
                x=linspace(-10,10);
            end
            
            app.UIAxes.Title.String=app.DFunctionDropDown.Value;
                        
            switch app.DFunctionDropDown.Value
                case 'sin(x)'
                    plot(app.UIAxes,x,sin(x))
                case 'cos(x)'
                    plot(app.UIAxes,x,cos(x))
                case 'tan(x)'
                    plot(app.UIAxes,x,tan(x))
                case 'Custom'
                    func=app.CustomFunctionEditField.Value;
                    func=replace(func,"X","x");
                    func=replace(func,"Y","y");
                    func=eval(func);
                    plot(app.UIAxes,x,func)
                    app.UIAxes.Title.String=app.CustomFunctionEditField.Value;
            end    
        end

        % Value changed function: DFunctionDropDown
        function DFunctionDropDownValueChanged(app, event)
            app.CustomFunctionEditField.Visible=false;
            app.CustomFunctionEditFieldLabel.Visible=false;
                                   
            switch app.DFunctionDropDown.Value
                case 'Custom'
                    app.CustomFunctionEditField.Visible=true; 
                    app.CustomFunctionEditFieldLabel.Visible=true;               
            end
            
        end

        % Button pushed function: ClearButton
        function ClearButtonPushed(app, event)
            cla(app.UIAxes)
            app.UIAxes.Title.String='';
        end

        % Button pushed function: PlotButton_2
        function PlotButton_2Pushed(app, event)
            if app.xminSpinner_2.Value<app.xmaxSpinner_2.Value
                x=linspace(app.xminSpinner_2.Value,app.xmaxSpinner_2.Value);
            else
                x=linspace(-10,10);
            end
            
            if app.yminSpinner.Value<app.ymaxSpinner.Value
                x=linspace(app.yminSpinner.Value,app.ymaxSpinner.Value);
            else
                y=linspace(-10,10);
            end
            
            [X,Y]=meshgrid(x,y);
            
            app.UIAxes_2.Title.String=app.DFunctionDropDown_2.Value;
                        
            switch app.DFunctionDropDown_2.Value
                case 'sin(x)+cos(y)'
                    surf(app.UIAxes_2,X,Y,sin(X)+cos(Y))
                case 'x.*sin(y)'
                    surf(app.UIAxes_2,X,Y,X.*sin(Y))
                case 'x.^2+y.^2'
                    surf(app.UIAxes_2,X,Y,X.^2+Y.^2)
                case 'Custom'
                    func=app.CustomFunctionEditField_2.Value;
                    func=replace(func,"x","X");
                    func=replace(func,"y","Y");
                    func=eval(func);
                    surf(app.UIAxes_2,X,Y,func)
                    app.UIAxes_2.Title.String=app.CustomFunctionEditField_2.Value;
            end                
        end

        % Value changed function: DFunctionDropDown_2
        function DFunctionDropDown_2ValueChanged(app, event)
            app.CustomFunctionEditField_2.Visible=false;
            app.CustomFunctionEditField_2Label.Visible=false;
                                   
            switch app.DFunctionDropDown_2.Value
                case 'Custom'
                    app.CustomFunctionEditField_2.Visible=true; 
                    app.CustomFunctionEditField_2Label.Visible=true;               
            end
            
        end

        % Button pushed function: ClearButton_2
        function ClearButton_2Pushed(app, event)
            cla(app.UIAxes_2)
            app.UIAxes_2.Title.String='';            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.851 0.7255 0.4941];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 -11 640 492];

            % Create DPlotTab
            app.DPlotTab = uitab(app.TabGroup);
            app.DPlotTab.Title = '2D Plot';
            app.DPlotTab.BackgroundColor = [0.851 0.7255 0.4941];
            app.DPlotTab.ForegroundColor = [0.0431 0.0392 0.051];

            % Create UIAxes
            app.UIAxes = uiaxes(app.DPlotTab);
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.UIAxes.Position = [203 120 414 319];

            % Create xminSpinnerLabel
            app.xminSpinnerLabel = uilabel(app.DPlotTab);
            app.xminSpinnerLabel.HorizontalAlignment = 'right';
            app.xminSpinnerLabel.FontColor = [0.0431 0.0392 0.051];
            app.xminSpinnerLabel.Position = [39 378 31 22];
            app.xminSpinnerLabel.Text = 'xmin';

            % Create DFunctionDropDownLabel
            app.DFunctionDropDownLabel = uilabel(app.DPlotTab);
            app.DFunctionDropDownLabel.HorizontalAlignment = 'right';
            app.DFunctionDropDownLabel.FontColor = [0.0431 0.0392 0.051];
            app.DFunctionDropDownLabel.Position = [19 131 70 22];
            app.DFunctionDropDownLabel.Text = '2D Function';

            % Create PlotButton
            app.PlotButton = uibutton(app.DPlotTab, 'push');
            app.PlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.PlotButton.BackgroundColor = [0.949 0.7451 0.1333];
            app.PlotButton.FontColor = [0.0431 0.0392 0.051];
            app.PlotButton.Position = [360 78 100 22];
            app.PlotButton.Text = 'Plot';

            % Create DFunctionDropDown
            app.DFunctionDropDown = uidropdown(app.DPlotTab);
            app.DFunctionDropDown.Items = {'sin(x)', 'cos(x)', 'tan(x)', 'Custom'};
            app.DFunctionDropDown.ValueChangedFcn = createCallbackFcn(app, @DFunctionDropDownValueChanged, true);
            app.DFunctionDropDown.FontColor = [0.0431 0.0392 0.051];
            app.DFunctionDropDown.Position = [104 131 100 22];
            app.DFunctionDropDown.Value = 'sin(x)';

            % Create xminSpinner
            app.xminSpinner = uispinner(app.DPlotTab);
            app.xminSpinner.FontColor = [0.0431 0.0392 0.051];
            app.xminSpinner.Position = [83 378 100 22];

            % Create CustomFunctionEditFieldLabel
            app.CustomFunctionEditFieldLabel = uilabel(app.DPlotTab);
            app.CustomFunctionEditFieldLabel.HorizontalAlignment = 'right';
            app.CustomFunctionEditFieldLabel.FontColor = [0.0431 0.0392 0.051];
            app.CustomFunctionEditFieldLabel.Visible = 'off';
            app.CustomFunctionEditFieldLabel.Position = [19 89 96 22];
            app.CustomFunctionEditFieldLabel.Text = 'Custom Function';

            % Create CustomFunctionEditField
            app.CustomFunctionEditField = uieditfield(app.DPlotTab, 'text');
            app.CustomFunctionEditField.FontColor = [0.0431 0.0392 0.051];
            app.CustomFunctionEditField.Visible = 'off';
            app.CustomFunctionEditField.Position = [130 89 100 22];
            app.CustomFunctionEditField.Value = 'x.*sin(x)';

            % Create xmaxSpinnerLabel
            app.xmaxSpinnerLabel = uilabel(app.DPlotTab);
            app.xmaxSpinnerLabel.HorizontalAlignment = 'right';
            app.xmaxSpinnerLabel.Position = [36 328 34 22];
            app.xmaxSpinnerLabel.Text = 'xmax';

            % Create ClearButton
            app.ClearButton = uibutton(app.DPlotTab, 'push');
            app.ClearButton.ButtonPushedFcn = createCallbackFcn(app, @ClearButtonPushed, true);
            app.ClearButton.BackgroundColor = [0.949 0.6627 0.1333];
            app.ClearButton.FontColor = [0.0431 0.0392 0.051];
            app.ClearButton.Position = [360 36 100 22];
            app.ClearButton.Text = 'Clear';

            % Create xmaxSpinner
            app.xmaxSpinner = uispinner(app.DPlotTab);
            app.xmaxSpinner.FontColor = [0.0431 0.0392 0.051];
            app.xmaxSpinner.Position = [82 328 100 22];

            % Create Label
            app.Label = uilabel(app.DPlotTab);
            app.Label.HorizontalAlignment = 'center';
            app.Label.WordWrap = 'on';
            app.Label.FontColor = [0.0431 0.0392 0.051];
            app.Label.Position = [37 178 145 112];
            app.Label.Text = {'WARNING!'; 'If you write a custom function, it is important to use the dot notation. '; 'Examples:'; 'x.*sin(x)'; 'x.^2'; '2*sin(x)'};

            % Create DPlotTab_2
            app.DPlotTab_2 = uitab(app.TabGroup);
            app.DPlotTab_2.Title = '3D Plot';
            app.DPlotTab_2.BackgroundColor = [0.851 0.7255 0.4941];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.DPlotTab_2);
            xlabel(app.UIAxes_2, 'X')
            ylabel(app.UIAxes_2, 'Y')
            zlabel(app.UIAxes_2, 'Z')
            app.UIAxes_2.XGrid = 'on';
            app.UIAxes_2.YGrid = 'on';
            app.UIAxes_2.Position = [203 120 414 319];

            % Create PlotButton_2
            app.PlotButton_2 = uibutton(app.DPlotTab_2, 'push');
            app.PlotButton_2.ButtonPushedFcn = createCallbackFcn(app, @PlotButton_2Pushed, true);
            app.PlotButton_2.BackgroundColor = [0.949 0.7451 0.1333];
            app.PlotButton_2.FontColor = [0.0431 0.0392 0.051];
            app.PlotButton_2.Position = [398 78 100 22];
            app.PlotButton_2.Text = 'Plot';

            % Create ClearButton_2
            app.ClearButton_2 = uibutton(app.DPlotTab_2, 'push');
            app.ClearButton_2.ButtonPushedFcn = createCallbackFcn(app, @ClearButton_2Pushed, true);
            app.ClearButton_2.BackgroundColor = [0.949 0.6627 0.1333];
            app.ClearButton_2.FontColor = [0.0431 0.0392 0.051];
            app.ClearButton_2.Position = [398 36 100 22];
            app.ClearButton_2.Text = 'Clear';

            % Create Label_2
            app.Label_2 = uilabel(app.DPlotTab_2);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.WordWrap = 'on';
            app.Label_2.FontColor = [0.0431 0.0392 0.051];
            app.Label_2.Position = [39 134 145 112];
            app.Label_2.Text = {'WARNING!'; 'If you write a custom function, it is important to use the dot notation. '; 'Examples:'; 'x.*sin(x)'; 'x.^2'; '2*sin(x)'};

            % Create xminSpinner_2Label
            app.xminSpinner_2Label = uilabel(app.DPlotTab_2);
            app.xminSpinner_2Label.HorizontalAlignment = 'right';
            app.xminSpinner_2Label.FontColor = [0.0431 0.0392 0.051];
            app.xminSpinner_2Label.Position = [37 389 31 22];
            app.xminSpinner_2Label.Text = 'xmin';

            % Create xminSpinner_2
            app.xminSpinner_2 = uispinner(app.DPlotTab_2);
            app.xminSpinner_2.FontColor = [0.0431 0.0392 0.051];
            app.xminSpinner_2.Position = [83 389 100 22];

            % Create xmaxSpinner_2Label
            app.xmaxSpinner_2Label = uilabel(app.DPlotTab_2);
            app.xmaxSpinner_2Label.HorizontalAlignment = 'right';
            app.xmaxSpinner_2Label.FontColor = [0.0431 0.0392 0.051];
            app.xmaxSpinner_2Label.Position = [37 348 34 22];
            app.xmaxSpinner_2Label.Text = 'xmax';

            % Create xmaxSpinner_2
            app.xmaxSpinner_2 = uispinner(app.DPlotTab_2);
            app.xmaxSpinner_2.FontColor = [0.0431 0.0392 0.051];
            app.xmaxSpinner_2.Position = [83 348 100 22];

            % Create DFunctionLabel
            app.DFunctionLabel = uilabel(app.DPlotTab_2);
            app.DFunctionLabel.HorizontalAlignment = 'right';
            app.DFunctionLabel.FontColor = [0.0431 0.0392 0.051];
            app.DFunctionLabel.Position = [19 78 70 22];
            app.DFunctionLabel.Text = '3D Function';

            % Create DFunctionDropDown_2
            app.DFunctionDropDown_2 = uidropdown(app.DPlotTab_2);
            app.DFunctionDropDown_2.Items = {'sin(x)+cos(y)', 'x.*sin(y)', 'x.^2+y.^2', 'Custom'};
            app.DFunctionDropDown_2.ValueChangedFcn = createCallbackFcn(app, @DFunctionDropDown_2ValueChanged, true);
            app.DFunctionDropDown_2.FontColor = [0.0431 0.0392 0.051];
            app.DFunctionDropDown_2.Position = [104 78 112 22];
            app.DFunctionDropDown_2.Value = 'sin(x)+cos(y)';

            % Create CustomFunctionEditField_2Label
            app.CustomFunctionEditField_2Label = uilabel(app.DPlotTab_2);
            app.CustomFunctionEditField_2Label.HorizontalAlignment = 'right';
            app.CustomFunctionEditField_2Label.FontColor = [0.0431 0.0392 0.051];
            app.CustomFunctionEditField_2Label.Visible = 'off';
            app.CustomFunctionEditField_2Label.Position = [19 36 96 22];
            app.CustomFunctionEditField_2Label.Text = 'Custom Function';

            % Create CustomFunctionEditField_2
            app.CustomFunctionEditField_2 = uieditfield(app.DPlotTab_2, 'text');
            app.CustomFunctionEditField_2.FontColor = [0.0431 0.0392 0.051];
            app.CustomFunctionEditField_2.Visible = 'off';
            app.CustomFunctionEditField_2.Position = [130 36 100 22];
            app.CustomFunctionEditField_2.Value = 'y.*sin(x)';

            % Create yminSpinnerLabel
            app.yminSpinnerLabel = uilabel(app.DPlotTab_2);
            app.yminSpinnerLabel.HorizontalAlignment = 'right';
            app.yminSpinnerLabel.FontColor = [0.0431 0.0392 0.051];
            app.yminSpinnerLabel.Position = [37 307 31 22];
            app.yminSpinnerLabel.Text = 'ymin';

            % Create yminSpinner
            app.yminSpinner = uispinner(app.DPlotTab_2);
            app.yminSpinner.FontColor = [0.0431 0.0392 0.051];
            app.yminSpinner.Position = [83 307 100 22];

            % Create ymaxSpinnerLabel
            app.ymaxSpinnerLabel = uilabel(app.DPlotTab_2);
            app.ymaxSpinnerLabel.HorizontalAlignment = 'right';
            app.ymaxSpinnerLabel.FontColor = [0.0431 0.0392 0.051];
            app.ymaxSpinnerLabel.Position = [37 268 34 22];
            app.ymaxSpinnerLabel.Text = 'ymax';

            % Create ymaxSpinner
            app.ymaxSpinner = uispinner(app.DPlotTab_2);
            app.ymaxSpinner.FontColor = [0.0431 0.0392 0.051];
            app.ymaxSpinner.Position = [83 268 100 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GraphPlot_Code

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