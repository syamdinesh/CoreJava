/**
 * 
 */
package oop;

/**
 * @author syamd
 *
 */
public class OppsPractice {
	static int i;
	int j;

	OppsPractice(int i, int j) {
		this.i = i;
		this.j = j;
		System.out.println("construcor");
	}

	public static void main(String[] args) {
		System.out.println("main method");
		OppsPractice oppsPractice = new OppsPractice(5, 10);
		System.out.println(+i + " " + oppsPractice.j + " ");
		oppsPractice.men();
	}

	static {
		System.out.println("static block: " + i);
	}

	{
		System.out.println("instance block: " + j);
	}

	private void men() {
		i = 9;
		System.out.println(i);
	}
}
