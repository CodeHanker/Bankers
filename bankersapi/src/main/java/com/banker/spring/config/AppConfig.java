package com.banker.spring.config;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import static org.hibernate.cfg.Environment.*;   //for static properties key strings (DRIVER, URL, USER, PASS)

@Configuration									//to Tell spring container that, this is a configuration file
@PropertySource("classpath:db.properties")		//to Tell spring container that where to locate property file, which is our class-path
@EnableTransactionManagement					//to enable transaction management

//to scan more than one package
@ComponentScans(value = {
		@ComponentScan("com.banker.spring.dao"),
		@ComponentScan("com.banker.spring.service")
})

public class AppConfig {

	@Autowired
	private Environment env;					//to read property file (db.property) we need Environment Variable
												//with Autowired, spring container will create it's (Environment) object for us

	@Bean
	public LocalSessionFactoryBean getSessionFactory() {

		LocalSessionFactoryBean factoryBean = new LocalSessionFactoryBean();
		Properties props = new Properties();

		//Setting JDBC Properties
		props.put(DRIVER, env.getProperty("mysql.driver"));
		props.put(URL, env.getProperty("mysql.url"));
		props.put(USER, env.getProperty("mysql.user"));
		props.put(PASS, env.getProperty("mysql.password"));


		//Setting Hibernate PropeRties
		props.put(SHOW_SQL, env.getProperty("hibernate.show_sql"));
		props.put(HBM2DDL_AUTO, env.getProperty("hibernate.hbm2ddl.auto"));

		//Setting C3P0 PropeRties
		props.put(C3P0_MIN_SIZE, env.getProperty("hibernate.c3p0.min_size"));
		props.put(C3P0_MAX_SIZE, env.getProperty("hibernate.c3p0.max_size"));
		props.put(C3P0_ACQUIRE_INCREMENT, env.getProperty("hibernate.c3p0.acquire_increment"));
		props.put(C3P0_TIMEOUT, env.getProperty("hibernate.c3p0.timeout"));

		props.put(C3P0_MAX_SIZE, env.getProperty("hibernate.c3p0.max_size"));
		props.put(C3P0_MAX_STATEMENTS, env.getProperty("hibernate.c3p0.max_statements"));


		//setting these properties (props) to the factoryBean
		factoryBean.setHibernateProperties(props);

		//tables to be created by hibernate ===> to tell hibernate which is the package to be scanned to create table as per model classes
		factoryBean.setPackagesToScan("com.banker.spring.model");

		return factoryBean;
	}

	//One more Bean : hiberanateTransactionManager
	@Bean
	public HibernateTransactionManager getTransactionManager() {

		HibernateTransactionManager transactionManager = new HibernateTransactionManager();
		transactionManager.setSessionFactory(getSessionFactory().getObject());

		return transactionManager;
	}

}
