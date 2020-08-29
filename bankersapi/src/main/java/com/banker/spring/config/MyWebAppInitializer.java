package com.banker.spring.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class MyWebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	//class: AbstractAnnotationConfigDispatcherServletInitializer - to configure spring & hibernate

	@Override
	protected Class<?>[] getRootConfigClasses() {
		//to tell which is rootConfigClass
		return new Class[] { AppConfig.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		//to tell which is servletConfigClasses
		return new Class[] { WebConfig.class };
	}

	@Override
	protected String[] getServletMappings() {
		//ServletMapprings - which is "/" Slash
		return new String[] { "/" };
	}

}
