<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
var menus =
[
{
"backMenu": [
{
"child": [{
"appFrontIcon": "cuIcon-clothes",
"buttons": ["新增", "查看", "修改", "删除"],
"menu": "用户",
"menuJump": "列表",
"tableName": "yonghu"
}], "menu": "用户管理"
},
{
"child": [{
"appFrontIcon": "cuIcon-clothes",
"buttons": ["新增", "查看", "修改", "删除"],
"menu": "车辆品牌",
"menuJump": "列表",
"tableName": "cheliangpinpai"}], "menu": "车辆品牌管理"
},
{
"child": [{
"appFrontIcon": "cuIcon-camera",
"buttons": ["新增", "查看", "修改", "删除"],
"menu": "汽车租赁",
"menuJump": "列表",
"tableName": "qichezulin"
}], "menu": "汽车租赁管理"
},
{
"child": [{
"appFrontIcon": "cuIcon-camera",
"buttons": ["新增", "查看", "修改", "删除"],
"menu": "汽车归还",
"menuJump": "列表",
"tableName": "qicheguihuan"
}], "menu": "汽车归还管理"
},
{
"child": [{
"appFrontIcon": "cuIcon-keyboard",
"buttons": ["查看", "修改", "删除", "审核", "每月营收统计"],
"menu": "租赁记录",
"menuJump": "列表",
"tableName": "zulinjilu"
}], "menu": "租赁记录管理"
},
{
"child": [{
"appFrontIcon": "cuIcon-clothes",
"buttons": ["查看", "修改", "删除", "审核", "支付"],
"menu": "归还记录",
"menuJump": "列表",
"tableName": "guihaijilu"
}], "menu": "归还记录管理"
},
{
"child": [{
"appFrontIcon": "cuIcon-shop",
"buttons": ["查看", "修改"],
"menu": "轮播图管理",
"tableName": "config"
}, {
"appFrontIcon": "cuIcon-news",
"buttons": ["新增", "查看", "修改", "删除"],
"menu": "公告信息",
"tableName": "news"
}], "menu": "系统管理"
}],
"frontMenu": [{
"child": [{
"appFrontIcon": "cuIcon-newshot",
"buttons": ["查看", "租赁"],
"menu": "汽车租赁列表",
"menuJump": "列表",
"tableName": "qichezulin"
}], "menu": "汽车租赁模块"
}],
"hasBackLogin": "是",
"hasBackRegister": "否",
"hasFrontLogin": "否",
"hasFrontRegister": "否",
"roleName": "管理员",
"tableName": "users"
},
{
"backMenu": [
{
"child": [{
"appFrontIcon": "cuIcon-camera",
"buttons": ["新增", "查看", "修改", "删除"],
"menu": "汽车归还",
"menuJump": "列表",
"tableName": "qicheguihuan"
}], "menu": "汽车归还管理"
},
{
"child": [{
"appFrontIcon": "cuIcon-keyboard",
"buttons": ["查看", "支付", "车辆归还"],
"menu": "租赁记录",
"menuJump": "列表",
"tableName": "zulinjilu"
}], "menu": "租赁记录管理" },
{
"child": [{
"appFrontIcon": "cuIcon-clothes",
"buttons": ["查看"],
"menu": "归还记录",
"menuJump": "列表",
"tableName": "guihaijilu"
}], "menu": "归还记录管理"
}
],
"frontMenu": [{
"child": [{
"appFrontIcon": "cuIcon-newshot",
"buttons": ["查看", "租赁"],
"menu": "汽车租赁列表",
"menuJump": "列表",
"tableName": "qichezulin"
}], "menu": "汽车租赁模块"
}],
"hasBackLogin": "是",
"hasBackRegister": "否",
"hasFrontLogin": "是",
"hasFrontRegister": "是",
"roleName": "用户",
"tableName": "yonghu"
}
];
var hasMessage = '';
