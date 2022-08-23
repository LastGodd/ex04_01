package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;

	@Autowired
	private BoardAttachMapper attachMapper;

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList....."+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get....." + bno);
		return mapper.get(bno);
	}

	@Transactional
	@Override
	public void register(BoardVO vo) {
		log.info("register....." + vo);
		mapper.insert(vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		vo.getAttachList().forEach(attach -> {
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		});
		
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove....." + bno);
		// Database 먼저 삭제해야 함
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public boolean modify(BoardVO vo) {
		log.info("modify: " + vo);
		return mapper.update(vo) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("getTotal: " + cri);
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno" + bno);
		return attachMapper.findByBno(bno);
	}

}
