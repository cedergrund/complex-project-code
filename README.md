# ✨ Unlocking Polygonal Worlds with Schwarz-Christoffel! 🗺️

Welcome to the code repository for our project exploring the fascinating Schwarz-Christoffel (SC) transformation!

Have you ever wondered how to smoothly warp one shape into another while preserving angles? Or how to simulate fluid gently flowing around a twisty, polygonal obstacle? That's where the Schwarz-Christoffel map comes in!

This repository holds the computational magic behind our report, showing how we tackled the math to map simple domains (like the upper half-plane) to complex polygons, visualize ideal fluid flow, and even get a little artistic! 🎨

---

## What's Inside the Toybox?

You'll find code written in both Python and MATLAB, because sometimes you need the right tool for the right job (and it's fun to see how different tools approach the same problem!).

- `first_pass.ipynb` & `python_code.ipynb`: Our adventures in Python! These Jupyter notebooks contain code exploring the SC transformation using libraries like `mpmath` for complex arithmetic and integration, and `scipy` for solving the tricky parameter problem. Dive in to see the step-by-step process!
- `.m` files (`kish3.m`, `mona3.m`, `sean3.m`, `figure1.m`, `figure2.m`, `figure3.m`, `corner.m`, `sc_uniform_flow.m`, etc.): MATLAB scripts and functions! Many of our visualizations and parameter solving were done using the powerful Schwarz-Christoffel Toolbox in MATLAB. These files are often set up to generate specific examples or figures mentioned in the report.
- `images/` & `final_images/`: Look here for some of the visual outputs and perhaps source images used in the project. See the warped shapes and the pretty streamlines!
- `archive/`: Like any good project, there's a place for older versions or experimental code. Probably not what you're looking for first! 😉

---

## Getting Started (Let's Make Some Maps!)

To run this code, you'll need:

1.  **Python:**
    - A working Python installation (We used [Specify Python Version, e.g., 3.9+]).
    - The necessary libraries: `mpmath`, `scipy`, `numpy`, `matplotlib`, and any others specified within the notebooks. You can usually install these using pip:
      ```bash
      pip install mpmath scipy numpy matplotlib [any-other-libraries]
      ```
    - Jupyter Notebook or JupyterLab to run the `.ipynb` files.
2.  **MATLAB:**
    - A working MATLAB installation (We used [Specify MATLAB Version]).
    - The **Schwarz-Christoffel Toolbox** installed. You can find information on how to get and install it here: [Link to SC Toolbox Website/Instructions, if available, or just mention its name].

**How to Play:**

- Clone this repository to your local machine.
- Open the Jupyter notebooks (`.ipynb`) in your Python environment to follow along with the Python implementation.
- Open the MATLAB scripts (`.m`) in MATLAB. Many of these scripts are designed to be run directly and will generate plots or perform specific calculations. Look at the comments within the scripts for details!

---

## Producing the Figures from the Report

Curious about how a specific figure in our report was made? Many of the `.m` files named like `figure1.m`, `figure2.m`, etc., are designed to generate those exact plots (assuming you have the dependencies set up!). The Jupyter notebooks also produce figures as part of their workflow.

---

## Acknowledgements

A huge thanks to our instructors, [Professor Names, e.g., Professor Kish and Professor Nixon], for guiding us through the fascinating world of complex analysis and conformal mapping!

---

Have fun exploring the code and the wonderful world of Schwarz-Christoffel transformations!

Happy Mapping! 🗺️🌊🌟
