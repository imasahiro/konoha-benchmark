/*
 * DHRYSTONE Benchmark
 * original souce code was here: http://www.okayan.jp/DhrystoneApplet/
 *
 * Ported to KonohaScript by Masahiro Ide
 */
K.import("konoha.array");
K.import("konoha.assign");
K.import("konoha.class");
K.import("konoha.date");
K.import("konoha.global");
K.import("konoha.string");
K.import("konoha.while");
K.import("konoha.null");

IDENT_1 = 0;
IDENT_2 = 1;
IDENT_3 = 2;
IDENT_4 = 3;
IDENT_5 = 4;

class Record_Type {
	Record_Type record_Comp;
	int discr;
	int enum_Comp;
	int int_Comp;
	String string_Comp;
	int enum_Comp_2;
	String string_Comp_2;
	int char_Comp_1;
	int char_Comp_2;
}
Record_Type          record_Glob;
Record_Type          next_Record_Glob;
int                  int_Glob;
int                 char_Glob_1;
int                 char_Glob_2;
IArray = int[];
IArray               array_Glob_1    = new int[128];
IArray[]             array_Glob_2    = new IArray[128];

Record_Type          first_Record    = new Record_Type();
Record_Type          second_Record   = new Record_Type();

CharCode_A = "A".charCodeAt(0);
CharCode_B = "B".charCodeAt(0);
CharCode_C = "C".charCodeAt(0);
CharCode_W = "W".charCodeAt(0);
CharCode_X = "X".charCodeAt(0);
CharCode_Y = "Y".charCodeAt(0);
CharCode_Z = "Z".charCodeAt(0);

class Dhry {
	int number_Of_Runs = 10000;
	void execute() {
		int         int_Loc_1;
		int         int_Loc_2;
		int         int_Loc_3;
		int[]       int_Loc_3_Ref = new int[1];
		int[]       int_Loc_1_Ref = new int[1];
		int        char_Index;
		int[]       enum_Loc = new int[1];
		String      string_Loc_1;
		String      string_Loc_2;

		boolean    bool_Glob;
		int        begin_time;
		int        end_time;
		int        total_time;

		int         run_Index;
		int         meas_Index;

		next_Record_Glob            = second_Record;
		record_Glob                 = first_Record;

		record_Glob.record_Comp     = next_Record_Glob;
		record_Glob.discr           = IDENT_1;
		record_Glob.enum_Comp       = IDENT_3;
		record_Glob.int_Comp        = 40;
		record_Glob.string_Comp     = "DHRYSTONE PROGRAM, SOME STRING";

		string_Loc_1                = "DHRYSTONE PROGRAM, 1'ST STRING";

		System.p("Execution starts, " + number_Of_Runs + " runs through Dhrystone");

		begin_time = new Date().getTime();
		run_Index = 1; 
		while (run_Index <= number_Of_Runs) {

			proc_5();
			bool_Glob = false;
			proc_4(bool_Glob);

			int_Loc_1 = 2;
			int_Loc_2 = 3;

			string_Loc_2 = "DHRYSTONE PROGRAM, 2'ND STRING";

			enum_Loc[0] = IDENT_2;
			bool_Glob = !func_2(string_Loc_1, string_Loc_2);

			while (int_Loc_1 < int_Loc_2) {
				int_Loc_3_Ref[0] = 5 * int_Loc_1 - int_Loc_2;
				proc_7(int_Loc_1, int_Loc_2, int_Loc_3_Ref);
				int_Loc_1 += 1;
			}

			int_Loc_3 = int_Loc_3_Ref[0];
			proc_8(array_Glob_1, array_Glob_2, int_Loc_1, int_Loc_3);
			proc_1(record_Glob);
			char_Index = CharCode_A; 
			while (char_Index <= char_Glob_2) {
				if (enum_Loc[0] == func_1(char_Index, CharCode_C)) {
					proc_6(IDENT_1, enum_Loc);
				}
				char_Index += 1;
			}

			int_Loc_3 = int_Loc_2 * int_Loc_1;
			int_Loc_2 = int_Loc_3 / int_Loc_1;
			int_Loc_2 = 7 * (int_Loc_3 - int_Loc_2) - int_Loc_1;

			int_Loc_1_Ref[0] = int_Loc_1;
			proc_2(int_Loc_1_Ref);
			int_Loc_1 = int_Loc_1_Ref[0];
			run_Index += 1;
		}

		end_time = new Date().getTime();
		total_time = end_time - begin_time;

		System.p("total time: " + total_time + "ms");
		System.p("Result: " + number_Of_Runs * 1000 / total_time + " dhrystone/sec.");

	}

	void proc_1(Record_Type pointer_Par_Val) {

		Record_Type next_Record = pointer_Par_Val.record_Comp;

		pointer_Par_Val.record_Comp = record_Glob;

		pointer_Par_Val.int_Comp = 5;

		next_Record.int_Comp = pointer_Par_Val.int_Comp;
		next_Record.record_Comp = pointer_Par_Val.record_Comp;
		proc_3(next_Record.record_Comp);

		int[] int_Ref = new int[1];

		if (next_Record.discr == IDENT_1) {
			next_Record.int_Comp = 6;
			int_Ref[0] = next_Record.enum_Comp;
			proc_6(pointer_Par_Val.enum_Comp, int_Ref);
			next_Record.enum_Comp = int_Ref[0];
			next_Record.record_Comp = record_Glob.record_Comp;
			int_Ref[0] = next_Record.int_Comp;
			proc_7(next_Record.int_Comp, 10, int_Ref);
			next_Record.int_Comp = int_Ref[0];
		} else {
			pointer_Par_Val = pointer_Par_Val.record_Comp;
		}

	}

