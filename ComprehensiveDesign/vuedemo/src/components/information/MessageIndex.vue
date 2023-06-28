<template>
  <el-container style="height: 500px; border: 1px solid #eee">
    <el-aside width="300px" style="background-color: rgb(255,252,252); border-radius: 30px">
      <el-row>
        <div style="float: left;margin-left: 30px;margin-top: 25px;"><el-avatar :size="35"></el-avatar>  {{userId}}</div>
      </el-row>
            <el-table :data="sessionList" style="width: 100%">
              <el-table-column>
                <template slot-scope="scope" >
                  <el-button type="text" style="width: 100%;background-color: #d6d6f6" shadow="hover" @click="changeToUserId(scope.row.userId)">
<!--                    <el-avatar style="float: left"  :size="33" :src="scope.row.avatar"></el-avatar>-->
                    <div style="float: left; margin-left: 10px" v-for="i in unReadMessageNum">
                        <span v-if="i.key==scope.row.userId">
                          <el-badge v-if="i.value" :value="i.value" type="item">
                            <el-avatar :size="35" :src="scope.row.avatar"></el-avatar>
                          </el-badge>
                          <el-avatar v-else :size="33" :src="scope.row.avatar"></el-avatar>
                        </span>
                    </div>
                    <span style="margin-left: 15px;float:left;">---{{scope.row.userId}}|{{ scope.row.nickname}}</span>
                    <span style="float: right" v-for="m in lastMessageList">
                      <span v-if="m.senderId==scope.row.userId">|{{m.messageCreateTime}}</span>
                      <span v-if="m.receiverId==scope.row.userId">|{{m.messageCreateTime}}</span>
                    </span>

<!--                    <el-divider content-position="left">-->
<!--                    </el-divider>-->
                    <div v-for="m in lastMessageList" style="float:left; margin-left: 8px; margin-top: 10px">
                      <div v-if="m.senderId==scope.row.userId">: {{m.content}}</div>
                      <div v-if="m.receiverId==scope.row.userId">: {{m.content}}</div>
                    </div>

                  </el-button>

                </template>
              </el-table-column>
<!--              <el-table-column prop="avatar" label="头像">-->
<!--              </el-table-column>-->
<!--              <el-table-column prop="nickname" label="昵称" >-->
<!--              </el-table-column>-->
            </el-table>

    </el-aside>

    <el-container v-if="toUserId" style="border-color: #24c97f;border-radius: 30px">
      <el-header style=" font-size: 24px">
        <span style="float: left">{{toUserId}}</span>
        <span style="float: right">
        <el-tooltip class="item" effect="dark" content="时间显示" placement="bottom">
          <el-switch
              v-model="showTime"
              active-color="#13ce66"
              active-icon-class="el-icon-time"
              inactive-color="#ff4949">
          </el-switch>
        </el-tooltip>
        </span>
      </el-header>
      <el-main>

        <el-table id="messageTable" ref="messageTable" :data="messageList" height="100%" >
          <el-table-column style="height: 100%" v-on:load="toBottom">
            <template slot-scope="scope">
              <el-divider content-position="center" v-if="showTime" style="size: 10px;color: gray">{{scope.row.messageCreateTime}}</el-divider>
              <div v-if="scope.row.senderId==userId">
                <el-row type="flex" class="row-bg" justify="end">
                  <el-col :span="2"><div class="grid-content bg-purple">
                    <span v-if="scope.row.isRead==0" style="margin-left: 10px;color: red">未读</span>
                    <span v-if="scope.row.isRead==1" style="margin-left: 10px">已读</span>
                  </div></el-col>
                  <el-col :span="4"><div class="grid-content bg-purple-light">{{ scope.row.content }}</div></el-col>
                  <el-col :span="1"><div class="grid-content bg-purple">{{ scope.row.senderId }}</div></el-col>
                </el-row>
              </div>
              <div v-else>
                <el-row type="flex" class="row-bg" justify="start">
                  <el-col :span="1"><div class="grid-content bg-purple">{{ scope.row.senderId }}</div></el-col>
                  <el-col :span="4"><div class="grid-content bg-purple-light">{{ scope.row.content }}</div></el-col>
                </el-row>
              </div>
            </template>
          </el-table-column>
          <!--          <el-table-column prop="senderId" label="发送人" width="140">-->
          <!--          </el-table-column>-->
          <!--          <el-table-column prop="receiverId" label="接受人" width="140">-->
          <!--          </el-table-column>-->
          <!--          <el-table-column prop="content" label="内容" >-->
          <!--          </el-table-column>-->
          <!--          <el-table-column prop="messageCreateTime" label="时间">-->
          <!--          </el-table-column>-->
          <!--          <el-table-column prop="isRead" label="状态" >-->
          <!--            <template slot-scope="scope">-->
          <!--              <span v-if="scope.row.isRead==0" style="margin-left: 10px">未读</span>-->
          <!--              <span v-if="scope.row.isRead==1" style="margin-left: 10px">已读</span>-->
          <!--            </template>-->
          <!--            <span v-if=""></span>-->
          <!--          </el-table-column>-->
        </el-table>

      </el-main>
      <el-divider></el-divider>
      <el-footer>
        <el-input
            type="textarea"
            placeholder="请输入内容"
            v-model="message.content"
            maxlength="200"
            show-word-limit
        >
        </el-input>
        <el-button v-if="toUserId" type="primary" plain v-on:click="send">Send</el-button>

      </el-footer>
    </el-container>

  </el-container>

