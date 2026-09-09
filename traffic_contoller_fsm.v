// Code your design here
module timer (
    input wire clk,
    input wire reset,
    output wire timer_done
);

    reg [4:0] counter;

    always @(posedge clk) begin
       
      if (reset)
            counter <= 5'd0;
      
      else if (counter == 5'd30)
            counter <= 5'd0;
      
      else
            counter <= counter + 1'b1;
  
    end

    assign timer_done = (counter == 5'd25) || (counter == 5'd30);

endmodule



module traffic_fsm (
    input  wire clk,
    input  wire reset,
    input  wire Timer_done,
    output wire out
);
    
  parameter s0 = 2'b00;
  
  parameter s1 = 2'b01;
  
  parameter s2 = 2'b10;
  
  parameter s3 = 2'b11;
  
  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(*) begin
    
    next_state[1] = (state[1] & ~Timer_done) | (state[1] & ~state[0]) | 	(~state[1] & state[0] & Timer_done);

    next_state[0] = state[0] ^ Timer_done;
    
  end
  
  always @(posedge clk) begin
   
    if(reset) begin
    
      state <= s0;
    
    end
   
    else begin
      
    state[1] <= next_state[1];
    state[0] <= next_state[0];
 
    end
  
  end
  
  assign out = state[1];
  
endmodule



module traffic_light_controller (
    
  	input wire clk,
    input wire reset,
    output wire out
);

    wire t;

    timer tx (
      .clk(clk),
      .reset(reset),
      .timer_done(t)
    );

    traffic_fsm fx (
      .clk(clk),
      .reset(reset),
      .Timer_done(t),
      .out(out)
    );

endmodule
