/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 */

K.import("konoha");
K.import("konoha.io");

int N=12;
int max(int a, int b) {
    if (a > b) {
        return a;
    }
    else {
        return b;
    }
}

int fannkuch(int n) {
    int[] perm  = new int[n];
    int[] perm1 = new int[n];
    int[] count = new int[n];
    int maxFlipsCount = 0;
    int permCount = 0;
    int checksum = 0;

    //for(int i=0; i<n; i++) { perm1[i] = i; }
    int i=0; while(i<n) { perm1[i] = i; i+=1; }
    int r = n;

    while (true) {

        while (r != 1) { count[r-1] = r; r-=1; }

        //for(int i=0; i<n; i++) { perm[i] = perm1[i]; }
        i=0; while(i<n) { perm[i] = perm1[i]; i+=1; }

        int flipsCount = 0;
        int k;

        while ( !((k=perm[0]) == 0) ) {
            int k2 = (k+1) >> 1;
            //for(int i=0; i<k2; i++) {
            i=0; while(i<k2) {
                int temp = perm[i]; perm[i] = perm[k-i]; perm[k-i] = temp;
                i+=1;
            }
            flipsCount+=1;
        }

        maxFlipsCount = max(maxFlipsCount, flipsCount);
        //checksum = checksum + ((permCount%2 == 0) ? flipsCount : -flipsCount);
        if(permCount%2 == 0) {
          checksum += flipsCount;
        } else {
          checksum += -flipsCount;
        }

        // Use incremental change to generate another permutation
        while (true) {
            if (r == n) {
                System.out.println(""+checksum);
                return maxFlipsCount;
            }
            int perm0 = perm1[0];
            int i = 0;
            while (i < r) {
                int j = i + 1;
                perm1[i] = perm1[j];
                i = j;
            }
            perm1[r] = perm0;

            count[r] = count[r] - 1;
            if (count[r] > 0) break;
            r+=1;
        }

        permCount+=1;
    }
    return 0;
}

void run() {
    int n = N;
    System.out.println("Pfannkuchen("+n+") = "+fannkuch(n));
}

run();

