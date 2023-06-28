<template>
  <el-container>
    <el-aside style="width: 200px;margin-top: 20px">
      <switch></switch>
      <SideMenu @indexSelect="listByCategory" ref="sideMenu"></SideMenu>
    </el-aside>
    <el-main>
      <blogs class="blogs-area" ref="blogsArea"></blogs>
    </el-main>
  </el-container>
</template>

<script>
import SideMenu from "@/components/blog/SideMenu";
import Blogs from "@/components/blog/Blogs";

export default {
  name: "BlogIndex",
  components: {Blogs, SideMenu},
  methods: {
    listByCategory () {
      var _this = this
      var categoryId = this.$refs.sideMenu.categoryId
      var url = 'categories/' + categoryId + '/blogs'
      this.$axios.get(url).then(resp => {
        if (resp && resp.data.code === 200) {
          _this.$refs.blogsArea.blogs = resp.data.result
          _this.$refs.blogsArea.currentPage = 1
        }
      })
    }
  }
}
</script>

<style scoped>
/*.blogs-area {*/
/*  width: 990px;*/
/*  margin-left: auto;*/
/*  margin-right: auto;*/
/*}*/
</style>