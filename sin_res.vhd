LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE work.nco_conf.ALL;

ENTITY WAVE_RES IS
	GENERIC(N:NATURAL:=W_ADDR);
	PORT(
		clk: IN STD_LOGIC;
		address: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		fsin: OUT SIGNED(N DOWNTO 0)
	);
END WAVE_RES;

ARCHITECTURE WAVE_RES_IMPL OF WAVE_RES IS
	SIGNAL lut_addr: STD_LOGIC_VECTOR(N-1 DOWNTO 0):=(OTHERS=>'0');
	SIGNAL fsin_quater: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL sign:STD_LOGIC:='0';
BEGIN
	fsin <= SIGNED('0'&fsin_quater) WHEN sign='0' ELSE -SIGNED('0'&fsin_quater);
	--fsin <= -SIGNED('0'&fsin_quater);
	lut: F_LUT 
		GENERIC MAP(N=>N) 
		PORT MAP(clk,lut_addr,fsin_quater);
		
	PROCESS(clk)
	BEGIN
		IF(rising_edge(clk)) THEN
			IF(address>=0 and address<1024) THEN
				lut_addr <= address;
				sign<='0';
			ELSIF(address>=1024 and address<2048) THEN	
				lut_addr <= 2047-address;
				sign<='0';
			ELSIF(address>=2048 and address<3072) THEN	
				lut_addr <= address-2048;
				sign<='1';	
			ELSIF(address>=3072 and address<=4095) THEN	
				lut_addr <= 4095-address;
				sign<='1';		
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;