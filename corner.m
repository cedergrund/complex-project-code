% Ensure you have the Schwarz-Christoffel Toolbox installed and added to your MATLAB path

% Step 1: Define the Polygon
vertices = [0 + 0i, 1 + 0i, 1 + 1i, 0 + 1i];  % Example: square polygon (modify if desired)
p = polygon(vertices);

% Step 2: Construct the Conformal Map from Upper Half-Plane
f = hplmap(p);
params = parameters(f);
z_pre = params.prevertex; % Prevertices in upper half-plane

% Step 3: Define Source and Sink in the Upper Half-Plane
source_idx = 1;
sink_idx = 3;
z_source = z_pre(source_idx);
z_sink = z_pre(sink_idx);

% Step 4: Define Grid in UHP for plotting
[x, y] = meshgrid(linspace(-2, 2, 200), linspace(0, 2, 200));
z = x + 1i*y;

% Step 5: Compute Potential and Stream Function for Source/Sink in UHP
phi = log(abs(z - z_source)) - log(abs(z - z_sink));
psi = angle(z - z_source) - angle(z - z_sink);

% Step 6: Map Points to Polygonal Domain
w = eval(f, z);

% Step 7: Plot the results
figure('Position', [100, 100, 1200, 500]);

% --- Subplot 1: Upper Half-Plane ---
subplot(1, 2, 1);
hold on;
[~, h_phi] = contour(real(z), imag(z), phi, 20, 'r'); % Equipotential lines
[~, h_psi] = contour(real(z), imag(z), psi, 40, 'b'); % Streamlines
plot(real(z_pre), imag(z_pre), 'ko', 'MarkerFaceColor', 'k'); % Prevertices
h_source = plot(real(z_source), imag(z_source), 'go', 'MarkerFaceColor', 'g', 'DisplayName', 'Source'); % Source
h_sink = plot(real(z_sink), imag(z_sink), 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Sink'); % Sink

% Label prevertices
text(real(z_pre) + 0.05, imag(z_pre), arrayfun(@(n) sprintf('z_{%d}', n), 1:length(z_pre), 'UniformOutput', false));

title('Source/Sink Ideal Flow in UHP');
xlabel('Re(z)');
ylabel('Im(z)');
axis equal tight;
grid on;
legend([h_phi, h_psi, h_source, h_sink], {'Equipotential Lines', 'Streamlines', 'Source', 'Sink'}, ...
    'Location', 'southoutside', 'Orientation', 'vertical');
xlim([-2,2]);
ylim([0,2]);

% --- Subplot 2: Mapped Domain ---
subplot(1, 2, 2);
hold on;
[~, h_phi_mapped] = contour(real(w), imag(w), phi, 20, 'r'); % Equipotential lines
[~, h_psi_mapped] = contour(real(w), imag(w), psi, 40, 'b'); % Streamlines
plot(real(vertices), imag(vertices), 'ko', 'MarkerFaceColor', 'k'); % Polygon vertices

% Close the polygon
vertices_closed = [vertices, vertices(1)];
plot(real(vertices_closed), imag(vertices_closed), 'k-', 'LineWidth', 1.5);

% Map Source and Sink
w_source = eval(f, z_source);
w_sink = eval(f, z_sink);
h_source_mapped = plot(real(w_source), imag(w_source), 'go', 'MarkerFaceColor', 'g', 'DisplayName', 'Mapped Source');
h_sink_mapped = plot(real(w_sink), imag(w_sink), 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Mapped Sink');

% Label polygon vertices
text(real(vertices) + 0.05, imag(vertices), arrayfun(@(n) sprintf('w_{%d}', n), 1:length(vertices), 'UniformOutput', false));

title('Mapped Source/Sink Flow in Polygon');
xlabel('Re(w)');
ylabel('Im(w)');
axis equal tight;
grid on;
legend([h_phi_mapped, h_psi_mapped, h_source_mapped, h_sink_mapped], ...
    {'Mapped Equipotential Lines', 'Mapped Streamlines', 'Mapped Source', 'Mapped Sink'}, ...
    'Location', 'southoutside', 'Orientation', 'vertical');
