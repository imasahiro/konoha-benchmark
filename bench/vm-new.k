/*
 * object.new
 */
K.import("konoha")
N = 10000000;

class A {
}
class B {
    int    f0;
    String f1;
    float  f2;
    B(int a, String b, float c) {
        f0 = a;
        f1 = b;
        f2 = c;
    }
}
class C {
    A      f0;
    int    f1;
    String f2;
    B      f3;
    float  f4;
    C      f5;
    C(A a, int b, String c, B d, float e, C f) {
        f0 = a;
        f1 = b;
        f2 = c;
        f3 = d;
        f4 = e;
        f5 = f;
    }
}
class D0 {
    int b0;
}
class D extends D0 {
    String f0;
    String f1;
    String f2;
    D      b1;
    D(int a, D b, String c, String d, String e) {
        b0 = a;
        b1 = b;
        f0 = c;
        f1 = d;
        f2 = e;
    }
}
class Bench1 {
    void run() {
        int i = 0;
        while (i < N) {
            A a0 = new A();
            A a1 = new A();
            A a2 = new A();
            A a3 = new A();
            B b0 = new B(10, "a", 0.1);
            B b1 = new B(11, "b", 0.2);
            B b2 = new B(12, "c", 0.3);
            B b3 = new B(13, "d", 0.4);
            C c0 = new C();
            C c1 = new C(a0, 0, "", b0, 0.0, c0);
            D d0 = new D();
            D d1 = new D(0, d0, "a", "b", "c");
            i += 1;
        }
    }
}

new Bench1().run();

