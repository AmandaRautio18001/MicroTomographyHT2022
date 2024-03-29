function [fitresult, gof] = smooth_spline_zx(z, x, show)
%CREATEFIT(Z,X)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input: z
%      Y Output: x
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 08-Dec-2022 06:34:01


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( z, x );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.0205681089988943;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
if show == true
    % Plot fit with data.
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, xData, yData );
    %legend( h, 'x vs. z', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
    % Label axes
%     xlabel( 'z', 'Interpreter', 'none' );
%     ylabel( 'x', 'Interpreter', 'none' );
    xlabel('Z axis','fontweight','bold','fontsize',16)
    ylabel('X axis','fontweight','bold','fontsize',16)
    set(gca,'fontweight','bold','fontsize',16);
    grid on
end

