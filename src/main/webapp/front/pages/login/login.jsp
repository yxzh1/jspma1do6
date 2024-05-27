<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page isELIgnored="true" %>
<!-- 登陆 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>登录</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <!-- 样式 -->
    <link rel="stylesheet" href="../../css/style.css"/>
    <!-- 主题（主要颜色设置） -->
    <link rel="stylesheet" href="../../css/theme.css"/>
    <!-- 通用的css -->
    <link rel="stylesheet" href="../../css/common.css"/>
</head>
<style type="text/css">
    html, body {
        height: 100%;
    }

    #loginForm .l-redio .layui-form-radio {
        cursor: pointer;
        margin: 0;
        display: inline-block;
        vertical-align: middle;
        line-height: 28px;
    }

    #loginForm .l-redio .layui-form-radio .layui-icon {
        color: #999;
        display: inline-block;
        font-size: 18px;
        margin-right: 8px;
    }

    #loginForm .l-redio .layui-form-radio div {
        color: #999;
        display: inline-block;
        vertical-align: middle;
        font-size: 14px;
    }

    #loginForm .l-redio .layui-form-radio.layui-form-radioed .layui-icon {
        color: #288bbf;
        display: inline-block;
        font-size: 18px;
    }

    #loginForm .l-redio .layui-form-radio.layui-form-radioed div {
        color: #288bbf;
        display: inline-block;
        vertical-align: middle;
        font-size: 14px;
    }
</style>
<body>
<div id="login" class="login"
     :style='{"minHeight":"100vh","width":"100%","alignItems":"flex-start","background":"url(http://codegen.caihongy.cn/20230128/effb535f5a6142daa256f40fb8542933.jpg) no-repeat center bottom / 100% 100%,#fff","justifyContent":"flex-start","display":"flex"}'>
    <form id="loginForm" class="layui-form login-form"
          :style='{"padding":"60px 0px 40px","boxShadow":"0 0px 0px rgba(0, 0, 0, .1)","margin":"60px 0 0 12%","borderColor":"#eee","display":"block","justifyContent":"center","outline":"0px solid #fff","borderRadius":"0","flexWrap":"wrap","background":"rgba(255,255,255,1)","borderWidth":"0px","width":"44%","borderStyle":"solid","height":"100%"}'>
        <div v-if="true"
             :style='{"margin":"0 0 4px","color":"#5fa6d0","textAlign":"center","display":"none","width":"100%","lineHeight":"44px","fontSize":"22px","textShadow":"0px 0px 0px rgba(64, 158, 255, .5)"}'>
            USER / LOGIN
        </div>
        <div v-if="true"
             :style='{"boxShadow":"inset 0px 0px 0px 0px #c5f1c0","padding":"0 0 10px","margin":"20px auto 40px","borderColor":"#98c6e2 #5fa6d0 #98c6e2 #5fa6d0","color":"#888","textAlign":"center","borderRadius":"0","background":"url(http://codegen.caihongy.cn/20230128/4cbad5a2e6f444188a2c08cb74dc8160.png) no-repeat center bottom","borderWidth":"0px","width":"80%","lineHeight":"50px","fontSize":"24px","borderStyle":"solid","textShadow":"0px 0px 0px rgba(64, 158, 255, .5)","fontWeight":"500"}'>
            汽车租赁网站
        </div>
        <div :style='{"width":"60%","margin":"0 auto 20px","flexWrap":"wrap","display":"flex"}' class="form-item">
            <div class="layui-form-label" v-if="true"
                 :style='{"width":"64px","padding":"0 10px 0 0","lineHeight":"44px","fontSize":"14px","color":"#333"}'>
                账号:
            </div>
            <input :style='{"padding":"0 10px","borderColor":"#ddd","color":"#333","outline":"0px solid #efefef","outlineOffset":"4px","borderRadius":"8px","flex":"1","borderWidth":"2px","background":"#fff","width":"100%","fontSize":"14px","borderStyle":"solid","height":"44px"}'
                   type="text" name="username" required lay-verify="required" placeholder="请输入账号"
                   autocomplete="off" class="layui-input" value="sys">
        </div>
        <div :style='{"width":"60%","margin":"0 auto 20px","flexWrap":"wrap","display":"flex"}' class="form-item">
            <div class="layui-form-label" v-if="true"
                 :style='{"width":"64px","padding":"0 10px 0 0","lineHeight":"44px","fontSize":"14px","color":"#333"}'>
                密码:
            </div>
            <input :style='{"padding":"0 10px","borderColor":"#ddd","color":"#333","outline":"0px solid #efefef","outlineOffset":"4px","borderRadius":"8px","flex":"1","borderWidth":"2px","background":"#fff","width":"100%","fontSize":"14px","borderStyle":"solid","height":"44px"}'
                   type="password" name="password" required lay-verify="required" placeholder="请输入密码"
                   autocomplete="off" class="layui-input" value="123456">
        </div>
        <div  :style='{"width":"50%","margin":"20px auto 10px","background":"none"}' class="form-item l-redio">
            <input v-for="(item,index) in roles" v-bind:key="index" type="radio" name="role" id="role"
                   :value="item.tableName" :title="item.roleName">
        </div>
        <div :style='{"padding":"10px 0 20px","margin":"0 0px 0px 0","borderColor":"#f5d4d4","alignItems":"center","textAlign":"right","bottom":"0","display":"flex","right":"0","borderRadius":"0","left":"0","background":"linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(178,213,232,1) 100%)","borderWidth":"0px","width":"10%","position":"absolute","borderStyle":"solid","height":"100%"}'>
        </div>
        <div :style='{"padding":"0px","margin":"20px 0px 0 0","alignItems":"center","flexWrap":"wrap","textAlign":"right","background":"none","display":"flex","width":"100%","justifyContent":"center","height":"auto"}'>
            <button :style='{"cursor":"pointer","padding":"0 10px","margin":"0 10px 0px 0","borderColor":"#ddd","color":"#288bbf","textAlign":"center","display":"inline-block","textDecoration":"none","minWidth":"100px","borderRadius":"8px","borderWidth":"2px","background":"#eee","lineHeight":"40px","fontSize":"16px","borderStyle":"solid"}' class="layui-btn btn-submit" lay-submit lay-filter="login">登录</button>
            <a :style='{"cursor":"pointer","padding":"0 10px","margin":"0 10px 0px 0","borderColor":"#ddd","color":"#288bbf","textAlign":"center","display":"inline-block","textDecoration":"none","minWidth":"100px","borderRadius":"8px","borderWidth":"2px","background":"#eee","lineHeight":"35px","fontSize":"16px","borderStyle":"solid"}'
               v-if="item.tableName!='users'&&item.hasFrontRegister=='是'" v-for="(item,index) in menu"
               v-bind:key="index" :href="'javascript:registerClick(\''+item.tableName+'\')'">注册{{item.roleName.replace('注册','')}}</a>
        </div>
    </form>
