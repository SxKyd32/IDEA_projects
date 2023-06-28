<template xmlns="http://www.w3.org/1999/html">
  <div>
    <div v-for="a in broadcast_info">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>{{a.broadcast.broadcastContent}}</span>
          <div style="float: right; padding: 3px 0">
            <el-popconfirm @confirm="del(a.id)" title="这是一段内容确定删除吗？">
              <i class="el-icon-delete" slot="reference"></i>
            </el-popconfirm>
          </div>
        </div>
      </el-card>
      <el-divider><i class="el-icon-data-board"></i>  {{a.broadcast.broadcastCreateTime}}</el-divider>
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
  name :'BoadcastTable',
  props:{broadcast:''},
  data() {
    return {
      broadcast_info: [],
      size:3,
      total:1,
      count: 1,
    }
  },
  mounted: function (){
    this.$axios.get('/refresh_info/broadcast/'+this.$store.state.user.userId).then(res=>{
    })
    this.loadBroadcast()
    this.$emit('setTag','broadcast')
  },
  methods: {
    loadBroadcast() {
      var _this = this
      this.$axios.get('/get_broadcast_num/'+this.$store.state.user.userId).then(res=>{
        _this.total=res.data
      })
      this.$axios.get('/get_broadcast/'+this.$store.state.user.userId+'/0/'+this.size).then(res=>{         // 1要改成动态获取的userId
        _this.broadcast_info=res.data
      })
    },
    del(c){
      this.$axios.get('/del_broadcast_info/'+c).then(this.loadBroadcast)
      console.log("ok")
    },
    change(page){
      this.$axios.get('/get_broadcast/'+this.$store.state.user.userId+'/'+(page-1)+'/'+this.size).then(res=>{
        this.broadcast_info=res.data
      })
    }
  }
}
</script>