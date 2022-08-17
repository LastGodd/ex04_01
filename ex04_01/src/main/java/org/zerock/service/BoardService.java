package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {

	// public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);

	public BoardVO get(Long bno);

	public boolean register(BoardVO vo);

	public boolean remove(Long bno);

	public boolean modify(BoardVO vo);

	public int getTotal(Criteria cri);
}
