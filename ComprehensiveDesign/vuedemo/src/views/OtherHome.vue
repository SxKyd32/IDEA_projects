<template>
  <div class="home">
    <el-row :gutter="20" style="margin-top:10px;">
      <el-col :span="6">
        <LeftBar style="margin-bottom: 50px"></LeftBar>
        <FollowBar></FollowBar>
      </el-col>
      <el-col :span="18">
        <TopBar></TopBar>
        <OtherContent></OtherContent>
      </el-col>
    </el-row>

  </div>
</template>

<script>
import LeftBar from "@/components/ypy/LeftBar";
import TopBar from "@/components/ypy/TopBar";
import FollowBar from "../components/ypy/FollowBar";
import OtherContent from "../components/ypy/OtherContent";

export default {
  name: 'OtherHome',
  components:{
    FollowBar,
    TopBar,
    LeftBar,
    OtherContent,
  },

}
</script>