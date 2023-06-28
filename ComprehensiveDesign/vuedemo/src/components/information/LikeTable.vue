<<template xmlns="http://www.w3.org/1999/html">
  <div>
    <div v-for="a in like_info">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>{{a.likes.likeCreateTime}}</span>
          <div style="float: right; padding: 3px 0">
            <el-popconfirm @confirm="del(a.likes.likeId)" title="这是一段内容确定删除吗？">
              <i class="el-icon-delete" slot="reference"></i>
            </el-popconfirm>
          </div>
        </div>
        <div class="text item">
          {{a.fanName}}点赞了你的博客《{{a.title}}》
        </div>
      </el-card>
      <el-divider><i class="el-icon-thumb">新的点赞</i></el-divider>
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
  name :'LikeTable',
  props:{like:''},
  data() {
    return {
      like_info: [],
      size:3,
      total:1,
      count: 1,
    }
  },
  mounted: function (){
    this.$axios.get('/refresh_info/like/'+this.$store.state.user.userId).then(res=>{
    })
    this.loadLike()
    this.$emit('setTag','like')
  },
  methods: {
    loadLike() {
      var _this = this
      this.$axios.get('/get_like_num/'+this.$store.state.user.userId).then(res=>{
        _this.total=res.data
      })
      this.$axios.get('/get_like/'+this.$store.state.user.userId+'/0/'+this.size).then(res=>{
        _this.like_info=res.data
      })
    },
    del(c){
      this.$axios.get('/del_like_info/'+c).then(this.loadLike)
    },
    change(page){
      this.$axios.get('/get_like/'+this.$store.state.user.userId+'/'+(page-1)+'/'+this.size).then(res=>{
        this.like_info=res.data
      })
    }
  }
}
</script>