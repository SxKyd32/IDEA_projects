<template>
  <div class="articles-area">
    <el-card style="text-align: left;width: 990px;margin: 35px auto 0 auto">
      <div>
        <span style="font-size: 20px"><strong>{{article.title}}</strong></span>
        <el-divider content-position="left">{{article.blogCreateTime}}</el-divider>
        <div class="markdown-body">
          <div v-html="article.htmlContent"></div>
        </div>
      </div>

      <!--点赞模块-->
      <icon-svg
          v-if="isLiked === '0'"
          @click.native="addLikes(article.blogId)" icon-class="dianzan" />
      <icon-svg
          v-if="isLiked === '1'"
          @click.native="addLikes(article.blogId)" icon-class="dianzan-red" />
      <!--点赞模块-->
      <icon-svg
          v-if="isCollection === '0'"
          @click.native="addCollections(article.blogId)" icon-class="star" />
      <icon-svg
          v-if="isCollection === '1'"
          @click.native="addCollections(article.blogId)" icon-class="star-red" />
    </el-card>

    <el-card>
      <!--评论模块-->
      <comments><</comments>
    </el-card>

  </div>
</template>

<script>
  import "@/assets/iconfont.js"
  import Comments from "@/components/blog/Comments";
  export default {
    name: 'ArticleDetails',
    components: {Comments},
    data () {
      return {
        //isLiked 用于判断用户是否已点赞 1:已点赞 0:未点赞
        isLiked:'0',
        //isCollection 用于判断用户是否已收藏 1:已收藏 0:未收藏
        isCollection:'0',
        article: []
      }
    },
    mounted () {
      //打开页面时加载文章
      this.loadArticle()
      //根据用户点赞数据动态改变点赞按钮颜色
      this.checkLikes(this.$route.query.blogId)
      //根据用户收藏数据动态改变收藏按钮颜色
      this.checkCollections(this.$route.query.blogId)
    },
    methods: {
      //搜索文章
      loadArticle () {
        var _this = this
        this.$axios.get('/blog/' + this.$route.query.blogId).then(resp => {
          if (resp && resp.data.code === 200) {
            _this.article = resp.data.result
            console.log( _this.article)
          }
        })
      },
      //用户点赞
      addLikes (blogId) {
        this.$axios
            //搜索用户-点赞数据表
            .get('/searchuserlikes/', { // 前端发送get请求
            })
            .then(response1 => {
              var _this =this;
              console.log(response1.data.length)
              //用户之前未点赞
              var count = response1.data.length
              //获取当前时间
              var timestamp = new Date( +new Date() )
              console.log("时间:")
              console.log(timestamp); //1495302061441
              console.log(_this.$store.state)
              this.$axios.post('/likeblog/'+ blogId, {
                // likeId:'0',
                blogId:blogId,
                userId:_this.$store.state.user.userId,
                likeCreateTime:timestamp,
                status:0
              }).then(resp => {
                if (resp && resp.data.result === "取消点赞") {
                  // console.log(this.$refs.test.iconClass)
                  console.log("取消点赞！")
                  this.isLiked = '0'
                }
                else{
                  this.isLiked = '1'
                  console.log(resp.data)
                  console.log("成功点赞！")
                  this.$axios.get('/sendOneWebSocket/'+blogId+'/like')
                }
              }).catch(failResponse => {
                console.log(failResponse);
              })
            })
            // 错误处理
            .catch(error => {
              console.log(error)
              console.log('STH WRONG WITH IT LIUBO')
            })
      },
      //检测用户是否点赞，动态改变点赞按钮颜色
      checkLikes (blogId) {
        this.$axios
            //搜索用户-点赞数据表
            .get('/searchuserlikes/', { // 前端发送get请求
            })
            .then(response1 => {
              this.$axios.get('/checklikeblog/'+ blogId, {
              }).then(resp => {
                if (resp && resp.data.result === "已点赞") {
                  console.log("已点赞！")
                  this.isLiked = '1'
                }
                else{
                  console.log("未点赞！")
                  this.isLiked = '0'
                  console.log(resp.data)
                }
              }).catch(failResponse => {
                console.log(failResponse);
              })
            })
            // 错误处理
            .catch(error => {
              console.log(error)
              console.log('STH WRONG WITH IT LIUBO')
            })
      },


      //用户收藏
      addCollections (blogId) {
        this.$axios
            //搜索用户-收藏数据表
            .get('/searchusercollections/', { // 前端发送get请求
            })
            .then(response1 => {
              var _this =this;
              console.log(response1.data.length)
              //用户之前未收藏
              var count = response1.data.length
              //获取当前时间
              var timestamp = new Date( +new Date() )
              console.log("时间:")
              console.log(timestamp); //1495302061441
              console.log(_this.$store.state)
              this.$axios.post('/collectionblog/'+ blogId, {
                // collectionId:'0',
                blogId:blogId,
                userId:_this.$store.state.user.userId,
                collectionCreateTime:timestamp,
                //status 0:表示未读
                status:0
              }).then(resp => {
                if (resp && resp.data.result === "取消收藏") {
                  // console.log(this.$refs.test.iconClass)
                  console.log("取消收藏！")
                  this.isCollection = '0'
                }
                else{
                  this.isCollection = '1'
                  console.log(resp.data)
                  console.log("成功收藏！")
                }
              }).catch(failResponse => {
                console.log(failResponse);
              })
            })
            // 错误处理
            .catch(error => {
              console.log(error)
              console.log('STH WRONG WITH IT LIUBO')
            })
      },
      //检测用户是否收藏，动态改变收藏按钮颜色
      checkCollections (blogId) {
        this.$axios
            //搜索用户-收藏数据表
            .get('/searchusercollections/', { // 前端发送get请求
            })
            .then(response1 => {
              this.$axios.get('/checkcollectionblog/'+ blogId, {
              }).then(resp => {
                if (resp && resp.data.result === "已收藏") {
                  console.log("已收藏！")
                  this.isCollection = '1'
                }
                else{
                  console.log("未收藏！")
                  this.isCollection = '0'
                  console.log(resp.data)
                }
              }).catch(failResponse => {
                console.log(failResponse);
              })
            })
            // 错误处理
            .catch(error => {
              console.log(error)
              console.log('STH WRONG WITH IT LIUBO')
            })
      }

    }
  }
</script>

<style scoped>
  @import "../../styles/markdown.css";
</style>
