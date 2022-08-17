package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class PageDTO {
	// 화면에서 보여지는 시작번호
	private int startPage;
	// 화면에서 보여지는 끝번호
	private int endPage;
	// 이전과 다음으로 이동 가능한 링크의 표시 여부
	private boolean prev;
	private boolean next;

	// 전체 데이터 수
	private int total;
	private Criteria cri;

	// 생성자를 통해서 값 대입
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;

		// 페이지 버튼이 37까지 (1페이지당 10개씩이니까 데이터는 약 370개이다)있다고 가정하면 마지막 페이지의 넘버는 40으로 계산됨
		// 2 / 10.0 = 0.2 => 1 * 10 = 10
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		// 눈에 보이는 버튼은 31이 된다.
		this.startPage = this.endPage - 9;

		// 진짜 마지막 버튼을 구하고 endPage 보다 적으면 해당 값을 대입
		// 69 * 1.0 =
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		this.endPage = realEnd <= endPage ? realEnd : endPage;

		// 시작 페이지가 1보다 크면 이전 버튼이 true가 된다.
		this.prev = this.startPage > 1;
		// 계산한 마지막 페이지보다 진짜 페이지가 크면 다음 버튼이 true가 된다.
		this.next = this.endPage < realEnd;
	}

}
