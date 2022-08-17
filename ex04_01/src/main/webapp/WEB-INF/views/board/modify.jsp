<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Modify Page</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Modify Page</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form role="form" action="/board/modify" method="post">
								<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>">
								<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
								<input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
								<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
								<div class="form-group">
									<label>Bno</label> <input type="text" class="form-control"
										name="bno" value="<c:out value='${board.bno }'/>"
										readonly="readonly">
								</div>
								<div class="form-group">
									<label>Title</label> <input type="text" class="form-control"
										name="title" value="<c:out value='${board.title }'/>">
								</div>
								<div class="form-group">
									<label>Text area</label>
									<textarea class="form-control" rows="3" name="content"><c:out
											value="${board.content }" /></textarea>
								</div>
								<div class="form-group">
									<label>Writer</label> <input type="text" class="form-control"
										name="writer" value="<c:out value='${board.writer }'/>"
										readonly="readonly">
								</div>
								<button data-oper="modify" class="btn btn-default">Modify</button>
								<button data-oper="remove" class="btn btn-danger">Remove</button>
								<button data-oper="list" class="btn btn-info">List</button>
							</form>
						</div>
					</div>
					<!-- /.row (nested) -->
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
</div>
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");
		
		$('button').on("click", function(e) {
			e.preventDefault();
			var oper = $(this).data("oper");
			console.log(oper);
			
			if(oper === 'remove') {
				formObj.attr("action", "/board/remove");
			} else if(oper ==='list') {
				formObj.attr("action", "/board/list").attr("method", "get");
				// form 테그에서 필요한 부분만 잠시 복사(clone)해서 보관해 두고 form태그 내의 모든 내용은 지워버림.
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
			}
			formObj.submit();
		});
	});
</script>