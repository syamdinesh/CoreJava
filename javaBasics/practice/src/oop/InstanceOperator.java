package oop;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Period;

public class InstanceOperator extends So {
	int i;
	static int j = 100;

	public InstanceOperator() {
		super(5);
		System.out.println("InstanceOperator class constructor");
	}
	
	public static void main(String[] args) {
		LocalDate localDate = LocalDate.of(2015, 3, 26);
		Period ofDays = Period.ofDays(1);
		System.out.println(localDate.plus(ofDays));
	}

	@Override
	void men() {
		System.out.println("implementaion for InstanceOperator class men method");
	}

	@Override
	void mens() {
		System.out.println("This is overridden mens() method");
	}
	
	public char maxOccurCharacter(String s){
		char[] charArray = s.toCharArray();
		int charArrayLength=charArray.length;
		for(char c :charArray) {
			int count=1;
			if(c==charArray[charArrayLength]) {
				count++;
				charArrayLength--;
			}
		}
		return 'c'; 
	}
}

abstract class So {
	final int i = 10;

	So() {
		System.out.println("This is from So class default constructor" + i);
	}

	So(int i) {
		super();
		System.out.println("This is from So class constructor");
	}

	abstract void men();

	void mens() {
		System.out.println("This is mens method");
	}
}

interface B {
}