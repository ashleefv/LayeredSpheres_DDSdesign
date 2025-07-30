function output = solve_FD_spheres_variable_diffusivity(varargin)
%% Solves the PDE for Fickian diffusion within a radially symmetric sphere 
% The PDE is solved numerically using method of lines, the spherical finite
% difference discretization scheme defined and analyzed in the reference, 
% and any built-in MATLAB ODE solver. 
%% --- Reference --- 
%  A. N. Ford Versypt & R. D. Braatz, Analysis of finite difference 
%  discretization schemes for diffusion in spheres with variable 
%  diffusivity, Computers & Chemical Engineering, 71 (2014) 241-252, 
%  https://doi.org/10.1016/j.compchemeng.2014.05.022
% close all

InitialDrugInOuterLayer = 0; %If PCL-chitosan, drug is initially loaded on chitosan (inner) layer
% User defined parameters for double-walled microspheres
% variable: definition, units
% R1: radius of the inner core, cm 
% R2: total radius including the inner and outer shells, cm
    % If R1 = 0, then sphere is all outer shell material without an inner core. dr1 = 0
    % If R2 = R1, then sphere is all the inner core material without an outer shell. dr2 = 0
% burst: initial burst, %
% DInner: drug diffusion coefficient for inner shell, cm2/s (chitosan)
% DOuter: drug diffusion coefficient for outer shell, cm2/s (PCL)
% k: drug partition coefficient, dimensionless

%Bringing the variables from bilayer_numerical_diffn_paramest, or default
%values
if nargin == 5
    R1 =(8.9e-4)/2;  %R1 comes from the experimental average size data
    R2 = R1;   %If only chitosan
    burst_fixed = varargin{3};
    DInner_fixed = varargin{4}; % cm2/s;
    stddev_wt = varargin{5};
    k = 1;
elseif nargin == 8
    R1 = (10.2e-4)/2; %R1 comes from the experimental average size data
    R2 = (12.7e-4)/2; %If PCL-Chitosan. %R2 comes from the experimental average size data
    burst_fixed = varargin{3};
    DInner_fixed = varargin{4}; % cm2/s;
    DOuter_fixed = varargin{5}; %cm^2/s
    stddev_wt = varargin{6};
    num_estim_param = varargin{7};
    k_fixed = varargin{8};
else
    %This values are for the default case, when there is no optimization
    %going on. They can be modified manually.
    R1 = (10.2e-4)/2;
    R2 = (12.7e-4)/2; %If PCL-Chitosan
    DInner = 1e-12; % cm2/s;;
    DOuter = 1e-15; % cm2/s;;
    burst = 10; % %
    k = 1;
    % R1 = (8.9e-4)/2;
    % R2 = (8.9e-4)/2; %If Chitosan only
    % R1 = (10.2e-4)/2;
	% R2 = (12.7e-4)/2; %If PCL-Chitosan
	% DInner = 1.14e-14; % cm2/s
    % DOuter = 6.8e-15; % cm2/s
    % burst = 13.76; % %
    alpha0Inner = DInner/R2^2; % scale by outer radius in dimensional form
    alpha0Outer = DOuter/R2^2; % scale by outer radius in dimensional form
end 
    timevector = [0:1:170].*86400; % in seconds

%% Parameters, initial conditions, boundary conditions, and grid points
%%% Chitosan-PCL core-shell microparticle
% Inner diameter: Chitosan monolayer particle 8.9 +/- 3.5 um
% Outer diameter: Chitosan-PCL bilayer particle 12.7 +/- 5.9 um
% Outer PCL layer 1-1.5um
Mdesired = 300; 
if R2>R1 
    if R1>0% two layers
        M = floor(R1/R2*Mdesired); %number of spatial intervals in Method of Lines for the inner core layer
	% note the if ceil is used instead of floor, you can ensure that Minner+Mouter = Mdesired. With floor, there may be one fewer than Mdesired.
    else 
        M = Mdesired;
    end
else
    M = Mdesired;
end
NR = M+1; % number of spatial discretization points along r in each layer
initial_condition = 1; % c(r,0) for 0 <= r < 1    %Normalized initial concentration
boundary_condition = 0; % c(1,t) for t >= 0       %Perfect sink conditions (c=0) at the border

%% Unit tests: with R2 = 1, R1 = 0 and 1 with M = 200 should give the same results as R1 = 0.5 with M = 100 if DInner = DOuter

if R2<R1
    beep
    'r2 must be greater than or equal to r1'
end
% initially
NR1 = NR;
NR2 = NR;
rInner = linspace(0,R1,NR1)./R2; % inner core from 0 to r1
dr1 = rInner(2)-rInner(1);

% to keep sundqvist FD approximately 2nd order
% On the Use of Nonuniform Grids in Finite-Difference Equations equation (4)

if 0<R1/R2 && R1/R2 <1 %Making sure R1 is not 0 and R1 is different to R2
    dr2approx = dr1^2+dr1;
    NR2 = ceil((R2-R1)./R2/dr2approx)+1;
end

rOuter = linspace(R1,R2,NR2)./R2;
dr2 = rOuter(end)-rOuter(end-1);
if abs(dr1-0) < eps
    r = rOuter;
