<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <%@ include file="../../static/head.jsp" %>
    <link href="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/css/datetimepicker.css"
          rel="stylesheet">
    <script type="text/javascript" charset="utf-8">
        window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/resources/ueditor/"; //UEDITOR_HOME_URL、config、all这三个顺序不能改变
    </script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<style>
    label.error {
        color: red !important;
        width: auto !important;
    }
</style>
<body>
<div id="main-container">
    <!-- Top Navigation -->
    <%@ include file="../../static/topNav.jsp" %>

    <!-- Menu -->
    <div id="menu-container" class="navbar">
        <ul class="navbar-nav navbar-vertical" id="navUl">

        </ul>
    </div>
    <!-- /Menu -->

    <!-- Breadcrumb -->
    <div id="breadcrumb-container">
        <h3 class="breadcrumb-title">编辑汽车归还</h3>
        <ol class="breadcrumb-list">
            <li class="breadcrumb-item-home">
                <a href="#">
                    <span class="ti-home"></span>
                </a>
            </li>
            <li class="breadcrumb-item-one"><span>汽车归还管理</span></li>
            <li class="breadcrumb-item-two"><span>编辑汽车归还</span></li>
        </ol>
    </div>

    <!-- Main Content -->
    <div id="add-container">
        <form id="addOrUpdateForm">
            <input id="updateId" name="id" type="hidden">
            <div class="form-item">
                <label>租赁订单</label>
                <input name="zulindingdan" id="zulindingdan" class="form-control" placeholder="请输入租赁订单">
            </div>
            <div class="form-item">
                <label>车辆名称</label>
                <input name="cheliangmingcheng" id="cheliangmingcheng" class="form-control"
                       placeholder="请输入车辆名称">
            </div>
            <div class="form-item-img">
                <label>车辆图片</label>
                <div style="display: flex;align-items: center;">
                    <div v-for="(item,index) in cheliangtupianImgList" :key="index" style="position: relative;">
                        <div style="position: absolute;right: 10px;top: 0;width: 32px;height: 32px;background: #fff;padding: 6px;font-size: 0;cursor: pointer;border-radius: 0 20px 0 0;"
                             @click="cheliangtupianDelClick(index)">
                            <img src="../../../resources/images/shanchu.png"
                                 style="width: 20px;height: 20px;margin: 0;box-shadow: none;min-height:20px">
                        </div>
                        <img :src="baseUrl + item" width="100" height="100">
                    </div>
                </div>
                <div class="upload btn-img">选择文件<input name="file" type="file" id="cheliangtupianupload"
                                                           class="form-control-file"></div>
                <input name="cheliangtupian" id="cheliangtupian-input" type="hidden">
            </div>
            <div class="form-item">
                <label>租赁时间</label>
                <input name="zulinshijian" id="zulinshijian-input" class="date" size="15" type="text"
                       placeholder="请输入租赁时间">
            </div>
            <div class="form-item">
                <label>租赁价格</label>
                <input name="zulinjiage" id="zulinjiage" class="form-control" placeholder="请输入租赁价格">
            </div>
            <div class="form-item">
                <label>归还时间</label>
                <input id="guihaishijian-input" class="date" name="guihaishijian" size="15" type="text"
                       placeholder="请选择归还时间">
            </div>
            <div class="form-item">
                <label>车辆状态</label>
                <select id="cheliangzhuangtaiSelect" name="cheliangzhuangtai" class="form-control">
                    <option value="">请选择车辆状态</option>
                    <option class="cheliangzhuangtaiOption" value="未归还">
                        未归还
                    </option>
                    <option class="cheliangzhuangtaiOption" value="已归还">
                        已归还
                    </option>
                </select>
            </div>

            <div class="form-btn">
                <button id="submitBtn" type="button" class="btn btn-primary btn-add">提交</button>
                <button id="exitBtn" type="button" class="btn btn-primary btn-close">取消</button>
            </div>
        </form>
    </div>
</div>

<!-- Back to Top -->
<a id="back-to-top" href="#" class="back-to-top">Top</a>
<!-- /Back to Top -->

