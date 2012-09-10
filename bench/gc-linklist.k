/*
 * create link list
 */
K.import("konoha");
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
		for (int i=0; i < COUNT; i++) {
			for (int j=0; j < N; j++) {
				/* short live objects */
				for (int k=0; k < LIST_SIZE; k++) { new A(); }
				/* create link list */
				A a = new A();
				head.next = a;
				head = a;
			}
		}
	}
}

new BenchGC().run();