elseif abs(dr2-0) < eps
    r = rInner;
else
    r = [rInner, rOuter]; % combined r for inner core and outer shell repeating r at interface, non-dimensionalized
end
Ntotal = length(r); % total numuber of points in two zones.

if dr1 >0 && dr2 > 0
    % two layers
    % inner BC at rr = 1, interior at rr=2:NR1-1 for inner core, rr = NR1
    % and NR1+1 for interface and, interior at rr = NR+2:NR1+N2-1 for outer shell
    c0(1:NR1-1) = initial_condition;
    c0(NR1+2:Ntotal-1) = InitialDrugInOuterLayer;
    % outer BC at NR1+NR2
    c0(Ntotal) = boundary_condition;
else
    c0(1:NR-1) = initial_condition;
    c0(NR) = boundary_condition;
end

if nargin == 5
    params = varargin{1};
    burst = params(1)*burst_fixed;
    DInner = params(2)*DInner_fixed;
    timevector = varargin{2}.*86400; %s
end

if nargin == 8
    params = varargin{1};
    burst = params(1)*burst_fixed;
    DOuter = params(2)*DOuter_fixed;
    if num_estim_param == 3
        DInner = DInner_fixed;
        k = params(3)*k_fixed;
    elseif num_estim_param == 4
        DInner = params(3)*DInner_fixed;
        k = params(4)*k_fixed;
    end
    timevector = varargin{2}.*86400; %s
end


if nargin == 5
    alpha0Inner = DInner/R2^2; % scale by outer radius in dimensional form
elseif nargin == 8
    alpha0Inner = DInner/R2^2; % scale by outer radius in dimensional form
    alpha0Outer = DOuter/R2^2; % scale by outer radius in dimensional form
end

% Make alpha a scalar for one layer and a vector of two values if two
% layers (inner and outer)
if dr1 >0 && dr2 > 0
    alpha = [alpha0Inner alpha0Outer];
    gamma = alpha0Outer*dr1/(alpha0Inner*dr2);
    c0(NR1) = (initial_condition+InitialDrugInOuterLayer*gamma)/(1+gamma/k); %Interface condition from the core side
    c0(NR1+1) = c0(NR1)/k; %Interface condition from the shell side
elseif dr2 == 0
    alpha = alpha0Inner;
else
    alpha = alpha0Outer;   
end


%% ODE solver (ode45) call
[time,concentration] = ode45(@(t,c)FD_spheres_variable_diffusivity_two_spheres(t,c,dr1,dr2,NR1,NR2,alpha,r,k),timevector,c0);
c=concentration';


%Cumulative drug release calculations
if dr1>0
    denom1 = dr1*simps(c0(1:NR1).*rInner(1:NR1).*rInner(1:NR1));
    if dr2 >0
     	denom2 = dr2*simps(c0(NR1+1:Ntotal).*rOuter(1:NR2).*rOuter(1:NR2));      
    else
        denom2 = 0 ;  
    end
else
	denom1 = 0;
	denom2 = initial_condition/3*(rOuter(end)^3-rInner(end)^3); 
end
cumulrel_num = ones(size(time));
    for tt = 1:length(time)
        if time(tt) == 0
            cumulrel_num(tt) = burst;
        else
            if dr1 >0
                integrand1 = dr1*simps((concentration(tt,1:NR1)).*rInner(1:NR1).*rInner(1:NR1)); % from 0 to r1                
                if dr2 >0
                    integrand2 = dr2*simps((concentration(tt,NR1+1:Ntotal)).*rOuter(1:NR2).*rOuter(1:NR2)); % from r1 to r2
                else
                    integrand2 = 0;
                end
            else
                integrand1 = 0;
                integrand2 = dr2*simps((concentration(tt,1:NR)).*rOuter(1:NR).*rOuter(1:NR)); % from 0 to r2
            end  
            cumulrel_num(tt) = (100-burst)*(1-( integrand1 + integrand2 )/(denom1+denom2))+burst; % integrating from 0 to r1, then r1 to r2
        end
    end

%Output cumulative drug release considering or not standard deviation
if nargin == 5 || nargin == 7
    output = cumulrel_num./stddev_wt;
else
    output = cumulrel_num;

    %plot 7 different time steps
    % plot(r,c(:,10),r,c(:,20),r,c(:,30),r,c(:,40),r,c(:,50),r,c(:,60),r,c(:,70))
    % xlabel("r/R_{shell}")
    % ylabel("Concentration (a.u.)")
    % legend("t = 10 days", "t = 20 days", "t = 30 days", "t = 40 days","t = 50 days", "t = 60 days","t = 70 days")
    % axis([0 1 0 1])

    % %plot(r,c(:,1:5))
    % plot(rInner,c(1:NR1,1),'b')
    % hold on
    % plot(rOuter,c(NR1+1:Ntotal,1),'b')
    % hold on
    % 
    % plot(rInner,c(1:NR1,2),'r')
    % hold on
    % plot(rOuter,c(NR1+1:Ntotal,2),'r')
    % hold on
    % 
    % plot(rInner,c(1:NR1,5),'g')
    % hold on
    % plot(rOuter,c(NR1+1:Ntotal,5),'g')
    % hold on
end


end
