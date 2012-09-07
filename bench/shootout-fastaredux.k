/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 */

K.import("konoha");
K.import("konoha.io");
K.import("konoha.bytes");
K.import("konoha.string");

int LINE_LENGTH=60;
int OUT_BUFFER_SIZE = 256*1024;
int LOOKUP_SIZE = 4*1024;
float LOOKUP_SCALE = (LOOKUP_SIZE - 1) * 1.0;
int N=2500000;

void OutputStream.write(Bytes b, int begin, int end) {
  int i=begin;
  while(i < end) {
    this.putByte(b.get(i));
    i += 1;
  }
}

int min(int n, int m) {
    if (n < m) {
        return n;
    }
    return m;
}

void arraycopy(Bytes src, int srcPos, Bytes dest, int destPos, int length) {
    int i=0; while( i < length) { 
        dest[i+destPos] = src[i + srcPos];
      i+=1;
    }
}

class Freq {
    int c;
    float p;
    Freq(int cc, float pp) {c = cc;p = pp;}
}

ALU = ("GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" + 
 "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
 "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
 "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
 "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
 "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
 "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA");
Freq[] iub = [
    new Freq('a', 0.27),
    new Freq('c', 0.12),
    new Freq('g', 0.12),
    new Freq('t', 0.27),
    new Freq('B', 0.02),
    new Freq('D', 0.02),
    new Freq('H', 0.02),
    new Freq('K', 0.02),
    new Freq('M', 0.02),
    new Freq('N', 0.02),
    new Freq('R', 0.02),
    new Freq('S', 0.02),
    new Freq('V', 0.02),
    new Freq('W', 0.02),
    new Freq('Y', 0.02)];
Freq[] homosapiens = [
    new Freq('a', 0.3029549426680),
    new Freq('c', 0.1979883004921),
    new Freq('g', 0.1975473066391),
    new Freq('t', 0.3015094502008)];

int IM=139968;
int IA=3877;
int IC=29573;
float SCALE = LOOKUP_SCALE / IM;

class Random {
    int last;
    Random() {
        last = 42;
    }
    float next() {
        last = (last * IA + IC) % IM;
        return SCALE * last;
    }
}

class Io {
    Bytes buf;
    int lim;
    int ct;
    OutputStream stream;
    Io(OutputStream writer) {
        buf = new Bytes(OUT_BUFFER_SIZE);
        lim = OUT_BUFFER_SIZE - 2 * LINE_LENGTH - 1;
        ct = 0;
        stream = writer;
    }
    void checkFlush() {
        if (ct >= lim) {
            stream.write(buf, 0, ct);
            ct = 0;
        }
    }

    void close() {
        stream.write(buf, 0, ct);ct = 0;
        //stream.close();
    }
}


class Fasta {
    @static void sumAndScale(Freq[] a) {
        float p = 0;
        //for (int i = 0; i < a.size; i+=1)
        int i=0; while (i < a.size) {
            a[i].p = (p += a[i].p) * LOOKUP_SCALE;
            p += a[i].p;
            a[i].p = p * LOOKUP_SCALE;
            i+=1;
        }
        a[a.size - 1].p = LOOKUP_SCALE;
    }
}

Random rand = new Random();
class RandomFasta {
    Freq[] lookup;
    Io ous;
    RandomFasta(OutputStream writer) {
        lookup = new Freq[LOOKUP_SIZE];
        ous    = new Io(writer);
    }
    void makeLookup(Freq[] a) {
        int i=0, j=0;
        while(i < LOOKUP_SIZE) { 
            while (a[j].p < i) {j+=1;}
            lookup[i] = a[j];
            i+=1;
        }
    }

    void addLine(int bytes) {
        ous.checkFlush();
        int lct=ous.ct;
        while(lct<ous.ct+bytes){
            float r = rand.next();
            int  ai = (int) r;
            while (lookup[ai].p < r) { ai+=1; }
            ous.buf[lct] = lookup[ai].c;
            lct+=1;
        }
        ous.buf[lct] = "\n".asBytes()[0];
        lct+=1;
        ous.ct=lct;
    }

    void make(String desc, Freq[] a, int n) {
        int nn = n;
        makeLookup(a);
        arraycopy(desc.asBytes(), 0, ous.buf, ous.ct, desc.size);
        ous.ct+=desc.size;

        while (nn > 0) {
            int bytes = min(LINE_LENGTH, nn);
            addLine(bytes);
            nn -= bytes;
        }
        ous.close();
    }
}

class RepeatFasta {
    Io ous;
    RepeatFasta(OutputStream writer) {
        ous = new Io(writer);
    }

    void make(String desc, Bytes alu, int n) {
        int nn = n;
        arraycopy(desc.asBytes(), 0, ous.buf, ous.ct, desc.size);
        ous.ct += desc.size;

        Bytes buf = new Bytes(alu.size + LINE_LENGTH);
        int i = 0; while( i < buf.size) { 
            int min = min(alu.size, buf.size - i);
            arraycopy(alu, 0, buf, i, min);
            i += alu.size;
        }
        int pos = 0;
        while (nn > 0) {
            int bytes = min(LINE_LENGTH, nn);
            ous.checkFlush();
            arraycopy(buf, pos, ous.buf, ous.ct, bytes);
            ous.ct += bytes;

            ous.buf[ous.ct] = "\n".asBytes()[0];
            ous.ct += 1;
            pos = (pos + bytes) % alu.size;
            nn -= bytes;
        }
        ous.close();
    }
}

void run() {
    int n = N;
    Fasta.sumAndScale(iub);
    Fasta.sumAndScale(homosapiens);
    OutputStream ous = new OutputStream("tmp.fastaredux", "w");
    RepeatFasta f1 = new RepeatFasta(ous);
    f1.make(">ONE Homo sapiens alu\n", ALU.asBytes(), n * 2);
    RandomFasta f2 = new RandomFasta(ous);
    f2.make(">TWO IUB ambiguity codes\n", iub, n * 3);
    RandomFasta f3 = new RandomFasta(ous);
    f3.make(">THREE Homo sapiens frequency\n", homosapiens, n * 5);
    ous.flush();
    ous.close();
}

run();

