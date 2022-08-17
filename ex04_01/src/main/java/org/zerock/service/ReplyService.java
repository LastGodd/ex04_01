package org.zerock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);

	public ReplyVO get(Long bno);

	public int remove(Long bno);

	public int modify(ReplyVO vo);

	public List<ReplyVO> getList(@Param("cri") Criteria cri, @Param("bno") Long bno);
}
