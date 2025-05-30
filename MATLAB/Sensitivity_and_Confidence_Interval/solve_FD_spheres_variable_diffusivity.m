function output = solve_FD_spheres_variable_diffusivity(varargin)
%% Solves the PDE for Fickian diffusion with variable diffusivity within a radially symmetric sphere 
% The PDE is solved numerically using method of lines, the spherical finite
% difference discretization scheme defined and analyzed in the reference, 
% and any built-in MATLAB ODE solver. 
%% --- Reference --- 
%  A. N. Ford Versypt & R. D. Braatz, Analysis of finite difference 
%  discretization schemes for diffusion in spheres with variable 
%  diffusivity, Computers & Chemical Engineering, 71 (2014) 241-252, 
%  https://doi.org/10.1016/j.compchemeng.2014.05.022
% close all

InitialDrugInOuterLayer = 0;
% User defined parameters for double-walled microspheres
% variable: definition, units
% R1: radius of the inner core, cm 
% R2: total radius including the inner and outer shells, cm
    % If R1 = 0, then sphere is all outer shell material without an inner core. dr1 = 0
    % If R2 = R1, then sphere is all the inner core material without an outer shell. dr2 = 0
% burst: initial burst, %
% DInner: drug diffusion coefficient for inner shell, cm2/s
% DOuter: drug diffusion coefficient for outer shell, cm2/s

if  nargin == 6
    R1 = (10.2e-4)/2; 
    R2 = (12.7e-4)/2; %If PCL-Chitosan
    burst_fixed = varargin{3};
    DInner_fixed = varargin{4}; % cm2/s;
    DOuter_fixed = varargin{5}; %cm^2/s
    k_fixed = varargin{6};
end 

%% Parameters
%%% Chitosan-PCL core-shell microparticle
% Inner diameter: Chitosan monolayer particle 8.9 +/- 3.5 um
% Outer diameter: Chitosan-PCL bilayer particle 12.7 +/- 5.9 um
% Outer PCL layer 1-1.5um
Mdesired = 300; % single layer
if R2>R1 
    if R1>0% two layers
        M = floor(R1/R2*Mdesired); %number of spatial intervals in Method of Lines for each layer
    else 
        M = Mdesired;
    end
else
    M = Mdesired;
end
NR = M+1; % number of spatial discretization points along r in each layer
initial_condition = 1; % c(r,0) for 0 <= r < 1
boundary_condition = 0; % c(1,t) for t >= 0

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
    r = [rInner, rOuter]; % combined r for inner core and outer shell without replicating r1, non-dimensionalized
end
Ntotal = length(r); % total numuber of points in two zones.
if dr1 >0 && dr2 > 0
    % two layers
    % inner BC at rr = 1, interior at rr=2:NR for inner core, 
    % interior at rr = NR+1:2*NR for outer shell
    c0(1:NR1-1) = initial_condition;
    c0(NR1+2:Ntotal-1) = InitialDrugInOuterLayer;
    % outer BC at 2*NR-1
    c0(Ntotal) = boundary_condition;
else
    c0(1:NR-1) = initial_condition;
    c0(NR) = boundary_condition;
end

if nargin == 6
    params = varargin{1};
    burst = params(1)*burst_fixed;
    DOuter = params(2)*DOuter_fixed;
    DInner = params(3)*DInner_fixed;
    k = params(4)*k_fixed;
    timevector = varargin{2}.*86400; %s
    alpha0Inner = DInner/R2^2; % scale by outer radius in dimensional form
    alpha0Outer = DOuter/R2^2; % scale by outer radius in dimensional form
end


% 
% CASE V: constant diffusivity with alpha = alpha0Inner 0<r<r1
            % and alpha = alpha0Outer r1<r<r2
if dr1 >0 && dr2 > 0
    alpha = [alpha0Inner alpha0Outer];
    %Establish I.C at the interface
    gamma = alpha0Outer*dr1/(alpha0Inner*dr2);
    c0(NR1) = (initial_condition+InitialDrugInOuterLayer*gamma)/(1+gamma/k); %Interface condition from the core side
    c0(NR1+1) = c0(NR1)/k; %Interface condition from the shell side
elseif dr2 == 0
    alpha = alpha0Inner;
else
    alpha = alpha0Outer;   
end


%% ODE solver (ode23s) call
addpath(fileparts(pwd));
[time,concentration] = ode23s(@(t,c)FD_spheres_variable_diffusivity_two_spheres(t,c,dr1,dr2,NR1,NR2,alpha,r,k),timevector,c0);

if dr1>0
    denom1 = dr1*simps(c0(1:NR1).*rInner(1:NR1).*rInner(1:NR1));
   % initial_condition/3*rInner(end)^3
    if dr2 >0
     	denom2 = dr2*simps(c0(NR1+1:Ntotal).*rOuter(1:NR2).*rOuter(1:NR2));
        %InitialDrugInOuterLayer/3*(rOuter(end)^3-rInner(end)^3)        
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
                % If X is a scalar spacing, then simps(X,Y) is equivalent to X*simps(Y).
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

output = cumulrel_num;

end
