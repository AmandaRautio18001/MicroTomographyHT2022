function [fitresult, gof] = sum_of_sin(tt, yy,show)
%CREATEFIT(TT,YY)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input: tt
%      Y Output: yy
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 08-Dec-2022 23:12:55


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( tt, yy );

% Set up fittype and options.
ft = fittype( 'sin5' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf];
opts.Normalize = 'on';
opts.StartPoint = [0.29698486451767 1.75510697734726 1.40498195625328 0.204157824613015 5.26532093204177 -1.61406829820122 0.619033246781571 3.51021395469451 0.540902352655538 0.313309718419086 0.877553488673628 -1.05137310176415 0.0173827144240756 10.5306418640835 0.327426273348272];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

if show == true
% Plot fit with data.
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, xData, yData );
    legend( h, 'yy vs. tt', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
    % Label axes
    xlabel( 'tt', 'Interpreter', 'none' );
    ylabel( 'yy', 'Interpreter', 'none' );
    grid on
end

