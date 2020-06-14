package com.soap;

public class Name {

	public Name() {
		
	}
	
	public String getNames(String name)
	{
		String name1 = "";
		if("syam".equals(name))
		{
			name1 = "syam";
		}
		else if("vamsi".equals(name1)) {
			name1 = "vamsi";
		}
		else
		{
			String name2 = "anything";
			return name2;
		}
		return name1;
	}

}
