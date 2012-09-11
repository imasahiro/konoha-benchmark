/*
 * CreateTree
 * http://www.cs.cmu.edu/~spoons/gc/benchmarks.html
 */
K.import("konoha");
K.import("konoha.date")

class Node {
	Node left, right;
	int i = 0, j = 0;
	Node(Node l, Node r) {
		left = l;
		right = r;
	}
}


const PRINT = false;
const kStretchTreeDepth    = 18;  // about 16Mb
const kLongLivedTreeDepth  = 16;  // about 4Mb
const kArraySize  = 500000;  // about 4Mb
const kMinTreeDepth = 4;
const kMaxTreeDepth = 16;

class GCBench {

	GCBench() {
	}
	// Nodes used by a tree of a given size
	@static int treeSize(int i) {
		return ((1 << (i + 1)) - 1);
	}

	// Number of iterations to use for a given tree depth
	@static int numIters(int i) {
		return 2 * treeSize(kStretchTreeDepth) / treeSize(i);
	}

	// Build tree top down, assigning to older objects. 
	@static void populate(int iDepth, Node thisNode) {
		if (iDepth<=0) {
			return;
		} else {
			iDepth -= 1;
			thisNode.left  = new Node();
			thisNode.right = new Node();
			populate (iDepth, thisNode.left);
			populate (iDepth, thisNode.right);
		}
	}

	// Build tree bottom-up
	@static Node makeTree(int iDepth) {
		if (iDepth<=0) {
			return new Node();
		} else {
			return new Node(makeTree(iDepth-1), makeTree(iDepth-1));
		}
	}

	@static void printDiagnostics() {
		//if (PRINT) {
	//    int lTotalMemory = System.getTotalMemory();
  //    p(" Total memory available=" + lTotalMemory + " bytes");
  //}
	}

	@static void timeConstruction(int depth) {
		float tStart, tFinish;
		int    iNumIters = numIters(depth);
		Node   tempTree;

		if (PRINT) {
			p("Creating " + iNumIters + " trees of depth " + depth);
		}
		tStart = new Date().getTime();
		int i = 0;
		while (i < iNumIters) {
			tempTree = new Node();
			populate(depth, tempTree);
			tempTree = null;
			i += 1;
		}
		tFinish = new Date().getTime();
		if (PRINT) {
			p("\tTop down construction took " + (tFinish - tStart) + "secs");
		}
		tStart = new Date().getTime();
		int i = 0;
		while (i < iNumIters) {
			tempTree = makeTree(depth);
			tempTree = null;
			i += 1;
		}
		tFinish = new Date().getTime();
		if (PRINT) {
			p("\tBottom up construction took " + (tFinish - tStart) + "secs");
		}

	}

	@Override void run() {
		Node   longLivedTree;
		Node   tempTree;
		float tStart, tFinish;
		float tElapsed;

		if (PRINT) {
			p(
					" Stretching memory with a binary tree of depth "
					+ kStretchTreeDepth);
		}
		printDiagnostics();
		tStart = new Date().getTime();

		// Stretch the memory space quickly
		tempTree = makeTree(kStretchTreeDepth);
		tempTree = null;

		// Create a long lived objects
		if (PRINT) {
			p(
					" Creating a long-lived binary tree of depth " +
					kLongLivedTreeDepth);
		}
		longLivedTree = new Node();
		populate(kLongLivedTreeDepth, longLivedTree);

		// Create long-lived array, filling half of it
		if (PRINT) {
			p(
					" Creating a long-lived array of "
					+ kArraySize + " floats");
		}
		float[] array = new float[kArraySize];
		int i = 1;
		while (i < kArraySize/2) {
			array[i] = 1.0/i;
			i += 1;
		}
		printDiagnostics();

		int d = kMinTreeDepth;
		while (d <= kMaxTreeDepth) {
			timeConstruction(d);
			d += 2;
		}

		if (longLivedTree == null || array[1000] != 1.0/1000) {
			if (PRINT) {
				p("Failed");
				// fake reference to LongLivedTree
		// and array
	// to keep them from being optimized away
			}
		}

		tFinish = new Date().getTime();
		tElapsed = tFinish-tStart;
		printDiagnostics();
		if (PRINT) {
			p("Completed in " + tElapsed + "s.");
		}
	}
}

new GCBench().run();
