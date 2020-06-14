package string.practice;

import java.util.logging.Logger;

import practice.Practice;

public class StringPractice extends Practice{
	
	private static final Logger LOG = Logger.getLogger(StringPractice.class.getName());

	public StringPractice() {
		LOG.warning("This is " + getClass() + " constructor");
	}

	public static void main(String[] args) {
		new StringPractice();

		String s = "10";
		LOG.warning(s + "'s hashcode is:- " + s.hashCode());

		String s1 = new String("10");
		LOG.warning(s1 + "'s hashcode is:- " + s1.hashCode());
		if (s == s1)
			LOG.warning("True");
		else
			LOG.warning("False");
		new StringPractice().men();
	}
	
	public void men() {
		LOG.warning("this is no argumnet men()");
	}
	
	public void men(int i, float j) {
		LOG.warning("this is two argumnet men()");
	}
	
	public void men(float f, float j) {
		LOG.warning("this is two argumnet men()");
	}
}
