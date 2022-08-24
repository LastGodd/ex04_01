package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;

// Rest 하나의 고유한 리소스를 대표하도록 설계된다는 개념
// @RestController 대신 @Controller + 메서드 선언부 @ResponseBody를 사용해도 동일한 효과가 있다.
// @RestController
@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
	// Security 실습
	@GetMapping("/all")
	public void doAll() {
		log.info("do all can access everybody");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("logined member");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("admin only");
	}

	// RestController 실습
	// produces 속성은 메서드가 생산하는 MIME 타입을 의미
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}

	// MediaType.APPLICATION_JSON_UTF8_VALUE >> 스프링 5.2버전부터 없어짐
	// produces 속성은 필수값이 아니므로 생략해도 된다.
	@GetMapping(value = "/getSample", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public SampleVO getSamle() {
		return new SampleVO(112, "스타", "로드");
	}

	@GetMapping("/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113, "로켓", "라쿤");
	}

	@GetMapping("/getList")
	public List<SampleVO> getList() {
		return IntStream.range(1, 10).mapToObj(i -> new SampleVO(i, i + "First", " Last")).collect(Collectors.toList());
	}

	// 맵의 경우 키와 값을 가지는 하나의 객체로 간주 됨
	@GetMapping("/getMap")
	public Map<String, SampleVO> getMap() {
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트", "주니어"));
		return map;
	}

	// ResponseEntity는 데이터와 함께 HTTP 헤더의 상태 메시지 등을 같이 전달하는 용도로 사용
	// HTTP의 상태 코드와 에러 메시지 등을 함께 데이터로 전달할 수 있기 때문에 받는 입장에서는 확실하게 결과를 알 수 있다.
	// http://localhost:8080/sample/check.json?height=140&weight=60 >> height 값이 150보다 작으면 502(bad gateway) 그렇지 않으면 200(ok) 코드와 데이터를 전송 
	@GetMapping(value = "/check", params = { "height", "weight" })
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		SampleVO vo = new SampleVO(0, "" + height, "" + weight);
		ResponseEntity<SampleVO> result = null;

		if (height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}

		return result;
	}
	
	// @PathVariable URL에서 {}로 처리된 부분을 사용할 때
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") String pid) {
		return new String[] {"category: " + cat, "productid: " + pid};
	}
	
	// @RequestBody
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert.....ticket" + ticket);
		return ticket;
	}
}
