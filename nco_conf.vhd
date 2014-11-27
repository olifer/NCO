LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE nco_conf IS
	CONSTANT W_ACCUM:NATURAL:=19; -- width of the accumulator register
	CONSTANT W_ADDR:NATURAL:=12; -- width of the address register
	
	------------------------------------------------------------------
	COMPONENT PA IS
		GENERIC(N:NATURAL;M:NATURAL);
		PORT(
			clk: IN STD_LOGIC;
			nrst: IN STD_LOGIC;
			phase_inc: IN STD_LOGIC_VECTOR(M-1 downto 0);
			address: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	 END COMPONENT;
	------------------------------------------------------------------
	COMPONENT F_LUT IS
		GENERIC(N:NATURAL);
		PORT(
			clk: IN STD_LOGIC;
			lut_addr: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			fsin: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	END COMPONENT;
	------------------------------------------------------------------
	COMPONENT WAVE_RES IS
		GENERIC(N:NATURAL);
		PORT(
			clk: IN STD_LOGIC;
			address: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			fsin: OUT SIGNED(N DOWNTO 0)
		);
	 END COMPONENT;
	 ------------------------------------------------------------------
	 COMPONENT PWM IS
		GENERIC(N:NATURAL);
		PORT(
			clk: IN STD_LOGIC;
			nrst: IN STD_LOGIC;
			pwm_in: IN STD_LOGIC_VECTOR(N DOWNTO 0); 
			pwm_out: OUT STD_LOGIC
		);
	END COMPONENT;
	------------------------------------------------------------------
END nco_conf;