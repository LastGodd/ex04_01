package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

// 로그를 기록해주는 AOP
// @Aspect : 해당 클래스의 객체가 Aspect를 구현한 것임을 나타내기 위해 사용
@Aspect
@Log4j
// AOP와 관련은 없지만 Spring에서 Bean으로 인식하기 위해 사용
@Component
public class LogAdvice {

	// @Before내부의 execution...문자열은 AspectJ의 표현식
	// execution의 경우 접근제한자와 특정 클래스의 메서드를 지정할 수 있음
	// 맨 앞의 *은 접근제한자를 의미, 맨 뒤의 *은 클래스의 이름과 메서드의 이름을 의미
	@Before( "execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("====================");
	}
	
	// execution으로 시작하는 Pointcut 설정에 doAdd() 메서드를 명시, 파라미터 타입을 지정, 뒤쪽 &&args(..)부분에 변수명을 지정
	@Before( "execution(* org.zerock.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	// pointcut과 throwing 속성을 지정하고 변수 이름을 exception으로 지정
	@AfterThrowing(pointcut = "execution(* org.zerock.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception.....!");
		log.info("exception: " + exception);
	}
	
	@Around("execution(* org.zerock.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis();
		
		log.info("Target: " + pjp.getTarget());
		log.info("param: " + Arrays.toString(pjp.getArgs()));
		
		// invoke method
		Object result = null;
		
		try {
			result = pjp.proceed();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis();
		
		log.info("TIME: " + (end - start));
		
		return result;
	}
}
