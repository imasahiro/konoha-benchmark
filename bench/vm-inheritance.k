/*
 * object inheritance
 */
K.import("konoha")
N=1000000;

class A {
	@public @Virtual int f() { return 0; }
}
class B extends A {
	@public int f() { return 1; }
}
class C extends A {
	@public @Virtual int f() { return 2; }
}
class D extends C {
	@public int f() { return 3; }
}

class Bench1 {
	Bench1() {
		//this.name = "monomorphic";
	}
	void run() {
		A a = new A();
		A b = new B();
		A c = new C();
		A d = new D();
		int i = 0;
		while(i < N) {
			a.f(); b.f(); c.f(); d.f(); a.f(); b.f(); c.f(); d.f(); a.f(); b.f();
			c.f(); d.f(); a.f(); b.f(); c.f(); d.f(); a.f(); b.f(); c.f(); d.f();
			i += 1;
		}
	}
}
class Bench2 {
	Bench2() {
		//this.name = "bimorphic";
	}
	void run() {
		A a = new A();
		A b = new B();
		A c = new C();
		A d = new D();
		int i = 0;
		while(i < N) {
			a.f(); b.f(); c.f(); d.f(); a.f(); b.f(); c.f(); d.f(); a.f(); b.f();
			c.f(); d.f(); a.f(); b.f(); c.f(); d.f(); a.f(); b.f(); c.f(); d.f();
			i += 1;
		}
	}
}
class Bench3 {
	Bench3() {
		//this.name = "polymorphic";
	}
	void run() {
		A a = new A();
		A b = new B();
		A c = new C();
		A d = new D();
		int i = 0;
		while(i < N) {
			a.f(); b.f(); c.f(); d.f(); a.f(); b.f(); c.f(); d.f(); a.f(); b.f();
			c.f(); d.f(); a.f(); b.f(); c.f(); d.f(); a.f(); b.f(); c.f(); d.f();
			i += 1;
		}
	}
}
class Bench4 {
	Bench4() {
		//this.name = "polymorphic ver2";
	}
	void run() {
		A[] array = new A[20];
		int i = 0;
		// TODO unexpected TypeError is raised here.
		while(i < 20) {
			if (i % 4 == 0){
				array[i] = new A();
			}else if (i % 4 == 1){
				array[i] = new B();
			}
			else if (i % 4 == 2){
				array[i] = new C();
			}
			else if (i % 4 == 3){
				array[i] = new D();
			}
			i += 1;
		}
		while(i < N) {
			int j = 0;
			while (j < 20) {
				A a = array[j];
				a.f();
				j += 1;
			}
			i += 1;
		}
	}
}

new Bench1().run();
new Bench2().run();
new Bench3().run();
new Bench4().run();

