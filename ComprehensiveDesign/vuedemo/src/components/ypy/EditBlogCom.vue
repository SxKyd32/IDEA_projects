<template>
  <div class="grid-content bg-purple">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>编辑博客</span>
      </div>
      <div>
        <el-form label-width="80px" size="small" label-position="right">
          <el-form-item label="博客标题*" >
            <el-input auto-complete="off" v-model="newBlog.title"></el-input>
          </el-form-item>
          <el-form-item label="博客简介*" prop="phone">
            <el-input auto-complete="off" v-model="newBlog.description"></el-input>
          </el-form-item>
          <el-collapse style="margin-bottom: 20px">
            <el-collapse-item title="添加博客封面" style="font-size: 14px" name="1">
              <el-form-item label="封面地址" prop="phone">
                <el-input auto-complete="off" v-model="newBlog.cover"></el-input>
              </el-form-item>
              <el-upload
                  class="avatar-uploader"
                  action="http://localhost:8443/api/blog/covers"
                  :show-file-list="false"
                  :on-success="handleSuccess"
              >
                <img v-if="newBlog.cover" :src="newBlog.cover" class="avatar">
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
              </el-upload>
            </el-collapse-item>
          </el-collapse>
          <el-form-item label="博客内容*">
            <mavon-editor v-model="newBlog.content" ref=md @imgAdd="$imgAdd"></mavon-editor>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button size="mini" type="primary" @click="submit">提交</el-button>
          <el-button size="mini" type="warning" @click="toback">恢复</el-button>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "EditBlogCom",
  data(){
    return{
      oldBlog:{
      },
      newBlog:{
        blogCreateTime: "",
        blogId: 0,
        collectionNum: 0,
        commentNum: 0,
        content: "",
        description: "",
        likeNum: 0,
        status: 0,
        title: "",
        userId: 0
      }
    }
  },
  methods:{
    submit(){
      this.$axios.post('/blog/add',this.newBlog).then( (res)=>{
        this.$router.push({
          name:'UserHome'
        })
      })

    },
    toback(){
      this.newBlog = JSON.parse(JSON.stringify(this.oldBlog))
    },
    handleSuccess(response) {
      this.newBlog.cover = response
      this.$emit('onUpload')
      this.$message.warning('上传成功')
    },
    $imgAdd(pos, $file) {
      var formdata = new FormData();
      formdata.append('file', $file);
      this.$axios({
        url: 'http://localhost:8443/api/blog/covers',
        method: 'post',
        data: formdata,
        headers: {'Content-Type': 'multipart/form-data'},
      }).then((res) => {
        this.$refs.md.$img2Url(pos, res.data);
      })
    },
  },
  mounted() {
    this.$axios.get('/blog/blogid/'+this.$route.params.blogid).then( (res)=>{
      this.oldBlog = JSON.parse(JSON.stringify(res.data))
      this.newBlog = JSON.parse(JSON.stringify(res.data))
    })
  }

}
</script>

<style scoped>
.avatar-uploader {
  margin: 0 auto;
  width: 100px;
  height: 100px;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader:hover{
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
}
.avatar {
  width: 100px;
  height: 100px;
  display: block;
}
</style>