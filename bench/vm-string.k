/*
 * string ops
 */
N=10000000;
U=1000;
T=100;

K.import("konoha")

class Bench1 {
    void run() {
        String str = "1234567890";
        String zero = "0";
        String one = "1";
        // str.size = 60;
        int i = 0;
		while (i < T;) {
            String newstr = "";
			int j = 0;
            while (j < U) {
                newstr = newstr + str + zero + one;
				j += 1;
            }
            newstr = null;
			i += 1;
        }
    }
}
class Bench2 {
    void run() {
        String empty10 = "          ";
        String s = empty10 + "1234567890" + empty10;
        String v = "";
		int i = 0;
        while(i < N) {
            v = s.trim();
        }
        p(v);
    }
}

new Bench1().run();
new Bench2().run();

