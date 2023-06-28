<template>
  <div>
<!--    <el-row style="height: 840px;">-->
<!--      <search-bar @onSearch="searchResult" ref="searchBar"></search-bar>-->
<!--    </el-row>-->
    <div style="margin-top: 40px">
      <!--<el-button @click="addArticle()">添加文章</el-button>-->
      <div class="blogs-area">
        <el-card style="text-align: left">
          <div v-for="article in blogs" :key="article.blogId">
            <div style="float:left;width:85%;height: 150px;">
              <router-link class="article-link" :to="{path:'blog/article'
              ,query:{blogId: article.blogId}}">
                <span style="font-size: 20px"><strong>{{article.title}}</strong></span>
              </router-link>
              <el-divider content-position="left">
                {{article.blogCreateTime}}
              </el-divider>
              <router-link class="article-link" :to="{path:'blog/article'
              ,query:{blogId: article.blogId}}">
                <p>{{article.description}}</p>
              </router-link>
              <el-divider content-position="right">
                <i class="el-icon-caret-top"></i>
                {{article.likeNum}}
                <i class="el-icon-star-on"></i>
                {{article.collectionNum}}
              </el-divider>
            </div>
<!--            文章封面-->
            <el-image
                style="margin:18px 0 0 30px;width:100px;height: 100px"
                :src="article.articleCover"
                fit="cover">
            </el-image>
            <el-divider>
            </el-divider>
          </div>
        </el-card>
      </div>
<!--      分页-->
      <el-pagination
          background
          layout="total, prev, pager, next, jumper"
          @current-change="handleCurrentChange"
          :page-size="pageSize"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<!--引入阿里图标库 https://www.iconfont.cn/collections/detail?cid=614-->

<script>
import SearchBar from './SearchBar'
export default {
  name: 'Blogs',
  components: {SearchBar},
  data () {
    return {
      //isLiked 用于判断用户是否已点赞 1:已点赞 0:未点赞
      isLiked:'0',
      blogs: [],
      pageSize: 4,
      total: 0
    }
  },
  mounted () {
    this.loadArticles()
  },
  methods: {
    loadArticles () {
      var _this = this
      this.$axios.get('/blog/' + this.pageSize + '/1').then(resp => {
        if (resp && resp.data.code === 200) {
          console.log("succ")
          _this.blogs = resp.data.result.content
          _this.total = resp.data.result.totalElements
          console.log(_this.blogs[0])
        }
      })
    },
    handleCurrentChange (page) {
      var _this = this
      this.$axios.get('/blog/' + this.pageSize + '/' + page).then(resp => {
        if (resp && resp.data.code === 200) {
          _this.blogs = resp.data.result.content
          _this.total = resp.data.result.totalElements
        }
      }).catch(failResponse => {
        console.log(failResponse);
      })
    }
  }
}
</script>



<style scoped>
.blogs-area {
  width: 990px;
  height: 750px;
  margin-left: auto;
  margin-right: auto;
}

.article-link {
  text-decoration: none;
  color: #606266;
}

.article-link:hover {
  color: #409EFF;
}

.active {
  color: #fff;
  border-bottom: 1px solid red;
}
</style>

