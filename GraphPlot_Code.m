classdef GraphPlot_Code < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        TabGroup                      matlab.ui.container.TabGroup
        DPlotTab                      matlab.ui.container.Tab
        Label                         matlab.ui.control.Label
        xmaxSpinner                   matlab.ui.control.Spinner
        ClearButton                   matlab.ui.control.Button
        xmaxSpinnerLabel              matlab.ui.control.Label
        CustomFunctionEditField       matlab.ui.control.EditField
        CustomFunctionEditFieldLabel  matlab.ui.control.Label
        xminSpinner                   matlab.ui.control.Spinner
        DFunctionDropDown             matlab.ui.control.DropDown
        PlotButton                    matlab.ui.control.Button
        DFunctionDropDownLabel        matlab.ui.control.Label
        xminSpinnerLabel              matlab.ui.control.Label
        UIAxes                        matlab.ui.control.UIAxes
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
                    func=eval(app.CustomFunctionEditField.Value);
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
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 -11 640 492];

            % Create DPlotTab
            app.DPlotTab = uitab(app.TabGroup);
            app.DPlotTab.Title = '2D Plot';

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
            app.xminSpinnerLabel.Position = [37 389 31 22];
            app.xminSpinnerLabel.Text = 'xmin';

            % Create DFunctionDropDownLabel
            app.DFunctionDropDownLabel = uilabel(app.DPlotTab);
            app.DFunctionDropDownLabel.HorizontalAlignment = 'right';
            app.DFunctionDropDownLabel.Position = [19 78 70 22];
            app.DFunctionDropDownLabel.Text = '2D Function';

            % Create PlotButton
            app.PlotButton = uibutton(app.DPlotTab, 'push');
            app.PlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.PlotButton.Position = [398 78 100 22];
            app.PlotButton.Text = 'Plot';

            % Create DFunctionDropDown
            app.DFunctionDropDown = uidropdown(app.DPlotTab);
            app.DFunctionDropDown.Items = {'sin(x)', 'cos(x)', 'tan(x)', 'Custom'};
            app.DFunctionDropDown.ValueChangedFcn = createCallbackFcn(app, @DFunctionDropDownValueChanged, true);
            app.DFunctionDropDown.Position = [104 78 100 22];
            app.DFunctionDropDown.Value = 'sin(x)';

            % Create xminSpinner
            app.xminSpinner = uispinner(app.DPlotTab);
            app.xminSpinner.Position = [83 389 100 22];

            % Create CustomFunctionEditFieldLabel
            app.CustomFunctionEditFieldLabel = uilabel(app.DPlotTab);
            app.CustomFunctionEditFieldLabel.HorizontalAlignment = 'right';
            app.CustomFunctionEditFieldLabel.Visible = 'off';
            app.CustomFunctionEditFieldLabel.Position = [19 36 96 22];
            app.CustomFunctionEditFieldLabel.Text = 'Custom Function';

            % Create CustomFunctionEditField
            app.CustomFunctionEditField = uieditfield(app.DPlotTab, 'text');
            app.CustomFunctionEditField.Visible = 'off';
            app.CustomFunctionEditField.Position = [130 36 100 22];
            app.CustomFunctionEditField.Value = 'x.*sin(x)';

            % Create xmaxSpinnerLabel
            app.xmaxSpinnerLabel = uilabel(app.DPlotTab);
            app.xmaxSpinnerLabel.HorizontalAlignment = 'right';
            app.xmaxSpinnerLabel.Position = [37 348 34 22];
            app.xmaxSpinnerLabel.Text = 'xmax';

            % Create ClearButton
            app.ClearButton = uibutton(app.DPlotTab, 'push');
            app.ClearButton.ButtonPushedFcn = createCallbackFcn(app, @ClearButtonPushed, true);
            app.ClearButton.Position = [398 36 100 22];
            app.ClearButton.Text = 'Clear';

            % Create xmaxSpinner
            app.xmaxSpinner = uispinner(app.DPlotTab);
            app.xmaxSpinner.Position = [83 348 100 22];

            % Create Label
            app.Label = uilabel(app.DPlotTab);
            app.Label.HorizontalAlignment = 'center';
            app.Label.WordWrap = 'on';
            app.Label.Position = [38 144 145 112];
            app.Label.Text = {'WARNING!'; 'If you write a custom function, it is important to use the dot notation. '; 'Examples:'; 'x.*sin(x)'; 'x.^2'; '2*sin(x)'};

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