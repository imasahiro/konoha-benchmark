/*
 * create link list
 */
import("konoha.assign");
import("konoha.class");
import("konoha.const");
import("konoha.while");
class A {
    A next;
}
const COUNT = 10;
const N = 100000;
const LIST_SIZE = 100;

class BenchGC {
	BenchGC() {
	}
	void run() {
		A head = new A();
		int i = 0;
		while (i < COUNT) {
			int j = 0;
			while (j < N) {
				/* short live objects */
				int k = 0;
				while (k < LIST_SIZE) {
					new A();
					k += 1;
				}
				/* create link list */
				A a = new A();
				head.next = a;
				head = a;
				j += 1;
			}
			i += 1;
		}
	}
}

new BenchGC().run();

