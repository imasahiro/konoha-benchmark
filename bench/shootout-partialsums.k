/*
 * The Great Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 */

K.import("konoha");
K.import("konoha.io");
K.import("konoha.math");
int N=2_500_000;

void partial(int n) {
    float twothirds = 2.0/3.0;

    float a1 = 0.0, a2 = 0.0, a3 = 0.0, a4 = 0.0, a5 = 0.0;
    float a6 = 0.0, a7 = 0.0, a8 = 0.0, a9 = 0.0, alt = -1.0;

    int k=1; while(k<=n) { 
        float k2 = k * k, k3 = k2 * k;
        float sk = Math.sin(k), ck = Math.cos(k);
        alt = -alt;

        a1 += Math.pow(twothirds,k-1);
        a2 += 1.0/(Math.sqrt(k));
        a3 += 1.0/(k*(k+1.0));
        a4 += 1.0/(k3 * sk*sk);
        a5 += 1.0/(k3 * ck*ck);
        a6 += 1.0/k;
        a7 += 1.0/k2;
        a8 += alt/k;
        a9 += alt/(2.0*k -1.0);
        k+=1;
    }
    System.out.println(""+a1/*.format("%0.9f")*/ + "\t(2/3)^k");
    System.out.println(""+a2/*.format("%0.9f")*/ + "\tk^-0.5");
    System.out.println(""+a3/*.format("%0.9f")*/ + "\t1/k(k+1)");
    System.out.println(""+a4/*.format("%0.9f")*/ + "\tFlint Hills");
    System.out.println(""+a5/*.format("%0.9f")*/ + "\tCookson Hills");
    System.out.println(""+a6/*.format("%0.9f")*/ + "\tHarmonic");
    System.out.println(""+a7/*.format("%0.9f")*/ + "\tRiemann Zeta");
    System.out.println(""+a8/*.format("%0.9f")*/ + "\tAlternating Harmonic");
    System.out.println(""+a9/*.format("%0.9f")*/ + "\tGregory");
}

void run() {
    int n = N;
    partial(n);
}

run();

