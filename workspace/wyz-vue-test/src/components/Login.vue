<template>
  <div id="building">
  <div>
    <el-card class="box-card" style="width:480px;margin:auto;">
      <el-input type="text" v-model="username" placeholder="请输入用户名"/>
      <br><br>
      <el-input type="password" v-model="password" placeholder="请输入密码"/>
      <br><br>
      <el-button v-on:click="login">登录</el-button>
    </el-card>
  </div>
  </div>
</template>

<script>

export default {
  name: 'Login',
  data () {
    return {
        username: '',
        password: '',
      responseResult: []
    }
  },
  methods: {
    login () {
      this.$axios
          .get('/login/'+this.username+'/'+this.password, {
          })
          .then(successResponse => {
            if (successResponse.data === 200) {
              this.$router.replace({path: '/index'})
            }
          })
          // eslint-disable-next-line no-unused-vars
          .catch(failResponse => {
            //console.log(failResponse);
          })
    }
  }
}
</script>
<style>
#building {
  background: url("../assets/login_bg.jpg");
  width: 100%;
  height: 100%;
  position: fixed;
  background-size: 100% 100%;
}
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

.box-card {
  width: 480px;
}
</style>