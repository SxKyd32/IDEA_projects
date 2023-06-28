<template>
  <div class="register">
    <section class="form_container">
      <div class="manage_tip">
        <span class="title">欢迎注册个人博客系统</span>
      </div>
      <el-form :model="registerUser" :rules="rules" class="registerForm" ref="registerForm" label-width="80px">
        <el-form-item label="昵称" prop="nickname">
          <el-input v-model="registerUser.nickname" placeholder="请输入昵称"></el-input>
        </el-form-item>
        <el-form-item label="用户名" prop="userPhone">
          <el-input v-model="registerUser.userPhone" placeholder="请输入电话号"></el-input>
        </el-form-item>
        <el-form-item label="用户密码" prop="userPassword">
          <el-input v-model="registerUser.userPassword" placeholder="请输入密码" type="password"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="userPassword2">
          <el-input v-model="registerUser.userPassword2" placeholder="请确认密码" type="password"></el-input>
        </el-form-item>
        <el-form-item label="用户邮箱" prop="userEmail">
          <el-input v-model="registerUser.userEmail" placeholder="请输入邮箱"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary"  class="submit_btn" @click="submitForm('registerForm')">注 册</el-button>
        </el-form-item>
      </el-form>
    </section>
  </div>
</template>

<script>
export default {
  name: "register",
  data() {
    //    判断密码是否一致；
    var validatePass2 = (rule, value, callback) => {
      if (value !== this.registerUser.userPassword) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    }
    return {
      registerUser: {
        userId: '',
        userPhone: '123234563456',
        userPassword: '12345test',
        status: '1',
        nickname: 'test',
        userEmail: 'test@test.com',
        avatar: "1",
        userCreateTime:""
      },
      rules: {
        // 要以数组形式展示
        userPhone: [
          { required: true, message: "用户名不能为空", trigger: "change" },
          { min: 11, max: 11, message: "手机号长度应为11位", trigger: "blur" }
        ],
        userEmail: [
          {
            type: "email",
            required: true,
            message: "邮箱格式不正确",
            trigger: "blur"
          }
        ],
        nickname: [
          { required: true, message: "用户昵称不能为空", trigger: "change" },
          { min: 2, max: 10, message: "长度在 2 到 30 个字符", trigger: "blur" }
        ],
        userPassword: [
          { required: true, message: "密码不能为空", trigger: "blur" },
          { min: 6, max: 30, message: "长度在 6 到 30 个字符", trigger: "blur" }
        ],
        userPassword2: [
          { required: true, message: "确认密码不能为空", trigger: "blur" },
          {
            min: 6,
            max: 30,
            message: "长度在 6 到 30 个字符",
            trigger: "blur"
          },
            //验证两次输入密码是否一致
          { validator: validatePass2, trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$axios
              .get('/searchuser/', { // 前端发送get请求
              })
              .then(response1 => {
                // _this.total = response.total;
                this.registerUser.userId = response1.data.result.length
                // this.changePage(current)//更新当前页码的数据
                console.log(response1.data.result.length) // 控制台打印响应的数据
                //获取当前时间
                var timestamp = new Date( +new Date() )
                console.log("时间:")
                console.log(timestamp); //1495302061441
                this.$axios
                    .post('/userregister', {
                      // userId: this.registerUser.userId + 1,
                      userPhone: this.registerUser.userPhone,
                      userPassword: this.registerUser.userPassword,
                      nickname: this.registerUser.nickname,
                      status: this.registerUser.status,
                      userEmail: this.registerUser.userEmail,
                      avatar: this.registerUser.avatar,
                      userCreateTime:timestamp
                    })
                    .then(function (response2) {
                      alert(JSON.stringify(response2.data))
                    })
                    .catch(error => {
                      console.log(error)
                      alert("用户手机号已被注册!")
                    })
              })
              // 错误处理
              .catch(error => {
                console.log(error)
                console.log('STH WRONG WITH IT LIUBO')
              })
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    }
  }
};
</script>
<style>

</style>