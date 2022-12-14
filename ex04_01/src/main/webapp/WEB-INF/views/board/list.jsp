<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board Tables</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">Board Tables
						<button id="regBtn" type="button" class="btn btn-xs btn-primary pull-right">Register
							New Board</button>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<table width="100%" class="table table-striped table-bordered table-hover">
							<thead>
								<colgroup>
									<col style="width:1%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
								</colgroup>
								<tr>
									<th>#</th>
									<th>Title</th>
									<th>Writer</th>
									<th>RegDate</th>
									<th>UpdateDate</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="board">
									<tr class="odd gradeX">
										<td>
											<c:out value="${board.bno }" />
										</td>
										<td><a class="move" href="<c:out value='${board.bno }' />">
												<c:out value="${board.title }" /><b>[
													<c:out value="${board.replyCnt }" />]
												</b>
											</a></td>
										<td>
											<c:out value="${board.writer }" />
										</td>
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd"
												value="${board.regdate }" />
										</td>
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd"
												value="${board.updateDate }" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<!-- ???????????? -->
						<div class="row">
							<div class="col-lg-12">
								<form id="searchForm" action="/board/list" method="get">
									<select name="type">
										<option value="" <c:out
											value="${pageMaker.cri.type == null ? 'selected' : '' }" />>--
										</option>
										<option value="T" <c:out
											value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }" />>??????
										</option>
										<option value="C" <c:out
											value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }" />>??????
										</option>
										<option value="W" <c:out
											value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }" />>?????????
										</option>
										<option value="TC" <c:out
											value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }" />>??????
										or ??????</option>
										<option value="TW" <c:out
											value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }" />>??????
										or ?????????</option>
										<option value="TWC" <c:out
											value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }" />>??????
										or ?????? or ?????????</option>
									</select>
									<input type="text" name="keyword"
										value="<c:out value='${pageMaker.cri.keyword }'/>">
									<input type="hidden" name="pageNum"
										value="<c:out value='${pageMaker.cri.pageNum }'/>">
									<input type="hidden" name="amount"
										value="<c:out value='${pageMaker.cri.amount }'/>">
									<button class="btn btn-default">Search</button>
								</form>
							</div>
						</div>
						<!-- /.table-responsive -->
					</div>
					<!-- /.panel-body -->

					<!-- ????????? -->
					<div class="pull-right">
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li class="page_item">
									<a class="page_link" href="${pageMaker.startPage - 1}">Prev</a>
								</li>
							</c:if>

							<c:forEach var="num" begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }">
								<li class="page_item ${pageMaker.cri.pageNum == num ? 'active' : '' }">
									<a class="page_link" href="<c:out value='${num }'/>">${num}</a>
								</li>
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<li class="page_item">
									<a class="page_link" href="${pageMaker.endPage + 1}">Next</a>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /#page-wrapper -->

	<!-- ?????? -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">????????? ?????????????????????.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ??????????????? ????????? ??????????????? ???????????? ?????? ?????? -->
	<form id="actionForm" action="/board/list" method="get">
		<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum }'/>">
		<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount }'/>">
		<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type }'/>">
		<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>">
	</form>

	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	<script>
		$(document).ready(function () {
			var result = '<c:out value="${result}"/>';

			checkModal(result);

			history.replaceState({}, null, null);

			function checkModal(result) {
				if (result === '' || history.state) {
					return;
				}
				if (parseInt(result) > 0) {
					$(".modal-body").html("????????? " + parseInt(result) + "?????? ?????????????????????.");
				}

				$("#myModal").modal("show");
			}

			$("#regBtn").on("click", function () {
				self.location = "/board/register";
			});

			var actionForm = $("#actionForm");

			$(".page_link").on("click", function (e) {
				e.preventDefault();
				console.log('click');
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});

			$(".move").on("click", function (e) {
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr('href') + "'>");
				actionForm.attr("action", "/board/get");
				actionForm.submit();
			});

			var searchForm = $("#searchForm");

			$("#searchForm button").on("click", function (e) {
				if (!searchForm.find("option:selected").val()) {
					alert("??????????????? ???????????????.");
					return false;
				}

				if (!searchForm.find("input[name='keyword']").val()) {
					alert("???????????? ???????????????.")
					return false;
				}

				searchForm.find("input[name='pageNum']").val(1);
				e.preventDafult();

				searchForm.submit();
			});

		});
	</script>

	<%@include file="../includes/footer.jsp" %>