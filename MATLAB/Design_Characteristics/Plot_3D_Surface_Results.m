clear variables
clc

load ("3D_Surface_Data.mat")

%% Plotting

timevector = 0:1:200; % time to study in days
timevector_plot = timevector/86400; %scaling to days
    tot_size = size(storage_cumulrel);
    i = tot_size(1);
    j = tot_size(2);
    total = i*j;


    % %%% Cumulative drug release
    figure(7);
    figname = 'figure7';
    subplot(2,2,1)
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
    surf(x1,y1,time_within_cumulrel)
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','rotation', 14,'FontSize', 8)
    ylabel("$\Delta R$ baseline multiplier",'interpreter','latex','rotation', -25,'FontSize', 8)
    zlabel("Days to achieve 90% release",'FontSize', 8)
    zticks([0 30 60 90 120 150 180])
    axis([0 2, 0 10, 30 180])

    %%%Drug release rate
    subplot(2,2,2)
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
    surf(x2,y2,time_within_relrate)
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','rotation', 14,'FontSize', 8)
    ylabel("$\Delta R$ baseline multiplier",'interpreter','latex','rotation', -25,'FontSize', 8)
    zlabel("Days above 2\mug/day of drug release",'FontSize', 8)
    zticks([0 30 60 90 120 150 180])
    axis([0 2, 0 10, 30 180])

    subplot(2,2,3)
    surf(x1,y1,time_within_cumulrel)
    hold on
    surf(x2,y2,time_within_relrate)
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','rotation', 14,'FontSize', 8)
    ylabel("$\Delta R$ baseline multiplier",'interpreter','latex','rotation', -25,'FontSize', 8)
    zlabel("Days to achieve thresholds",'FontSize', 8)
    zticks([0 30 60 90 120 150 180])
    axis([0 2, 0 10, 30 180])

    subplot(2,2,4)
    hold on
    set(gca,'ColorOrderIndex',3)
    co = get(gca, 'ColorOrder'); % Get the default color order
    color6 = co(6, :);
    R1_numeric = str2double(R1_text);
    R1_size_cumulrel = size(time_within_cumulrel);
    R1_size_relrate = size(time_within_relrate);
    plot(R1_numeric(1:R1_size_cumulrel(2)),time_within_cumulrel(2,:)','--','Color',color6,'LineWidth',2)
    plot(R1_numeric(1:R1_size_relrate(2)),time_within_relrate(2,:)','-','Color',color6,'LineWidth',2)
    axis([0.4 2, 30 180])
    xticks([0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2])
    yticks([0 30 60 90 120 150 180])
    xlabel("$R_{core}$ baseline multiplier",'interpreter','latex','FontSize', 8)
    ylabel("Days to achieve thresholds",'FontSize', 8)
    legend('Cumulative release','Release rate','FontName','Arial','FontSize',8,'Location','southeast')
    hold off

    labelstring = {'a)', 'b)', 'c)', 'd)'};
    for v = 1:4
        subplot(2,2,v)
        hold on
        text(-0.25, 1.1, labelstring(v)', 'Units', 'normalized', 'FontWeight', 'bold','FontSize', 8)
    end
    
widthInches = 6.5;
heightInches = 5;
run('../ScriptForExportingImages.m')

