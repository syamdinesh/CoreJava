package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.bean.LimitsServiceBean;
import com.example.demo.configuration.LimitsConfiguration;

/**
 * @author syamd
 */
@RestController
public class LimitsServiceController {

	@Autowired
	private LimitsConfiguration limitsConfiguration;

	@GetMapping("/limits")
	public LimitsServiceBean limitConfiguration() {
		return new LimitsServiceBean(limitsConfiguration.getMaximum(), limitsConfiguration.getMinimum());
	}
}