</div>

<script src="../../layui/layui.js"></script>
<script src="../../js/vue.js"></script>
<!-- 组件配置信息 -->
<script src="../../js/config.js"></script>
<!-- 扩展插件配置信息 -->
<script src="../../modules/config.js"></script>
<!-- 工具方法 -->
<script src="../../js/utils.js"></script>
<script>
    var vue = new Vue({
        el: '#login',
        data: {
            menu: menu,
            roles: []
        },
        created() {
            for (let item in this.menu) {
                this.roles.push(this.menu[item]);
                // if (this.menu[item].hasFrontLogin == '是') {
                //     this.roles.push(this.menu[item]);
                // }
            }
            console.log("roles-------------->",this.roles)
        },
        methods: {
            jump(url) {
                jump(url)
            },
        }
    })

    var codes = [{
        num: 1,
        color: '#000',
        rotate: '10deg',
        size: '16px'
    }, {
        num: 2,
        color: '#000',
        rotate: '10deg',
        size: '16px'
    }, {
        num: 3,
        color: '#000',
        rotate: '10deg',
        size: '16px'
    }, {
        num: 4,
        color: '#000',
        rotate: '10deg',
        size: '16px'
    }]

    layui.use(['layer', 'element', 'carousel', 'form', 'http', 'jquery'], function () {
        var layer = layui.layer;
        var element = layui.element;
        var carousel = layui.carousel;
        var form = layui.form;
        var http = layui.http;
        var jquery = layui.jquery;

        function randomString() {
            var len = 4;
            var chars = [
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
                'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
                'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
                'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
                'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2',
                '3', '4', '5', '6', '7', '8', '9'
            ]
            var colors = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
            var sizes = ['14', '15', '16', '17', '18']

            var output = []
            for (var i = 0; i < len; i++) {
                // 随机验证码
                var key = Math.floor(Math.random() * chars.length)
                codes[i].num = chars[key]
                // 随机验证码颜色
                var code = '#'
                for (var j = 0; j < 6; j++) {
                    var key = Math.floor(Math.random() * colors.length)
                    code += colors[key]
                }
                codes[i].color = code
                // 随机验证码方向
                var rotate = Math.floor(Math.random() * 45)
                var plus = Math.floor(Math.random() * 2)
                if (plus == 1) rotate = '-' + rotate
                codes[i].rotate = 'rotate(' + rotate + 'deg)'
                // 随机验证码字体大小
                var size = Math.floor(Math.random() * sizes.length)
                codes[i].size = sizes[size] + 'px'
            }

            var str = ''
            for (var i = 0; i < codes.length; i++) {
                str += '<span style="color:' + codes[i].color + ';transform:' + codes[i].rotate + ';fontSize:' + codes[i].size + ';padding: 0 3px;display:inline-block">' + codes[i].num + '</span>'
            }
            jquery('#nums').html('').append(str);
        }

        jquery('#nums').click(function () {
            randomString();
        })

        randomString();

        // 登录
        form.on('submit(login)', function (data) {
            data = data.field;
            if (vue.roles.length != 1) {
                if (!data.role) {
                    layer.msg('请选择登录用户类型', {
                        time: 2000,
                        icon: 5
                    });
                    return false;
                }
            } else {
                data.role = vue.roles[0].tableName;
            }

            if(data.role === "yonghu"){
                http.request(data.role + '/login', 'get', data, function (res) {
                    layer.msg('登录成功', {
                        time: 2000,
                        icon: 6
                    });
                    // 登录凭证
                    localStorage.setItem('Token', res.token);
                    var roleName = "";
                    if (typeof (jquery('#role:checked').attr('title')) == "undefined") {
                        roleName = vue.roles[0].roleName;
                    } else {
                        roleName = jquery('#role:checked').attr('title');
                    }
                    localStorage.setItem('role', roleName);
                    // 当前登录用户角色
                    localStorage.setItem('userTable', data.role);
                    localStorage.setItem('sessionTable', data.role);
                    // 用户名称
                    localStorage.setItem('adminName', data.username);
                    http.request(data.role + '/session', 'get', {}, function (res) {
                        // 用户id
                        localStorage.setItem('userid', res.data.id);
                        if (res.data.vip) {
                            localStorage.setItem('vip', res.data.vip);
                        }
                        if (res.data.touxiang) {
                            localStorage.setItem('headportrait', res.data.touxiang);
                        } else if (res.data.headportrait) {
                            localStorage.setItem('headportrait', res.data.headportrait);
                        }
                        // 路径访问设置
                        window.location.href = '../../index.jsp';
                    })

                });
            }
            if(data.role === "users"){
                http.request(data.role + '/login', 'post', data, function (res) {
                    layer.msg('登录成功', {
                        time: 2000,
                        icon: 6
                    });
                    // 登录凭证
                    localStorage.setItem('Token', res.token);
                    var roleName = "";
                    if (typeof (jquery('#role:checked').attr('title')) == "undefined") {
                        roleName = vue.roles[0].roleName;
                    } else {
                        roleName = jquery('#role:checked').attr('title');
                    }
                    localStorage.setItem('role', roleName);
                    // 当前登录用户角色
                    localStorage.setItem('userTable', data.role);
                    localStorage.setItem('sessionTable', data.role);
                    // 用户名称
                    localStorage.setItem('adminName', data.username);
                    http.request(data.role + '/session', 'get', {}, function (res) {
                        // 用户id
                        localStorage.setItem('userid', res.data.id);
                        if (res.data.vip) {
                            localStorage.setItem('vip', res.data.vip);
                        }
                        if (res.data.touxiang) {
                            localStorage.setItem('headportrait', res.data.touxiang);
                        } else if (res.data.headportrait) {
                            localStorage.setItem('headportrait', res.data.headportrait);
                        }
                        // 路径访问设置
                        window.location.href = '../../index.jsp';
                    })

                });
            }

            return false
        });

    });

    /**
     * 跳转登录
     * @param {Object} tablename
     */
    function registerClick(tablename) {
        window.location.href = '../' + tablename + '/register.jsp?tablename=' + tablename;
    }
</script>
</body>
</html>
