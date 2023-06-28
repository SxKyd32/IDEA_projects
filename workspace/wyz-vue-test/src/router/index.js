import Vue from 'vue'
import Router from 'vue-router'
// 导入刚才编写的组件
import Login from '@/components/Login'
import WorkerManagement from "@/components/home/WorkerManagement";

Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        // 下面都是固定的写法
        {
            path: '/',
            name: 'Login',
            component: Login,
            meta: {
                title: "请登录"
            }
        },
        {
            path:'/index',
            name:'WorkerManagement',
            component:WorkerManagement,
            meta: {
                title: "员工信息管理系统"
            }
        }
    ]
})