</template>

<script>

import axios from "axios";
import moment from "moment";


export default {
  name: "MessageIndex",


  mounted() {
    this.onload()
    //websocket

    //
  },    // if ('WebSocket' in window) {
  //   this.websocket = new WebSocket('ws://localhost:8443/api/websocket/' + this.userId)
  //   this.initWebSocket()
  // } else {
  //   alert('当前浏览器 Not support websocket')
  // }
  beforeDestroy () {
    this.onbeforeunload()
  },
  updated() {
    this.$nextTick(() => {
      let msg = document.getElementById('messageTable') // 获取对象
      msg.scrollTop = msg.scrollHeight // 滚动高度
    })
  },

  watch:{
    unReadMessageNum:{qjq(val){
      this.unReadMessageNum = val
    },
      deep:true
    },

    messageList:{qjq(val){
     this.messageList = val
    },
      deep:true
    },
    lastMessageList:{qjq(val){
        this.lastMessageList = val
      },
      deep:true
    },
    sessionList: {qjq(val){
        this.sessionList = val
      },
      deep:true
    },
  },
  methods: {


    send() {
      var table = this.$refs.messageTable
      var height = table.bodyWrapper

      console.log(height.scrollHeight)
      height.scrollTop = height.scrollHeight
      console.log(height.scrollTop)
      if(this.message.content==""){
        this.$alert("please input some message.")
      }
      else {
        this.message.messageCreateTime = new Date().Format("yyyy-MM-dd HH:mm:ss")
        this.message.senderId = this.userId
        this.message.receiverId = this.toUserId
        this.$axios
            .post('/addMessage',this.message).then(success => {
              this.testMessage.push(success.data)
              this.messageList.push(success.data)
              // this.$alert(success.data.content+success.data.senderId)
              this.getLastMessage(this.toUserId)
              this.message.content=""
        })
        this.toBottom()
      }
    },

    toBottom(){
      this.$nextTick(() => {
        let msg = document.getElementById('messageTable') // 获取对象
        msg.scrollTop = msg.scrollHeight // 滚动高度
      })
    },

    onload() {
      this.$axios
          .get("/getSessionByUserId?id="+this.userId).then(success =>{
            this.sessionList = success.data
          for (var i=0,len=this.sessionList.length; i<len; i++)
          {
            this.getLastMessage(this.sessionList[i].userId);
            this.getUnreadMessageNum(this.sessionList[i].userId)
          }
      // this.toUserId = this.getParameter("toUserId")
      if(this.toUserId){
        this.$axios
            .get("/chat?senderId="+this.userId+"&receiverId="+this.toUserId).then(success =>{
          this.messageList = success.data
        })
      }


      })
      // this.$alert(this.toUserId)
    },
    changeToUserId(id){
      this.toUserId = id
      this.$axios
          .get("/readMessageOfUserId?senderId="+this.toUserId+"&receiverId="+this.userId).then(success=>{
        this.getUnreadMessageNum(id)

      })
      this.$axios
          .get("/chat?senderId="+this.userId+"&receiverId="+this.toUserId).then(success =>{
        this.messageList = success.data
        this.getUnreadMessageNum(id)
      })
    },

    getUnreadMessageNum(id){
      this.$axios
          .get("/getUnreadMessageNum?senderId="+id+"&receiverId="+this.userId).then(success=>{
          for(var i=0;i<this.unReadMessageNum.length;i++){
            if(this.unReadMessageNum[i].key==id){
              this.unReadMessageNum.splice(i,1)
            }
          }
          this.unReadMessageNum.push({key:id,value:success.data})
          // this.$alert(this.unReadMessageNum)
          // this.$alert(this.unReadMessageNum.length)
      })
    },
    getLastMessage(id){
      this.$axios
          .get("/getLastMessage?senderId="+id+"&receiverId="+this.userId).then(success =>{
            for(var i=0;i<this.lastMessageList.length;i++){
              if(this.lastMessageList[i].receiverId==id){
                this.lastMessageList.splice(i,1)
              }
            }
            // this.$alert(this.lastMessageList)
            this.lastMessageList.push(success.data)
      })
    },

    getParameter(name) {
      let reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)","i");
      let r = location.search.substr(1).match(reg);
      if (r!=null) return (r[2]); return null;
    },


    //websocket
    initWebSocket () {
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
    setErrorMessage () {
      console.log('WebSocket连接发生错误   状态码：' + this.websocket.readyState)
    },
    setOnopenMessage () {
      console.log('WebSocket连接成功    状态码：' + this.websocket.readyState)
    },
    setOnmessageMessage (event) {
      // 根据服务器推送的消息做自己的业务处理
      console.log('服务端返回：' + event.data)
    },
    setOncloseMessage () {
      console.log('WebSocket连接关闭    状态码：' + this.websocket.readyState)
    },
    onbeforeunload () {
      this.closeWebSocket()
    },
    closeWebSocket () {
      this.websocket.close()
    }


  },
  data() {
    return {
      showTime:false,
      unReadMessageNum:[],
      lastMessageList:[],
      testMessage: [],
      messageList:[],
      sessionList: [],
      userId:this.$store.state.user.userId,
      toUserId:this.getParameter("id"),
      // toUserId:0,
      // toUserId:11,
      message:{
        content:"",
        senderId:this.userId,
        receiverId:this.toUserId,
        messageCreateTime:new Date().Format("yyyy-MM-dd HH:mm:ss")
      },
    }
  },



}
Date.prototype.Format = function (fmt) {
  var o = {
    "M+": this.getMonth() + 1, //月份
    "d+": this.getDate(), //日
    "H+": this.getHours(), //小时
    "m+": this.getMinutes(), //分
    "s+": this.getSeconds(), //秒
    "q+": Math.floor((this.getMonth() + 3) / 3), //季度
    "S": this.getMilliseconds() //毫秒
  };
  if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
  for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
  return fmt;
}
</script>

<style scoped>
.el-header {
  background-color: #d4e1f6;
  color: #333;
  line-height: 60px;
}
.el-table{
  margin: 0;

  padding: 0;
}

.el-main{
  height: 400px;
  padding-bottom: 0;
}

.el-aside {
  color: #333;
}
</style>
