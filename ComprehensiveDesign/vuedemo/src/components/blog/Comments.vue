<template>
  <div>
    <!--发表评论控件-->
<!--    <div v-clickoutside="hideReplyBtn" @click="inputFocus" class="my-reply">-->
    <div @click="inputFocus" class="my-reply">
      <el-avatar class="header-img" :size="40" :src="user.avatar"></el-avatar>
      <div class="reply-info" >
        {{user.userId}}
<!--        <div-->
<!--            tabindex="0"-->
<!--            contenteditable="true"-->
<!--            id="replyInput"-->
<!--            spellcheck="false"-->
<!--            placeholder="输入评论..."-->
<!--            class="reply-input"-->
<!--            @focus="showReplyBtn"-->
<!--            @input="onDivInput($event)">-->
<!--        </div>-->

        <el-form :model="comment" label-width="80px">
          <el-form-item>
            <el-input
                type="textarea"
                :rows="2"
                v-model="comment.commentContent" placeholder="请输入评论"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button class="reply-btn"
                       size="medium" @click="sendComment" type="primary">发表评论</el-button>
          </el-form-item>
        </el-form>

      </div>
      <div class="reply-btn-box" v-show="btnShow">
        <el-button class="reply-btn"
                   size="medium" @click="sendComment" type="primary">发表评论</el-button>
      </div>
    </div>

    <div style="margin-top: 40px">
      <!--<el-button @click="addArticle()">添加文章</el-button>-->
      <div class="comments-area">
        <el-card style="text-align: left">
          <div v-for="comment in comments" :key="comment.commentId">
            <div style="float:left;width:85%;height: 150px;">
<!--              <router-link class="article-link" :to="{path:'comment'-->
<!--              ,query:{commentId: comment.commentId}}">-->
<!--                <span style="font-size: 20px"><strong>{{comment.commentId}}</strong></span>-->
<!--              </router-link>-->
              <el-divider content-position="left">
                <span style="font-size: 20px">
<!--                <strong>{{comment.commentId}}   {{comment.commentCreateTime}}</strong>-->
                <strong >{{comment.userId}}--------------{{comment.commentCreateTime}}</strong>
              </span>
              </el-divider>
              <span style="font-size: 20px">
                <el-avatar class="header-img" :size="40" ></el-avatar>
              </span>
                <p>{{comment.commentContent}}</p>
            </div>
<!--            &lt;!&ndash;            文章封面&ndash;&gt;-->
<!--            <el-image-->
<!--                style="margin:18px 0 0 30px;width:100px;height: 100px"-->
<!--                :src="article.articleCover"-->
<!--                fit="cover">-->
<!--            </el-image>-->
<!--            <el-divider>-->
<!--            </el-divider>-->
          </div>
        </el-card>
      </div>
      <!--分页-->
      <el-pagination
          background
          layout="total, prev, pager, next, jumper"
          @current-change="handleCurrentChange"
          :page-size="pageSize"
          :total="total">
      </el-pagination>
    </div>

<!--    &lt;!&ndash;显示评论内容&ndash;&gt;-->
<!--    <div v-for="(item,i) in comments" :key="i" class="author-title reply-father">-->
<!--    &lt;!&ndash;用户头像&ndash;&gt;-->
<!--      <el-avatar class="header-img" :size="40" :src="item.headImg"></el-avatar>-->
<!--    &lt;!&ndash;用户信息:用户昵称和发布评论时间&ndash;&gt;-->
<!--      <div class="author-info">-->
<!--        <span class="author-name">{{item.name}}</span>-->
<!--        <span class="author-time">{{item.time}}</span>-->
<!--      </div>-->
<!--      &lt;!&ndash;显示评论内存commentContent&ndash;&gt;-->
<!--      <div class="talk-box">-->
<!--        <p>-->
<!--          <span class="reply">{{item.comment}}</span>-->
<!--        </p>-->
<!--      </div>-->

    </div>
</template>

<script>


