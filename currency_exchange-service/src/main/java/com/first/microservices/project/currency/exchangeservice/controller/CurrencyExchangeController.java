package com.first.microservices.project.currency.exchangeservice.controller;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.first.microservices.project.currency.exchangeservice.bean.ExchangeCurrency;

/**
 * @author syamd
 *
 */
@RestController
public class CurrencyExchangeController {

	@Autowired
	private Environment environment;

	@GetMapping("/currency-exchange/from/{from}/to/{to}")
	public ExchangeCurrency currencyExchangeMethod(@PathVariable String from, @PathVariable String to,
			@RequestParam String usd) {
		ExchangeCurrency exchangeCurrency = new ExchangeCurrency(1000L, from, to, BigDecimal.valueOf(75), usd);
		exchangeCurrency.setPort(Integer.parseInt(environment.getProperty("local.server.port")));
		return exchangeCurrency;
	}
}
