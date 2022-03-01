package com.example.demo.bean;

/**
 * @author syamd
 *
 */
public class LimitsServiceBean {

	private int maximum;
	private int minimum;

	public LimitsServiceBean(int maximum, int minimum) {
		super();
		this.maximum = maximum;
		this.minimum = minimum;
	}

	public int getMaximum() {
		return maximum;
	}

	public int getMinimum() {
		return minimum;
	}
}