<%@ include file="../../static/foot.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.ui.widget.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.fileupload.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/jquery.validate.min.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/messages_zh.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/validate/card.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script>
    <%@ include file="../../utils/menu.jsp"%>
    <%@ include file="../../static/setMenu.js"%>
    <%@ include file="../../static/utils.js"%>
    <%@ include file="../../utils/baseUrl.jsp"%>

    var tableName = "guihaijilu";
    var pageType = "add-or-update";
    var updateId = "";
    var crossTableId = -1;
    var crossTableName = '';
    var ruleForm = {};
    var crossRuleForm = {};

    var vm = new Vue({
        el: '#addOrUpdateForm',
        data: {
            ruleForm: {},
            cheliangtupianImgList: [],
            baseUrl: baseUrl,
        },
        beforeCreate: function () {
            ruleForm = JSON.parse(window.localStorage.getItem("itemPlus"));
            console.log("ruleForm--->",ruleForm)
        },
        methods: {
            cheliangtupianDelClick(index) {
                var mymessage = confirm("确定移除图片？");
                if (mymessage == true) {
                    this.cheliangtupianImgList.splice(index, 1)
                }

            },
        }
    });

    // 文件上传
    function upload() {
        $('#cheliangtupianupload').fileupload({
            url: baseUrl + 'file/upload',
            headers: {token: window.sessionStorage.getItem("token")},
            dataType: 'json',
            done: function (e, data) {
                document.getElementById('cheliangtupian-input').setAttribute('value', "upload/" + data.result.file);
                if (document.getElementById('cheliangtupianFileName') != null) {
                    document.getElementById('cheliangtupianFileName').innerHTML = "上传成功!";
                }
                vm.cheliangtupianImgList.push("upload/" + data.result.file)
            }
        });
    }

    //取消
    function cancel() {
        window.location.href = "list.jsp";
    }

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    // 表单提交
    function submit() {
        //获取表单数据前取消禁用
        $("#guihaishijian-input").attr('disabled', false);
        $("#zulinshijian-input").attr('disabled', false);

        if (validform() === true) {
            let data = {};
            let value = $('#addOrUpdateForm').serializeArray();
            $.each(value, function (index, item) {
                data[item.name] = item.value;
            });
            if (vm.cheliangtupianImgList.length) {
                data.cheliangtupian = vm.cheliangtupianImgList.join(',')
            }
            console.log("data---->",data)
            var tins = JSON.parse(window.localStorage.getItem("itemPlusT"));
            var zulinjiluData = {
                "id" : data.id,
                "zulinjiage" : data.zulinjiage,
                "zulinzhuangtai" : data.cheliangzhuangtai,
            }
            console.log("zulinjiluData--->",zulinjiluData)
            // 需要删除的属性
            var propertiesToDelete = ['zulinjiage','cheliangzhuangtai'];
            // 删除属性
            propertiesToDelete.forEach(function(property) {
                delete data[property];
            });

            var guihaijiluData = data
            guihaijiluData.id = tins.id
            console.log("guihaijiluData--->",guihaijiluData)

            // let json = JSON.stringify(data);
            var urlParam = 'update';
            var successMes = '修改成功';
            // httpJson("zulinjilu/update","POST",zulinjiluData,(res)=>{
            //     if(res.code == 0){
            //         console.log('更新zulinjilu属性成功');
            //     }
            // });
            // httpJson("guihaijilu/update","POST",guihaijiluData,(res)=>{
            //     if(res.code == 0){
            //         console.log('更新guihaijilu属性成功');
            //         // window.location.href = "list.jsp";
            //     }
            // });

        } else {
            alert("表单未填完整或有错误");
        }
    }

    // 填充富文本框
    function setContent() {
    }

    // 获取富文本框内容
    function getContent() {
    }

    // 表单校验
    function validform() {
        return $("#addOrUpdateForm").validate({
            rules: {
                zulindingdan: {},
                cheliangmingcheng: {},
                cheliangpinpai: {},
                chepaihaoma: {},
                cheliangtupian: {},
                zulinshijian: {},
                guihaishijian: {},
                cheliangpingfen: {
                    required: true,
                },
                cheliangpingjia: {
                    required: true,
                },
                zulinyajin: {
                    digits: true,
                },
                guihaibeizhu: {},
                yonghuming: {
                    required: true,
                },
                xingming: {},
                shouji: {
                    isPhone: true,
                },
                shenfenzheng: {
                    isIdCardNo: true,
                },
                shhf: {},
                ispay: {},
            },
            messages: {
                cheliangmingcheng: {},
                cheliangpinpai: {},
                chepaihaoma: {},
                cheliangtupian: {},
                zulinshijian: {},
                guihaishijian: {},
                cheliangpingfen: {
                    required: "车辆评分不能为空",
                },
                cheliangpingjia: {
                    required: "车辆评价不能为空",
                },
                zulinyajin: {
                    digits: "请输入整数",
                },
                guihaibeizhu: {},
                yonghuming: {
                    required: "用户名不能为空",
                },
                xingming: {},
                shouji: {},
                shenfenzheng: {},
                shhf: {},
                ispay: {},
            }
        }).form();
    }

    // 添加表单校验方法
    function addValidation() {
        jQuery.validator.addMethod("isPhone", function (value, element) {
            var length = value.length;
            var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(19[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
            return this.optional(element) || (length == 11 && mobile.test(value));
        }, "请填写正确的手机号码");
        jQuery.validator.addMethod("isIdCardNo", function (value, element) {
            return this.optional(element) || value.length == 18;
        }, "请正确输入您的身份证号码");
        jQuery.validator.addMethod("isTel", function (value, element) {
            var length = value.length;
            var phone = /(^(\d{3,4}-)?\d{6,8}$)|(^(\d{3,4}-)?\d{6,8}(-\d{1,5})?$)|(\d{11})/;
            return this.optional(element) || (phone.test(value));
        }, "请填写正确的固定电话");//可以自定义默认提示信息
    }

    // 获取当前详情
    function getDetails() {
        ruleForm = JSON.parse(window.localStorage.getItem("itemPlus"));
        console.log("ruleForm--->",window.localStorage.getItem("itemPlus"))
        // 设置图片src
        showImg();
        // 数据填充
        dataBind();
        //注册表单验证
        $(validform());
    }

    // 下拉框选项回显
    function setSelectOption() {
    }

    // 关联下拉框改变
    function lvSelectChange(level) {
        let data = {};
        let value = $('#addOrUpdateForm').serializeArray();
        $.each(value, function (index, item) {
            data[item.name] = item.value;
        });

    }

    // 清除可能会重复渲染的selection
    function clear(className) {
        var elements = document.getElementsByClassName(className);
        for (var i = elements.length - 1; i >= 0; i--) {
            elements[i].parentNode.removeChild(elements[i]);
        }
    }

    function dateTimePick() {
        $.fn.datetimepicker.dates['zh-CN'] = {
            days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
            daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
            daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
            months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
            monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
            today: "今天",
            suffix: [],
            meridiem: ["上午", "下午"]
        };
        $("#guihaishijian-input").val(getCurDateTime());
        $("#guihaishijian-input").datetimepicker({
            autoclose: true,
            format: 'yyyy-mm-dd hh:ii:00',
            minuteStep: 1,
            language: 'zh-CN',
        });
        $("#zulinshijian-input").val(getCurDateTime());
        $("#zulinshijian-input").datetimepicker({
            autoclose: true,
            format: 'yyyy-mm-dd hh:ii:00',
            minuteStep: 1,
            language: 'zh-CN',
        });

    }

    function calculation() {
        //积
        var x = 0;
        //和
        var y = 0;
        var flag = 0;


    }

    function calculationSE(colName) {
        //单列求和接口
        http("guihaijilu" + colName, "GET", {
            tableName: "guihaijilu",
            columnName: colName
        }, (res) => {
            if (res.code == 0) {
                $("#" + colName).attr("value", res.data);
            }
        });
    }

    function calculationPre() {
        //进入该页面就填充"单列求和"的列
    }


    //新增时填充字段
    function fill() {
        var username = window.sessionStorage.getItem('username');
        var accountTableName = window.sessionStorage.getItem('accountTableName');
        http(accountTableName + '/session', 'GET', {}, (res) => {
            if (res.code == 0) {
                var myId = res.data.id;
                if (res.data != null && res.data.yonghuming != null && res.data.yonghuming != '') {
                    $('#yonghuming').val(res.data.yonghuming)
                    $("#yonghuming").attr('readonly', 'readonly');
                }
                if (res.data != null && res.data.xingming != null && res.data.xingming != '') {
                    $('#xingming').val(res.data.xingming)
                    $("#xingming").attr('readonly', 'readonly');
                }
                if (res.data != null && res.data.shouji != null && res.data.shouji != '') {
                    $('#shouji').val(res.data.shouji)
                    $("#shouji").attr('readonly', 'readonly');
                }
                if (res.data != null && res.data.shenfenzheng != null && res.data.shenfenzheng != '') {
                    $('#shenfenzheng').val(res.data.shenfenzheng)
                    $("#shenfenzheng").attr('readonly', 'readonly');
                }
                $(validform());
            }
        });

    }

    function dataBind() {
        $("#updateId").val(ruleForm.id);
        $("#zulindingdan").val(ruleForm.zulindingdan);
        $("#cheliangmingcheng").val(ruleForm.cheliangmingcheng);
        $("#cheliangpinpai").val(ruleForm.cheliangpinpai);
        $("#chepaihaoma").val(ruleForm.chepaihaoma);
        if (ruleForm.cheliangtupian) {
            vm.cheliangtupianImgList = ruleForm.cheliangtupian.split(',')
        }
        $("#cheliangtupian-input").val(ruleForm.cheliangtupian);
        $("#zulinshijian-input").val(ruleForm.zulinshijian);
        $("#zulinjiage").val(ruleForm.zulinjiage);
        $("#guihaishijian-input").val(ruleForm.guihaishijian);
        $("#cheliangzhuangtaiSelect").val(ruleForm.zulinzhuangtai);
    }

    //图片显示
    function showImg() {
        var cheliangtupianFileName = "\"" + ruleForm.cheliangtupian + "\"";
        $("#cheliangtupianImg").attr("src", baseUrl + ruleForm.cheliangtupian);
    }

    //跨表

    //跨表
    function crossTable() {
        crossTableName = window.sessionStorage.getItem('crossTableName');
        crossTableId = window.sessionStorage.getItem('crossTableId');
        if (crossTableName != null && crossTableName != '' && crossTableId != null && crossTableId != '' && crossTableId != -1) {
            http(crossTableName + "/info/" + crossTableId, "GET", {}, (res) => {
                if (res.code == 0) {
                    crossRuleForm = res.data;
                    $('#updateId').val(crossTableId);
                    if (res.data != null && res.data != '' && res.data.zulindingdan != null && res.data.zulindingdan != '') {

                        $("#zulindingdan").val(res.data.zulindingdan);
                        $("#zulindingdan").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.cheliangmingcheng != null && res.data.cheliangmingcheng != '') {

                        $("#cheliangmingcheng").val(res.data.cheliangmingcheng);
                        $("#cheliangmingcheng").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.cheliangpinpai != null && res.data.cheliangpinpai != '') {

                        $("#cheliangpinpai").val(res.data.cheliangpinpai);
                        $("#cheliangpinpai").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.chepaihaoma != null && res.data.chepaihaoma != '') {

                        $("#chepaihaoma").val(res.data.chepaihaoma);
                        $("#chepaihaoma").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.cheliangtupian != null && res.data.cheliangtupian != '') {

                        vm.cheliangtupianImgList = res.data.cheliangtupian.split(',')
                    }
                    if (res.data != null && res.data != '' && res.data.zulinshijian != null && res.data.zulinshijian != '') {

                        $("#zulinshijian").val(res.data.zulinshijian);
                        $("#zulinshijian").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.guihaishijian != null && res.data.guihaishijian != '') {

                        $("#guihaishijian-input").val(res.data.guihaishijian);
                        $('#guihaishijianFileName').val(res.data.guihaishijian)
                    }
                    if (res.data != null && res.data != '' && res.data.cheliangpingfen != null && res.data.cheliangpingfen != '') {

                        var cheliangpingfenOptions = document.getElementsByClassName("cheliangpingfenOption");
                        for (var cheliangpingfenCount = 0; cheliangpingfenCount < cheliangpingfenOptions.length; cheliangpingfenCount++) {
                            if (cheliangpingfenOptions[cheliangpingfenCount].getAttribute('value') == res.data.cheliangpingfen) {
                                cheliangpingfenOptions[cheliangpingfenCount].setAttribute('selected', 'selected');
                            }
                        }
                    }
                    if (res.data != null && res.data != '' && res.data.cheliangpingjia != null && res.data.cheliangpingjia != '') {

                        $("#cheliangpingjia").val(res.data.cheliangpingjia);
                    }
                    if (res.data != null && res.data != '' && res.data.zulinyajin != null && res.data.zulinyajin != '') {

                        $("#zulinyajin").val(res.data.zulinyajin);
                        $("#zulinyajin").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.guihaibeizhu != null && res.data.guihaibeizhu != '') {

                        $("#guihaibeizhu").val(res.data.guihaibeizhu);
                        $("#guihaibeizhu").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.yonghuming != null && res.data.yonghuming != '') {

                        $("#yonghuming").val(res.data.yonghuming);
                        $("#yonghuming").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.xingming != null && res.data.xingming != '') {

                        $("#xingming").val(res.data.xingming);
                        $("#xingming").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.shouji != null && res.data.shouji != '') {

                        $("#shouji").val(res.data.shouji);
                        $("#shouji").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.shenfenzheng != null && res.data.shenfenzheng != '') {

                        $("#shenfenzheng").val(res.data.shenfenzheng);
                        $("#shenfenzheng").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.shhf != null && res.data.shhf != '') {

                        $("#shhf").val(res.data.shhf);
                        $("#shhf").attr('readonly', 'readonly');
                    }
                    if (res.data != null && res.data != '' && res.data.ispay != null && res.data.ispay != '') {

                        $("#ispay").val(res.data.ispay);
                        $("#ispay").attr('readonly', 'readonly');
                    }
                }
            });
        }
        window.sessionStorage.removeItem('crossTableName');
        window.sessionStorage.removeItem('crossTableId');
    }

    //跨表更新字段
    function crossTableUpdate() {
        let flag = crossTableUpdateValidation();
        if (flag) {
            httpJson(crossTableName + "/update", "POST", {
                id: crossTableId,
            }, (res) => {
                if (res.code == 0) {
                    console.log('跨表更新成功');
                    return true;
                }
            });
        }
        return false;
    }

    //跨表更新前验证
    function crossTableUpdateValidation() {
        //防止减法导致库存负值
        return true;
    }

    $(document).ready(function () {
        //设置右上角用户名
        $('.dropdown-menu h5').html(window.sessionStorage.getItem('username') + '(' + window.sessionStorage.getItem('role') + ')')
        //设置项目名
        $('.sidebar-header h3 a').html(projectName)
        //设置导航栏菜单
        setMenu();
        //初始化时间插件
        dateTimePick();
        //添加表单校验信息文本
        // addValidation();
        getDetails();
        //初始化上传按钮
        upload();
        //单列求和
        // calculationPre();
        //跨表
        // crossTable();
        <%@ include file="../../static/myInfo.js"%>
        $('#submitBtn').on('click', function (e) {
            e.preventDefault();
            //console.log("点击了...提交按钮");
            submit();
        });
        $('#exitBtn').on('click', function (e) {
            cancel();
        });
        // readonly();
    });

    function readonly() {
        if (window.sessionStorage.getItem('role') != "管理员") {
            $('#money').attr('readonly', 'readonly');
            $("#zulindingdan").attr('readonly', 'readonly');
            $("#cheliangmingcheng").attr('readonly', 'readonly');
            $("#cheliangpinpai").attr('readonly', 'readonly');
            $("#chepaihaoma").attr('readonly', 'readonly');
            $("#cheliangtupian").attr('readonly', 'readonly');
            $("#zulinshijian").attr('readonly', 'readonly');
            $("#guihaishijian-input").attr('disabled', true);
            $("#zulinyajin").attr('readonly', 'readonly');
            $("#yonghuming").attr('readonly', 'readonly');
            $("#xingming").attr('readonly', 'readonly');
            $("#shouji").attr('readonly', 'readonly');
            $("#shenfenzheng").attr('readonly', 'readonly');
        }
    }

    //比较大小
    function compare() {
        var largerVal = null;
        var smallerVal = null;
        if (largerVal != null && smallerVal != null) {
            if (parseInt(largerVal) <= parseInt(smallerVal)) {
                alert(smallerName + '不能大于等于' + largerName);
                return false;
            }
        }
        return true;
    }


    // 用户登出
    <%@ include file="../../static/logout.jsp"%>
</script>
</body>

</html>
