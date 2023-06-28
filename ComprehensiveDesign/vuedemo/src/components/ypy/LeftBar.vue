<template>

  <div class="grid-content bg-purple" v-if="status === 'common'">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>个人中心</span>
      </div>
      <div>
        <el-image :src="myInfo.avatar"
                  style="width: 100px;height: 100px; border-radius: 50%;margin-bottom: 20px"
                  @click="toAvatar"></el-image>
      </div>
      <span style="color:#222226;font-size:22px;font-weight:500;line-height:24px;">{{ myInfo.nickname }}</span>
      <el-divider></el-divider>
      <div class="personal-relation">
        <div class="relation-title">手机号:</div>
        <div class="relation-item">{{ myInfo.userPhone }}</div>
      </div>
      <div class="personal-relation">
        <div class="relation-item">Email:</div>
        <div class="relation-item">{{ myInfo.userEmail }}</div>
      </div>
      <div class="personal-relation">
        <div class="relation-item">创建时间:</div>
        <div class="relation-item">{{ myCreateDate }}</div>
      </div>
      <el-divider></el-divider>
      <el-button type="danger" @click="toPwd">修改密码</el-button>
      <el-button type="" @click="toInfo">修改信息</el-button>
    </el-card>
  </div>
  <div v-else-if="status === 'cInfo'">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>修改信息</span>
      </div>

      <div class="personal-relation" style="margin-bottom: 25px" >
        手机号:
        <el-input v-model="myInfo.userPhone"></el-input>
      </div>
      <div class="personal-relation" style="margin-bottom: 25px">
        Email:
        <el-input v-model="myInfo.userEmail"></el-input>
      </div>
      <div class="personal-relation" style="margin-bottom: 25px">
        昵称:
        <el-input v-model="myInfo.nickname"></el-input>
      </div>
      <el-divider></el-divider>
      <el-button type="primary" @click="saveInfo">保存</el-button>
      <el-button @click="toCommon">取消</el-button>
    </el-card>
  </div>
  <div v-else-if="status === 'cPwd'">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>修改密码</span>
      </div>
      <div class="personal-relation" style="margin-bottom: 25px">
        原密码:
        <el-input v-model="pwd.oldp"></el-input>
      </div>
      <div class="personal-relation" style="margin-bottom: 25px">
        新密码:
        <el-input v-model="pwd.newp"></el-input>
      </div>
      <div class="personal-relation" style="margin-bottom: 25px">
        确认新密码:
        <el-input v-model="pwd.newp2"></el-input>
      </div>
      <el-divider></el-divider>
      <el-button type="primary" @click="savePwd">提交</el-button>
      <el-button @click="toCommon">取消</el-button>

    </el-card>
  </div>
  <div v-else-if="status === 'cAvatar'">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>修改头像</span>
      </div>

      <el-upload
          class="avatar-uploader"
          action="http://localhost:8443/api/blog/covers"
          :show-file-list="false"
          :on-success="handleSuccess"
          >
        <img v-if="myInfo.avatar" :src="myInfo.avatar" class="avatar">
        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
      </el-upload>
      <el-divider></el-divider>
      <el-button type="primary" @click="saveInfo">保存</el-button>
      <el-button @click="toCommon">取消</el-button>
    </el-card>
  </div>

</template>

<script>
export default {
  name: "LeftBar",
  data() {
    return {
      status: 'common',
      myInfo: {
        avatar: "",
        nickname: "",
        status: 0,
        userCreateTime: "",
        userEmail: "",
        userId: 0,
        userPassword: "",
        userPhone: "",
      },
      myCreateDate: "",
      pwd: {
        oldp: "",
        newp: "",
        newp2: "",
      },

    }
  },
  methods: {
    saveInfo() {
      this.$axios.post("/user/save", this.myInfo).then((res) => {
        //更新状态信息
        let loginForm = {
          userId:this.myInfo.userId,
              userPhone: this.myInfo.userPhone,
              userPassword: this.myInfo.userPassword,
              avatar:this.myInfo.avatar,
              nickname:this.myInfo.nickname
        }
        this.$store.commit('login', loginForm)
        this.toCommon()
      })
    },
    toCommon() {
      this.status = 'common'
    },
    toPwd() {
      this.status = 'cPwd'
    },
    toAvatar(){
      this.status = 'cAvatar'
    },
    toInfo() {
      this.status = 'cInfo'
    },
    savePwd() {
      if (this.pwd.oldp === this.myInfo.userPassword && this.pwd.newp === this.pwd.newp2) {
        this.myInfo.userPassword = this.pwd.newp
        this.saveInfo()
      }
    },
    handleSuccess (response) {
      this.myInfo.avatar = response
      this.$emit('onUpload')
      this.$message.warning('上传成功')
    },
  },
  mounted() {
    this.$axios.get("/user/1").then((res) => {
          this.myInfo = res.data
          this.myCreateDate = this.$moment(this.myInfo.userCreateTime).format('YYYY-MM-DD HH:mm:ss')
        }
    )
  }
}
</script>

<style scoped>
.personal-relation{
  display: flex;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>