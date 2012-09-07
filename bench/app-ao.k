/*
 * AO Benchmark
 */
K.import("konoha.float");
K.import("konoha.math");
K.import("konoha.int");
K.import("konoha.while");
K.import("konoha.class");
K.import("konoha.array");
K.import("konoha.assign");
K.import("konoha.null");
K.import("konoha.string");
K.import("konoha.bytes");
K.import("posix.file");

WIDTH  = 64;
HEIGHT = 64;

NSUBSAMPLES = 2;
NAO_SAMPLES = 4;

class Vec {
	float x;
	float y;
	float z;
	Vec(float x, float y, float z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
	Vec add(Vec v1) {
		return new Vec(x + v1.x, y + v1.y, z + v1.z);
	}
	Vec sub(Vec v1) {
		return new Vec(x - v1.x, y - v1.y, z - v1.z);
	}
	float dot(Vec v1) {
		return x * v1.x + y * v1.y + z * v1.z;
	}
	Vec cross(Vec v1) {
		float u = y * v1.z - z * v1.y;
		float v = z * v1.x - x * v1.z;
		float w = x * v1.y - y * v1.x;
		return new Vec(u, v, w);
	}
	float length() {
		return Math.sqrt(dot(this));
	}
	void normalize() {
		float len = length();
		if (len > 1.0e-10) {
			x = x / len;
			y = y / len;
			z = z / len;
		}
	}
}

class Ray {
	Vec org;
	Vec dir;
	Ray(Vec org, Vec dir) {
		this.org = org;
		this.dir = dir;
	}
}
class Intersection {
	float t = 1.0e+17;
	Vec p;
	Vec n;
	boolean hit = false;
	Intersection() {
		//t = 1.0e+17;
		n = new Vec();
	}
}
class Sphere {
	Vec center;
	float radius;

	Sphere(Vec center, float radius) {
		this.center = center;
		this.radius = radius;
	}

	void intersect(Intersection isect, Ray ray) {
		// rs = ray.org - sphere.center
		Vec rs = ray.org.sub(center);
		float b = rs.dot(ray.dir);
		float c = rs.dot(rs) - (radius * radius);
		float d = b * b - c;
		if (d > 0.0) {
			float t = -b - Math.sqrt(d);
			if ((t > 0.0) && (t < isect.t)) {
				isect.t = t;
				isect.hit = true;
				Vec p = new Vec(ray.org.x + ray.dir.x * t, ray.org.y + ray.dir.y * t, ray.org.z + ray.dir.z * t);
				Vec n = p.sub(center);
				n.normalize();
				isect.n = n;
				isect.p = p;
			}
		}
	}
}
class Plane {
	Vec p;
	Vec n;
	Plane(Vec p, Vec n) {
		this.p = p;
		this.n = n;
	}

