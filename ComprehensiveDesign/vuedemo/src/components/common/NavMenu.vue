<template>
  <el-menu
      :default-active="'/index'"
      router
      mode="horizontal"
      background-color="white"
      text-color="#222"
      style="min-width: 1300px">
    <el-menu-item v-for="(item,i) in navList" :key="i" :index="item.name">
      {{ item.navItem }}
    </el-menu-item>
    <!--   <el-header style="z-index: 1;height: 80px;margin-left: -20px">-->
    <!--     <Header style="position: absolute;width: 98%;"></Header>-->
    <!--   </el-header>-->
    <el-menu-item style="width: 800px" >
      <el-input
          placeholder="请输入搜索内容"
          prefix-icon="el-icon-search"
          clearable
          style="position: center; width: 500px;"
          v-model="search"
          @click.native="handleSearch">
      </el-input>
    </el-menu-item>
    <el-submenu index="2" >
      <template slot="title">
        <el-avatar :src="avatar" />
      </template>
      <el-menu-item index="">个人中心</el-menu-item>
<!--      <el-menu-item index="2-2">选项2</el-menu-item>-->
<!--      <el-menu-item index="2-3">选项3</el-menu-item>-->
      <el-submenu index="2-4">
        <template slot="title" >消息中心</template>
        <el-menu-item index="/information/broadcast"><el-badge is-dot :hidden="broadcast_tag" class="item">公告</el-badge></el-menu-item>
        <el-menu-item index="/information/comment"><el-badge is-dot :hidden="comment_tag" class="item">评论</el-badge></el-menu-item>
        <el-menu-item index="/information/follow"><el-badge is-dot :hidden="follow_tag" class="item">关注</el-badge></el-menu-item>
        <el-menu-item index="/information/like"><el-badge is-dot :hidden="like_tag" class="item">点赞</el-badge></el-menu-item>
        <el-menu-item index="/message"><el-badge is-dot :hidden="message_tag" class="item">私信</el-badge></el-menu-item>
        <el-menu-item index="/information/set"><el-badge is-dot :hidden="true" class="item">设置</el-badge></el-menu-item>
      </el-submenu>
      <el-menu-item index="2-2" @click="userlogout" >退出登录</el-menu-item>
    </el-submenu>
  </el-menu>
</template>

<script>



export default {
  props:{
    comment:"",
    like:'',
    broadcast:'',
    follow:'',
    message:'',
    info:''
  },
  name: 'NavMenu',
  //监听器
  watch: {
    avatar: function (val) {
      this.avatar=val
    },
    comment: function (val) {
      this.comment_tag = val
    },
    follow: function (val) {
      this.follow_tag = val
    },
    broadcast: function (val) {
      this.broadcast_tag = val
    },
    like: function (val) {
      this.like_tag = val
    },
    message:function (val) {
      this.message_tag = val
    }
  },
  data () {
    return {
      info_tag:true,
      count:0,
      broadcast_tag:this.broadcast,
      comment_tag:this.comment,
      follow_tag:this.follow,
      like_tag:this.like,
      message_tag:this.message,
      navList: [
        {name: '/index', navItem: '首页'},
        {name: '/blog', navItem: '博客'},
        {name: '/userhome', navItem: '个人中心'}
      ],
      search:"",
      avatar:this.$store.state.user.avatar
    }
  },
  methods: {
    //用户登出
    userlogout () {
      console.log(this.$store.state.user) // 控制台打印日志
      window.localStorage.clear() // 清除所有缓存
      this.$router.replace({ path: '/login' })
    },
    //搜索博文
    handleSearch () {
      let search = this.search
      // let orderKey = this.key
      // let orderByValue = this.order
      let _this = this
      // console.log(this.$store.state) //控制台打印日志
      if (search === '') {
        console.log('search all !')
        console.log('length:' + this.data.length) // 获取长度
        // console.log(JSON.parse(JSON.stringify(row))) //JSON.stringify解决显示[object,object]的问题
        // console.log("index:"+index)
      } else {
        console.log('search one !')
      }
      this.$axios
          .get('/searchblog/' + search, { // 前端发送post请求？
          })
          .then(response => {
            _this.data = response.data // 传递后端数据到前端
            JSON.stringify(response.data)
            loadArticles()
            // this.changePage(current)//更新当前页码的数据
            console.log(response) // 控制台打印响应的数据
          })
          // 错误处理
          .catch(error => {
            console.log(error)
            console.log('STH WRONG WITH IT LIUBO')
          })
    },
  }
}
</script>

<style scoped>
.item {
  margin-top: 10px;
  margin-right: 40px;
}
</style>
