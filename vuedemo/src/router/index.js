import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from "@/components/Home";
import AppIndex from "@/components/home/AppIndex";
import Login from "@/components/user/Login";
import BlogIndex from "@/components/blog/BlogIndex";
import UserRegister from "@/components/user/UserRegister";
import Comments from "@/components/blog/Comments";
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Default',
    redirect: '/home',
    component: Home
  },
  {
    path: '/comments',
    name: 'Comments',
    component: Comments
  },
  {
    path: '/home',
    name: 'Home',
    component: Home,
    // home页面并不需要被访问
    redirect: '/index',
    children: [
      {
        //网站首页
        path: '/index',
        name: 'AppIndex',
        component: AppIndex,
        meta: {
          //页面需要被拦截
          requireAuth: true
        }
      },
      {
        path: '/blog',
        name: 'BlogIndex',
        component: BlogIndex,
        meta: {
          requireAuth: true
        }
      },
      {
        path: '/blog/article',
        name: 'ArticleDetails',
        component: () => import('../components/blog/ArticleDetails')
      },
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/userregister',
    name: 'UserRegister',
    component: UserRegister
  }
]

const router = new VueRouter({
  mode: 'history',
  // base: process.env.BASE_URL,
  routes
})

export default router

// // 用于创建默认路由
// export const createRouter = routes => new Router({
//   mode: 'history',
//   routes:[
//   {
//     path: '/',
//     name: 'Default',
//     redirect: '/home',
//     component: Home
//   },
//   {
//     path: '/home',
//     name: 'Home',
//     component: Home,
//     // home页面并不需要被访问
//     redirect: '/index',
//     children: [
//       {
//         //网站首页
//         path: '/index',
//         name: 'AppIndex',
//         component: AppIndex,
//         meta: {
//           //页面需要被拦截
//           requireAuth: true
//         }
//       },
//       {
//         path: '/blog',
//         name: 'BlogIndex',
//         component: BlogIndex,
//         meta: {
//           requireAuth: true
//         }
//       },
//       {
//         path: '/blog/article',
//         name: 'ArticleDetails',
//         component: () => import('../components/blog/ArticleDetails')
//       },
//     {
//       path: '*',
//       component: () => import('../components/pages/Error404')
//     }
//   ]
// })
//
