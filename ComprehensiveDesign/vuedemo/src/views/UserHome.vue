<template>
  <div class="home">
    <el-row :gutter="20" style="margin-top:10px;">
      <el-col :span="6">
        <LeftBar style="margin-bottom: 50px"></LeftBar>
        <FollowBar></FollowBar>
      </el-col>
      <el-col :span="18">
        <TopBar></TopBar>
        <Content></Content>
      </el-col>
    </el-row>

  </div>
</template>

<script>
import Content from "@/components/ypy/Content";
import LeftBar from "@/components/ypy/LeftBar";
import TopBar from "@/components/ypy/TopBar";
import FollowBar from "../components/ypy/FollowBar";

export default {
  name: 'Home',
  components:{
    FollowBar,
    TopBar,
    Content,
    LeftBar,
  },

}
</script>
