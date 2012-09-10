/*
 * scimark2 MonteCarlo bench
 */
K.import("konoha.class");
K.import("konoha.assign");
K.import("konoha.float");
K.import("konoha.while");
K.import("konoha.math")
K.import("konoha.const")
K.load("../scimark/scimarkutil/Constants.k");
K.load("../scimark/scimarkutil/Random.k");
/**
 * Estimate Pi by approximating the area of a circle.
 * 
 * How: generate N random numbers in the unit square, (0,0) to (1,1)
 * and see how are within a radius of 1 or less, i.e.
 * <pre>  
 * 
 * sqrt(x^2 + y^2) < r
 * 
 * </pre>
 * since the radius is 1.0, we can square both sides
 * and avoid a sqrt() computation:
 * <pre>
 * 
 * x^2 + y^2 <= 1.0
 * 
 * </pre>
 * this area under the curve is (Pi * r^2)/ 4.0,
 * and the area of the unit of square is 1.0,
 * so Pi can be approximated by 
 * <pre>
 * # points with x^2+y^2 < 1
 * Pi =~ 		--------------------------  * 4.0
 * total # points
 * 
 * </pre>
 * 
 */
const SEED = 113;
class MonteCarlo {

	float num_flops(int num_samples) {
		// 3 flops in x^2+y^2 and 1 flop in random routine
		return (num_samples).tofloat() * 4.0;

	}

	float integrate(int num_samples) {

		Random r = new Random(SEED);
		int under_curve = 0;

		int count = 0;
		while (count < num_samples) {
			float x= r.nextDouble();
			float y= r.nextDouble();
			if ( x*x + y*y <= 1.0) {
				under_curve += 1;
			}
			count += 1;
		}
		return (under_curve.tofloat() / num_samples) * 4.0;
	}
}

class Bench1 {
	void run() {
		Random r = new Random(RANDOM_SEED);
		System.p(MonteCarlo.integrate(15000000));
	}
}

new Bench1().run();
