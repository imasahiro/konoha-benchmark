/*
 * fibonacci 40
 */
K.import("konoha")
K.import("konoha.string")
N = 40;

int fibo(int n) {
    if (n < 3) {
        return 1;
    }
    else {
        return fibo(n-1) + fibo(n-2);
    }
}

//dynamic dyn_fibo(dynamic n) {
//    if (n < 3) {
//        return 1;
//    }
//    return dyn_fibo(n-1) + dyn_fibo(n-2);
//}

float float_fibo(float n) {
    if (n < 3) {
        return 1.0;
    }
    return float_fibo(n-1)+float_fibo(n-2);
}

String string_fibo(int n) {
    if (n < 3) {
        return "x";
    }
    return string_fibo(n-1) + string_fibo(n-2);
}

class FiboInt {
    void run() {
        p("fibo :"+ fibo(N));
    }
}
class FiboFloat {
    void run() {
        p("fibo :"+ float_fibo(N));
    }
}
class FiboString {
    void run() {
        p("fibo :"+ string_fibo(N).size);
    }
}
//class FiboDyn {
//    FiboDyn() {
//        this.name = "fibo:dynamic"+N;
//    }
//    void run() {
//        p("fibo :"+ dyn_fibo(N));
//    }
//}

new FiboInt().run();
new FiboFloat().run();
new FiboString().run();
//new FiboDyn().run();

