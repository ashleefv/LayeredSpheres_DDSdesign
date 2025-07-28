clear variables
clc

load ("3D_Surface_Data_Supplementary.mat")

%% Plotting
tolerance = 0.1;
timevector = 0:1:380; % time to study in days
timevector_plot = timevector/86400; %scaling to days
    tot_size = size(storage_cumulrel);
    i = tot_size(1);
    j = tot_size(2);
    total = i*j;


    % %%% Cumulative drug release
    figure(510);
    figname = 'figureS10';
    subplot(2,3,1)
    time_within_cumulrel = zeros();
    x1 = zeros();
    y1 = zeros();
    for l=1:i
        chosen_R2 = R2_thick(l)/(R2_bl-R1_bl);
        for m=1:j
            chosen_R1 = R1_sizes(m)/R1_bl;
            idxl = storage_cumulrel{l,m} >= cumulrel_threshold;
            idx = find (idxl);
            if (isempty(idx)~=1)
                time_within_cumulrel(l,m) = idx(1);
                x1(l,m) = chosen_R1;
                y1(l,m) = chosen_R2;
            end
        end
    end
    time_within_cumulrel(time_within_cumulrel==0) = NaN;

    time_within_relrate = zeros(i,j);
    x2 = zeros(i,j);
    y2 = zeros(i,j);

    for l=1:i
        chosen_R2 = R2_thick(l)/(R2_bl-R1_bl);
        for m=1:j
            chosen_R1 = R1_sizes(m)/R1_bl;
            x2(l,m) = chosen_R1;
            y2(l,m) = chosen_R2;
            time_within_relrate(l,m) = sum(storage_relrate{l,m}>=relrate_threshold);
        end
    end
