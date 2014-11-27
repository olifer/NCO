LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.nco_conf.ALL;

-- Numerically controlled oscillator (NCO)
ENTITY NCO IS
    -- N:width of address; M:width of accumultor;
    GENERIC(N:NATURAL:=W_ADDR;M:NATURAL:=W_ACCUM);
    PORT(
        clk: IN STD_LOGIC; -- 50 MHz
        nrst: IN STD_LOGIC;
        -- 100Hz resolution, Fres=Fclk/(2^M)
        phase_inc: IN STD_LOGIC_VECTOR(M-1 DOWNTO 0);
        address: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  fsin: OUT STD_LOGIC_VECTOR(N DOWNTO 0);
		  pwm_out: OUT STD_LOGIC
    );
END NCO;

ARCHITECTURE NCO_IMPL OF NCO IS
	SIGNAL addr: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL fsin_loc: SIGNED(N DOWNTO 0);
BEGIN
	address <= addr;
	fsin <= STD_LOGIC_VECTOR(fsin_loc);
	
	phase_acc: PA 
		GENERIC MAP(W_ADDR,W_ACCUM)
		PORT MAP(clk,nrst,phase_inc,addr); 
	
	sin_wave: WAVE_RES 
		GENERIC MAP(W_ADDR)
		PORT MAP(clk,addr,fsin_loc); 
	
	sin_pwm: PWM 
		GENERIC MAP(W_ADDR)
		PORT MAP(clk,nrst,STD_LOGIC_VECTOR(fsin_loc),pwm_out); 	

END ARCHITECTURE;
