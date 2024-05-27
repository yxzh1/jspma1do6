<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
	<%@ include file="../../static/head.jsp"%>
	<!-- font-awesome -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
</head>
<style>
	.d-flex {
		display: flex;
	}

	.flex-grow-1 {
		flex-grow: 1;
		margin-right: 10px; /* 添加间距 */
	}
</style>
<body>
	<div id="main-container">
		<!-- Top Navigation -->
		<%@ include file="../../static/topNav.jsp"%>
				
		<!-- Menu -->
		<div id="menu-container" class="navbar">
			<ul class="navbar-nav navbar-vertical" id="navUl">
				
			</ul>
		</div>
		<!-- /Menu -->

		<!-- Breadcrumb -->
		<div id="breadcrumb-container">
			<h3 class="breadcrumb-title">汽车归还管理</h3>
			<ol class="breadcrumb-list">
				<li class="breadcrumb-item-home">
					<a href="#">
						<span class="ti-home"></span>
					</a>
				</li>
				<li class="breadcrumb-item-one"><span>汽车归还管理</span></li>
				<li class="breadcrumb-item-two"><span>汽车归还列表</span></li>
			</ol>
		</div>
		<!-- /Breadcrumb -->
				
		<!-- Main Content -->
		<div id="center-container">

			<div class="d-flex">
				<div class="flex-grow-1" style="width: 25%">
					<label>车辆名称</label>
					<input type="text" id="cheliangmingchengSearch" class="form-control form-control-sm" placeholder="请输入车辆名称" aria-controls="tableId">
				</div>
				<div class="flex-grow-1" style="width: 25%">
					<label>车辆品牌</label>
					<select name="cheliangpinpai" id="cheliangpinpaiSelect" class="form-control form-control-sm" aria-controls="tableId">
					</select>
				</div>
				<div class="flex-grow-1" style="width: 25%">
					<label>车辆状态</label>
					<select name="cheliangzhuangtai" id="cheliangzhuangtaiSelect" class="form-control form-control-sm" aria-controls="tableId">
						<option value=" "></option>
						<option value="已租赁">已租赁</option>
						<option value="可租赁">可租赁</option>
					</select>
				</div>

			</div>
			
			<div class="btns">
