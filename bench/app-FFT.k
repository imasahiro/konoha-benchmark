/*
 * scimark2 FFT bench
 */
K.import("konoha");
K.import("konoha.math");
K.load("../scimark/scimarkutil/Constants.k");
K.load("../scimark/scimarkutil/Random.k");

/** Computes FFT's of complex, float precision data where n is an integer power of 2.
 * This appears to be slower than the Radix2 method,
 * but the code is smaller and simpler, and it requires no extra storage.
 * <P>
 *
 * @author Bruce R. Miller bruce.miller@nist.gov,
 * @author Derived from GSL (Gnu Scientific Library), 
 * @author GSL's FFT Code by Brian Gough bjg@vvv.lanl.gov
 */

/* See {@link ComplexDoubleFFT ComplexDoubleFFT} for details of data layout.
 */



class FFT {

	void arraycopy(float[] src, float[] dest, int length) {
		int i = 0;
		while (i < length) {
			dest[i] = src[i];
			i += 1;
		}
	}

	float num_flops(int n) {
		float nd = n.tofloat();
		float logN = log2(n).tofloat();

		return (5.0*nd-2)*logN + 2*(nd+1);
	}

	/** Compute Fast Fourier Transform of (complex) data, in place.*/
	void transform (Array[float] data) {
		transform_internal(data, -1);
	}

	/** Compute Inverse Fast Fourier Transform of (complex) data, in place.*/
	void inverse (Array[float] data) {
		transform_internal(data, +1);  
		// Normalize
		int nd=data.size;
		int n =nd/2;
		float norm=1/(n.tofloat());
		int i = 0;
		while (i < nd) {
			data[i] *= norm;
			i += 1;
		}
	}

	/** Accuracy check on FFT of data. Make a copy of data, Compute the FFT, then
	 * the inverse and compare to the original.  Returns the rms difference.*/
	float test(float[] data) {
		int length = data.size;
		// Make duplicate for comparison
		float[] copy = new float[length];
		arraycopy(data,copy,length);
		// Transform & invert
		transform(data);
		inverse(data);
		// Compute RMS difference.
		float diff = 0.0;
		int i = 0;
		while (i < length) {
			float d = data[i]-copy[i];
			diff += d*d;
			i += 1;
		}
		return Math.sqrt(diff/length);
	}

	/** Make a random array of n (complex) elements. */
	Array[float] makeRandom(int n) {
		int nd = 2*n;
		float[] data = new float[nd];
		int i = 0;
		while (i < nd) {
			data[i]= Math.random();
			i += 1;
		}
		return data;
	}

	/** Simple Test routine. */
	void main(String[] args){
		if (args.size == 0) {
			int n = 1024;
			System.p("n="+n+" => RMS Error="+test(makeRandom(n)));
		}
		int i = 0; 
		while(i<args.size) {
			int n = (args[i]).toint();
			System.p("n="+n+" => RMS Error="+test(makeRandom(n)));
			i += 1;
		}
	}
	/* ______________________________________________________________________ */

	int log2 (int n){
		int log = 0;
		int k = 1;
		while (k < n) {
			log++;
			k *= 2;
		}
		//if (n != (1 << log))
	//    throw new Error("FFT: Data length is not a power of 2!: "+n);
		return log;
	}

	void transform_internal (float[] data, int direction) {
		if (data.size == 0) return;
		int n = data.size/2;
		if (n == 1) return;         // Identity operation!
		int logn = log2(n);

		/* bit reverse the input data for decimation in time algorithm */
		bitreverse(data);

		/* apply fft recursion */
		/* this loop executed log2(N) times */
		int dual = 1;
		int bit = 0;
		while (bit < logn) {
			float w_real = 1.0;
			float w_imag = 0.0;

			float theta = 2.0 * direction * MATH_PI / (2.0 * dual.tofloat());
			float s = Math.sin(theta);
			float t = Math.sin(theta / 2.0);
			float s2 = 2.0 * t * t;

			/* a = 0 */
			int b = 0;
			while (b < n) {
				int i = 2*b ;
				int j = 2*(b + dual);

				float wd_real = data[j] ;
				float wd_imag = data[j+1] ;

				data[j]   = data[i]   - wd_real;
				data[j+1] = data[i+1] - wd_imag;
				data[i]  += wd_real;
				data[i+1]+= wd_imag;
				b = b + 2 * dual;
			}

			/* a = 1 .. (dual-1) */
			int a = 1;
			while (a < dual) {
				/* trignometric recurrence for w-> exp(i theta) w */
				float tmp_real = w_real - s * w_imag - s2 * w_real;
				float tmp_imag = w_imag + s * w_real - s2 * w_imag;
				w_real = tmp_real;
				w_imag = tmp_imag;
				int b = 0;
				while (b < n) {
					int i = 2*(b + a);
					int j = 2*(b + a + dual);

					float z1_real = data[j];
					float z1_imag = data[j+1];

					float wd_real = w_real * z1_real - w_imag * z1_imag;
					float wd_imag = w_real * z1_imag + w_imag * z1_real;

					data[j]   = data[i]   - wd_real;
					data[j+1] = data[i+1] - wd_imag;
					data[i]  += wd_real;
					data[i+1]+= wd_imag;
					b += 2 * dual;
				}
				a += 1;
			}

			dual *= 2;
			bit += 1;
		}
	}


	void bitreverse(float[] data) {
		/* This is the Goldrader bit-reversal algorithm */
		int n=data.size/2;
		int nm1 = n-1;
		int i=0; 
		int j=0;
		while (i < nm1) {

			int ii = 2*i;
			//int ii = i << 1;

			int jj = 2*j;
			//int jj = j << 1;

			int k = n / 2 ;
			//int k = n >> 1;

			if (i < j) {
				float tmp_real    = data[ii];
				float tmp_imag    = data[ii+1];
				data[ii]   = data[jj];
				data[ii+1] = data[jj+1];
				data[jj]   = tmp_real;
				data[jj+1] = tmp_imag;
			}

			while (k <= j) {
				j = j - k ;
				//j -= k;

				k = k / 2 ; 
				//k >>= 1 ; 
			}
			j += k;
			i += 1;
		}
	}
}

float[] randomVector(int n, Random r) {
	float[] a = new float[n];

	int i = 0;
	while (i < n) {
		a[i] = r.nextDouble();
		i += 1;
	}
	return a;
}

class FFTBench {
	void run() {
		Random r = new Random(RANDOM_SEED);
		// initialize FFT data as complex (n real/img pairs)

		float[] x = randomVector(2*FFT_SIZE, r);
		int cycles = 600;
		int i = 0;
		while (i < cycles) {
			FFT.transform(x); // forward transform
			FFT.inverse(x);   // backward transform
			i += 1;
		}
		System.p("RMS Error="+FFT.test(x));
	}
}

new FFTBench().run();

