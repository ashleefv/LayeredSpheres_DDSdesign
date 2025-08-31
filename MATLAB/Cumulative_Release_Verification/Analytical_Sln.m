clear variables
clc


% Solve for alpha from the given transcendental equation

% Parameters definition
a = (12.7e-4)/2; % Radius of coated particle (cm) from center
b = (10.2e-4)/2; % Radius of matrix (cm) from center
Dm = 1e-15; %cm/s Diffusitivity in matrix (core)
Dc = 1e-13; %cm/s Diffusitivity in coating film (shell)
Dr = Dc/Dm; %Ratio of diffusivities, coating / matrix
l = a/b; % radius ratio
Kb = 1; %Partition coefficient matrix-coating
Ka = 1; %Partition coefficient extraction medium-coating
delta = (a-b)/b; %dimensionless thickness of coating
t = [0:1:170]*86400; %170 d in seconds
tau = Dm*t/b^2; %Dimensionless time (Dm*t/b)

%% Eqn 28 from Lu and Chen, J Control Rel (1993)
% Define the function handle
f = @(alpha) Kb* ( sqrt(Dr).*alpha.*cos(sqrt(Dr).*alpha) ...
    - sin(sqrt(Dr).*alpha)).*sin(delta.*alpha) ...
    + Dr.*sin(sqrt(Dr).*alpha) .* ...
      ((alpha.*cos(delta.*alpha) + sin(delta.*alpha))) ;

% Search range and resolution for sign changes
alpha_min = 0.01; %Avoid trivial solution not starting from 0
alpha_max = 100;
Nscan     = 1000; % high for reliability
alphas    = linspace(alpha_min, alpha_max, Nscan);
vals      = f(alphas);

roots_found = [];

for k = 1:(length(alphas)-1)
    if vals(k) == 0
        roots_found(end+1) = alphas(k);
    elseif vals(k) * vals(k+1) < 0
        % Sign change — refine with fzero
        root = fzero(f, [alphas(k), alphas(k+1)]);
        roots_found(end+1) = root;
    end
end


%% Eqn 29 from Lu and Chen, J Control Rel (1993)
alpha_vals = roots_found;

%Initialize Qn
Qn = zeros(length(alpha_vals),1);

for i = 1:length(alpha_vals)
    alpha = alpha_vals(i);

    term1 = sin(sqrt(Dr)*alpha) * cos(delta*alpha) * (l*Dr - delta*Kb) / (2 * alpha * Dr);
    term2 = sin(sqrt(Dr)*alpha) * sin(delta*alpha) * ((delta + Kb) / 2);
    term3 = cos(sqrt(Dr)*alpha) * cos(delta*alpha) * ((Dr + delta*Kb) / (2 * sqrt(Dr)));
    term4 = cos(sqrt(Dr)*alpha) * sin(delta*alpha) * (sqrt(Dr) / (2 * alpha));

    Qn(i) = -Dr * alpha^2 * (term1 - term2 + term3 + term4);
end


%% Eqn 30a from Lu and Chen, J Control Rel (1993)

% Initialize summation
R = 0;

% === Loop over each term ===
for n = 1:length(alpha_vals)
    alpha     = alpha_vals(n);
    Q     = Qn(n);
    
    term1 = sin(sqrt(Dr)*alpha) - sqrt(Dr)*alpha * cos(sqrt(Dr)*alpha);
    term2 = (1 - exp(-Dr * alpha^2 * tau)) / alpha;
    
    R = R + (term1 / Q) * term2;
end

% Final result
R = 3 * l* R;

%Dimensionalizing time 
t=tau*b*b/Dm;
t=t/86400;

% Terms of cumulative drug release (%)
R=R*100;

%Plotting
plot(t, R)
xlabel('time (d)')
ylabel('Cumulative drug release (%)')