	void intersect(Intersection isect, Ray ray) {
		float d = -p.dot(n);
		float v = ray.dir.dot(n);
		if (Math.fabs(v) < 1.0e-17){
			return;
		}
		float t = -(ray.org.dot(n) + d) / v;
		if ((t > 0.0) && (t < isect.t)) {
			isect.hit = true;
			isect.t = t;
			isect.n = n;
			Vec ip = new Vec(ray.org.x + t * ray.dir.x, ray.org.y + t * ray.dir.y, ray.org.z + t * ray.dir.z);
			isect.p = ip;
		}
	}
}

void orthoBasis(Vec[] basis, Vec n) {
	basis[1] = new Vec(0.0, 0.0, 0.0);
	basis[2] = new Vec(n.x, n.y, n.z);

	if ((n.x < 0.6) && (n.x > -0.6)) {
		basis[1].x = 1.0;
	} else if ((n.y < 0.6) && (n.y > -0.6)) {
		basis[1].y = 1.0;
	} else if ((n.z < 0.6) && (n.z > -0.6)) {
		basis[1].z = 1.0;
	} else {
		basis[1].x = 1.0;
	}

	basis[0] = basis[1].cross(basis[2]);
	basis[0].normalize();

	basis[1] = basis[2].cross(basis[0]);
	basis[1].normalize();
}

int clamp(float f) {
	int i = (f * 255.5).toint();
	if (i < 0)        i = 0;
	else if (i > 255) i = 255;
	return i;
}

class AObench {
	Sphere[] spheres;
	Plane plane;
	AObench() {
		this.spheres = new Sphere[3];
		this.spheres[0] = new Sphere(new Vec(-2.0, 0.0, -3.5), 0.5);
		this.spheres[1] = new Sphere(new Vec(-0.5, 0.0, -3.0), 0.5);
		this.spheres[2] = new Sphere(new Vec(1.0, 0.0, -2.2), 0.5);
		this.plane = new Plane(new Vec(0.0, -0.5, 0.0), new Vec(0.0, 1.0, 0.0));
	}
	Vec ambientOcclusion(Intersection isect) {
		int ntheta = NAO_SAMPLES;
		int nphi   = NAO_SAMPLES;
		float eps = 0.0001;

		Vec p = new Vec(isect.p.x + eps * isect.n.x,
				isect.p.y + eps * isect.n.y,
				isect.p.z + eps * isect.n.z);

		Vec[] basis = new Vec[3];
		orthoBasis(basis, isect.n);
		float occlusion = 0.0;

		int j = 0;
		while (j < ntheta) {
			int i = 0;
			while (i < nphi) {
				float theta = Math.sqrt(Math.random());
				float phi = 2.0 * MATH_PI * Math.random();

				float x = Math.cos(phi) * theta;
				float y = Math.sin(phi) * theta;
				float z = Math.sqrt(1.0 - theta * theta);

				float rx = x * basis[0].x + y * basis[1].x + z * basis[2].x;
				float ry = x * basis[0].y + y * basis[1].y + z * basis[2].y;
				float rz = x * basis[0].z + y * basis[1].z + z * basis[2].z;

				Ray ray = new Ray(p, new Vec(rx, ry, rz));

				Intersection occIsect = new Intersection();
				spheres[0].intersect(occIsect, ray);
				spheres[1].intersect(occIsect, ray);
				spheres[2].intersect(occIsect, ray);
				plane.intersect(occIsect, ray);

				if (occIsect.hit) {
					occlusion += 1.0;
				}
				i += 1;
			}
			j += 1;
		}

		occlusion = (ntheta * nphi - occlusion) / (ntheta * nphi);
		return new Vec(occlusion, occlusion, occlusion);
	}
	void render(int[] byteImage, int w, int h, int subsamples) {
		Array[float] fimg = new float[w * h * 3];
		int y = 0;
		while (y < h) {
			int x = 0;
			while (x < w) {
				int v = 0;
				while (v < subsamples) {
					int u = 0;
					while (u < subsamples) {
						float px =   (x + u / subsamples.tofloat() - w / 2.0) / (w / 2.0);
						float py = -((y + v / subsamples.tofloat() - h / 2.0) / (h / 2.0));

						Vec eye = new Vec(px, py, -1.0);
						eye.normalize();
						Ray ray = new Ray(new Vec(), eye);

						Intersection isect = new Intersection();
						spheres[0].intersect(isect, ray);
						spheres[1].intersect(isect, ray);
						spheres[2].intersect(isect, ray);
						plane.intersect(isect, ray);

						if (isect.hit) {
							Vec c = ambientOcclusion(isect);
							int p0 = 3 * (y * w + x);
							fimg[p0 + 0] = fimg[p0 + 0] + c.x;
							fimg[p0 + 1] = fimg[p0 + 1] + c.y;
							fimg[p0 + 2] = fimg[p0 + 2] + c.z;

						}
						u += 1;
					}
					v += 1;
				}
				int p1 = 3 * (y * w + x);
				fimg[p1 + 0] = fimg[p1 + 0] / (subsamples * subsamples).tofloat();
				fimg[p1 + 1] = fimg[p1 + 1] / (subsamples * subsamples).tofloat();
				fimg[p1 + 2] = fimg[p1 + 2] / (subsamples * subsamples).tofloat();
				byteImage[p1 + 0] = clamp(fimg[p1 + 0]);
				byteImage[p1 + 1] = clamp(fimg[p1 + 1]);
				byteImage[p1 + 2] = clamp(fimg[p1 + 2]);

				x+= 1;
			}
			y += 1;
		}
	}
	void run() {
		int[] img = new int[WIDTH * HEIGHT * 3];
		render(img, WIDTH, HEIGHT, NSUBSAMPLES);

		FILE out = System.fopen("ao.ppm","w");
		String s = "P6\n"+WIDTH + " " + HEIGHT+"\n255 ";
		int len = s.getLength();
		out.write(s.asBytes(), 0, len);

		int i = 0;
		while (i < img.size) {
			out.putC(img[i]);
			i += 1;
		}
		out.close();
	}
}

new AObench().run();
