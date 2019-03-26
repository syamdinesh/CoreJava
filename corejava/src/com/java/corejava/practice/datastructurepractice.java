package com.java.corejava.practice;

import java.util.ArrayList;

public class datastructurepractice {

	public static void main(String[] args) {
		ArrayList<String> arrayList1 = new ArrayList<String>();
		arrayList1.add("String");
		arrayList1.add("Dinesh");
		arrayList1.add(2,"NannaGaru");
		arrayList1.add(1, "Syam");
		arrayList1.add(0, "Bayyana");
		arrayList1.add(0, "Z");
		System.out.println(arrayList1);
		
		arrayList1.remove(arrayList1.size()-1);
		
		System.out.println(arrayList1);
	}
}
