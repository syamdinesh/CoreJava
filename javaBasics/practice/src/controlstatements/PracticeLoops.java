package controlstatements;

public class PracticeLoops {
	static byte a=10;
	public static void main(String[] args) {
		double b=10.1;
		double c=10.0;
//		float d=10.0f;
		if (a==c) {
			System.out.println("both a & b are equal");
		}
		else if(b==c) {
			System.out.println("both b & c are equal");
		}
		else if(c==a) {
			System.out.println("both c & a are equal");
		}
		else {
			System.out.println("both int and byte are not equal");
		}
	}
}
