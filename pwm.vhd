LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE work.nco_conf.ALL;

ENTITY PWM IS
	GENERIC(N:NATURAL:=W_ADDR);
	PORT(
		clk: IN STD_LOGIC;
		nrst: IN STD_LOGIC;
		pwm_in: IN STD_LOGIC_VECTOR(N DOWNTO 0); -- signed
		pwm_out: OUT STD_LOGIC
	);
END PWM;

ARCHITECTURE PWM_IMPL OF PWM IS
	SIGNAL accum: UNSIGNED(N+1 DOWNTO 0):=(OTHERS=>'0');
	SIGNAL sin_shifted_sig:SIGNED(N+1 DOWNTO 0);
	SIGNAL sin_shifted_unsig:UNSIGNED(N DOWNTO 0):=(OTHERS=>'0');
BEGIN
	sin_shifted_sig <= SIGNED(pwm_in(N)&pwm_in)+2**N-1;	
	sin_shifted_unsig <= UNSIGNED(STD_LOGIC_VECTOR(sin_shifted_sig(N DOWNTO 0)));	
	
	PROCESS(clk, nrst)
	BEGIN
		IF(nrst='0') THEN
			accum <= (OTHERS=>'0');
		ELSIF(rising_edge(clk)) THEN -- falling_edge
			accum <= ('0'&accum(N DOWNTO 0))+('0'&sin_shifted_unsig);
		END IF;
	END PROCESS;
	
	pwm_out <= accum(N+1);
END ARCHITECTURE;