% determine colormap scale
    minVal = min([min(time_within_cumulrel(:)), min(time_within_relrate(:))]);
    maxVal = max([max(time_within_cumulrel(:)), max(time_within_relrate(:))]);


    surf(x1,y1,time_within_cumulrel)
    caxis([minVal maxVal]); % Set shared color axis
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','rotation', 20,'FontSize', 8)
    ylabel("$\Delta R$ baseline multiplier",'interpreter','latex','rotation', -32,'FontSize', 8)
    zlabel({'Days to achieve 90 \%release', '($t$ at $Q=90\%$)'},'FontSize', 8,'interpreter','latex')
    zticks([0 60 120 180 240 300 360])
    axis([0 2, 0 10, 0 360])

    %%%Drug release rate
    subplot(2,3,2)
    surf(x2,y2,time_within_relrate)
    caxis([minVal maxVal]); % Set shared color axis
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','rotation', 20,'FontSize', 8)
    ylabel("$\Delta R$ baseline multiplier",'interpreter','latex','rotation', -32,'FontSize', 8)
    zlabel({'Days above 1 $\mu$g/day', 'release rate', '($t$ at $\dot{A}_{rel}=1$)'},'FontSize', 8,'interpreter','latex')
    zticks([0 60 120 180 240 300 360])
    axis([0 2, 0 10, 0 360])

    subplot(2,3,3)
    surf(x1,y1,time_within_cumulrel)
    hold on
    surf(x2,y2,time_within_relrate)
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','rotation', 20,'FontSize', 8)
    ylabel("$\Delta R$ baseline multiplier",'interpreter','latex','rotation', -32,'FontSize', 8)
    zlabel("Days to achieve thresholds",'FontSize', 8,'interpreter','latex')
    zticks([0 60 120 180 240 300 360])
    axis([0 2, 0 10, 0 360])
    
    labelstring = {'a)', 'b)', 'c)', 'd)'};
    for v = 1:3
        subplot(2,3,v)
        hold on
        text(-0.3, 1.1, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize',8)
    end

    subplot(2,3,[4 5])
    for l=1:i
        chosen_R2 = R2_thick(l)/(R2_bl-R1_bl);
        for m=1:j
            chosen_R1 = R1_sizes(m)/R1_bl;
            x2(l,m) = chosen_R1;
            y2(l,m) = chosen_R2;
            time_within_relrate_ub(l,m) = sum(storage_relrate{l,m}>=(1-1*tolerance)*relrate_threshold);
        end
    end

    for l=1:i
        chosen_R2 = R2_thick(l)/(R2_bl-R1_bl);
        for m=1:j
            chosen_R1 = R1_sizes(m)/R1_bl;
            x2(l,m) = chosen_R1;
            y2(l,m) = chosen_R2;
            time_within_relrate_lb(l,m) = sum(storage_relrate{l,m}>=(1+1*tolerance)*relrate_threshold);
        end
    end


    hold on
    co = orderedcolors("gem");
    color1 = co(1,:);
    color4 = co(4,:);
    R1_numeric = str2double(R1_text);
    R1_size_cumulrel = size(time_within_cumulrel);
    R1_size_relrate = size(time_within_relrate);
    
    %Plotting cumulative release threshold for DeltaR=10
    plot(R1_numeric(1:R1_size_cumulrel(2)),time_within_cumulrel(end,:)','-','Color',color1,'LineWidth',2)

    %Plotting cumulative release threshold for DeltaR=0.5
    plot(R1_numeric(1:R1_size_cumulrel(2)),time_within_cumulrel(1,:)','--','Color',color1,'LineWidth',2)

    %Plotting release rate threshold for DeltaR=10
    plot(R1_numeric(1:R1_size_relrate(2)),time_within_relrate(end,:)','k-','linewidth',2)
    
    %Fill for release rate threshold for DeltaR=10
    x = R1_numeric(1:R1_size_relrate(2))';
    upper_bound_2 = time_within_relrate_ub(end,:);
    lower_bound_2 = time_within_relrate_lb(end,:);
    fill([x fliplr(x)], [upper_bound_2 fliplr(lower_bound_2)], 'k', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

    %Plotting release rate threshold for DeltaR=0.5
    plot(R1_numeric(1:R1_size_relrate(2)),time_within_relrate(1,:)','--','Color',color4,'LineWidth',2)
    
    %Fill for release rate threshold for DeltaR=0.5
    upper_bound_1 = time_within_relrate_ub(1,:);
    lower_bound_1 = time_within_relrate_lb(1,:);
    fill([x fliplr(x)], [upper_bound_1 fliplr(lower_bound_1)], color4, 'FaceAlpha', 0.3, 'EdgeColor', 'none');

    %To get the dashed effect for the 10 delta R shading
    plot(x, upper_bound_2, 'k-', 'LineWidth', 1); % Dashed black line for upper bound
    plot(x, lower_bound_2, 'k-', 'LineWidth', 1); % Dashed black line for lower bound

    %To get the dashed effect for the 0.5 delta R shading
    plot(x, upper_bound_1, '--', 'color', color4, 'LineWidth', 1); % Dashed purple line for upper bound
    plot(x, lower_bound_1, '--', 'color', color4, 'LineWidth', 1); % Dashed purple line for lower bound

    xticks([0.25 0.5 0.75 1 1.25 1.5 1.75 2])
    yticks([0 60 120 180 240 300 360])
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','FontSize', 8)
    ylabel("Days to achieve thresholds",'FontSize', 8,'interpreter','latex')
     hold off
    axis([0.25 2, 0 360])
    
    %Overall legend
    legend(['$t_{Q=90\%}$: ' , num2str(y1(end)), '$\Delta R$'],...
        ['$t_{Q=90\%}$: ', num2str(y1(1)),'$\Delta R$'],...
        ['$t_{\dot{A}_{rel}=1}$: ', num2str(y2(end)),'$\Delta R$'],...
        ['$t_{\dot{A}_{rel}=1 \pm 0.1}: 10 \Delta R$'],...
        ['$t_{\dot{A}_{rel}=1}$: ' , num2str(y2(1)), '$\Delta R$'],...
        ['$t_{\dot{A}_{rel}=1 \pm 0.1}: 0.5 \Delta R$',],...
        'interpreter','latex','Location','south','FontSize', 8)
    h = legend('Location','southoutside');
    p = [0.75 0.27 0.03 0.03];
    set(h,'Position', p,'Units', 'normalized');
    
text(-0.08, 1.1, labelstring(4)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize',8)

widthInches = 8;
heightInches = 5;
run('../ScriptForExportingImages.m')


