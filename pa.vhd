LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.nco_conf.ALL;

-- Phase Accumulator
ENTITY PA IS
    -- N:width of address; M:width of accumultor;
    GENERIC(N:natural:=12;M:natural:=19);
    PORT(
        clk: IN STD_LOGIC; -- 50 MHz
        nrst: IN STD_LOGIC;
        -- 100Hz resolution, Fres=Fclk/(2^M)
        phase_inc: IN STD_LOGIC_VECTOR(M-1 DOWNTO 0);
        address: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END PA;

ARCHITECTURE PA_IMPL OF PA IS
    SIGNAL accum: STD_LOGIC_VECTOR(M-1 DOWNTO 0):=(OTHERS=>'0');
BEGIN
    PROCESS(clk,nrst)
    BEGIN
        IF(nrst='0') THEN
            accum <= (OTHERS=>'0');
        ELSIF(rising_edge(clk)) THEN
            accum <= accum + phase_inc;
        END IF;    
    END PROCESS;    
    address <= accum(M-1 DOWNTO M-N);
END ARCHITECTURE;    
