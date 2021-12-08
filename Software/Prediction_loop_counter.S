#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408

.globl main
main:


li x28, 0xFFFF
li x29, GPIO_INOUT
# li s1, 0x00070040
csrwi 0x7f9, 0x08             # Enable or disable the branch prediction module
sw x28, 0(x29)                  # Write the Enable Register
li t1, 0x0
li t2, 0xff
j next


branchx: 
    addi t2, t2, -1
    bne t1, t2, next
    li t1, 0x09
    ret 

next:
    li  a1, GPIO_SWs            # Read the Switches
    lw  t0, 0(a1)

    li  a0, GPIO_LEDs
    srl t0, t0, 16
    sw  t0, 0(a0)               # Write the LEDs
    jal branchx
.end

