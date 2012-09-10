/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Kimio Kuramitsu, imasahiro, Wakamatsu
*/

K.import("konoha.null");
K.import("konoha.class");
K.import("konoha.while");
K.import("konoha.int");
K.import("konoha.assign");
K.import("konoha.io");

const MINDEPTH = 4;
const N=14;

class TreeNode {
	TreeNode left, right;
	int item;
	
	TreeNode(TreeNode left, TreeNode right, int item) {
		this.left = left;
		this.right = right;
		this.item = item;
	}
	
	int itemCheck(){
		// if necessary deallocate here
		if(this.left == null) return this.item;
		return this.item + this.left.itemCheck() - this.right.itemCheck();
	}
}

TreeNode bottomUpTree(int item, int depth){
	if (depth > 0){
		return new TreeNode(bottomUpTree(2*item-1, depth-1), bottomUpTree(2*item, depth-1), item);
	}
	else {
		return new TreeNode(null, null, item);
	}
}

void run() {
	int n = N;
	//int maxDepth = (MINDEPTH + 2 > n) ? MINDEPTH + 2 : n;
	int maxDepth = n;
	if(MINDEPTH+2 > n) {maxDepth = MINDEPTH + 2;}
	int stretchDepth = maxDepth + 1;
	//int check = bottomUpTree(0,stretchDepth).itemCheck();
	TreeNode b = bottomUpTree(0, stretchDepth);
	int check = b.itemCheck();
	System.out.println("stretch tree of depth " + stretchDepth + "\t check: " + check);
	TreeNode longLivedTree = bottomUpTree(0, maxDepth);
	int depth = MINDEPTH;
	while (depth <= maxDepth) {
		int iterations = 1 << (maxDepth - depth + MINDEPTH);
		check = 0;
		int i=1;
		while (i<= iterations){
			check += bottomUpTree(i, depth).itemCheck();
			check += bottomUpTree(-i, depth).itemCheck();
			i += 1;
		}
		System.out.println(""+(iterations*2) + "\t trees of depth " + depth + "\t check: " + check);
		depth += 2;
	}
	System.out.println("long lived tree of depth " + maxDepth + "\t check: "+ longLivedTree.itemCheck());
}

run();

