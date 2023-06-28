<template>
  <el-menu class="el-menu-demo" mode="horizontal" router>
    <el-menu-item v-for="(item,i) in navList" :key="i" :index="item.name">{{item.navItem}}</el-menu-item>
  </el-menu>
</template>

<script>
export default {
name: "TopBar",
  data(){
    return{
      navList: [
        {name: '/', navItem: '我的文章'},
        // {name: '/', navItem: '我的关注'},
        // {name: '/', navItem: '消息中心'},
        {name: '/postpage', navItem: '发表博客'}
      ]

    }
  },

}
</script>

<style scoped>

</style>