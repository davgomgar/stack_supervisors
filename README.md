# OTP StackSupervisors

** Just playing with OTP supervisors for fun**

This project creates a supervisors tree to manage the status of one stack.
When the stack raises an error and the process is terminated, a supervisor restart the process and the stack will be in the last good known state.

