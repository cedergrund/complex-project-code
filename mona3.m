
% Ensure the SC Toolbox is installed and added to your MATLAB path.

% -----------------------------
% Step 1: Define Polygon Vertices
% -----------------------------
% Replace these vertices with your desired polygon, ensuring counterclockwise order.
vertices = [411 + 0i, 409 + 143i, 393 + 182i, 349 + 230i, 341 + 268i, 292 + 317i, 288 + 464i, 275 + 494i, 248 + 518i, 203 + 519i, 171 + 496i, 141 + 347i, 77 + 271i, 46 + 155i, 39 + 0i];

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
source_idx = 14;
sink_idx = 2;

z_source = z_pre(source_idx);
z_sink = z_pre(sink_idx);

% -----------------------------
% Step 4: Define Grid in UHP
% -----------------------------
% Define a grid in the upper half-plane
[x, y] = meshgrid(linspace(-10, 10, 400), linspace(0.001, 10, 400));
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
figure('Position', [100, 100, 1200, 500]);

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
h_source = plot(real(z_source), imag(z_source), 'go', 'MarkerFaceColor', 'g', 'DisplayName', 'Source');
% Plot sink in red
h_sink = plot(real(z_sink), imag(z_sink), 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Sink');
% Label prevertices
text(real(z_pre) + 0.05, imag(z_pre), arrayfun(@(n) sprintf('z_{%d}', n), 1:length(z_pre), 'UniformOutput', false));
title('Source/Sink Ideal Flow in UHP');
xlabel('Re(z)');
ylabel('Im(z)');
axis equal tight;
grid on;
% Create legend
legend([h_phi, h_psi, h_source, h_sink], {'Equipotential Lines', 'Streamlines', 'Source', 'Sink'}, ...
    'Location', 'southoutside', 'Orientation', 'vertical');
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
% Map source and sink to the polygonal domain
w_source = eval(f, z_source);
w_sink = eval(f, z_sink);
% Plot mapped source in green
h_source_mapped = plot(real(w_source), imag(w_source), 'go', 'MarkerFaceColor', 'g', 'DisplayName', 'Mapped Source');
% Plot mapped sink in red
h_sink_mapped = plot(real(w_sink), imag(w_sink), 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Mapped Sink');
% Label polygon vertices
text(real(vertices) + 0.05, imag(vertices), arrayfun(@(n) sprintf('w_{%d}', n), 1:length(vertices), 'UniformOutput', false));
title('Mapped Source/Sink Flow in Mona Lisa Polygon');
xlabel('Re(w)');
ylabel('Im(w)');
axis equal tight;
grid on;
% Create legend
legend([h_phi_mapped, h_psi_mapped, h_source_mapped, h_sink_mapped], ...
    {'Mapped Equipotential Lines', 'Mapped Streamlines', 'Mapped Source', 'Mapped Sink'}, ...
    'Location', 'southoutside', 'Orientation', 'vertical');
