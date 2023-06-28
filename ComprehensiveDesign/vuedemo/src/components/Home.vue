<template>
  <div>
    <nav-menu :comment="comment":like="like":follow="follow":broadcast="broadcast":message="message"></nav-menu>
<!--    <test2></test2>
    <test3></test3>-->
    <router-view @setTag="setTag" :comment="comment":like="like":follow="follow":broadcast="broadcast":message="message"></router-view>
  </div>
</template>

<script>
import NavMenu from "@/components/common/NavMenu";
export default {
  name: "Home",
  components: { NavMenu},
  mounted() {
    // WebSocket
    if ('WebSocket' in window) {
      this.websocket = new WebSocket('ws://localhost:8443/websocket/'+this.$store.state.user.userId)
      this.initWebSocket()
    } else {
      alert('当前浏览器 Not support websocket')
    }
  },
  data() {
    return {
      activeIndex: '1',
      activeIndex2: '1',
      comment:true,
      like: true,
      follow: true,
      broadcast: true,
      message: true
    };
  },
  methods: {
    setTag(type){
      if(type==="follow")
        this.follow = true
      if(type==="comment")
        this.comment = true
      if(type==="like")
        this.like = true
      if(type==="broadcast")
        this.broadcast = true
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    inform(type){
      let msg
      if(type==="like")
        msg="点赞消息"
      if(type==="follow")
        msg="关注"
      if(type==="broadcast")
        msg="公告"
      if(type==="comment")
        msg="评论"
      this.$notify({
        title: '消息',
        message: "你有一个新的"+msg,
        duration:2000
      })
    },
    initWebSocket() {
      // 连接错误
      this.websocket.onerror = this.setErrorMessage

      // 连接成功
      this.websocket.onopen = this.setOnopenMessage

      // 收到消息的回调
      this.websocket.onmessage = this.setOnmessageMessage

      // 连接关闭的回调
      this.websocket.onclose = this.setOncloseMessage

      // 监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
      window.onbeforeunload = this.onbeforeunload
    },
    setErrorMessage() {
      console.log('WebSocket连接发生错误   状态码：' + this.websocket.readyState)
    },
    setOnopenMessage() {
      this.$axios.get('/information/'+this.$store.state.user.userId).then(res=>{
        this.comment = res.data.comment
        this.follow = res.data.follow
        this.like = res.data.like
        this.broadcast = res.data.broadcast
        this.message = res.data.message
      })       //此处表示查询1号用户的消息提醒！！！后续需要动态获取
    },
    setOnmessageMessage(event) {
      if(event.data==="like"||event.data=="follow"||event.data=='comment'||event.data=='broadcast')
      this.inform(event.data)
      // 根据服务器推送的消息做自己的业务处理
      if((event.data==="like"||event.data==="likew")&&this.like===true)
        this.like=false
      if((event.data==="comment"||event.data==="commentw")&&this.comment===true)
        this.comment=false
      if((event.data==="follow"||event.data==="followw")&&this.follow===true)
        this.follow=false
      if((event.data==="broadcast"||event.data==="broadcastw")&&this.broadcast===true)
        this.broadcast=false
    },
    setOncloseMessage() {
      console.log('WebSocket连接关闭    状态码：' + this.websocket.readyState)
    },
    onbeforeunload() {
      this.closeWebSocket()
    },
    closeWebSocket() {
      this.websocket.close()
    },
  }
}
</script>

<style scoped>

</style>