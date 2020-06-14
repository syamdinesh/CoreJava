package latest;

import java.io.FileInputStream;
import java.io.IOException;

public class InterfaceExample extends Exception implements B, A {

	public InterfaceExample() {
		System.out.println("This is constructor from Implementation class");
	}

	public static void main(String[] args){
		A interfaceExample = new InterfaceExample();
		try{
			interfaceExample.men();
		}catch (IOException e) {
			e.printStackTrace();
		}finally {
			System.out.println("finally block");
		}
	}

	@Override
	public void men() {
		// B.super.men();
		System.out.println("This is overridden method from implementation class");
	}
}

interface A {
	default void men() throws IOException {
		System.out.println("This is men() A");
	}
}

interface B {
	@SuppressWarnings("resource")
	default void men() throws IOException{
		FileInputStream fileInputStream;
			fileInputStream = new FileInputStream("C:\\SyamDi");

			FileInputStream fileInputStream1 = new FileInputStream("C:\\Syam");
			fileInputStream1.equals(fileInputStream);

		System.out.println("This is men() B");
	}
}
