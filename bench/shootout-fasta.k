/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 */

K.import("konoha");
K.import("konoha.io");
K.import("konoha.bytes");

N=25000; /*25000000*/
EOL = "\n";

void OutputStream.write(Bytes b, int begin, int end) {
  int i=begin;
  while(i < end) {
    this.putByte(b.get(i));
    i += 1;
  }
}

ALU = ("GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" + 
 "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
 "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
 "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
 "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
 "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
 "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA");

class Frequency {
    int c;
    float p;
    Frequency(int c, float p) {
        this.c = c;
        this.p = p;
    }
}

Frequency[] iub = [
    new Frequency('a', 0.27),
    new Frequency('c', 0.12),
    new Frequency('g', 0.12),
    new Frequency('t', 0.27),
    new Frequency('B', 0.02),
    new Frequency('D', 0.02),
    new Frequency('H', 0.02),
    new Frequency('K', 0.02),
    new Frequency('M', 0.02),
    new Frequency('N', 0.02),
    new Frequency('R', 0.02),
    new Frequency('S', 0.02),
    new Frequency('V', 0.02),
    new Frequency('W', 0.02),
    new Frequency('Y', 0.02)];
Frequency[] homosapiens = [
    new Frequency('a', 0.3029549426680),
    new Frequency('c', 0.1979883004921),
    new Frequency('g', 0.1975473066391),
    new Frequency('t', 0.3015094502008)];

IM=139968;
IA=3877;
IC=29573;

LINE_LENGTH=60;
BUFFER_SIZE=1024;

// pseudo-random number generator
int last = 42;
float random(float max) {
    last = (last * IA + IC) % IM;
    return max * last / IM;
}

Bytes alub = ALU.asBytes();

void makeCumulative(Frequency[] a) {
    float cp = 0.0;
    int i = 0; while(i < a.size) {
        cp += a[i].p;
        a[i].p = cp;
        i+=1;
    }
}

// naive
int selectRandom(Frequency[] a) {
    int len = a.size;
    float r = random(1.0);
    int i = 0; while(i < len) {
        if (r < a[i].p) {
            return a[i].c;
        }
        i+=1;
    }
    return a[len - 1].c;
}

int index = 0;
Bytes bbuffer = new Bytes(BUFFER_SIZE);
void makeRandomFasta(String id, String desc,Frequency[] a, int n, OutputStream writer) {
    index = 0;
    int m = 0;
    String descStr = ">" + id + " " + desc + EOL;
    writer.print(descStr);
    while (n > 0) {
        if (n < LINE_LENGTH) { m = n; } else { m = LINE_LENGTH; }
        if(BUFFER_SIZE - index < m){
            writer.write(bbuffer, 0, index);
            index = 0;
        }
        int i = 0; while(i < m) { i+=1;
            bbuffer[index] = selectRandom(a);
            index+=1;
        }
        bbuffer[index] = "\n".asBytes()[0];
        index+=1;
        n -= LINE_LENGTH;
    }
    if(index != 0) writer.write(bbuffer, 0, index);
}

void makeRepeatFasta(String id, String desc, String alu, int n, OutputStream writer) {
    index = 0;
    int m = 0;
    int k = 0;
    int kn = alub.size;
    String descStr = ">" + id + " " + desc + EOL;
    writer.print(descStr);
    while (n > 0) {
        if (n < LINE_LENGTH) { m = n; } else { m = LINE_LENGTH; }
        if(BUFFER_SIZE - index < m) {
            writer.write(bbuffer, 0, index);
            index = 0;
        }
        int i = 0; while(i < m) { i+=1;
            if (k == kn) { k = 0; }
            bbuffer[index] = alub[k];
            index+=1;
            k+=1;
        }
        bbuffer[index] = "\n".asBytes()[0];
        index+=1;
        n -= LINE_LENGTH;
    }
    if(index != 0) writer.write(bbuffer, 0, index);
}

void run() {
    int n = N;
    makeCumulative(homosapiens);
    makeCumulative(iub);
    OutputStream out = new OutputStream("tmp.fasta", "w");
    makeRepeatFasta("ONE", "Homo sapiens alu", ALU, n * 2, out);
    makeRandomFasta("TWO", "IUB ambiguity codes", iub, n * 3, out);
    makeRandomFasta("THREE", "Homo sapiens frequency", homosapiens, n * 5, out);
    out.close();
}

run();

