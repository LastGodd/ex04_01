package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO vo) {
		log.info("register....." + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long bno) {
		log.info("get....." + bno);
		return mapper.read(bno);
	}

	@Override
	public int remove(Long bno) {
		log.info("remove....." + bno);
		return mapper.delete(bno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("register....." + vo);
		return mapper.update(vo);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Board " + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
