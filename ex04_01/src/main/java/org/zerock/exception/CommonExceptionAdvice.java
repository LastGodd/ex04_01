package org.zerock.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	// 전체 예외를 잡아뒀기 떄문에 나중에 세분화 시키는 작업이 필요함
	@ExceptionHandler(Exception.class)
	public String excep(Exception ex, Model model) {
		log.error("Excepton....." + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(model);
		return "/exception/error_page";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		return "/exception/custom404";
	}
}
