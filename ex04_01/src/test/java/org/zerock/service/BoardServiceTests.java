package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Autowired
	private BoardService service;

//	@Test
//	public void testGetList() {
//		service.getList().forEach(board -> log.info(board));
//	}
	
	@Test
	public void testGetList() {
		// service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(2, 10)).forEach(board -> log.info(board));
	}

	@Test
	public void testGet() {
		log.info(service.get(2L));
	}

	@Test
	public void testRegiter() {
		BoardVO vo = new BoardVO();
		vo.setTitle("aaaa");
		vo.setContent("bbbb");
		vo.setWriter("cccc");
		service.register(vo);
		log.info(vo);
	}

	@Test
	public void testRemove() {
		Long removeNo = 30L;
		BoardVO vo = service.get(removeNo);
		if (vo == null) {
			return;
		}
		log.info(service.remove(removeNo));
	}

	@Test
	public void testModify() {
		Long modifyNo = 31L;
		BoardVO vo = service.get(modifyNo);
		if (vo == null) {
			return;
		}
		vo.setTitle("제목수정합니다");
		log.info(service.modify(vo));
	}
}
