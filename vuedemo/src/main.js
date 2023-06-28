import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
//引入ElementUI
import Element from 'element-ui'
import "element-ui/lib/theme-chalk/index.css"
Vue.use(Element)
//引入axios
// 设置反向代理，前端请求默认发送到 http://localhost:8443/api
import axios from 'axios'
axios.defaults.baseURL = 'http://localhost:8443/api'
Vue.prototype.$axios = axios
Vue.config.productionTip = false

//引入阿里矢量图标库 https://www.iconfont.cn/collections/detail?cid=614
//需要在public目录下创建static文件夹，引入iconfont.js文件 index.html添加script(有问题)
//改为将inconfont.js放到assets,然后通过import "@/assets/iconfont.js"直接在VUE文件引用
//在components/common下创建Icon-svg，方便引用
import IconSvg from '@/components/common/Icon-svg'
Vue.component('icon-svg', IconSvg)

//钩子函数，判断路由拦截
router.beforeEach((to, from, next) => {
      //此页面需要被拦截
      if (to.meta.requireAuth) {
        //登录状态已保存
        if (store.state.user.userPhone) {
          next()
        }
        //登录状态未保存
        else {
          next({
            path: '/login',
            query: {redirect: to.fullPath}
          })
        }
      }
      //此页面不需要被拦截
      else {
        next()
      }
    }
)


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
