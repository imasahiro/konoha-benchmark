/*
 * konoha microbench by kimio kuramitsu
 */

K.import("konoha")
K.import("konoha.math")

N = 100000000;

int testSimpleLoop() {
	int i = 0;
	while(i < N) {
		i += 1;
	}
	return i;
}

int testLocalVariable() {
	int y = 0;
	int i = 0;
	while(i < N) {
		y = i;
		i += 1;
	}
	return y;
}

int globalX = 0;
int globalY = 0;
int globalZ = 0;

int testGlobalVariable() {
	int j;
	int i = 0;
	while(i < N) {
		globalY = i;
		i = globalX + i + globalX;
		i += 1;
	}
	return globalY;
}

String testStringAssignment() {
	String s = "";
	int i = 0;
	while(i < N) {
		s = "A";
		i += 1;
	}
	return s;
}

int testintegerOperation() {
	int y = 0;
	int i = 0;
	while(i < N) {
		y += 1;
		i += 1;
	}
	return y;
}

float testfloatOperation() {
	float f = 0.0;
	int i = 0;
	while(i < N) {
		f += 0.1;
		i += 1;
	}
	return f;
}

void func0() {}

int testFunctionCall() {
	int i = 0;
	while(i < N) {
		func0();
		i += 1;
	}
	return i;
}

int func1() { return 1; }

int testFunctionReturn() {
	int res = 0;
	int i = 0;
	while(i< N) {
		res = func1();
		i += 1;
	}
	return res;
}

int testMathFabs() {
	int i = 0;
	while(i< N) {
		Math.fabs(-1.0);
		i += 1;
	}
	return i;
}

int testCallFunctionObject() {
	Func[void] f = func0;
	int i = 0;
	while(i< N) {
		f();
		i += 1;
	}
	return i;
}

int fibo(int n) {
	if(n < 3) return 1;
	return fibo(n-1) + fibo(n-2);
}

//

class Dim {
	int x;
	int y;
	int z;
	void f() {
	}
}

int testObjectCreation() {
	int i = 0;
	while(i < N) {
		Dim d = new Dim();
		i += 1;
	}
	return i;
}

Dim testFieldVariable() {
	Dim d = new Dim();
	int i = 0;
	while(i < N) {
		d.y = 1;
		i += 1;
	}
	return d;
}

int testMethodCall() {
	Dim d = new Dim();
	int i = 0;
	while(i < N) {
		d.f();
		i += 1;
	}
	return i;
}


class Bench1 {
	Bench1() {
		//this.name = "SimpleLoop";
	}
	void run() {
		testSimpleLoop();
	}
}
class Bench2 {
	Bench2() {
		//this.name = "LocalVariable";
	}
	void run() {
		testLocalVariable();
	}
}
class Bench3 {
	Bench3() {
		//this.name = "GlobalVariable";
	}
	void run() {
		testGlobalVariable();
	}
}
class Bench4 {
	int i;
	Bench4() {
		//this.name = "StringAssignment";
	}
	void run() {
		testStringAssignment();
	}
}
class Bench5 {
	Bench5() {
		//this.name = "integerOperation";
	}
	void run() {
		testintegerOperation();
	}
}
class Bench6 {
	Bench6() {
		//this.name = "floatOperation";
	}
	void run() {
		testfloatOperation();
	}
}
class Bench7 {
	Bench7() {
		//this.name = "FunctionCall";
	}
	void run() {
		testFunctionCall();
	}
}
class Bench8 {
	Bench8() {
		//this.name = "FunctionReturn";
	}
	void run() {
		testFunctionReturn();
	}
}
class Bench9 {
	Bench9() {
		//this.name = "NativeFunction";
	}
	void run() {
		testMathFabs();
	}
}
class Bench10 {
	Bench10() {
		//this.name = "CallFunctionObject";
	}
	void run() {
		testCallFunctionObject();
	}
}
class Bench11 {
	Bench11() {
		//this.name = "ObjectCreation";
	}
	void run() {
		testObjectCreation();
	}
}
class Bench12 {
	Bench12() {
		//this.name = "FieldVariable";
	}
	void run() {
		testFieldVariable();
	}
}
class Bench13 {
	Bench13() {
		//this.name = "MethodCall";
	}
	void run() {
		testMethodCall();
	}
}

new Bench1().run();
new Bench2().run();
new Bench3().run();
new Bench4().run();
new Bench5().run();
new Bench6().run();
new Bench7().run();
new Bench8().run();
new Bench9().run();
new Bench10().run();
new Bench11().run();
new Bench12().run();
new Bench13().run();

