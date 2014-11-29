-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "11/26/2014 16:40:20"
                                                            
-- Vhdl Test Bench template for design  :  NCO
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;                               

ENTITY NCO_vhd_tst IS
END NCO_vhd_tst;
ARCHITECTURE NCO_arch OF NCO_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL clk : STD_LOGIC:='0';
SIGNAL fsin : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL nrst : STD_LOGIC:='0';
SIGNAL phase_inc : STD_LOGIC_VECTOR(18 DOWNTO 0);
--SIGNAL fsin_shifted: STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL pwm_out: STD_LOGIC;
COMPONENT NCO
	PORT (
	address : BUFFER STD_LOGIC_VECTOR(11 DOWNTO 0);
	clk : IN STD_LOGIC;
	fsin : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	nrst : IN STD_LOGIC;
	phase_inc : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
	--fsin_shifted: OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	pwm_out: OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : NCO
	PORT MAP (
-- list connections between master ports and signals
	address => address,
	clk => clk,
	fsin => fsin,
	nrst => nrst,
	phase_inc => phase_inc,
	--fsin_shifted => fsin_shifted,
	pwm_out => pwm_out
	);
	
	phase_inc <= "0000000010100000000";
	nrst <= '1' after 2 ns;
	clk <= not clk after 20 ns;		                                         
END NCO_arch;
