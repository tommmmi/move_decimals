data x;
	length a $12.;
	a = "6.5"; output;
	a = "15959.29"; output;
	a = "3"; output;
run;

data x2; set x;
	* condition: a dot exists in the string;
	cond = prxmatch("/\./", a);

	* preceding numbers before dot + 1 after it;
	prec_nums_plus1 = prxchange("s/(.*)(\.)(.{1})(.*)/$1$3/", -1, a);

	* following numbers after first number after dot;
	rest_nums = prxchange("s/(.*)(\.)(.{1})(.*)/$4/", -1, a);

	* original string with added zero to the end;
	with0 = cats(a, "0");

	b = ifc(cond, catx(".", strip(prec_nums_plus1), strip(rest_nums)), with0);
run;
