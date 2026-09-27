`timescale 1ns/1ps

module lab3_rgb_pwm #(
    parameter integer CLK_HZ = 50_000_000,
    parameter integer PWM_HZ = 1_000,
    parameter integer LEVELS = 10,
    parameter integer DEBOUNCE_CYCLES = 1_000_000
) (
    input  wire       clk_50mhz,
    input  wire       rst_p,
    input  wire       button_r,
    input  wire       button_g,
    input  wire       button_b,
    output wire [3:0] led_r,
    output wire [3:0] led_g,
    output wire [3:0] led_b
);

    wire press_r, press_g, press_b;
    wire pwm_r, pwm_g, pwm_b;

    reg [3:0] level_r, level_g, level_b;

    button_onepulse #(
        .STABLE_CYCLES(DEBOUNCE_CYCLES)
    ) u_button_r (
        .clk(clk_50mhz),
        .rst_p(rst_p),
        .button(button_r),
        .pulse(press_r)
    );

    button_onepulse #(
        .STABLE_CYCLES(DEBOUNCE_CYCLES)
    ) u_button_g (
        .clk(clk_50mhz),
        .rst_p(rst_p),
        .button(button_g),
        .pulse(press_g)
    );

    button_onepulse #(
        .STABLE_CYCLES(DEBOUNCE_CYCLES)
    ) u_button_b (
        .clk(clk_50mhz),
        .rst_p(rst_p),
        .button(button_b),
        .pulse(press_b)
    );

    always @(posedge clk_50mhz or posedge rst_p) begin
        if (rst_p) begin
            level_r <= 0;
            level_g <= 0;
            level_b <= 0;
        end
        else begin
            if (press_r)
                level_r <= (level_r == LEVELS) ? 0 : level_r + 1'b1;

            if (press_g)
                level_g <= (level_g == LEVELS) ? 0 : level_g + 1'b1;

            if (press_b)
                level_b <= (level_b == LEVELS) ? 0 : level_b + 1'b1;
        end
    end

    pwm_channel #(
        .PERIOD_CYCLES(CLK_HZ / PWM_HZ),
        .LEVELS(LEVELS)
    ) u_pwm_r (
        .clk(clk_50mhz),
        .rst_p(rst_p),
        .level(level_r),
        .pwm(pwm_r)
    );

    pwm_channel #(
        .PERIOD_CYCLES(CLK_HZ / PWM_HZ),
        .LEVELS(LEVELS)
    ) u_pwm_g (
        .clk(clk_50mhz),
        .rst_p(rst_p),
        .level(level_g),
        .pwm(pwm_g)
    );

    pwm_channel #(
        .PERIOD_CYCLES(CLK_HZ / PWM_HZ),
        .LEVELS(LEVELS)
    ) u_pwm_b (
        .clk(clk_50mhz),
        .rst_p(rst_p),
        .level(level_b),
        .pwm(pwm_b)
    );

    assign led_r = {4{pwm_r}};
    assign led_g = {4{pwm_g}};
    assign led_b = {4{pwm_b}};

endmodule