<%--				<button onclick="add()" type="button" class="btn btn-success btn-add 新增"><i class="fa fa-plus"></i><span>添加</span></button>--%>
				<button onclick="deleteMore()" type="button" class="btn btn-danger btn-del 删除"><i class="fa fa-remove"></i><span>批量删除</span></button>
				<button onclick="search()" type="button" class="btn btn-search btn-primary">查询</button>
			</div>

			<table id="tableId" class="table table-bordered" style="margin-left: 150px">
				<thead>
					<tr>
						<th class="no-sort" style="min-width: 35px;">
							<div class="custom-control custom-checkbox">
								<input class="custom-control-input" type="checkbox" id="select-all" onclick="chooseAll()">
								<label class="custom-control-label" for="select-all"></label>
							</div>
						</th>
						<th onclick="sort('zulindingdan')">租赁订单<i id="zulindingdanIcon" class="fa fa-sort"></i></th>
						<th onclick="sort('cheliangmingcheng')">车辆名称<i id="cheliangmingchengIcon" class="fa fa-sort"></i></th>
						<th>车辆图片</th>
						<th onclick="sort('zulinshijian')">租赁时间<i id="zulinshijianIcon" class="fa fa-sort"></i></th>
						<th onclick="sort('zulinjiage')">租赁价格<i id="zulinjiageIcon" class="fa fa-sort"></i></th>
						<th onclick="sort('dingdanjine')">订单金额<i id="dingdanjinecon" class="fa fa-sort"></i></th>
						<th onclick="sort('guihaishijian')">归还时间<i id="guihaishijianIcon" class="fa fa-sort"></i></th>
						<th onclick="sort('cheliangzhuangtai')">车辆状态<i id="cheliangzhuangtaiIcon" class="fa fa-sort"></i></th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			

			<div id="pagination" style="margin-right: 90px;">
				<div class="dataTables_length" id="tableId_length">
					<select name="tableId_length" aria-controls="tableId" id="selectPageSize" onchange="changePageSize()">
						<option value="10">10</option>
						<option value="25">25</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select> 
					<span class="text">条每页</span>
				</div>
				<ul class="pagination">
					<li class="page-item" id="tableId_previous" onclick="pageNumChange('pre')">
						<a class="page-link" href="#" tabindex="-1">上一页</a>
					</li>
					<li class="page-item" id="tableId_next" onclick="pageNumChange('next')">
						<a class="page-link" href="#">下一页</a>
					</li>
				</ul>
			</div>
		</div>
		

	<!-- Back to Top -->
	<a id="back-to-top" href="#" class="back-to-top">Top</a>
	<!-- /Back to Top -->
	
	<%@ include file="../../static/foot.jsp"%>
	<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>

	<script>
		<%@ include file="../../utils/menu.jsp"%>
		<%@ include file="../../static/setMenu.js"%>
		<%@ include file="../../utils/baseUrl.jsp"%>
		<%@ include file="../../static/getRoleButtons.js"%>
		<%@ include file="../../static/crossBtnControl.js"%>
		var tableName = "qichezulin";
		var pageType = "list";
	  	var searchForm = { key: ""};
		var pageIndex = 1;
		var pageSize = 10;
		var totalPage = 0;
		var dataList = [];
		var dataListT = [];
		var dy = [];
		var sortColumn = '';
		var sortOrder= '';
		var ids = [];
		var checkAll = false;


		var cheliangpinpaiOptions = [];

		function init() {
			// 满足条件渲染提醒接口
		}
		// 改变每页记录条数
		function changePageSize() {
		    var selection = document.getElementById('selectPageSize');
		    var index = selection.selectedIndex;
			pageSize = selection.options[index].value;
			getDataList();
        }		
		//排序
		function sort(columnName){
			var iconId = '#'+columnName+'Icon'
			$('th i').attr('class','fa fa-sort');
			if(sortColumn == '' || sortColumn != columnName){
				sortColumn = columnName;
				sortOrder = 'asc';
				$(iconId).attr('class','fa fa-sort-asc');
			}
			if(sortColumn == columnName){
				if(sortOrder == 'asc'){
					sortOrder = 'desc';
					$(iconId).attr('class','fa fa-sort-desc');
				}else{
					sortOrder = 'asc';
					$(iconId).attr('class','fa fa-sort-asc');
				}
			}
			pageIndex = 1;
			getDataList();
		}		
		

		// 查询
		function search(){
			searchForm = { key: ""};
			if($('#cheliangmingchengSearch').val() != null && $('#cheliangmingchengSearch').val() != ''){
				searchForm.cheliangmingcheng ="%" +  $('#cheliangmingchengSearch').val() + "%";
			}
			
			var cheliangpinpaiIndex = document.getElementById("cheliangpinpaiSelect").selectedIndex;
			var cheliangpinpaiOptions = document.getElementById("cheliangpinpaiSelect").options;
			var cheliangpinpaiSelectedOption = cheliangpinpaiOptions[cheliangpinpaiIndex]
			if(cheliangpinpaiSelectedOption.text != null && cheliangpinpaiSelectedOption.text != ''){
				searchForm.cheliangpinpai = cheliangpinpaiSelectedOption.text;
			}
			var cheliangzhuangtaiIndex = document.getElementById("cheliangzhuangtaiSelect").selectedIndex;
			var cheliangzhuangtaiOptions = document.getElementById("cheliangzhuangtaiSelect").options;
			var cheliangzhuangtaiSelectedOption = cheliangzhuangtaiOptions[cheliangzhuangtaiIndex]
			if(cheliangzhuangtaiSelectedOption.text != null && cheliangzhuangtaiSelectedOption.text != ''){
				searchForm.cheliangzhuangtai = cheliangzhuangtaiSelectedOption.text;
			}
			getDataList();
		}		
		// 获取数据列表
		function getDataList() {
			getQichezulinList().then(() => {
				http("guihaijilu/page","GET",{
					page: pageIndex,
					limit: pageSize,
					sort: sortColumn,
					order: sortOrder,
					zulindingdan : searchForm.zulindingdan,
					cheliangpinpai : searchForm.cheliangpinpai,
					cheliangpingfen : searchForm.cheliangpingfen,
					shouji : searchForm.shouji,
				},(res)=>{
					if(res.code == 0){
						clear();
						dataList = res.data.list;
						totalPage = res.data.totalPage;
						console.log("dataList-----guihaijilu---->",dataList)
						var TuH = [];
						var temp = 0;
						if(dataList.length > dataListT.length){
							temp = dataListT.length
						}else{
							temp = dataList.length
						}
						for (let i = 0; i < temp; i++) {
							if(dataListT[i].cheliangmingcheng === dataList[i].cheliangmingcheng
									&& dataListT[i].cheliangpinpai === dataList[i].cheliangpinpai){
								TuH[i] = dataListT[i]
							}
						}
						dataListT = TuH;
						console.log("dataListT----过滤后的----->",dataListT)
						dy = dataListT
						console.log("dy----------->",dy)

						//var tbody = document.getElementById('tbMain');
						for(var i = 0;i < dataList.length; i++){ //遍历一下表格数据
							var trow = setDataRow(dataList[i],i); //定义一个方法,返回tr数据
							$('tbody').append(trow);
						}
						pagination(); //渲染翻页组件
						getRoleButtons();// 权限按钮控制
					}
				});
			});

        }

		function getQichezulinList(){
			return new Promise(resolve => {
				http("zulinjilu/page", "GET", {
					page: pageIndex,
					limit: pageSize,
					sort: sortColumn,
					order: sortOrder,
					cheliangmingcheng: searchForm.cheliangmingcheng,
					cheliangpinpai: searchForm.cheliangpinpai,
					cheliangzhuangtai: searchForm.cheliangzhuangtai,
				}, (res) => {
					if (res.code == 0) {
						dataListT = res.data.list;
						console.log("dataListT----qichezulin----->", dataListT)
						resolve(); // 执行成功，返回resolve
					}
				});
			})
		}

		// 渲染表格数据
		function setDataRow(item,number){
			//创建行
			var row = document.createElement('tr'); 
			row.setAttribute('class','useOnce');
			//创建勾选框
			var checkbox = document.createElement('td');
			var checkboxDiv = document.createElement('div');
			checkboxDiv.setAttribute("class","custom-control custom-checkbox");
			var checkboxInput = document.createElement('input');
			checkboxInput.setAttribute("class","custom-control-input");
			checkboxInput.setAttribute("type","checkbox");
			checkboxInput.setAttribute('name','chk');
			checkboxInput.setAttribute('value',item.id);
			checkboxInput.setAttribute("id",number);
			checkboxDiv.appendChild(checkboxInput);
			var checkboxLabel = document.createElement('label');
			checkboxLabel.setAttribute("class","custom-control-label");
			checkboxLabel.setAttribute("for",number);
			checkboxDiv.appendChild(checkboxLabel);
			checkbox.appendChild(checkboxDiv);
			row.appendChild(checkbox)

			//租赁订单
			var zulindingdanCell  = document.createElement('td');
			zulindingdanCell.innerHTML = item.zulindingdan;
			row.appendChild(zulindingdanCell);

			//车辆名称
			var cheliangmingchengCell  = document.createElement('td');
			cheliangmingchengCell.innerHTML = item.cheliangmingcheng;
			row.appendChild(cheliangmingchengCell);

			//车辆图片
			var cheliangtupianCell  = document.createElement('td');
			var cheliangtupianImg = document.createElement('img');
            cheliangtupianImg.setAttribute('src',item.cheliangtupian?(baseUrl+item.cheliangtupian.split(",")[0]):'');
			cheliangtupianImg.setAttribute('height',100);
			cheliangtupianImg.setAttribute('width',100);
			cheliangtupianCell.appendChild(cheliangtupianImg);
			row.appendChild(cheliangtupianCell);

			//租赁时间
			var zulinshijianCell  = document.createElement('td');
			zulinshijianCell.innerHTML = item.zulinshijian;
			row.appendChild(zulinshijianCell);

			//租赁价格
			var zulinjiageCell  = document.createElement('td');
			// zulinjiageCell.innerHTML = item.zulinjiage;
			zulinjiageCell.innerHTML = this.dataListT[number].zulinjiage;
			row.appendChild(zulinjiageCell);

			//订单金额
			var dingdanjineCell  = document.createElement('td');
			// zulinjiageCell.innerHTML = item.zulinjiage;
			dingdanjineCell.innerHTML = this.dataListT[number].dingdanjine;
			row.appendChild(dingdanjineCell);

			//归还时间
			var guihaishijianCell  = document.createElement('td');
			guihaishijianCell.innerHTML = item.guihaishijian;
			row.appendChild(guihaishijianCell);

			//车辆状态
			var cheliangzhuangtaiCell  = document.createElement('td');
			// cheliangzhuangtaiCell.innerHTML = item.cheliangzhuangtai;
			cheliangzhuangtaiCell.innerHTML = this.dataListT[number].zulinzhuangtai;
			row.appendChild(cheliangzhuangtaiCell);

			// var clicktimeCell  = document.createElement('td');
			//每行按钮
			var btnGroup = document.createElement('td');

			var crossBtn0 = document.createElement('button');
			crossBtn0.innerHTML = "租赁"
			crossBtn0.setAttribute("type","button");
			crossBtn0.setAttribute("class","btn btn-primary btn-sm");
			crossBtn0.setAttribute("onclick","crossTable(" + JSON.stringify(item) + ",'zulinjilu','','cheliangzhuangtai','该车辆已被租赁！','已租赁,可租赁'.split(',')[0])");
			if(crossBtnControl('租赁') == true){
				btnGroup.appendChild(crossBtn0);
			}   

			//详情按钮
			// var detailBtn = document.createElement('button');
			// var detailAttr = "detail(" + item.id + ')';
			// detailBtn.setAttribute("type","button");
			// detailBtn.setAttribute("class","btn btn-info btn-sm 查看");
			// detailBtn.setAttribute("onclick",detailAttr);
			// detailBtn.innerHTML = "查看"
			// btnGroup.appendChild(detailBtn)

			var role = window.sessionStorage.getItem("role");
			// console.log("role----->",role)
			// console.log("role === 用户----->",role === "用户")
			// console.log("role === 管理员----->",role === "管理员")

			//归还按钮
			var guihuanBtn = document.createElement('button');
			var guihuanAttr = 'guihuan(' +  JSON.stringify(item) + ')';
			guihuanBtn.setAttribute("type","button");
			guihuanBtn.setAttribute("class","btn btn-warning btn-sm 归还");
			guihuanBtn.setAttribute("onclick",guihuanAttr);
			guihuanBtn.innerHTML = "归还"
			if(role === "用户"){
				btnGroup.appendChild(guihuanBtn)
			}


			//修改按钮
			var editBtn = document.createElement('button');
			var editAttr = 'edit(' +  JSON.stringify(dataListT[number]) + "," + JSON.stringify(this.dataList[number]) +')';
			editBtn.setAttribute("type","button");
			editBtn.setAttribute("class","btn btn-warning btn-sm 修改");
			editBtn.setAttribute("onclick",editAttr);
			editBtn.innerHTML = "修改"
			if(role === "管理员") {
				btnGroup.appendChild(editBtn)
			}

			//删除按钮
			var deleteBtn = document.createElement('button');
			var deleteAttr = 'remove(' +  item.id + ')';
			deleteBtn.setAttribute("type","button");
			deleteBtn.setAttribute("class","btn btn-danger btn-sm 删除");
			deleteBtn.setAttribute("onclick",deleteAttr);
			deleteBtn.innerHTML = "删除"
			if(role === "管理员") {
				btnGroup.appendChild(deleteBtn)
			}

			row.appendChild(btnGroup)
			return row;
		}		

		// 翻页
        function pageNumChange(val) {
            if(val == 'pre') {
                pageIndex--;
            }else if(val == 'next'){
                pageIndex++;
            }else{
                pageIndex = val;
            }
			getDataList();
        }		
		// 下载
		function download(url){
			window.open(url);
		}
		// 打开新窗口播放媒体
		function mediaPlay(url){
			window.open(url);
		}		
		// 渲染翻页组件
		function pagination() {
			var beginIndex = pageIndex;
			var endIndex = pageIndex;
			var point = 4;
			//计算页码
			for(var i=0;i<3;i++){
				if(endIndex==totalPage){ break;}
				endIndex++;
				point--;
			}
			for(var i=0;i<3;i++){
				if(beginIndex==1){break;}
				beginIndex--;
				point--;
			}
			if(point>0){
				while (point>0){
					if(endIndex==totalPage){ break;}
					endIndex++;
					point--;
				}
				while (point>0){
					if(beginIndex==1){ break;}
					beginIndex--;
					point--
				}
			}
			// 是否显示 前一页 按钮
			if(pageIndex>1){
				$('#tableId_previous').show();
			}else{
				$('#tableId_previous').hide();
			}
			// 渲染页码按钮
			for(var i=beginIndex;i<=endIndex;i++){
				var pageNum = document.createElement('li');
				pageNum.setAttribute('onclick',"pageNumChange("+i+")");
				if(pageIndex == i){
					pageNum.setAttribute('class','paginate_button page-item active useOnce');
				}else{
					pageNum.setAttribute('class','paginate_button page-item useOnce');
				}								
				var pageHref = document.createElement('a');
				pageHref.setAttribute('class','page-link');
				pageHref.setAttribute('href','#');
				pageHref.setAttribute('aria-controls','tableId');
				pageHref.setAttribute('data-dt-idx',i);
				pageHref.setAttribute('tabindex',0);
				pageHref.innerHTML = i;
				pageNum.appendChild(pageHref);
				$('#tableId_next').before(pageNum);
			}
			// 是否显示 下一页 按钮
			if(pageIndex < totalPage){
				$('#tableId_next').show();
				$('#tableId_next a').attr('data-dt-idx',endIndex+1);
			}else{
				$('#tableId_next').hide();
			}
			var pageNumInfo = "当前第 "+ pageIndex + " 页，共 "+ totalPage + " 页";
			$('#tableId_info').html(pageNumInfo);
		}		
		// 跳转到指定页
		function toThatPage(){
			//var index = document.getElementById('pageIndexInput').value;
			if(index<0 || index>totalPage){
				alert('请输入正确的页码');
			}else {
				pageNumChange(index);
			}
		}		
		// 全选/全不选
		function chooseAll(){
			checkAll = !checkAll;
			var boxs = document.getElementsByName("chk");
			for(var i=0;i<boxs.length;i++){
				boxs[i].checked= checkAll;
			}
		}		
	
		// 批量删除
		function deleteMore(){
			ids = []
			var boxs = document.getElementsByName("chk");
			for(var i=0;i<boxs.length;i++){
				if(boxs[i].checked){
					ids.push(boxs[i].value)
				}
			}
			if(ids.length == 0){
				alert('请勾选要删除的记录');
			}else{
				remove(ids);
			}
		}	
		// 删除
        function remove(id) { 
            var mymessage = confirm("真的要删除吗？");
            if (mymessage == true) {
				var paramArray = [];
				if (id == ids){
					paramArray = id;
				}else{
					paramArray.push(id);
				}             
				httpJson("qichezulin/delete","POST",paramArray,(res)=>{
					if(res.code == 0){
						getDataList();		
						alert('删除成功');
					}
				});         
            }
            else {
                alert("已取消操作");
            }
        }			
		// 用户登出
        <%@ include file="../../static/logout.jsp"%>

		//修改
        function edit(item,itemT) {
            window.localStorage.setItem('itemPlus', JSON.stringify(item))
            window.localStorage.setItem('itemPlusT', JSON.stringify(itemT))
            window.location.href = "add-or-update.jsp"
        }
		//归还
		function guihuan(item) {
			if(dy.zulinzhuangtai === "未归还"){
				dy.zulinzhuangtai = "已归还"
			}else if(dy.zulinzhuangtai === "已归还"){
				// dy.zulinzhuangtai = "未归还"
				return ;
			}

			//转换归还时间为时间戳（以毫秒为单位）
			var returnTime = new Date(item.guihaishijian).getTime()
			//获取当前时间
			var currentTime = new Date()
			console.log("returnTime:",returnTime)
			console.log("currentTime:",currentTime)

			// 判断是否超时
			var isLate = currentTime > returnTime;

			if(isLate){
				dy.zulinjiage = dy.zulinjiage * 2
				dy.dingdanjine = dy.zulinjiage * 2
			}

			// 弹出消息框提示是否超时，超时则需付双倍费用
			var confirmMessage = isLate ? "已超时，需付双倍费用。是否继续？" : "未超时，是否继续？";
			if(confirm(confirmMessage)){
				httpJson("zulinjilu/update","POST",dy,(res)=>{
					if(res.code == 0){
						window.sessionStorage.removeItem('id');
						let flag = true;

						if(flag){
							alert('修改成功');
						}
						if(window.sessionStorage.getItem('onlyme') != null && window.sessionStorage.getItem('onlyme') === "true"){
							window.sessionStorage.removeItem('onlyme');
							window.location.href="${pageContext.request.contextPath}/index.jsp";
						}else{
							window.location.href = "list.jsp";
						}

					}
				});
			}

		}
		//清除会重复渲染的节点
        function clear(){
        	var elements = document.getElementsByClassName('useOnce');
        	for(var i = elements.length - 1; i >= 0; i--) { 
        	  elements[i].parentNode.removeChild(elements[i]); 
        	}
        }
	//添加
	function add(){
		window.location.href = "add-or-update.jsp"
	}
	//单列求和
	function getSum(colName){
		http("qichezulin"+colName,"GET",{
			tableName: "qichezulin",
			columnName: colName
		},(res)=>{
			if(res.code == 0){
				return res.data.sum;
			}
		});
	}		
	// 查看详情
	function detail(id){
		window.sessionStorage.setItem("id", id);
		//window.sessionStorage.setItem("ifView", true);
		window.location.href = "info.jsp";
	}

	function cheliangpinpaiSelect(){
		//填充下拉框选项
		http("option/cheliangpinpai/cheliangpinpai","GET",{},(res)=>{
			if(res.code == 0){
				cheliangpinpaiOptions = res.data;
				var nullOption = document.createElement('option');
				var cheliangpinpaiSelect = document.getElementById('cheliangpinpaiSelect');
				cheliangpinpaiSelect.appendChild(nullOption);
				for(var i=0;i<cheliangpinpaiOptions.length;i++){
					var cheliangpinpaiOption = document.createElement('option');
					cheliangpinpaiOption.setAttribute('name','cheliangpinpaiOption');
					cheliangpinpaiOption.setAttribute('value',cheliangpinpaiOptions[i]);
					cheliangpinpaiOption.innerHTML = cheliangpinpaiOptions[i];
					cheliangpinpaiSelect.appendChild(cheliangpinpaiOption);
				}
			}
		});
	}
	//跨表
	function crossTable(obj,crossTableName,crossOptAudit,statusColumnName,tips,statusColumnValue){
		window.sessionStorage.setItem('crossTableId',obj.id);
		window.sessionStorage.setItem('crossObj', JSON.stringify(obj));
		window.sessionStorage.setItem('crossTableName',"qichezulin");
		window.sessionStorage.setItem('statusColumnName',statusColumnName);
		window.sessionStorage.setItem('statusColumnValue',statusColumnValue);
		window.sessionStorage.setItem('tips',tips);
		if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
			for (var o in obj){
				if(o==statusColumnName && obj[o]==statusColumnValue){
                    alert(tips);
					return
				}
			}
		}
		var url = "../"+crossTableName+"/add-or-update.jsp?cross=true";
		window.location.href = url;
	}










		$(document).ready(function() { 
			//激活翻页按钮
			$('#tableId_previous').attr('class','paginate_button page-item previous')
			$('#tableId_next').attr('class','paginate_button page-item next')
			//隐藏原生搜索框
			$('#tableId_filter').hide()
			//设置右上角用户名
			$('.dropdown-menu h5').html(window.sessionStorage.getItem('username')+'('+window.sessionStorage.getItem('role')+')')
			//设置项目名
			$('.sidebar-header h3 a').html(projectName)
			setMenu();			
			init();
			getDataList();
			<%@ include file="../../static/myInfo.js"%>
			cheliangpinpaiSelect();
		});
	</script>
</body>

</html>
