package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);

	public BoardVO get(Long bno);

	public int insert(BoardVO board);

	public int delete(Long bno);

	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	// MyBatis의 SQL을 처리학 위해서는 기본적으로 하나의 파라미터 타입을 사용, 2개 이상의 데이터를 전달하려면 @Param 어노테이션 이용
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

}
