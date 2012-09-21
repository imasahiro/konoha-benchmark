//package jnt.scimark2;

/* Random.java based on Java Numerical Toolkit (JNT) Random.UniformSequence
   class.  We do not use Java's own java.util.Random so that we can compare
   results with equivalent C and Fortran coces.
 */
import("konoha.class");
import("konoha.global");
import("konoha.array");
import("konoha.float");
import("konoha.int");
import("konoha.assign");

const MDIG = 32;
const HMDIG = 16;
const ONE = 1;
const M1 = (ONE << (MDIG-2)) + ((ONE << (MDIG-2))-ONE);
const M2 = ONE << (HMDIG);

/* For mdig = 32 : M1 =          2147483647, M2 =      65536
   For mdig = 64 : M1 = 9223372036854775807, M2 = 4294967296 
 */


class Random {

	/* ------------------------------------------------------------------------------
	   CLASS VARIABLES
	   ------------------------------------------------------------------------------ */

	int seed = 0;

	Array[int] m;
	int   i = 4;
	int   j = 16;

	float dM1;

	boolean haveRange = false;
	float left  = 0.0;
	float right = 1.0;
	float width = 1.0;

	/* ------------------------------------------------------------------------------
	   CONSTRUCTORS
	   ------------------------------------------------------------------------------ */

	/**
	  Initializes a sequence of uniformly distributed quasi random numbers with a
	  seed based on the system clock.
	 */
	Random () {
		this.dM1 = 1.0 / M1;
		initialize(System.getTime().toint());
	}

	/**
	  Initializes a sequence of uniformly distributed quasi random numbers on a
	  given half-open interval [left,right) with a seed based on the system
	  clock.

	  @param <B>left</B> (float)<BR>

	  The left endpoint of the half-open interval [left,right).

	  @param <B>right</B> (float)<BR>

	  The right endpoint of the half-open interval [left,right).
	 */
	Random ( float left, float right) {
		this.dM1 = 1.0 / M1;
		initialize(System.getTime().toint());
		this.left = left;
		this.right = right;
		width = right - left;
		haveRange = true;
	}

	/**
	  Initializes a sequence of uniformly distributed quasi random numbers with a
	  given seed.

	  @param <B>seed</B> (int)<BR>

	  The seed of the random number generator.  Two sequences with the same
	  seed will be identical.
	 */
	Random (int seed) {
		this.dM1 = 1.0 / M1;
		initialize(seed);
	}

	/**
	  Initializes a sequence of uniformly distributed quasi random numbers
	  with a given seed on a given half-open interval [left,right).

	  @param <B>seed</B> (int)<BR>

	  The seed of the random number generator.  Two sequences with the same
	  seed will be identical.

	  @param <B>left</B> (float)<BR>

	  The left endpoint of the half-open interval [left,right).

	  @param <B>right</B> (float)<BR>

	  The right endpoint of the half-open interval [left,right).
	 */
	Random (int seed, float left, float right) {
		this.dM1 = 1.0 / M1;
		initialize( seed);
		this.left = left;
		this.right = right;
		width = right - left;
		haveRange = true;
	}

	/* ------------------------------------------------------------------------------
	   PUBLIC METHODS
	   ------------------------------------------------------------------------------ */

	/**
	  Returns the next random number in the sequence.
	 */
	float nextDouble () {

		int k;
		float nextValue;

		k = this.m[this.i] - m[this.j];
		if (k < 0) k += M1;
		m[j] = k;

		if (this.i == 0) {
			this.i = 16;
		} else {
			this.i -= 1;
		}

		if (this.j == 0) {
			this.j = 16 ;
		} else {
			this.j -= 1;
		}

		if (this.haveRange) {
			return  this.left +  this.dM1 * k.tofloat() * this.width;
		} else {
			return this.dM1 * k.tofloat();
		}

	}

	/**
	  Returns the next N random numbers in the sequence, as
	  a vector.
	 */
	void nextDoubles (float[] x) {

		int n = x.size;
		int remainder = n & 3;		// N mod 4

		if (haveRange) {
			int count = 0;
			while (count < n) {
				int k = m[i] - m[j];

				if (i == 0) i = 16;
				else i--;

				if (k < 0) k += M1;
				m[j] = k;

				if (j == 0) j = 16;
				else j--;

				x[count] = left + dM1 * k.tofloat() * width;
				count += 1;
			}

		} else {

			int count = 0;
			while (count < remainder) {
				int k = m[i] - m[j];

				if (i == 0) i = 16;
				else i--;

				if (k < 0) k += M1;
				m[j] = k;

				if (j == 0) j = 16;
				else j--;


				x[count] = dM1 * k.tofloat();
				count += 1;
			}

			for (int count=remainder; count<n; count+=4) {
				int k = m[i] - m[j];
				if (i == 0) i = 16;
				else i--;
				if (k < 0) k += M1;
				m[j] = k;
				if (j == 0) j = 16;
				else j--;
				x[count] = dM1 * (float) k;


				k = m[i] - m[j];
				if (i == 0) i = 16;
				else i--;
				if (k < 0) k += M1;
				m[j] = k;
				if (j == 0) j = 16;
				else j--;
				x[count+1] = dM1 * (float) k;


				k = m[i] - m[j];
				if (i == 0) i = 16;
				else i--;
				if (k < 0) k += M1;
				m[j] = k;
				if (j == 0) j = 16;
				else j--;
				x[count+2] = dM1 * (float) k;


				k = m[i] - m[j];
				if (i == 0) i = 16;
				else i--;
				if (k < 0) k += M1;
				m[j] = k;
				if (j == 0) j = 16;
				else j--;
				x[count+3] = dM1 * (float) k;
			}
		}
	}

	int min(int n, int m) {
		if (n < m) {
			return n;
		}
		return m;
	}
	int abs(int n) {
		if (n > 0) {
			return n;
		} else {
			return -n;
		}
	}


	/*----------------------------------------------------------------------------
	  PRIVATE METHODS
	  ------------------------------------------------------------------------ */

	void initialize (int seed) {

		int jseed, k0, k1, j0, j1, iloop;

		this.seed = seed;

		m = new int[17];

		jseed = min(abs(seed),M1);
		if (jseed % 2 == 0) jseed -= 1;
		k0 = 9069 % M2;
		k1 = 9069 / M2;
		j0 = jseed % M2;
		j1 = jseed / M2;
		iloop = 0;
		while (iloop < 17) {
			jseed = j0 * k0;
			j1 = (jseed / M2 + j0 * k1 + j1 * k0) % (M2 / 2);
			j0 = jseed % M2;
			m[iloop] = j0 + M2 * j1;
			iloop += 1;
		}
		i = 4;
		j = 16;

	}
}

