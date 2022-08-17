package org.zerock.mapper;

import java.util.List;

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
public class BoardMapperTests {

	@Autowired
	private BoardMapper mapper;

	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVO>list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}

	@Test
	public void testGet() {
		log.info(mapper.get(1L));
	}

	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("메퍼테스트제목");
		board.setContent("메퍼테스트내용");
		board.setWriter("메퍼테스트작성자");
		mapper.insert(board);
		log.info(board);
	}

	@Test
	public void testDelete() {
		BoardVO board = mapper.get(7L);
		if (board == null) {
			return;
		}
		mapper.delete(7L);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = mapper.get(1L);
		if (board == null) {
			return;
		}
		board.setTitle("이트제목");
		mapper.update(board);
		log.info(board);
	}

	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("한글");
		cri.setType("W");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
}
