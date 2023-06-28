<template>
  <div>

    <div class="grid-content bg-purple" style="margin-top: 30px">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span style="float: left;font-size: 30px">{{starInfo.nickname}}的博客</span>
          <div style="float: right">
            <el-button type="" @click="toBack">回到主页</el-button>
            <el-button type="warning" @click="unfollow" v-if="isFollow">已关注</el-button>
            <el-button type="warning" @click="follow" v-else>关注博主</el-button>

          </div>
        </div>
        <div>
          <el-card v-for="(blog, index) in starBlogs" :key="index" style="margin-bottom: 15px">
            <div slot="header">
              <span style="font-weight: bold; float: left">{{ blog.title }}</span>
              <span style="color: #cac6c6">{{ blog.blogCreateTime }}</span>
            </div>
            <div style="text-align:left">
              {{ blog.description }}
            </div>
          </el-card>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      starId:0,
      isFollow:true,
      starInfo:{},
      starBlogs: [],
      fanId:0,


    }
  },
  methods:{
    toBack() {
      this.$router.push({name:"Home"})
    },
    follow(){
      this.isFollow = true
      this.$axios.get("/follow/addfollow/"+this.fanId+"/"+this.starId).then((res)=>{
        this.$axios.get('/sendOneWebSocket/'+blogId+'/follow')
        this.$message.warning('成功关注')
      })
    },
    unfollow(){
      this.isFollow = false
      this.$axios.get("/follow/delfollow/"+this.fanId+"/"+this.starId).then((res)=>{
        this.$message.warning('成功取消关注')
      })
    },

  },
  mounted(){
    //设置访问对象id
    this.starId = this.$route.params.starid
    if(this.starId == null){
      this.$router.push({
        name:"UserHome"
      })
    }else{
      //获取访问对象所有博客信息
      this.$axios.get("/blog/userid/"+this.starId).then((res)=>{
            this.starBlogs = res.data
            for (var i=0;i<this.starBlogs.length; i++){
              this.starBlogs[i].blogCreateTime = this.$moment(this.starBlogs[i].blogCreateTime).format('YYYY-MM-DD HH:mm:ss')
            }
          }
      )
      //获取访问对象个人信息
      this.$axios.get("/user/"+this.starId).then((res)=> {
            this.starInfo = res.data
            this.starInfo.userCreateTime = this.$moment(this.starInfo.userCreateTime).format('YYYY-MM-DD HH:mm:ss')
          }
      )
      //获取当前登录用户id
      this.fanId = 1
      //查看是否关注
      this.$axios.get("/follow/isfollow/"+this.fanId+"/"+this.starId).then((res)=>{
        this.isFollow = res.data
      })
    }

  },
}
</script>

<style scoped>

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both
}

.box-card {
  width: 100%;
}

.name-role {
  font-size: 16px;
  padding: 5px;
  text-align: center;
}

.sender {
  text-align: center;
}

.registe-info {
  text-align: center;
  padding-top: 10px;
}

.personal-relation {
  font-size: 16px;
  padding: 0 5px 15px;
  margin-right: 1px;
  width: 100%
}

.relation-item {
  padding: 12px;
}

.bg-purple {
  background: #d3dce6;
}

.grid-content {
  border-radius: 4px;
  min-height: 36px;
}

</style>