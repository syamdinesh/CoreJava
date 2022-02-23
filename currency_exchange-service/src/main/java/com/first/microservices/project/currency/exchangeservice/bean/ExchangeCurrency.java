/**
 * 
 */
package com.first.microservices.project.currency.exchangeservice.bean;

import java.math.BigDecimal;

/**
 * @author syamd
 *
 */
public class ExchangeCurrency {

	private Long id;
	private String from;
	private String to;
	private BigDecimal conversionMultiple;
	private int port;
	private Long exchangedValue;

	/**
	 * 
	 */
	public ExchangeCurrency() {

	}

	public ExchangeCurrency(Long id, String from, String to, BigDecimal conversionMultiple, String usdValue) {
		super();
		this.id = id;
		this.from = from;
		this.to = to;
		this.conversionMultiple = conversionMultiple;
		this.exchangedValue = Long.parseLong(usdValue) * conversionMultiple.intValue();
	}

	public Long getId() {
		return id;
	}

	public String getFrom() {
		return from;
	}

	public String getTo() {
		return to;
	}

	public BigDecimal getConversionMultiple() {
		return conversionMultiple;
	}

	public void setConversionMultiple(BigDecimal conversionMultiple) {
		this.conversionMultiple = conversionMultiple;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public Long getExchangedValue() {
		return exchangedValue;
	}
}
