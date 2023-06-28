import Vue from 'vue'
import VueRouter from 'vue-router'
import AppIndex from '@/components/home/AppIndex'
import Login from '@/components/user/Login'
import Home from '@/components/Home'
import InformationIndex from "@/components/information/InformationIndex";
import CommentTable from "@/components/information/CommentTable"
import FollowTable from "@/components/information/FollowTable";
import BroadcastTable from "@/components/information/BroadcastTable";
import LikeTable from "@/components/information/LikeTable";
import BlogIndex from "@/components/blog/BlogIndex";
import InformationSet from "@/components/information/InformationSet";
import UserRegister from "@/components/user/UserRegister";
import Comments from "@/components/blog/Comments";
import UserHome from '../views/UserHome'
import PostPage from "@/views/PostPage";
import EditBlog from "../views/EditBlog";
import OtherHome from "../views/OtherHome";
import MessageIndex from "@/components/information/MessageIndex";
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
        component: () => import('../components/blog/ArticleDetails'),
        meta: {
          //页面需要被拦截
          requireAuth: true
        }
      },

        //消息模块
      {
        path: '/information',
        name: 'Information',
        component: InformationIndex,
        meta: {
          requireAuth: true
        },
        children: [
          {
            path: '/information/comment',
            name: 'comment',
            component: CommentTable,
            meta: {
              //页面需要被拦截
              requireAuth: true
            }
          },
          {
            path: '/information/like',
            name: 'like',
            component: LikeTable,
            meta: {
              //页面需要被拦截
              requireAuth: true
            }
          },
          {
            path: '/information/follow',
            name: 'follow',
            component: FollowTable,
            meta: {
              //页面需要被拦截
              requireAuth: true
            }
          },
          {
            path: '/information/broadcast',
            name: 'broadcast',
            component: BroadcastTable,
            meta: {
              //页面需要被拦截
              requireAuth: true
            }
          },
          {
            path: '/information/set',
            name: 'infoSet',
            component: InformationSet,
            meta: {
              //页面需要被拦截
              requireAuth: true
            }
          },
        ]
      },
      //ypy个人主页
      {
        path: '/userhome',
        name: 'UserHome',
        component: UserHome,
        meta: {
          //页面需要被拦截
          requireAuth: true
        }
      },
      {
        path: '/otherhome',
        name: 'OtherHome',
        component: OtherHome,
        meta: {
          //页面需要被拦截
          requireAuth: true
        }
      },
      {
        path: '/postpage',
        name:'PostPage',
        component: PostPage,
        meta: {
          //页面需要被拦截
          requireAuth: true
        }
      },
      {
        path: '/editblog',
        name: 'EditBlog',
        component: EditBlog,
        meta: {
          //页面需要被拦截
          requireAuth: true
        }
      },

      // 私信模块————张士育
      {
        path: '/message',
        name: 'Message',
        component: MessageIndex
      }

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

