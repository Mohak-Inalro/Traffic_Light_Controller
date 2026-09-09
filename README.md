# Traffic Light Controller

## Overview
A Verilog-based traffic light controller implemented using a finite state machine (FSM).

## Files
- `traffic_controller.v` — RTL implementation
- `testbench.v` — Simulation testbench
- `fsm_diagram.png` — FSM state diagram
- `README.md` — Project documentation

## FSM
The controller consists of the following states:
- RED
- GREEN
- YELLOW

## Tools
- Verilog
- Icarus Verilog

### FSM Design

I divided the controller into three states:

- **RED** – Red light is active
- **GREEN** – Green light is active
- **YELLOW** – Yellow light is active

The FSM follows the sequence:

RED → GREEN → YELLOW → RED

Instead of changing states after a fixed number of clock cycles directly in the FSM logic, I used a counter to keep track of how long the controller has remained in the current state.

### Counter Design

The counter acts as a timer for the FSM.

On every rising edge of the clock, the counter increments while the FSM remains in the current state. Once the counter reaches the required duration for that state, the FSM transitions to the next state and the counter is reset.

Conceptually, the control flow is:

Clock → Counter → Time Reached → State Transition → Counter Reset

This separates the **timing mechanism** from the state-transition logic, making the design easier to understand and modify.

For example, changing the duration of a traffic-light state only requires changing its corresponding timing condition rather than redesigning the FSM.

### Design Thought Process

The design was approached from the hardware perspective:

1. Identify the different operating conditions of the traffic light.
2. Represent each condition as an FSM state.
3. Define the valid state transitions.
4. Determine how long each state should remain active.
5. Implement a synchronous counter to measure clock cycles.
6. Use the counter value to trigger state transitions.
7. Reset the counter whenever the FSM enters a new state.
8. Verify the behavior using a dedicated Verilog testbench.

This approach helped keep the RTL modular, synchronous, and easy to extend.
