#! /usr/bin/env rdmd
/**
 * Slowcat in D
 * 
 * Author:  Bystroushaak (bystrousak@kitakitsune.org)
 * Version: 1.0.0
 * Date:    16.10.2011
 * 
 * Copyright: 
 *     This work is licensed under a CC BY.
 *     http://creativecommons.org/licenses/by/3.0/
*/
import std.stdio;
import std.getopt;
import std.string;
import core.thread;



void printHelp(string progname, ref File o = stdout){
	o.writeln(
		"Usage:\n"
		"\t" ~ progname.split("/")[$-1] ~ " [optional switches]\n\n"
		"Optional parameters:\n"
		"\t-t, --time\n"
		"\t\tTime in ms. Default is 100ms.\n\n"
		"\t-l LINES, --lines LINES\n"
		"\t\tShow LINES in one moment. Default is 1.\n\n"

		"\t-h, --help\n"
		"\t\tPrint this help.\n"
	);
}


int main(string[] args){
	int time, show_lines;
	bool help;
	
	// parse options
	try{
		getopt(
			args,
			std.getopt.config.bundling,
			"help|h", &help,
			"time|t", &time,
			"lines|l", &show_lines
		);
	}catch(Exception e){
		printHelp(args[0], stderr);
		return 1;
	}
	if (time <= 0)
		time = 100;
	if (show_lines <= 0)
		time = 1;
	
	foreach(ulong line_num, string line; lines(stdin)){
		write(line);
		
		if ((line_num % show_lines) == 0)
			Thread.sleep(dur!("msecs")(time));
	}
	
	return 0;
}