	void proc_2(int[] int_Par_Ref) {

		int int_Loc;
		int enum_Loc;

		int_Loc = int_Par_Ref[0] + 10;
		enum_Loc = 0;

		while (enum_Loc != IDENT_1) {
			if (char_Glob_1 == CharCode_A) {
				int_Loc -= 1;
				int_Par_Ref[0] = int_Loc - int_Glob;
				enum_Loc = IDENT_1;
			}
		}
	}

	void proc_3(Record_Type pointer_Par_Ref) {

		if (record_Glob != null) {
			pointer_Par_Ref = record_Glob.record_Comp;
		} else {
			int_Glob = 100;
		}

		int[] int_Comp_Ref = new int[1];
		int_Comp_Ref[0] = record_Glob.int_Comp;
		proc_7(10, int_Glob, int_Comp_Ref);
		record_Glob.int_Comp = int_Comp_Ref[0];

	}

	void proc_4(boolean bool_Glob) {

		boolean bool_Loc;

		bool_Loc = char_Glob_1 == CharCode_A;
		bool_Loc = bool_Loc || bool_Glob;
		char_Glob_2 = CharCode_B;

	}

	void proc_5() {

		char_Glob_1 = CharCode_A;

	}

	void proc_6(int enum_Par_Val, int[] enum_Par_Ref) {

		enum_Par_Ref[0] = enum_Par_Val;

		if (!func_3(enum_Par_Val)) {
			enum_Par_Ref[0] = IDENT_4;
		}

		//switch (enum_Par_Val) {

		//    case IDENT_1:
		//        enum_Par_Ref[0] = IDENT_1;
		//        break;

		//    case IDENT_2:
		//        if (int_Glob > 100)
		//            enum_Par_Ref[0] = IDENT_1;
		//        else
		//            enum_Par_Ref[0] = IDENT_4;
		//        break;

		//    case IDENT_3:
		//        enum_Par_Ref[0] = IDENT_2;
		//        break;

		//    case IDENT_4:
		//        break;

		//    case IDENT_5:
		//        enum_Par_Ref[0] = IDENT_3;
		//        break;

		//}
		if (enum_Par_Val == IDENT_1) {
			enum_Par_Ref[0] = IDENT_1;
		} else if (enum_Par_Val == IDENT_2) {
			if (int_Glob > 100) {
				enum_Par_Ref[0] = IDENT_1;
			}
			else {
				enum_Par_Ref[0] = IDENT_4;
			}
		} else if (enum_Par_Val == IDENT_3) {
			enum_Par_Ref[0] = IDENT_2;
		} else if (enum_Par_Val == IDENT_4) {
		} else if (enum_Par_Val == IDENT_5) {
			enum_Par_Ref[0] = IDENT_3;
		}
	}

	void proc_7(int int_Par_Val1, int int_Par_Val2, int[] int_Par_Ref) {

		int int_Loc;

		int_Loc        = int_Par_Val1 + 2;
		int_Par_Ref[0] = int_Par_Val2 + int_Loc;

	}

	void proc_8(int[] array_Par_1_Ref, int[][] array_Par_2_Ref, int int_Par_Val_1, int int_Par_Val_2) {

		int int_Index, int_Loc;

		int_Loc = int_Par_Val_1 + 5;
		array_Par_1_Ref[int_Loc] = int_Par_Val_2;
		array_Par_1_Ref[int_Loc+1] = array_Par_1_Ref[int_Loc];
		array_Par_1_Ref[int_Loc+30] = int_Loc;
		int_Index = int_Loc; 
		while (int_Index <= int_Loc+1) {
			array_Par_2_Ref[int_Loc][int_Index] = int_Loc;
			int_Index += 1;
		}
		array_Par_2_Ref[int_Loc][int_Loc-1] += 1;
		array_Par_2_Ref[int_Loc+20][int_Loc] = array_Par_1_Ref[int_Loc];
		int_Glob = 5;
		int_Index += 1;
	}

	int func_1(int char_Par_1_Val, int char_Par_2_Val) {

		int char_Loc_1, char_Loc_2;

		char_Loc_1 = char_Par_1_Val;
		char_Loc_2 = char_Loc_1;
		if (char_Loc_2 != char_Par_2_Val) {
			return IDENT_1;
		} else {
			return IDENT_2;
		}

	}

	boolean func_2(String string_Par_1_Ref, String string_Par_2_Ref) {

		int int_Loc;
		int char_Loc = 0;

		int_Loc = 2;
		while (int_Loc <= 2) {
			if (func_1(string_Par_1_Ref.charCodeAt(int_Loc), string_Par_2_Ref.charCodeAt(int_Loc + 1)) == IDENT_1) {
				char_Loc = CharCode_A;
				int_Loc += 1;
			}
		}
		if (char_Loc >= CharCode_W && char_Loc < CharCode_Z) {
			int_Loc = 7;
		}
		if (char_Loc == CharCode_X) {
			return true;
		} else {
			if (string_Par_1_Ref > string_Par_2_Ref) {
				int_Loc += 7;
				return true;
			} else {
				return false;
			}
		}

	}

	boolean func_3(int enum_Par_Val) {

		int enum_Loc;

		enum_Loc = enum_Par_Val;
		if (enum_Loc == IDENT_3) {
			return true;
		} else {
			return false;
		}

	}
}

class DhrystoneBench {
	void run() {
		int i = 0;
		while (i < 128) {
			array_Glob_2[i] = new int[128];
			i += 1;
		}
		//System.err.println("Dhrystone Benchmark, Version 2.1 (Language: mini Konoha)");
		//System.err.println();
		//System.err.print("Please give the number of runs through the benchmark: ");
		//System.err.flush();
		Dhry dh = new Dhry();
		dh.execute();
	}
}

new DhrystoneBench().run();
