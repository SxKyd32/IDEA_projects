<template xmlns="http://www.w3.org/1999/html">
  <div>
    <div v-for="a in follow_info">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>{{a.follow.followCreatTime}}</span>
          <div style="float: right; padding: 3px 0">
            <el-popconfirm @confirm="del(a.follow.followId)" title="这是一段内容确定删除吗？">
              <i class="el-icon-delete" slot="reference"></i>
            </el-popconfirm>
          </div>
        </div>
        <div class="text item">
          {{a.fanName}}关注了你
        </div>
      </el-card>
      <el-divider><i class="el-icon-star-on"></i>新的关注</el-divider>
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
  name :'FollowTable',
  props:{follow:''},
  data() {
    return {
      follow_info: [],
      size:3,
      total:1,
      count: 1,
    }
  },
  mounted: function (){
    this.loadFollow()
    this.$emit('setTag','follow')
    this.$axios.get('/refresh_info/follow/'+this.$store.state.user.userId).then(res=>{
    })
  },
  methods: {
    loadFollow() {
      var _this = this
      this.$axios.get('/get_follow_num/'+this.$store.state.user.userId).then(res=>{
        _this.total=res.data
      })
      this.$axios.get('/get_follow/'+this.$store.state.user.userId+'/0/'+this.size).then(res=>{
        _this.follow_info=res.data
      })
    },
    del(c){
      this.$axios.get('/del_follow_info/'+c).then(this.loadFollow)
    },
    change(page){
      this.$axios.get('/get_follow/'+this.$store.state.user.userId+'/'+(page-1)+'/'+this.size).then(res=>{
        this.follow_info=res.data
      })
    }
  }
}
</script>