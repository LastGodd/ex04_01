<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Read Page</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Read Page</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<div class="form-group">
								<label>Bno</label> <input type="text" class="form-control"
									name="bno" value="<c:out value='${board.bno }'/>"
									readonly="readonly">
							</div>
							<div class="form-group">
								<label>Title</label> <input type="text" class="form-control"
									name="title" value="<c:out value='${board.title }'/>"
									readonly="readonly">
							</div>
							<div class="form-group">
								<label>Text area</label>
								<textarea class="form-control" rows="3" name="content"
									readonly="readonly"><c:out value="${board.content }" /></textarea>
							</div>
							<div class="form-group">
								<label>Writer</label> <input type="text" class="form-control"
									name="writer" value="<c:out value='${board.writer }'/>"
									readonly="readonly">
							</div>
							<button data-oper="modify" class="btn btn-default">Modify</button>
							<button data-oper="list" class="btn btn-info">List</button>
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
	
	<!-- 댓글 시작 -->
	<div class="row">
		<!-- /.panel -->
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> Reply <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
				</div>

				<!-- /.panel-heading -->
				<div class="panel-body">
					<ul class="chat">
						<!-- start reply -->
						<li class="left clearfix" data-rno='12'>
							<div>
								<div class="header">
									<strong class="primary-font">user00</strong> 
									<small class="pull-right text-muted">2018-01-01 13:13</small>
								</div>
								<p>Good Job!</p>
							</div>
						</li>
						<!-- end reply -->
					</ul>
					<!-- ./end ul -->
				</div>
				<!-- /.panel .chat-panel -->
			</div>
		</div>
		<!-- ./end row -->
	</div>
	<!-- 댓글 끝 -->

</div>

<!-- 댓글 모달 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Reply Modal</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- 댓글 -->
				<div class="modal-group">
					<label>Reply</label>
					<input class="form-control" name='reply' value='New Replay!!!!'>
				</div>
				<!-- 댓글작성자 -->
				<div class="modal-group">
					<label>Replyer</label>
					<input class="form-control" name='replyer' value='replayer'>
				</div>
				<!-- 댓글등록일 -->
				<div class="modal-group">
					<label>Reply Date</label>
					<input class="form-control" name='replyDate' value=''>
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalClassBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 댓글 모달 끝 -->

<form id="operForm" action="/board/modify" method="get">
	<input type="hidden" id="bno" name="bno"
		value="<c:out value='${board.bno }'/>"> <input type="hidden"
		name="pageNum" value="<c:out value='${cri.pageNum }'/>"> <input
		type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
	<input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
	<input type="hidden" name="keyword"
		value="<c:out value='${cri.keyword }'/>">
</form>

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page) {
			console.log("show list " + page);
			replyService.getList({bno:bnoValue, page:page || 1}, function(replyCnt, list) {
				console.log("replyCnt: " + replyCnt);
				console.log("list: " + list);
				
				if(page == -1) {
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				
				var str="";
				if(list == null || list.lenght == 0) {
					return;
				}
				
				for(var i = 0; i < list.length ; i++) {
					str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str +="<small class='pull-right text-muted'>" +replyService.displayTime(list[i].replyDate)+ "</small></div>";
					str +="<p>" +list[i].reply+ "</p></div></li>";
				}
				replyUL.html(str);
			});
		} //end showList
		
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		// 입력에 필요없는 항목 안보이게 처리
		$("#addReplyBtn").on("click", function(e) {
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		// 새로운 댓글 추가처리
		modalRegisterBtn.on("click", function(e){
			var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno:bnoValue
			};
			replyService.add(reply, function(result){
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(1);
			});
		});
		
		// 댓글 클릭 이벤트처리(이벤트위임)
		// chat < li
		$(".chat").on("click", "li", function(e){
			var rno = $(this).data("rno");
			replyService.get(rno, function(reply) {
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		// 댓글 수정
		modalModBtn.on("click", function(e){
			var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
			replyService.update(reply, function(result) {
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		// 댓글 삭제
		modalRemoveBtn.on("click", function(e){
			var rno = modal.data("rno");
			replyService.remove(rno, function(result){
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
	});
</script>












<script type="text/javascript">
	/* console.log("=======");
	console.log("JS TEST");

	var bnoValue = '<c:out value="${board.bno}"/>'; */

	// 해당 글 번호에 있는 댓글목록 전체를 가져오는 모듈
	/* replyService.getList({bno:bnoValue, page:1}, function(list){
		for(var i = 0, len = list.length || 0; i < len; i++) {
			console.log(list[i]);
		}
	}); */

	// 댓글 등록하는 모듈
	/* replyService.add({reply:"JS Test", replyer:"tester", bno:bnoValue}, function(result) {
			alert("RESULT: " + result);
	}); */
	

	// 댓글 삭제
	/* replyService.remove(24, function(count) {
		console.log(count);
		if(count === 'success') {
			alert('REMOVED');
		}
	}, function(err) {
		alert('ERROR...');
	}); */

	// 22번 댓글 수정
	/* replyService.update({
		rno : 10,
		bno : bnoValue,
		reply : "Modified Reply..."
	}, function(result) {
		alert("수정 완료...");
	}); */

	/* replyService.get(10, function(data) {
		console.log(data);
	}); */

	/* $(document).ready(function() {
		// 어떤 모듈이 있는지 확인하기
		console.log(replyService);
	}); */
</script>

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list").submit();
		});

	});
</script>