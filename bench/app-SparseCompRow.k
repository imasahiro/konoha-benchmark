/*
 * scimark2 SparseCompRow bench
 */
K.import("konoha");
K.import("konoha.math");

SPARSE_SIZE_M = 1000;
SPARSE_SIZE_NZ = 5000;

class SparseCompRow {
	/* multiple iterations used to make kernel have roughly
	   same granulairty as other Scimark kernels. */

	float num_flops(int n, int nz, int num_iterations) {
		/* Note that if nz does not divide N evenly, then the
		   actual number of nonzeros used is adjusted slightly.
		 */
		int actual_nz = (nz/n) * n;
		return (actual_nz.tofloat()) * 2.0 * (num_iterations.tofloat());
	}


	/* computes  a matrix-vector multiply with a sparse matrix
	   held in compress-row format.  If the size of the matrix
	   in MxN with nz nonzeros, then the val[] is the nz nonzeros,
	   with its ith entry in column col[i].  The integer vector row[]
	   is of size M+1 and row[i] points to the begining of the
	   ith row in col[].  
	 */

	void matmult( float[] y, float[] val, int[] row,
			int[] col, float[] x, int num_iterations) {
		int m = row.size - 1;

		int reps = 0;
		while (reps < num_iterations) {

			int r = 0;
			while (r < m) {
				float sum = 0.0; 
				int rowR = row[r];
				int rowRp1 = row[r+1];
				int i = rowR;
				while (i < rowRp1) {
					sum += x[ col[i] ] * val[i];
					i += 1;
				}
				y[r] = sum;
				r += 1;
			}
			reps += 1;
		}
	}

}

Array[float] randomVector(int n) {
	Array[float] a = new float[n];
	int i = 0;
	while (i < n) {
		a[i] = Math.random();
		i += 1;
	}
	return a;
}

class Bench1 {
	void run() {
		int n = SPARSE_SIZE_M;
		int nz = SPARSE_SIZE_NZ;
		// initialize vector multipliers and storage for result
		// y = A*y;

		Array[float] x = randomVector(n);
		Array[float] y = new float[n];

		// initialize square sparse matrix
		//
		// for this test, we create a sparse matrix wit M/nz nonzeros
		// per row, with spaced-out evenly between the begining of the
		// row to the main diagonal.  Thus, the resulting pattern looks
		// like
		//             +-----------------+
		//             +*                +
		//             +***              +
		//             +* * *            +
		//             +** *  *          +
		//             +**  *   *        +
		//             +* *   *   *      +
		//             +*  *   *    *    +
		//             +*   *    *    *  + 
		//             +-----------------+
		//
		// (as best reproducible with integer artihmetic)
		// note that the first nr rows will have elements past
		// the diagonal.

		int nr = nz/n; 		// average number of nonzeros per row
		int anz = nr *n;   // _actual_ number of nonzeros

		Array[float] val = randomVector(anz);
		Array[int] col = new int[anz];
		Array[int] row = new int[n+1];

		row[0] = 0;
		int r = 0;
		while (r < n) {
			// initialize elements for row r

			int rowr = row[r];
			row[r+1] = rowr + nr;
			int step = r/ nr;
			if (step < 1) {
				step = 1;   // take at least unit steps
			}
			int i = 0;
			while (i < nr) {
				col[rowr+i] = i*step;
				i += 1;
			}
			r += 1;
		}
		SparseCompRow.matmult(y, val, row, col, x, 400);
	}
}

new Bench1().run();
