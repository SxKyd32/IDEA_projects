<template>
  <div>

    <div class="grid-content bg-purple" style="margin-top: 30px">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>我的博客</span>
        </div>
        <div>
          <!--              <el-table :data="myBlogs">-->
          <!--                <el-table-column prop="title"></el-table-column>-->
          <!--              </el-table>-->
          <el-card v-for="(blog, index) in myBlogs" :key="index" style="margin-bottom: 15px">
            <div slot="header">
              <span style="font-weight: bold; float: left">{{ blog.title }}</span>
              <span style="color: #cac6c6">{{ blog.blogCreateTime }}</span>
              <el-row style="float: right">
                <el-button style="padding: 5px 10px" type="primary" @click="toEdit(blog.blogId)">编辑</el-button>
                <el-button style="padding: 5px 10px; " type="danger" @click="mydelete(blog.blogId)">删除</el-button>
              </el-row>
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

      myBlogs: [
        {
          blogCreateTime: "2021-06-21T01:41:39.000+0000",
          blogId: 1,
          collectionNum: 0,
          commentNum: 0,
          content: "Vue (读音 /vjuː/，类似于 view) 是一套用于构建用户界面的渐进式JavaScript框架。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用（SPA）提供驱动。",
          description: "Vue.js是一套构建用户界面的渐进式框架。",
          likeNum: 0,
          status: 0,
          title: "Vue简介",
          userId: 1
        }
      ],


    }
  },
  methods:{
    mydelete(blogid){
      this.$axios.post("/blog/del/"+blogid).then((res)=>{
            this.$axios.get("/blog/userid/1").then((res)=>{
                  this.myBlogs = res.data
                  for (var i=0;i<this.myBlogs.length; i++){
                    this.myBlogs[i].blogCreateTime = this.$moment(this.myBlogs[i].blogCreateTime).format('YYYY-MM-DD HH:mm:ss')
                  }
                }
            )
          }
      )
    },
    toEdit(blogid){
      this.$router.push({
        name:'EditBlog',
        params:{blogid:blogid}
      })
    }
  },
  mounted(){
    var that = this
    this.$axios.get("/blog/userid/1").then(
        function (res){
          that.myBlogs = res.data
          for (var i=0;i<that.myBlogs.length; i++){
            that.myBlogs[i].blogCreateTime = that.$moment(that.myBlogs[i].blogCreateTime).format('YYYY-MM-DD HH:mm:ss')
          }
        }
    )
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