<template>
  <div>
    <el-menu router :default-active=$route.path class="el-menu-vertical-demo" :collapse="false">
      <el-menu-item index="/information/broadcast">
        <el-badge is-dot :hidden="broadcast_tag" class="item"><i class="el-icon-data-board"></i></el-badge>
        <span slot="title">公告</span>
      </el-menu-item>
      <el-menu-item index="/information/comment" >
        <el-badge is-dot :hidden="comment_tag" class="item"><i class="el-icon-s-comment"></i></el-badge>
        <span slot="title">评论</span>
      </el-menu-item>
      <el-menu-item index="/information/follow">
        <el-badge is-dot :hidden="follow_tag" class="item"><i class="el-icon-bell"></i></el-badge>
        <span slot="title">关注</span>
      </el-menu-item>
      <el-menu-item index="/information/like">
        <el-badge is-dot :hidden="like_tag" class="item"><i class="el-icon-thumb"></i></el-badge>
        <span slot="title">点赞</span>
      </el-menu-item>
     <el-menu-item index="/message">
       <el-badge is-dot :hidden="message_tag" class="item"><i class="el-icon-message"></i></el-badge>
        <span slot="title">私信</span>
      </el-menu-item>
      <el-menu-item index="/information/set">
        <el-badge is-dot :hidden="true" class="item"><i class="el-icon-set-up"></i></el-badge>
        <span slot="title">设置</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>
<style>
.el-menu-vertical-demo{
  width: 50px;
  min-height: 600px;
}
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  min-height: 600px;
}
.item {
  margin-top: 10px;
  margin-right: 40px;
}
</style>

<script>
export default {
  name :'SideMenu',
  props:{
    comment:"",
    like:'',
    broadcast:'',
    follow:'',
    message:'',
    info:''
  },
  watch: {
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
  data() {
    return {
      broadcast_tag:this.broadcast,
      comment_tag:this.comment,
      follow_tag:this.follow,
      like_tag:this.like,
      message_tag:this.message,
      Collapse: true
    };
  },
  mounted() {
  },
  methods: {
  }
}
</script>