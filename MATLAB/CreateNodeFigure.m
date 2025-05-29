figure(51)%Figure S1

set(0, 'defaultTextInterpreter', 'latex'); % Set default interpreter to LaTeX
set(0, 'DefaultTextFontName', 'CMU Serif'); % Set default text font to Computer Modern
set(0, 'DefaultAxesFontName', 'CMU Serif'); % Set default axes font to Computer Modern

x = -2:0.5:2; % Define the range for the number lines
%split the range in two
xtopleft = -1.5:0.5:0;
xtopright = 0:0.5:1.5;
ytopleft = 0.4*ones(size(xtopleft)); % y-values for the top line (shifted up by 0.5)
ytopright = 0.4*ones(size(xtopright)); % y-values for the top line (shifted up by 0.5)
ytop = 0.4*ones(size(x));
xbottomleft = -2:0.5:0;
xbottomright = 0:0.5:2;
ybottomleft = zeros(size(xbottomleft)); % y-values for the bottom line
ybottomright = zeros(size(xbottomright)); % y-values for the bottom line
ybottom = zeros(size(x)); % y-values for the bottom line
plot(xbottomleft, ybottomleft, 'k--', xbottomright, ybottomright, 'k-', xtopleft, ytopleft, 'k-',xtopright, ytopright, 'k--'); % 'k-' specifies black solid lines
hold on; % Keep the current plot
% top row
topRowString0 = {'$$\Delta r_{core}$$',[],[]};
topRowString = {'$$C_{i-1}$$','$$C_{i}$$','$$C_{i+1}$$'};
topRowString2 = {'$$i-1=I_{core}-1$$','$$i=I_{core}$$','$$i+1=I_{core}+1$$'};
%topRowString3 = {'$$r_{i-1} = (I_{core}-1)\Delta r_{core}$$','$$r_i=R_{core}/R_{shell}=\Delta r_{core}I_{core}$$','$$r_{i+1} = (I_{core}+1)\Delta r_{core}$$'};
topRowString3 = {[],'$$r_i=R_{core}/R_{shell}=\Delta r_{core}I_{core}$$',[]};

iterator = 1;
text(-1.8,ytop(1),'Core', 'HorizontalAlignment', 'center'); 
for i = -1.5:1.5:1.5
line([i i], [ytop(1)-0.05 ytop(1)+0.05], 'Color', 'k'); % Draw ticks for the second line
    text(i+.75, ytop(1)+0.05, topRowString0(iterator), 'HorizontalAlignment', 'center'); % Add labels to the first line
    text(i, ytop(1)-0.1, topRowString(iterator), 'HorizontalAlignment', 'center'); % Add labels to the second line
    text(i, ytop(1)-0.15, topRowString2(iterator), 'HorizontalAlignment', 'center'); % Add labels to the second line
    text(i, ytop(1)-0.2, topRowString3(iterator), 'HorizontalAlignment', 'center'); % Add labels to the second line

    iterator = iterator+1;
end

% bottom row
bottomRowString0 = {[],[],'$$\Delta r_{shell}$$'};
bottomRowString = {'$$C_{j-1}$$','$$C_{j}$$','$$C_{j+1}$$'};
bottomRowString2 = {'$$j-1=-1$$','$$j=0$$','$$j+1=1$$'};
%bottomRowString3 = {'$$r_{j-1}=\Delta r_{core}I_{core}-\Delta r_{shell}$$','$$r_j=R_{core}/R_{shell}=\Delta r_{core}I_{core}$$','$$r_{j+1}=\Delta r_{core}I_{core}+\Delta r_{shell}$$'};
bottomRowString3 = {[],'$$r_j=R_{core}/R_{shell}=\Delta r_{core}I_{core}$$',[]};

iterator = 1;
text(2.3,0,'Shell', 'HorizontalAlignment', 'center'); 
for i = -2:2:2
    line([i i], [-0.05 0.05], 'Color', 'k'); % Draw ticks for the first line
    text(i-1, 0.05, bottomRowString0(iterator), 'HorizontalAlignment', 'center'); % Add labels to the first line
    text(i, -0.1, bottomRowString(iterator), 'HorizontalAlignment', 'center'); % Add labels to the first line
    text(i, -0.15, bottomRowString2(iterator), 'HorizontalAlignment', 'center'); % Add labels to the first line
    text(i, -0.2, bottomRowString3(iterator), 'HorizontalAlignment', 'center'); % Add labels to the first line

    iterator = iterator+1;
end

axis([-2.5 2.5 -0.25 0.5]); % Set axis limits
set(gca, 'ytick', []); % Remove y-axis ticks
set(gca, 'xtick', []); % Remove y-axis ticks

set(gca, 'Box', 'on', 'XColor', 'w', 'YColor', 'w'); %remove box border

hold off
fig =gcf;

% res=600;
% exportgraphics(gca, 'NodeFigure.png', 'ContentType', 'vector','Resolution',res); % Save as PNG with vector content

%
%set(gcf,'paperunits','inches','PaperPosition',[0 0 5 0.75]);
%print('NodeFigure.png','-dpng',['-r' num2str(res)], '-vector');

figname = 'figureS1';
exportgraphics(fig,[figname, '.tiff'],'Resolution',600)
exportgraphics(fig,[figname, '.pdf'],'Resolution',600)