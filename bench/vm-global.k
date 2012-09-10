/*
 * access global variable
 */
N=10000;

K.import("konoha");
K.import("konoha.int");
K.import("konoha.float");
K.import("konoha.string");
K.import("konoha.class");
K.import("konoha.while");
K.import("konoha.assign");
K.import("konoha.io");

class A {
	int     a;
	float   b;
	boolean c;
	String  d;
	OutputStream  e;
	A() {
		a = 10;
		b = 10.0;
		c = true;
		d = "10";
		e = new OutputStream("tmp.fasta","w");
	}
}

class Bench1 {
	Bench1() {}
	void run() {
		A a = new A();
		int i=0;
		while(i < N) {
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1; a.a=1;
			i=i+1;
		}
	}
}

class Bench2 {
	Bench2() {}
	void run() {
		A a = new A();
		int i=0;
		while(i < N) {
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1; a.b=1;
			i=i+1;
		}
	}
}
class Bench3 {
	Bench3() {}
	void run() {
		A a = new A();
		int i=0;
		while(i < N) {
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false; a.c=true; a.c=false;
			i=i+1;
		}
	}
}
class Bench4 {
	Bench4() {}
	void run() {
		A a = new A();
		int i=0;
		while(i < N) {
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a"; a.d="a";
			i=i+1;
		}
	}
}
class Bench5 {
	Bench5() {}
	void run() {
		A a = new A();
		int i=0;
		while(i < N) {
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e; a.e=a.e;
			i=i+1;
		}
	}
}

new Bench1().run();
new Bench2().run();
new Bench3().run();
new Bench4().run();
new Bench5().run();
