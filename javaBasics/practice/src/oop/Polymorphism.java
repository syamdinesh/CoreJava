/**
 * 
 */
package oop;

/**
 * @author syamd
 */
public class Polymorphism {

	/**
	 * 
	 */
	public Polymorphism() {
		
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		A.men(1, 5);
	}

	
}

class A{
	public static final void men(int i, int j) {
		System.out.println(i+j);
	}
}
