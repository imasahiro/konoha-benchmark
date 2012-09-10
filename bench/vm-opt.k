/*
 * for optimizer
 */

K.import("konoha.assign")
K.import("konoha.class")
K.import("konoha.float")
K.import("konoha.while")

N = 10000000;

class Bench1 {
    void run() {
        float f = 0.0;
		int i = 0;
        while (i < N) {
            f += 0.1; f -= 0.1;
            f += 0.1; f -= 0.1;
            f += 0.1; f -= 0.1;
            f += 0.1; f -= 0.1;
			i += 1;
        }
    }
}

new Bench1().run();

