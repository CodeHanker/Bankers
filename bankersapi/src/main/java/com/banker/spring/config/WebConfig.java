package com.banker.spring.config;


import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration				//need to tell spring container, that this is a configFile
@EnableWebMvc				//need to tell spring container, that we are gonna use - webMvcs
@ComponentScan(basePackages = {"com.banker.spring.controller"})		//need to tell spring container, that where are the controller classes
public class WebConfig implements WebMvcConfigurer{
	//class: WebMvcConfigurerAdapter to achieve webMVC functionality
}