const clickoutside = {
  // 初始化指令
  bind(el, binding, vnode) {
    function documentHandler(e) {
      // 这里判断点击的元素是否是本身，是本身，则返回
      if (el.contains(e.target)) {
        return false;
      }
      // 判断指令中是否绑定了函数
      if (binding.expression) {
        // 如果绑定了函数 则调用那个函数，此处binding.value就是handleClose方法
        binding.value(e);
      }
    }
    // 给当前元素绑定个私有变量，方便在unbind中可以解除事件监听
    el.vueClickOutside = documentHandler;
    document.addEventListener('click', documentHandler);
  },
  update() {},
  unbind(el, binding) {
    // 解除事件监听
    document.removeEventListener('click', el.vueClickOutside);
    delete el.vueClickOutside;
  },
};
export default {
  name: "Comments",
  data(){
    return{
      btnShow: false,
      index:'0',
      replyComment:'',
      myName:'Lana Del Rey',
      myHeader:'https://ae01.alicdn.com/kf/Hd60a3f7c06fd47ae85624badd32ce54dv.jpg',
      myId:19870621,
      to:'',
      toId:-1,
      //分页查询数据
      comments: [],
      pageSize: 4,
      total: 0,
      //用户评论数据
      comment: {
        commentId:'',
        userId: '',
        blogId:'',
        commentContent:'',
        commentCreateTime:'',
        status:''
      },
      //已登录用户数据
      user:{
        userId:this.$store.state.user.userId,
        avatar:this.$store.state.user.avatar,
        nickname:this.$store.state.user.userId.nickname
      },
      // comments:[
      //   {
      //     name:'Lana Del Rey',
      //     id:19870621,
      //     headImg:'https://ae01.alicdn.com/kf/Hd60a3f7c06fd47ae85624badd32ce54dv.jpg',
      //     comment:'我发布一张新专辑Norman Fucking Rockwell,大家快来听啊',
      //     time:'2019年9月16日 18:43',
      //     commentNum:2,
      //     like:15,
      //     inputShow:false,
      //   },
      //   {
      //     name:'Taylor Swift',
      //     id:19891221,
      //     headImg:'https://ae01.alicdn.com/kf/H94c78935ffa64e7e977544d19ecebf06L.jpg',
      //     comment:'我发行了我的新专辑Lover',
      //     time:'2019年9月16日 18:43',
      //     commentNum:1,
      //     like:5,
      //     inputShow:false,
      //   },
      //   {
      //     name:'Norman Fucking Rockwell',
      //     id:20190830,
      //     headImg:'https://ae01.alicdn.com/kf/Hdd856ae4c81545d2b51fa0c209f7aa28Z.jpg',
      //     comment:'Plz buy Norman Fucking Rockwell on everywhere',
      //     time:'2019年9月16日 18:43',
      //     commentNum:0,
      //     like:5,
      //     inputShow:false,
      //   },
      // ]
    }
  },
  directives: {clickoutside},

  mounted () {
    //打开界面时载入所有评论
    this.loadComments()
  },
  methods: {
    //载入所有评论
    loadComments () {
      var _this = this
      this.$axios.get('/comment/' + this.pageSize + '/1').then(resp => {
        if (resp && resp.data.code === 200) {
          console.log("成功读取评论！")
          console.log(resp.data)
          _this.comments = resp.data.result.content
          _this.total = resp.data.result.totalElements
          console.log(_this.comments[0])
        }
      })
    },
    //数据改变时刷新评论显示
    handleCurrentChange (page) {
      var _this = this
      this.$axios.get('/comment/' + this.pageSize + '/' + page).then(resp => {
        if (resp && resp.data.code === 200) {
          _this.comments = resp.data.result.content
          _this.total = resp.data.result.totalElements
        }
      }).catch(failResponse => {
        console.log(failResponse);
      })
    },
    //评论文章
    sendComment(){
      // //输入为空
      if(this.comment.commentContent === "") {
        this.$message({
          showClose: true,
          type: 'warning',
          message: '评论不能为空'
        })
      }
      else{
        var _this = this
        //获取当前时间
        var timestamp = new Date( +new Date() )
        console.log("时间:")
        console.log(timestamp); //1495302061441
        this.$axios
            .post('/addcomment', {
              // commentId 后端 自增
              userId:_this.$store.state.user.userId,
              // blogId:this.$route.query.blogId,
              blogId:1,
              commentContent:this.comment.commentContent,
              commentCreateTime:timestamp
            })
            .then(function (response2) {
              this.$axios.get('/sendOneWebSocket/'+blogId+'/comment')
              alert(JSON.stringify(response2.data))
            })
            .catch(error => {
              console.log(error)
            })
        }


    },










    inputFocus(){
      var replyInput = document.getElementById('replyInput');
      replyInput.style.padding= "8px 8px"
      replyInput.style.border ="2px solid blue"
      replyInput.focus()
    },
    //显示发布评论按钮
    showReplyBtn(){
      this.btnShow = true
    },
    //隐藏发布评论按钮
    hideReplyBtn(){
      this.btnShow = false
      replyInput.style.padding= "10px"
      replyInput.style.border ="none"
    },
    // sendComment(){
    //   //输入为空
    //   if(!this.replyComment){
    //     this.$message({
    //       showClose: true,
    //       type:'warning',
    //       message:'评论不能为空'
    //     })
    //   }
    //   //评论不为空，与后端交互//todo
    //   else{
    //     let a ={}
    //     //获取输入变量
    //     let input =  document.getElementById('replyInput')
    //     //获取评论时间
    //     let timeNow = new Date().getTime();
    //     let time= this.dateStr(timeNow);
    //     a.name= this.myName
    //     a.comment =this.replyComment
    //     a.headImg = this.myHeader
    //     a.time = time
    //     a.commentNum = 0
    //     a.like = 0
    //     this.comments.push(a)
    //     this.replyComment = ''
    //     input.innerHTML = '';
    //   }
    // },
    onDivInput: function(e) {
      this.replyComment = e.target.innerHTML;
    },
    //评论时间处理函数
    dateStr(date){
      //获取js 时间戳
      var time=new Date().getTime();
      //去掉 js 时间戳后三位，与php 时间戳保持一致
      time=parseInt((time-date)/1000);
      //存储转换值
      var s;
      if(time<60*10){//十分钟内
        return '刚刚';
      }else if((time<60*60)&&(time>=60*10)){
        //超过十分钟少于1小时
        s = Math.floor(time/60);
        return  s+"分钟前";
      }else if((time<60*60*24)&&(time>=60*60)){
        //超过1小时少于24小时
        s = Math.floor(time/60/60);
        return  s+"小时前";
      }else if((time<60*60*24*30)&&(time>=60*60*24)){
        //超过1天少于30天内
        s = Math.floor(time/60/60/24);
        return s+"天前";
      }else{
        //超过30天ddd
        var date= new Date(parseInt(date));
        return date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate();
      }
    }
  }
}
</script>




