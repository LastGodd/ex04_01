package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// @Getter, @Setter, @RequiredArgsConstructor, @ToString, @EqualsAndHashCode
// @RequiredArgsConstructor - final 이나 @NonNull 필드 값만 파라미터로 받는 생성자를 만들어줌
@Data
// 모든 속성을 사용하는 생성자
@AllArgsConstructor
// 비어있는 생성자
@NoArgsConstructor
public class SampleVO {
	private Integer mno;
	private String firstName;
	private String lastName;
}
