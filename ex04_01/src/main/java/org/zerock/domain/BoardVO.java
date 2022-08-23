package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;
	
	// 등록 시 한 번에 BoardAttachVO를 처리할 수 있도록 작성
	private List<BoardAttachVO> attachList;
}
