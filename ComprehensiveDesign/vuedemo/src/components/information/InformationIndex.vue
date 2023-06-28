<template>
  <el-container>
    <el-aside width="220px">
      <switch></switch>
      <SideMenu :comment="comment":like="like":follow="follow":broadcast="broadcast":message="message" ref="sideMenu"></SideMenu>
    </el-aside>
    <el-main>
      <router-view @setTag="setTag":comment="comment":like="like":follow="follow":broadcast="broadcast":message="message"></router-view>
<!--      <tab-nav :is="apps" v-if="show" class="info-table" ref="infos"></tab-nav>-->
    </el-main>
  </el-container>
</template>

<script>
import SideMenu from './SideMenu'
export default {
  name: 'InformationIndex',
  components: {SideMenu},
  props:{
    comment:"",
    like:'',
    broadcast:'',
    follow:'',
    message:'',
    info:''
  },
  watch: {
    comment: function (val) {
      this.comment = val
    },
    follow: function (val) {
      this.follow = val
    },
    broadcast: function (val) {
      this.broadcast = val
    },
    like: function (val) {
      this.like = val
    },
    message:function (val) {
      this.message = val
    }
  },
  data(){
    return{
      show:false,
      apps:null
    }
  },
  methods:{
    setTag(type) {
      this.$emit('setTag',type)
    }
  }
}

</script>

<style scoped>
</style>