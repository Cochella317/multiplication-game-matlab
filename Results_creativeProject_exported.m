classdef Results_creativeProject_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        ThisgraphshowsthetimeithastakentoanswereachquestionLabel  matlab.ui.control.Label
        AboutTimeTakenLabel         matlab.ui.control.Label
        Label                       matlab.ui.control.Label
        AboutEMALabel               matlab.ui.control.Label
        ClicktoShowTimeTakenButton  matlab.ui.control.Button
        MoreInformationAboutAttemptLabel  matlab.ui.control.Label
        ClicktoShowTrendButton      matlab.ui.control.Button
        UIAxes2                     matlab.ui.control.UIAxes
        UIAxes                      matlab.ui.control.UIAxes
    end

    
    properties (Access = public)
        %bring EMA list and time to app
        EMA_list 
        time_total_list
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: ClicktoShowTrendButton
        function ClicktoShowTrendButtonPushed(app, event)
            app.EMA_list
            %plots question # and EMA value on top graph
            x = 1:15; 
            y = app.EMA_list; 
            plot(app.UIAxes, x, y)
        end

        % Button pushed function: ClicktoShowTimeTakenButton
        function ClicktoShowTimeTakenButtonPushed(app, event)
            app.time_total_list 
            %plots time it takes for each question to be answered 
            a = 1:15; 
            b = app.time_total_list; 
            plot(app.UIAxes2, a, b)

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9922 0.7922 0.251];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes (for EMA Trend)
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, {'Exponential Moving Average (EMA) Trend'; ''})
            xlabel(app.UIAxes, 'Question Number')
            ylabel(app.UIAxes, 'EMA Value')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.FontWeight = 'bold';
            app.UIAxes.XLim = [0 15];
            app.UIAxes.YLim = [-0.3 0.3];
            app.UIAxes.MinorGridLineStyle = 'none';
            app.UIAxes.XTick = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
            app.UIAxes.XTickLabel = {'1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; '15'};
            app.UIAxes.YTick = [-0.3 -0.2 -0.1 0 0.1 0.2 0.3];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.XMinorGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.FontSize = 10;
            app.UIAxes.Position = [17 245 338 202];

            % Create UIAxes2 (for Time Taken)
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Time Taken to Answer Question')
            xlabel(app.UIAxes2, 'Question Number')
            ylabel(app.UIAxes2, 'Time Taken (seconds)')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.FontWeight = 'bold';
            app.UIAxes2.XLim = [0 15];
            app.UIAxes2.YLim = [0 10];
            app.UIAxes2.MinorGridLineStyle = '-';
            app.UIAxes2.XTick = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
            app.UIAxes2.XGrid = 'on';
            app.UIAxes2.YGrid = 'on';
            app.UIAxes2.FontSize = 10;
            app.UIAxes2.Position = [23 38 325 189];

            % Create ClicktoShowTrendButton
            app.ClicktoShowTrendButton = uibutton(app.UIFigure, 'push');
            app.ClicktoShowTrendButton.ButtonPushedFcn = createCallbackFcn(app, @ClicktoShowTrendButtonPushed, true);
            app.ClicktoShowTrendButton.BackgroundColor = [0.2157 0.4471 1];
            app.ClicktoShowTrendButton.FontColor = [1 1 1];
            app.ClicktoShowTrendButton.Position = [362 281 123 23];
            app.ClicktoShowTrendButton.Text = 'Click to Show Trend';

            % Create MoreInformationAboutAttemptLabel
            app.MoreInformationAboutAttemptLabel = uilabel(app.UIFigure);
            app.MoreInformationAboutAttemptLabel.FontName = 'Ayuthaya';
            app.MoreInformationAboutAttemptLabel.FontSize = 20;
            app.MoreInformationAboutAttemptLabel.FontWeight = 'bold';
            app.MoreInformationAboutAttemptLabel.Position = [145 446 371 27];
            app.MoreInformationAboutAttemptLabel.Text = 'More Information About Attempt';

            % Create ClicktoShowTimeTakenButton
            app.ClicktoShowTimeTakenButton = uibutton(app.UIFigure, 'push');
            app.ClicktoShowTimeTakenButton.ButtonPushedFcn = createCallbackFcn(app, @ClicktoShowTimeTakenButtonPushed, true);
            app.ClicktoShowTimeTakenButton.BackgroundColor = [0.8745 0.1608 0.2078];
            app.ClicktoShowTimeTakenButton.FontColor = [1 1 1];
            app.ClicktoShowTimeTakenButton.Position = [364 120 152 24];
            app.ClicktoShowTimeTakenButton.Text = 'Click to Show Time Taken ';

            % Create AboutEMALabel
            app.AboutEMALabel = uilabel(app.UIFigure);
            app.AboutEMALabel.FontName = 'Ayuthaya';
            app.AboutEMALabel.FontWeight = 'bold';
            app.AboutEMALabel.Position = [364 379 91 22];
            app.AboutEMALabel.Text = 'About EMA:  ';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.FontName = 'Arial';
            app.Label.Position = [362 311 269 69];
            app.Label.Text = {'A decreasing trend shows that user keeps getting '; 'hard and/or easy questions wrong. An increasing'; 'trend shows that user is getting questions right as '; 'questions get harder and/or easier. '};

            % Create AboutTimeTakenLabel
            app.AboutTimeTakenLabel = uilabel(app.UIFigure);
            app.AboutTimeTakenLabel.FontName = 'Ayuthaya';
            app.AboutTimeTakenLabel.FontWeight = 'bold';
            app.AboutTimeTakenLabel.Position = [364 181 127 22];
            app.AboutTimeTakenLabel.Text = 'About Time Taken:';

            % Create ThisgraphshowsthetimeithastakentoanswereachquestionLabel
            app.ThisgraphshowsthetimeithastakentoanswereachquestionLabel = uilabel(app.UIFigure);
            app.ThisgraphshowsthetimeithastakentoanswereachquestionLabel.Position = [364 152 270 30];
            app.ThisgraphshowsthetimeithastakentoanswereachquestionLabel.Text = {'This graph shows the time it has taken to answer'; 'each question. '};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Results_creativeProject_exported

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