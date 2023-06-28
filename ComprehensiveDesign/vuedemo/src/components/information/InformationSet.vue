<template>
  <div>
    <el-card style="text-align: left">
      <div slot="header" class="clearfix">
        <span>消息提醒设置</span>
        <el-switch style="float:right; padding: 3px 0" @change="tag('all')" v-model="all" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
      </div>
      <div v-show="all">
        <div class="text item">
          <el-card style="text-align: left">
            <div slot="header" class="clearfix">
              <span>公告消息提醒设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('broadcast')" v-model="broadcast" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
            <div v-show="broadcast" class="clearfix">
              <span>消息弹窗设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('broadcast_w')" v-model="broadcast_w" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
          </el-card>
        </div>
        <div class="text item">
          <el-card style="text-align: left">
            <div slot="header" class="clearfix">
              <span>评论消息提醒设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('comment')" v-model="comment" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
            <div v-show="comment" class="clearfix">
              <span>消息弹窗设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('comment_w')" v-model="comment_w" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
          </el-card>
        </div>
        <div class="text item">
          <el-card style="text-align: left">
            <div slot="header" class="clearfix">
              <span>关注消息提醒设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('follow')" v-model="follow" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
            <div v-show="follow" class="clearfix">
              <span>消息弹窗设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('follow_w')" v-model="follow_w" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
          </el-card>
        </div>
        <div class="text item">
          <el-card style="text-align: left">
            <div slot="header" class="clearfix">
              <span>点赞消息提醒设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('like')" v-model="like" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
            <div v-show="like" class="clearfix">
              <span>消息弹窗设置</span>
              <el-switch style="float:right; padding: 3px 0" @change="tag('like_w')" v-model="like_w" active-color="#13ce66" inactive-color="#cccccc"></el-switch>
            </div>
          </el-card>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'InformationSet',
  mounted() {
    this.$axios.get('/get_settings/'+this.$store.state.user.userId).then(res=>{
      if(res.data.isFollow==0)
        this.follow=false
      if(res.data.isComment==0)
        this.comment=false
      if(res.data.isLike==0)
        this.like=false
      if(res.data.isBroadcast==0)
        this.broadcast=false
      if(res.data.followW==0)
        this.follow_w=false
      if(res.data.likeW==0)
        this.like_w=false
      if(res.data.broadcastW==0)
        this.broadcast_w=false
      if(res.data.commentW==0)
        this.comment_w=false
    })
  },
  data: () => ({
    all: true,
    broadcast: true,
    broadcast_w: true,
    like: true,
    like_w: true,
    follow: true,
    follow_w: true,
    comment: true,
    comment_w: true,
  }),
  methods: {
    tag(type) {
      if (type == 'all') {
        this.broadcast = this.all
        this.comment = this.all
        this.like = this.all
        this.follow = this.all
        this.broadcast_w = this.broadcast
        this.comment_w = this.comment
        this.follow_w = this.follow
        this.like_w = this.like
        this.$axios.get('/' + type + '/' + this.all + '/'+this.$store.state.user.userId)
      }
      if (type == 'broadcast') {
        this.broadcast_w = this.broadcast
        this.$axios.get('/' + type + '/' + this.broadcast + '/'+this.$store.state.user.userId)
      }

      if (type == 'comment') {
        this.comment_w = this.comment
        this.$axios.get('/Is' + type + '/' + this.comment + '/'+this.$store.state.user.userId)
      }

      if (type == 'follow') {
        this.follow_w = this.follow
        this.$axios.get('/' + type + '/' + this.follow + '/'+this.$store.state.user.userId)
      }

      if (type == 'like') {
        this.like_w = this.like
        this.$axios.get('/' + type + '/' + this.like + '/'+this.$store.state.user.userId)
      }
      if (type == 'like_w') {
        this.$axios.get('/' + type + '/' + this.like_w + '/'+this.$store.state.user.userId)
      }
      if (type == 'comment_w') {
        this.$axios.get('/' + type + '/' + this.comment_w + '/'+this.$store.state.user.userId)
      }
      if (type == 'follow_w') {
        this.$axios.get('/' + type + '/' + this.follow_w + '/'+this.$store.state.user.userId)
      }
      if (type == 'broadcast_w') {
        this.$axios.get('/' + type + '/' + this.broadcast_w + '/'+this.$store.state.user.userId)
      }
    }
  }
}

</script>

<style>
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}
</style>