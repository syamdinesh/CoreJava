package exception.handling;

public class ExceptionExample {

	private static final long serialVersionUID = 1L;

	public ExceptionExample() {
		System.out.println(getClass() + " constructor");
	}

	public static void main(String[] args) {
		new ExceptionExample().m1();
		System.out.println("This is end");
	}
	
	void m1() {
		try {
			System.out.println("This is try block");
			stop();
		}catch(NullPointerException ae){
			System.out.println("catch");
		}finally {
			System.out.println("finally block");
		}
		System.out.println("m1() method");
	}
	void stop() {
		Object x=null;
		x.toString();
		System.out.println("stop method");
	}
}