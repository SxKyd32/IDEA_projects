<template>
  <div class="home">
    <el-row :gutter="20" style="margin-top:10px;">
      <el-col :span="6">
        <LeftBar style="margin-bottom: 50px"></LeftBar>
        <FollowBar></FollowBar>
      </el-col>
      <el-col :span="18">
        <TopBar></TopBar>
        <EditBlogCom></EditBlogCom>
      </el-col>
    </el-row>

  </div>
</template>

<script>
import TopBar from "../components/ypy/TopBar";
import Content from "../components/ypy/Content";
import LeftBar from "../components/ypy/LeftBar";
import EditBlogCom from "../components/ypy/EditBlogCom";
import FollowBar from "../components/ypy/FollowBar";

export default {
  name: "EditBlog",
  components:{
    EditBlogCom,
    TopBar,
    Content,
    LeftBar,
    FollowBar
  },
}
</script>

<style scoped>

</style>