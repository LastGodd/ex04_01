<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
<div class="bigPictureWrapper">
	<div class="bigPicture">
	
	</div>
</div>

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
	<!-- 첨부파일 -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			
				<div class="panel-heading">Files</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple="multiple">
					</div>
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		(function() {
			var bno = '<c:out value="${board.bno}"/>'
			$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {
				console.log(arr);
				var str = "";
				$(arr).each(function(i, attach) {
					// image type
					if(attach.fileType) {
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						str += "<li data-path='"+attach.uploadPath+"' data-uidd='"+attach.uuid+"'";
						str += " data-fileName='"+attach.fileName+"' data-type='"+attach.fileType+"'></div>";
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' ";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					} else {
						str += "<li data-path='"+attach.uploadPath+"' data-uidd='"+attach.uuid+"'";
						str += " data-fileName='"+attach.fileName+"' data-type='"+attach.fileType+"'></div>";
						str += "<span> " + attach.fileName + "</span><br>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' ";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'>";
						str += "</div>";
						str += "</li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})();
		
		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file");
			if(confirm("Remove this file? ")) {
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		
		function checkExtension(fileName, fileSize) {
			
			if(fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$("input[type='file']").change(function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++) {
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json'
			}).done(function(result){
				console.log(result);
				showUploadResult(result);
			});
		});
		
		function showUploadResult(uploadResultArr) {
			if(!uploadResultArr || uploadResultArr.lenght == 0) {
				return;
			}
			var uploadUL = $(".uploadResult ul");
			var str = "";
			
			$(uploadResultArr).each(function(i, obj) {
				if(obj.image) {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					str += "<li data-path='"+obj.uploadPath+"'";
					str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"'";
					str += "><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\'";
					str += " data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str + "</li>";
				} else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					str += "<li data-path='"+obj.uploadPath+"'";
					str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"'"
					str += "><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\'";
					str += " data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str + "</li>";
				}
			});
			uploadUL.append(str);
		}
	});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");
		
		$('button').on("click", function(e) {
			e.preventDefault();
			var oper = $(this).data("oper");
			console.log(oper);
			
			if(oper === 'remove') {
				formObj.attr("action", "/board/remove");
			} else if(oper === 'list') {
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
			} else if(oper === 'modify') {
				// p590 추가
			}
			formObj.submit();
		});
	});
</script>