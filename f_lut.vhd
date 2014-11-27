LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.nco_conf.ALL;


ENTITY F_LUT IS
	GENERIC(N:NATURAL:=W_ADDR);
	PORT(
		clk: IN STD_LOGIC;
		lut_addr: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		fsin: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END F_LUT;

ARCHITECTURE LUT_IMPL OF F_LUT IS
	TYPE romT IS ARRAY(0 TO (2**N)/4-1) OF STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	CONSTANT sinRom: romT:=(
		x"000", x"006", x"00D", x"013", x"019", x"01F", x"026", x"02C", 
		x"032", x"039", x"03F", x"045", x"04B", x"052", x"058", x"05E", 
		x"064", x"06B", x"071", x"077", x"07E", x"084", x"08A", x"090", 
		x"097", x"09D", x"0A3", x"0AA", x"0B0", x"0B6", x"0BC", x"0C3", 
		x"0C9", x"0CF", x"0D5", x"0DC", x"0E2", x"0E8", x"0EF", x"0F5", 
		x"0FB", x"101", x"108", x"10E", x"114", x"11A", x"121", x"127", 
		x"12D", x"134", x"13A", x"140", x"146", x"14D", x"153", x"159", 
		x"15F", x"166", x"16C", x"172", x"178", x"17F", x"185", x"18B", 
		x"191", x"198", x"19E", x"1A4", x"1AA", x"1B1", x"1B7", x"1BD", 
		x"1C3", x"1CA", x"1D0", x"1D6", x"1DC", x"1E3", x"1E9", x"1EF", 
		x"1F5", x"1FC", x"202", x"208", x"20E", x"214", x"21B", x"221", 
		x"227", x"22D", x"234", x"23A", x"240", x"246", x"24C", x"253", 
		x"259", x"25F", x"265", x"26B", x"272", x"278", x"27E", x"284", 
		x"28B", x"291", x"297", x"29D", x"2A3", x"2AA", x"2B0", x"2B6", 
		x"2BC", x"2C2", x"2C8", x"2CF", x"2D5", x"2DB", x"2E1", x"2E7", 
		x"2EE", x"2F4", x"2FA", x"300", x"306", x"30C", x"313", x"319", 
		x"31F", x"325", x"32B", x"331", x"338", x"33E", x"344", x"34A", 
		x"350", x"356", x"35C", x"363", x"369", x"36F", x"375", x"37B", 
		x"381", x"387", x"38D", x"394", x"39A", x"3A0", x"3A6", x"3AC", 
		x"3B2", x"3B8", x"3BE", x"3C5", x"3CB", x"3D1", x"3D7", x"3DD", 
		x"3E3", x"3E9", x"3EF", x"3F5", x"3FB", x"401", x"408", x"40E", 
		x"414", x"41A", x"420", x"426", x"42C", x"432", x"438", x"43E", 
		x"444", x"44A", x"450", x"456", x"45C", x"462", x"468", x"46F", 
		x"475", x"47B", x"481", x"487", x"48D", x"493", x"499", x"49F", 
		x"4A5", x"4AB", x"4B1", x"4B7", x"4BD", x"4C3", x"4C9", x"4CF", 
		x"4D5", x"4DB", x"4E1", x"4E7", x"4ED", x"4F3", x"4F9", x"4FF", 
		x"505", x"50A", x"510", x"516", x"51C", x"522", x"528", x"52E", 
		x"534", x"53A", x"540", x"546", x"54C", x"552", x"558", x"55E", 
		x"564", x"569", x"56F", x"575", x"57B", x"581", x"587", x"58D", 
		x"593", x"599", x"59F", x"5A4", x"5AA", x"5B0", x"5B6", x"5BC", 
		x"5C2", x"5C8", x"5CD", x"5D3", x"5D9", x"5DF", x"5E5", x"5EB", 
		x"5F1", x"5F6", x"5FC", x"602", x"608", x"60E", x"613", x"619", 
		x"61F", x"625", x"62B", x"630", x"636", x"63C", x"642", x"648", 
		x"64D", x"653", x"659", x"65F", x"664", x"66A", x"670", x"676", 
		x"67B", x"681", x"687", x"68D", x"692", x"698", x"69E", x"6A4", 
		x"6A9", x"6AF", x"6B5", x"6BA", x"6C0", x"6C6", x"6CB", x"6D1", 
		x"6D7", x"6DD", x"6E2", x"6E8", x"6EE", x"6F3", x"6F9", x"6FE", 
		x"704", x"70A", x"70F", x"715", x"71B", x"720", x"726", x"72C", 
		x"731", x"737", x"73C", x"742", x"748", x"74D", x"753", x"758", 
		x"75E", x"763", x"769", x"76F", x"774", x"77A", x"77F", x"785", 
		x"78A", x"790", x"795", x"79B", x"7A0", x"7A6", x"7AC", x"7B1", 
		x"7B7", x"7BC", x"7C2", x"7C7", x"7CD", x"7D2", x"7D7", x"7DD", 
		x"7E2", x"7E8", x"7ED", x"7F3", x"7F8", x"7FE", x"803", x"809", 
		x"80E", x"813", x"819", x"81E", x"824", x"829", x"82E", x"834", 
		x"839", x"83F", x"844", x"849", x"84F", x"854", x"859", x"85F", 
		x"864", x"86A", x"86F", x"874", x"87A", x"87F", x"884", x"88A", 
		x"88F", x"894", x"899", x"89F", x"8A4", x"8A9", x"8AF", x"8B4", 
		x"8B9", x"8BE", x"8C4", x"8C9", x"8CE", x"8D3", x"8D9", x"8DE", 
		x"8E3", x"8E8", x"8ED", x"8F3", x"8F8", x"8FD", x"902", x"907", 
		x"90D", x"912", x"917", x"91C", x"921", x"927", x"92C", x"931", 
		x"936", x"93B", x"940", x"945", x"94A", x"950", x"955", x"95A", 
		x"95F", x"964", x"969", x"96E", x"973", x"978", x"97D", x"982", 
		x"987", x"98C", x"991", x"996", x"99C", x"9A1", x"9A6", x"9AB", 
		x"9B0", x"9B5", x"9BA", x"9BF", x"9C4", x"9C8", x"9CD", x"9D2", 
		x"9D7", x"9DC", x"9E1", x"9E6", x"9EB", x"9F0", x"9F5", x"9FA", 
		x"9FF", x"A04", x"A09", x"A0D", x"A12", x"A17", x"A1C", x"A21", 
		x"A26", x"A2B", x"A30", x"A34", x"A39", x"A3E", x"A43", x"A48", 
		x"A4C", x"A51", x"A56", x"A5B", x"A60", x"A64", x"A69", x"A6E", 
		x"A73", x"A77", x"A7C", x"A81", x"A86", x"A8A", x"A8F", x"A94", 
		x"A99", x"A9D", x"AA2", x"AA7", x"AAB", x"AB0", x"AB5", x"AB9", 
		x"ABE", x"AC3", x"AC7", x"ACC", x"AD1", x"AD5", x"ADA", x"ADE", 
		x"AE3", x"AE8", x"AEC", x"AF1", x"AF5", x"AFA", x"AFF", x"B03", 
		x"B08", x"B0C", x"B11", x"B15", x"B1A", x"B1E", x"B23", x"B27", 
		x"B2C", x"B30", x"B35", x"B39", x"B3E", x"B42", x"B47", x"B4B", 
		x"B50", x"B54", x"B58", x"B5D", x"B61", x"B66", x"B6A", x"B6F", 
		x"B73", x"B77", x"B7C", x"B80", x"B84", x"B89", x"B8D", x"B91", 
		x"B96", x"B9A", x"B9E", x"BA3", x"BA7", x"BAB", x"BB0", x"BB4", 
		x"BB8", x"BBC", x"BC1", x"BC5", x"BC9", x"BCE", x"BD2", x"BD6", 
		x"BDA", x"BDE", x"BE3", x"BE7", x"BEB", x"BEF", x"BF3", x"BF8", 
		x"BFC", x"C00", x"C04", x"C08", x"C0C", x"C10", x"C15", x"C19", 
		x"C1D", x"C21", x"C25", x"C29", x"C2D", x"C31", x"C35", x"C39", 
		x"C3D", x"C41", x"C45", x"C49", x"C4D", x"C51", x"C55", x"C59", 
		x"C5D", x"C61", x"C65", x"C69", x"C6D", x"C71", x"C75", x"C79", 
		x"C7D", x"C81", x"C85", x"C89", x"C8D", x"C91", x"C95", x"C98", 
		x"C9C", x"CA0", x"CA4", x"CA8", x"CAC", x"CB0", x"CB3", x"CB7", 
		x"CBB", x"CBF", x"CC3", x"CC6", x"CCA", x"CCE", x"CD2", x"CD5", 
		x"CD9", x"CDD", x"CE1", x"CE4", x"CE8", x"CEC", x"CEF", x"CF3", 
		x"CF7", x"CFA", x"CFE", x"D02", x"D05", x"D09", x"D0D", x"D10", 
		x"D14", x"D18", x"D1B", x"D1F", x"D22", x"D26", x"D2A", x"D2D", 
		x"D31", x"D34", x"D38", x"D3B", x"D3F", x"D42", x"D46", x"D49", 
		x"D4D", x"D50", x"D54", x"D57", x"D5B", x"D5E", x"D62", x"D65", 
		x"D69", x"D6C", x"D6F", x"D73", x"D76", x"D7A", x"D7D", x"D80", 
		x"D84", x"D87", x"D8A", x"D8E", x"D91", x"D94", x"D98", x"D9B", 
		x"D9E", x"DA2", x"DA5", x"DA8", x"DAB", x"DAF", x"DB2", x"DB5", 
		x"DB8", x"DBC", x"DBF", x"DC2", x"DC5", x"DC8", x"DCC", x"DCF", 
		x"DD2", x"DD5", x"DD8", x"DDB", x"DDF", x"DE2", x"DE5", x"DE8", 
		x"DEB", x"DEE", x"DF1", x"DF4", x"DF7", x"DFA", x"DFD", x"E00", 
		x"E04", x"E07", x"E0A", x"E0D", x"E10", x"E13", x"E16", x"E19", 
		x"E1B", x"E1E", x"E21", x"E24", x"E27", x"E2A", x"E2D", x"E30", 
		x"E33", x"E36", x"E39", x"E3C", x"E3E", x"E41", x"E44", x"E47", 
		x"E4A", x"E4D", x"E4F", x"E52", x"E55", x"E58", x"E5B", x"E5D", 
		x"E60", x"E63", x"E66", x"E68", x"E6B", x"E6E", x"E70", x"E73", 
		x"E76", x"E79", x"E7B", x"E7E", x"E81", x"E83", x"E86", x"E88", 
		x"E8B", x"E8E", x"E90", x"E93", x"E95", x"E98", x"E9B", x"E9D", 
		x"EA0", x"EA2", x"EA5", x"EA7", x"EAA", x"EAC", x"EAF", x"EB1", 
		x"EB4", x"EB6", x"EB9", x"EBB", x"EBE", x"EC0", x"EC2", x"EC5", 
		x"EC7", x"ECA", x"ECC", x"ECE", x"ED1", x"ED3", x"ED6", x"ED8", 
		x"EDA", x"EDD", x"EDF", x"EE1", x"EE3", x"EE6", x"EE8", x"EEA", 
		x"EED", x"EEF", x"EF1", x"EF3", x"EF6", x"EF8", x"EFA", x"EFC", 
		x"EFE", x"F01", x"F03", x"F05", x"F07", x"F09", x"F0B", x"F0E", 
		x"F10", x"F12", x"F14", x"F16", x"F18", x"F1A", x"F1C", x"F1E", 
		x"F20", x"F22", x"F24", x"F26", x"F28", x"F2A", x"F2C", x"F2E", 
		x"F30", x"F32", x"F34", x"F36", x"F38", x"F3A", x"F3C", x"F3E", 
		x"F40", x"F42", x"F44", x"F45", x"F47", x"F49", x"F4B", x"F4D", 
		x"F4F", x"F50", x"F52", x"F54", x"F56", x"F58", x"F59", x"F5B", 
		x"F5D", x"F5F", x"F60", x"F62", x"F64", x"F66", x"F67", x"F69", 
		x"F6B", x"F6C", x"F6E", x"F70", x"F71", x"F73", x"F75", x"F76", 
		x"F78", x"F79", x"F7B", x"F7D", x"F7E", x"F80", x"F81", x"F83", 
		x"F84", x"F86", x"F87", x"F89", x"F8A", x"F8C", x"F8D", x"F8F", 
		x"F90", x"F92", x"F93", x"F95", x"F96", x"F97", x"F99", x"F9A", 
		x"F9C", x"F9D", x"F9E", x"FA0", x"FA1", x"FA2", x"FA4", x"FA5", 
		x"FA6", x"FA8", x"FA9", x"FAA", x"FAB", x"FAD", x"FAE", x"FAF", 
		x"FB0", x"FB2", x"FB3", x"FB4", x"FB5", x"FB6", x"FB7", x"FB9", 
		x"FBA", x"FBB", x"FBC", x"FBD", x"FBE", x"FBF", x"FC1", x"FC2", 
		x"FC3", x"FC4", x"FC5", x"FC6", x"FC7", x"FC8", x"FC9", x"FCA", 
		x"FCB", x"FCC", x"FCD", x"FCE", x"FCF", x"FD0", x"FD1", x"FD2", 
		x"FD3", x"FD4", x"FD5", x"FD5", x"FD6", x"FD7", x"FD8", x"FD9", 
		x"FDA", x"FDB", x"FDB", x"FDC", x"FDD", x"FDE", x"FDF", x"FDF", 
		x"FE0", x"FE1", x"FE2", x"FE2", x"FE3", x"FE4", x"FE5", x"FE5", 
		x"FE6", x"FE7", x"FE7", x"FE8", x"FE9", x"FE9", x"FEA", x"FEB", 
		x"FEB", x"FEC", x"FEC", x"FED", x"FEE", x"FEE", x"FEF", x"FEF", 
		x"FF0", x"FF0", x"FF1", x"FF1", x"FF2", x"FF2", x"FF3", x"FF3", 
		x"FF4", x"FF4", x"FF5", x"FF5", x"FF6", x"FF6", x"FF7", x"FF7", 
		x"FF7", x"FF8", x"FF8", x"FF8", x"FF9", x"FF9", x"FF9", x"FFA", 
		x"FFA", x"FFA", x"FFB", x"FFB", x"FFB", x"FFB", x"FFC", x"FFC", 
		x"FFC", x"FFC", x"FFD", x"FFD", x"FFD", x"FFD", x"FFD", x"FFE", 
		x"FFE", x"FFE", x"FFE", x"FFE", x"FFE", x"FFE", x"FFF", x"FFF", 
		x"FFF", x"FFF", x"FFF", x"FFF", x"FFF", x"FFF", x"FFF", x"FFF"
	);
BEGIN
	PROCESS(clk)
	BEGIN
		IF(rising_edge(clk)) THEN
			fsin <= sinRom(conv_integer(lut_addr));
		END IF;
	END PROCESS;
END ARCHITECTURE;