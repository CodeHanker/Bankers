package com.banker.spring.model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor		//Now @Data will not generate @RequiredArgsConstructor
@Data					//@Getter, @Setter, @ToString, @EqualsAndHashCode and @RequiredArgsConstructor
@Entity
@Table(name="ACCOUNTS")
public class Accounts implements Serializable {

	private static final long serialVersionUID = 1L;







}
