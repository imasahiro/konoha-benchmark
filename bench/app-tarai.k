/*
 * tarai 12 6 0
 */
K.import("konoha.class");

int tarai(int x, int y, int z) {
	if (y >= x) {
		return y;
	} else {
		return tarai(
				tarai(x - 1, y, z),
				tarai(y - 1, z, x),
				tarai(z - 1, x, y));
	}
}

class BenchTarai {
	void run() {
		System.p(tarai(12, 6, 0));
	}
}

new BenchTarai().run();
