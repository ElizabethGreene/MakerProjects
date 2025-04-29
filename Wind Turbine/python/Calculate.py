import numpy as np

# Turbine parameters
H, D = 0.2, 0.1  # Height (m), Diameter (m)
R = D / 2
rho = 1.225  # Air density (kg/m^3)
v_wind = 5  # Wind speed (m/s)
c = 0.02  # Chord length (m)
num_elements = 10
h = H / num_elements

# Assume lift/drag coefficients (from lookup table)
Cl, Cd = 1.0, 0.1  # Example values

# Iterate to find steady-state rotational speed
omega = 10  # Initial guess (rad/s)
for _ in range(100):
    torque = 0
    for i in range(num_elements):
        # Relative velocity and angle of attack
        v_blade = omega * R
        v_rel = np.sqrt(v_wind**2 + v_blade**2)
        alpha = np.arctan2(v_wind, v_blade)
        # Lift and drag forces
        F_lift = 0.5 * rho * v_rel**2 * c * h * Cl
        F_drag = 0.5 * rho * v_rel**2 * c * h * Cd
        # Tangential force (simplified)
        F_tangential = F_lift * np.cos(alpha) - F_drag * np.sin(alpha)
        torque += F_tangential * R
    # Update omega (simple proportional adjustment)
    omega += torque * 0.01  # Adjust omega until torque ≈ 0

# Calculate power
power = torque * omega
print(f"Rotational Speed: {omega * 60 / (2 * np.pi)} RPM")
print(f"Power: {power} Watts")