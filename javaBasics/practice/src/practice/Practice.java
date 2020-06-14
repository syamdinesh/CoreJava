package practice;

public class Practice {
	public static void main(String[] args) {
		int i=10;
		String s="Syam";
		String s1=new String("Syam");
		System.out.println(s1.hashCode()+" "+s.hashCode()+" "+args.hashCode());
		s1=s+s1;
		System.out.println(s1.hashCode()+" "+s1);
		
		try {
			i=i/0;
		}
		catch(ArithmeticException e) {
			System.out.println("Catch block");
		}catch (Exception e) {
			System.out.println("Catch block");
		}
//		AB practice = new AB(5,2);
//		System.out.println(practice+" "+practice.getI());
	}
	
	protected void men() {
		System.out.println("This is protected men() method from Practice class");
	}
}	
class AB{
	private final int i;
	
	private final float f;
	
	public AB(int i, int f){
		this.i=i;
		this.f=f;
	}
	
	public int getI() {
		return i;
	}
	
	public float getF() {
		return f;
	}
	
	@Override
	public String toString() {
		return i+" "+f;
	}
}