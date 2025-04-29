
% Ensure the SC Toolbox is installed and added to your MATLAB path.

% -----------------------------
% Step 1: Define Polygon Vertices
% -----------------------------
clear;
% Replace these vertices with your desired polygon, ensuring counterclockwise order.
vertices = [518 + 0i, 523 + 22i, 421 + 159i, 365 + 317i, 303 + 348i, 235 + 297i, 185 + 142i, 95 + 0i];

% Create a polygon object
p = polygon(vertices);

% -----------------------------
% Step 2: Construct the Conformal Map
% -----------------------------
% Map from the upper half-plane to the polygon
f = hplmap(p);

% Extract mapping parameters
params = parameters(f);
z_pre = params.prevertex; % Prevertices in the upper half-plane

% -----------------------------
% Step 3: Define Source and Sink
% -----------------------------
% Select prevertices for source and sink, avoiding the one at infinity
% For example, choose the first and third prevertices
source_idx = 5;
sink_idx = 1;

z_source = z_pre(source_idx);
z_sink = z_pre(sink_idx);

% -----------------------------
% Step 4: Define Grid in UHP
% -----------------------------
% Define a grid in the upper half-plane
[x, y] = meshgrid(linspace(-10, 10, 400), linspace(0.000001, 10, 400));
z = x + 1i * y;

% -----------------------------
% Step 5: Compute Complex Potential
% -----------------------------
% Compute the complex potential due to a source and sink
% Avoid division by zero by adding a small epsilon
epsilon = 1e-10;
w_complex = log(z - z_source + epsilon) - log(z - z_sink + epsilon);

% Extract potential function (phi) and stream function (psi)
phi = real(w_complex);
psi = imag(w_complex);

% -----------------------------
% Step 6: Map Grid to Polygonal Domain
% -----------------------------
% Apply the conformal map to the grid
w = eval(f, z);

% -----------------------------
% Step 7: Visualization
% -----------------------------
figure('Position', [100, 100, 1200, 600]); % Increased height for legend

% Subplot 1: Upper Half-Plane
subplot(1, 2, 1);
hold on;
% Plot equipotential lines (phi) in red
[~, h_phi] = contour(real(z), imag(z), phi, 20, 'r');
% Plot streamlines (psi) in blue
[~, h_psi] = contour(real(z), imag(z), psi, 40, 'b');
% Plot prevertices in black
plot(real(z_pre), imag(z_pre), 'ko', 'MarkerFaceColor', 'k');
% Plot source in green
h_source = plot(real(z_source), imag(z_source), 'go', 'MarkerFaceColor', 'g');
% Plot sink in red
h_sink = plot(real(z_sink), imag(z_sink), 'ro', 'MarkerFaceColor', 'r');
% Label prevertices
text(real(z_pre) + 0.05, imag(z_pre), arrayfun(@(n) sprintf('z_{%d}', n), 1:length(z_pre), 'UniformOutput', false));
title('Source/Sink Ideal Flow in UHP');
xlabel('Re(z)');
ylabel('Im(z)');
axis equal tight;
grid on;
xlim([-3,3])
ylim([0,3])

% Subplot 2: Mapped Domain
subplot(1, 2, 2);
hold on;
% Plot equipotential lines (phi) in red
[~, h_phi_mapped] = contour(real(w), imag(w), phi, 20, 'r');
% Plot streamlines (psi) in blue
[~, h_psi_mapped] = contour(real(w), imag(w), psi, 40, 'b');
% Plot polygon vertices in black
plot(real(vertices), imag(vertices), 'ko', 'MarkerFaceColor', 'k');
% Close the polygon
vertices_closed = [vertices, vertices(1)];
plot(real(vertices_closed), imag(vertices_closed), 'k-', 'LineWidth', 1.5);
% Plot mapped source and sink
w_source = eval(f, z_source);
w_sink = eval(f, z_sink);
plot(real(w_source), imag(w_source), 'go', 'MarkerFaceColor', 'g');
plot(real(w_sink), imag(w_sink), 'ro', 'MarkerFaceColor', 'r');
% Label polygon vertices
text(real(vertices) + 0.05, imag(vertices), arrayfun(@(n) sprintf('w_{%d}', n), 1:length(vertices), 'UniformOutput', false));
title('Mapped Source/Sink Flow in Kish Polygon');
xlabel('Re(w)');
ylabel('Im(w)');
axis equal tight;
grid on;

% -----------------------------
% Step 8: Create Unified Legend
% -----------------------------
% Create dummy invisible lines for legend
dummy_phi = plot(NaN, NaN, 'r-', 'LineWidth', 1.5);
dummy_psi = plot(NaN, NaN, 'b-', 'LineWidth', 1.5);
dummy_source = plot(NaN, NaN, 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
dummy_sink = plot(NaN, NaN, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

% Create unified legend
legend([dummy_phi, dummy_psi, dummy_source, dummy_sink], ...
    {'Equipotential Lines', 'Streamlines', 'Source', 'Sink'}, ...
    'Orientation', 'horizontal', ...
    'Position', [0.25 0.02 0.5 0.05]);

% Hide dummy lines
set([dummy_phi, dummy_psi, dummy_source, dummy_sink], 'Visible', 'on');