package org.zerock.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.AsyncContext;
import javax.servlet.DispatcherType;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpUpgradeHandler;
import javax.servlet.http.Part;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@Log4j
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
public class BoardControllerTests {

	@Autowired
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

//	@Test
//	public void testGetList() throws Exception {
//		log.info(
//				mockMvc.perform(MockMvcRequestBuilders.get("/board/list")).andReturn().getModelAndView().getModelMap());
//	}
	
	
	// 임시 비밀번호 난수 만드는 방법
	@Test
	public void testUUID() {
		
		// 32자리 생성
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		
		// 10자리로 자르기
		String tempPw = uuid.substring(0, 10);
		
		log.info("UUID: " + uuid);
		log.info("tempPw: " + tempPw);
		
		
	}

	@Test
	public void testGetList() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list").param("pageNum", "2").param("amount", "10"))
				.andReturn().getModelAndView().getModelMap());
		
	}

	@Test
	public void testGet() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get").param("bno", "1")).andReturn()
				.getModelAndView().getModelMap());
	}

	@Test
	public void testRegister() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register").param("title", "aaa")
				.param("content", "bbb").param("writer", "ccc")).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}

	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove").param("bno", "32")).andReturn()
				.getModelAndView().getViewName();
		log.info(resultPage);
	}

	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify").param("bno", "31")
				.param("title", "AAA").param("content", "BBB").param("writer", "CCC")).andReturn().getModelAndView()
				.getViewName();
		log.info(resultPage);
	}
}
