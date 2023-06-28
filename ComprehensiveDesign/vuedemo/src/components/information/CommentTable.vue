<template xmlns="http://www.w3.org/1999/html">
  <div>
    <div v-for="a in comment_info">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>{{a.comment.commentContent}}</span>
          <div style="float: right; padding: 3px 0">
            <el-popconfirm @confirm="del(a.comment.commentId)" title="这是一段内容确定删除吗？">
              <i class="el-icon-delete" slot="reference"></i>
            </el-popconfirm>
          </div>
        </div>
        <div class="text item">
          {{a.userName}}评论了你的博客《{{a.title}}》
        </div>
      </el-card>
      <el-divider><i class="el-icon-s-comment"></i>  {{a.comment.commentCreateTime}}</el-divider>
    </div>
    <div style="bottom: auto" class="block">
      <el-pagination
          :hide-on-single-page="true"
          @current-change="change"
          :current-page="count"
          layout="prev, pager, next"
          :total="total"
          :page-size="size">
      </el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  name :'CommentTable',
  props:{comment:''},
  data() {
    return {
      comment_info: [],
      size:3,
      total:1,
      count: 1,
    }
  },
  mounted: function (){
    this.$axios.get('/refresh_info/comment/'+this.$store.state.user.userId).then(res=>{
      console.log(res.data.code)
    })
    this.loadComment()
      this.$emit('setTag','comment')
  },
  methods: {
    loadComment() {
      var _this = this
      this.$axios.get('/get_comment_num/'+this.$store.state.user.userId).then(res=>{
        _this.total=res.data
      })
      this.$axios.get('/get_comment/'+this.$store.state.user.userId+'/0/'+this.size).then(res=>{
        _this.comment_info=res.data
      })
    },
    del(c){
      this.$axios.get('/del_comment_info/'+c).then(this.loadComment)
    },
    change(page){
      this.$axios.get('/get_comment/'+this.$store.state.user.userId+'/'+(page-1)+'/'+this.size).then(res=>{
        this.comment_info=res.data
      })
    }
  }
}
</script>