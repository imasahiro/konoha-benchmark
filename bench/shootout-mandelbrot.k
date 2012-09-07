/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 */

K.import("konoha");
K.import("konoha.io");
K.import("konoha.bytes");

int BUFFER_SIZE=8192;
String EOL = "\n";
void OutputStream.write(Bytes b, int begin, int end) {
  int i=begin;
  while(i < end) {
    this.putByte(b.get(i));
    i += 1;
  }
}

class Mandelbrot {
    int size;
    OutputStream ous;
    Bytes buf;
    int bufLen;
    float fac;
    int shift;

    Mandelbrot(int size) {
        this.bufLen = 0;
        this.size = size;
        fac = 2.0 / size;
        ous = new OutputStream("Mandelbrot.ppm", "w");
        if (size % 8 == 0) {
            shift = 0;
        } else {
            shift = 8 - (size % 8);
        }
        buf = new Bytes(BUFFER_SIZE);
    }
    void compute() {
        ous.println("P4" + EOL + size + " " + size);
        int y = 0; while( y<size) { y+=1;
            computeRow(y);
        }
        ous.write(buf, 0, bufLen);
        ous.close();
    }

    void computeRow(int y) {
        int bits = 0;

        float ci = (y*fac - 1.0);
        Bytes bufLocal = buf;
        int x = 0; while(x<size) {
            float zr = 0.0;
            float zi = 0.0;
            float cr = (x*fac - 1.5);
            int i = 50;
            float zrN = 0;
            float ziN = 0;
            while(i>0) {
                zi  = 2.0 * zr * zi + ci;
                zr  = zrN - ziN + cr;
                ziN = zi * zi;
                zrN = zr * zr;
                if (ziN + zrN > 4.0) {
                    break;
                }
                i = i - 1;
            }

            bits = bits << 1;
            if (i == 0) bits+=1;

            if (x % 8 == 7) {
                bufLocal[bufLen] = bits;
                bufLen += 1;
                if (bufLen == BUFFER_SIZE) {
                    ous.write(bufLocal, 0, BUFFER_SIZE);
                    bufLen = 0;
                }
                bits = 0;
            }
            x+=1;
        }
        if (shift!=0) {
            bits = bits << shift;
            bufLocal[bufLen] = bits;
            bufLen += 1;
            if ( bufLen == BUFFER_SIZE) {
                ous.write(bufLocal, 0, BUFFER_SIZE);
                bufLen = 0;
            }
        }
    }
}

void run() {
    int n = 1600;
    new Mandelbrot(n).compute();
}

run();

