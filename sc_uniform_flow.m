% Define the polygon vertices in COUNTERCLOCKWISE order
vertices = [1019 + 447i, 1641 + 33i, 1433 + 737i, 1999 + 1195i, 1269 + 1195i, 1012 + 1881i, 770 + 1195i, 22 + 1195i, 605 + 737i, 398 + 33i];
p = polygon(vertices);

% Construct the conformal map from the upper half-plane to the polygon
f = hplmap(p);

% Extract mapping parameters
params = parameters(f);
z_pre = params.prevertex; % Prevertices in the upper half-plane

% Define streamlines and equipotential lines in the UHP
y_vals = linspace(0.00001, 2, 50);   % Horizontal lines (streamlines)
x_vals = linspace(-2, 2, 200);
x_vals_eq = linspace(-2, 2, 50);  % Vertical lines (equipotential)
y_vals_eq = linspace(0.00001, 2, 200);

% Plotting setup
figure('Position', [100, 100, 1200, 500]);

% Subplot 1: Upper Half-Plane
subplot(1, 2, 1);
hold on;
% Streamlines (horizontal)
h_stream = [];
for y = y_vals
    z_line = x_vals + 1i*y;
    h_stream = [h_stream, plot(real(z_line), imag(z_line), 'b')];
end
% Equipotential lines (vertical)
h_equip = [];
for x = x_vals_eq
    z_line = x + 1i*y_vals_eq;
    h_equip = [h_equip, plot(real(z_line), imag(z_line), 'r')];
end
% Prevertices
h_pre = plot(real(z_pre), imag(z_pre), 'ko', 'MarkerFaceColor', 'r');
text(real(z_pre) + 0.05, imag(z_pre), arrayfun(@(n) sprintf('z_{%d}', n), 1:length(z_pre), 'UniformOutput', false));
title('Uniform Flow in Upper Half-Plane');
xlabel('Re(z)'); ylabel('Im(z)');
axis equal tight; grid on;
legend([h_stream(1), h_equip(1), h_pre], {'Streamlines', 'Equipotential Lines', 'Prevertices'}, ...
    'Location', 'southoutside', 'FontSize', 7);

% Subplot 2: Mapped flow in the polygonal domain
subplot(1, 2, 2);
hold on;

% Plot mapped streamlines
h_mapped_stream = [];
for y = y_vals
    z_line = x_vals + 1i*y;
    w_line = eval(f, z_line);
    h = plot(real(w_line), imag(w_line), 'b');
    h_mapped_stream = [h_mapped_stream, h];
end

% Plot mapped equipotential lines
h_mapped_equip = [];
for x = x_vals_eq
    z_line = x + 1i*y_vals_eq;
    w_line = eval(f, z_line);
    h = plot(real(w_line), imag(w_line), 'r');
    h_mapped_equip = [h_mapped_equip, h];
end

% Plot polygon vertices and outline
h_vertices = plot(real(vertices), imag(vertices), 'ko', 'MarkerFaceColor', 'b'); % Points
vertices_closed = [vertices, vertices(1)]; % Close the polygon
h_outline = plot(real(vertices_closed), imag(vertices_closed), 'k-', 'LineWidth', 1.5); % Outline

% Label vertices
text(real(vertices) + 0.05, imag(vertices), arrayfun(@(n) sprintf('w_{%d}', n), 1:length(vertices), 'UniformOutput', false));

title('Mapped Flow in Polygonal Domain');
xlabel('Re(w)'); ylabel('Im(w)');
axis equal tight; grid on;

% Update legend to include outline
legend([h_mapped_stream(1), h_mapped_equip(1), h_vertices, h_outline], ...
    {'Mapped Streamlines', 'Mapped Equipotential Lines', 'Polygon Vertices', 'Polygon Outline'}, ...
    'Location', 'southoutside', 'FontSize', 7);

