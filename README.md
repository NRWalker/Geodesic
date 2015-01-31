# Geodesic Solver

## Nicholas Walker

## Description

This set of scripts allows the user to find and solve the geodesic equations given a metric and initial conditions. The script named "EOM_LaTeX" simply finds the symbolic expressions of the equations of motion of the system and provides the LaTeX strings for inclusion in documents. The "ConnectionCoefficient" and "EquationofMotion" files each provide functions for finding the connection coefficients and the equations of motion, respectively. "PlotCurve" just provides and easy to use function for plotting 3D geodesic curves. "Geodesic" is actually the script that provides the integration scheme to find geodesic curves. An additional parameter, J, is present in the script. This simply allows for the addition of other parameters to define the metric that can then be expanded only to certain orders to isolate certain effects. For instance, one may wish to isolate the effects of frame dragging or spherical oblateness. Additional integration algorithms are also provided. I prefer using Beeman's algorithm since it has cubic global error and is symplectic, which means it conserves energy. It does not seem to be a common algorithm in astrophysics, but I am happy with it. It does require two initial points, which is why I have a Velocity Verlet algorithm included. The alternative is to use the standar Runge-Kutta 4th order integration scheme. Just be careful about multi-orbit integration, as energy is not conserved.

## Development

I do not see the need to update this code anymore, but you never know. Perhaps I will learn something that causes me to reconsider.