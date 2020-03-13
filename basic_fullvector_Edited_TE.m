% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
%rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125*8;        % grid size (horizontal)
dy = 0.0125*8;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

rw = linspace(0.325,1,10);
NEFF = zeros(1,10);

for nn = 1:10
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw(nn),side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
fprintf(1,'neff  = %.6f\n',neff);
NEFF(nn) = neff;

for gg = 1:nmodes
    figure();
    
    % Using Contour
    subplot(2,2,1);
    contourmode(x,y,Hx(:,:,gg));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(2,2,2);
    contourmode(x,y,Hy(:,:,gg));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
    % Using Surf
    subplot(2,2,3);
    contourmode_Edited(x,y,Hx(:,:,gg));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(2,2,4);
    contourmode_Edited(x,y,Hy(:,:,gg));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
end

end

% Plot Neff
figure()
plot(rw,NEFF)
title('Neff');
xlabel('Ridge Half-Width');
ylabel('Neff');