function plotfill(x,y,threshold,tolerance)
within_range = (y>=(threshold - tolerance*threshold)) & (y<=(threshold+tolerance*threshold));

if (sum(within_range)~=0)
    expanded_range = within_range;
    expanded_range([false; within_range(1:end-1)]) = true; % Expand below
    expanded_range([within_range(2:end); false]) = true; % Expand above
    %yline(threshold - tolerance*threshold, 'r--')
    yline(threshold, 'k--')
    %yline(threshold+tolerance*threshold, 'g--')
    % shade the region
    fill_x = x(expanded_range)';
    fill_y = y(expanded_range)';
    fill([fill_x(1) fill_x fill_x(end)],[1e-3 fill_y 1e-3], ...
        'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
end

end