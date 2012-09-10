/*
 * loop
 */
N=100000000;
K.import("konoha")
class Bench1 {
	void run() {
		int i = 0;
		while (true) {
			if (i == N) {
				break;
			}
			i = i + 1;
		}
	}
}

class Bench2 {
	void run() {
		int i = 0;
		do {
			if (i == N) {
				break;
			}
			i = i + 1;
		} while (true);
	}
}

class Bench3 {
	void run() {
		int i = 0;
		for (; i < N; i += 1) {
		}
	}
}
A=1000;
B=100;
int f() {
	int n = 0;
	for (int i = 0; i < A; i += 1) {
		for (int j = 0; j < A; j += 1) {
			for (int k = 0; k < B; k += 1) {
				n = n + k;
			}
		}
	}
	return n;
}
class Bench4 {
	Bench4() {
		this.name = "nested-loop";
	}
	void run() {
		f();
	}
}

new Bench1().run();
new Bench2().run();
new Bench3().run();
new Bench4().run();

