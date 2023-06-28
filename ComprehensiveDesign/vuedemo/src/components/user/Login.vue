<template>
  <body id="poster">

      <el-header style="z-index: 1;height: 80px;margin-left: -20px">
        <Header style="position: absolute;width: 98%;"></Header>
      </el-header>
  <el-form :model="loginForm" :rules="rules" class="login-container" label-position="left"
           label-width="0px">
    <h3 class="login_title">系统登录</h3>
    <el-form-item prop="userPhone">
      <el-input type="text" v-model="loginForm.userPhone"
                auto-complete="off" placeholder="账号"></el-input>
    </el-form-item>
    <el-form-item  prop="userPassword">
      <el-input type="password" v-model="loginForm.userPassword"
                auto-complete="off" placeholder="密码"></el-input>
    </el-form-item>
    <el-form-item style="width: 100%">
      <el-button type="primary" style="width: 100%;background: #505458;border: none" v-on:click="userlogin">登录</el-button>
    </el-form-item>
    <el-form-item style="width: 100%">
      <el-button type="primary" style="width: 100%;background: #505458;border: none" v-on:click="userregister">注册</el-button>
    </el-form-item>
  </el-form>
  </body>
</template>

<script>

export default {
  name: 'Login',
  data () {
    return {
      //登录表单
      loginForm: {
        userId:"",
        userPhone: '12312341278',
        userPassword: '666666',
        avatar:'',
        nickname:''
      },
      responseResult: [],
      //登录表单验证
      rules: {
        // 要以数组形式展示
        userPhone: [
          { required: true, message: "用户名不能为空", trigger: "change" },
          { min: 11, max: 11, message: "手机号长度应为11位", trigger: "blur" }
        ],
        userPassword: [
          { required: true, message: "密码不能为空", trigger: "blur" },
          { min: 6, max: 30, message: "密码长度在 6 到 30 个字符", trigger: "blur" }
        ]
      }
    }
  },
  methods: {
    userlogin () {
      var _this = this;
      // //控制台打印日志
      // console.log(this.$store.state)
      this.$axios
          .post('/login', {
            //注意与后端数据库字段统一!!
            userPhone: this.loginForm.userPhone,
            userPassword: this.loginForm.userPassword,
          })
          .then(successResponse => {
            if (successResponse.data.code === 200) {
              console.log(this.loginForm.userPhone)
              console.log(this.loginForm.userPassword)
              console.log("userId:"+successResponse.data.result.userId)
              //获取所登录用户的Id
              _this.userId = successResponse.data.result.userId
              this.loginForm.userId = _this.userId.toString()
              //获取所登录用户的头像
              _this.avatar = successResponse.data.result.avatar
              this.loginForm.avatar = _this.avatar
              //获取所登录用户的昵称
              _this.nickname = successResponse.data.result.nickname
              this.loginForm.nickname = _this.nickname


              console.log(this.loginForm.userId)
              console.log(this.loginForm.avatar)
              console.log(this.loginForm)
              // _this.$store.state.user.userId= _this.userId
              //提交登录信息状态
              _this.$store.commit('login', _this.loginForm)
              console.log(_this.$store.state)
              //重定向路径
              var path = this.$route.query.redirect
              //路径存在则跳转;路径不存在，则跳转到首页Index
              this.$router.replace({path: path === '/login' || path ===undefined? '/index' : path })
              console.log("登录成功！");
            }
            else{
              console.log("登录失败！");
            }
          })
          .catch(failResponse => {
            console.log(failResponse);
          })
    },
    userregister(){

      this.$router.replace('/userregister')
    }
  }
}
</script>
<style>
.login-container {
  border-radius: 15px;
  background-clip: padding-box;
  margin: 90px auto;
  width: 350px;
  padding: 35px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}

.login_title {
  margin: 0 auto 40px auto;
  text-align: center;
  color: #505458;
}
#poster {
  background: url("../../assets/login_bg.png") no-repeat center;
  height: 100%;
  width: 100%;
  background-size: cover;
  position: fixed;
}
body{
  margin: 0;
}

</style>


