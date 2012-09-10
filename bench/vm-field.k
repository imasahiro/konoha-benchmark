/*
 * field access
 */
K.import("konoha")
N=1000000;

class A {
    int a;
    A() {
        a = 10;
    }
    int b() {
        return a;
    }
}

class Bench1 {
    void run() {
        A a = new A();
        int i = 0;
        while (i < N) {
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a; a.a;
            i += 1;
        }
    }
}
class Bench2 {
    void run() {
        A a = new A();
        int i = 0;
        while (i < N) {
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b(); a.b();
            i += 1;
        }
    }
}

/*
class Bench3 {
    void run() {
        B b = new B();
        b.v = 100;
        int i = 0;
        while (i < N) {
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v; b.v;
            i += 1;
        }
    }
}
*/
new Bench1().run();
new Bench2().run();
//new Bench3().run();

