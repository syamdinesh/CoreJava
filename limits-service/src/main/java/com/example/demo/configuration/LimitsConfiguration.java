/**
 * 
 */
package com.example.demo.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author syamd
 */
@Component
@ConfigurationProperties("limits-service")
public class LimitsConfiguration {

	private int maximum;
	private int minimum;

	protected LimitsConfiguration() {

	}

	public int getMaximum() {
		return maximum;
	}

	public void setMaximum(int maximum) {
		this.maximum = maximum;
	}

	public int getMinimum() {
		return minimum;
	}

	public void setMinimum(int minimum) {
		this.minimum = minimum;
	}
}