<!--使用stylus-loader-->
<!--执行以下语句导入-->
<!--npm i stylus stylus-loader &#45;&#45;save-dev-->
<style lang="stylus" scoped>

.comments-area
  width: 990px
  height: 750px
  margin-left: auto
  margin-right: auto



.my-reply
  padding 10px
  background-color #fafbfc
  .header-img
    display inline-block
    vertical-align top
  .reply-info
    display inline-block
    margin-left 5px
    width 90%
    @media screen and (max-width:1200px) {
      width 80%
    }
    .reply-input
      min-height 20px
      line-height 22px
      padding 10px 10px
      color #ccc
      background-color #fff
      border-radius 5px
      &:empty:before
        content attr(placeholder)
      &:focus:before
        content none
      &:focus
        padding 8px 8px
        border 2px solid blue
        box-shadow none
        outline none
  .reply-btn-box
    height 25px
    margin 10px 0
    .reply-btn
      position relative
      float right
      margin-right 15px
.my-comment-reply
  margin-left 50px
  .reply-input
    width flex
.author-title:not(:last-child)
  border-bottom: 1px solid rgba(178,186,194,.3)
.author-title
  padding 10px
  .header-img
    display inline-block
    vertical-align top
  .author-info
    display inline-block
    margin-left 5px
    width 60%
    height 40px
    line-height 20px
    >span
      display block
      cursor pointer
      overflow hidden
      white-space nowrap
      text-overflow ellipsis
    .author-name
      color #000
      font-size 18px
      font-weight bold
    .author-time
      font-size 14px
  .icon-btn
    width 30%
    padding 0 !important
    float right
    @media screen and (max-width : 1200px){
      width 20%
      padding 7px
    }
    >span
      cursor pointer
    .iconfont
      margin 0 5px
  .talk-box
    margin 0 50px
    >p
      margin 0
    .reply
      font-size 16px
      color #000
  .reply-box
    margin 10px 0 0 50px
    background-color #efefef
</style>
