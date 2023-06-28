import Vue from 'vue'
import Vuex from 'vuex'
//使用Vuex进行状态管理
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {
      //window.sessionStorage
      userId:window.localStorage
          .getItem('user' || '[]') == null ? ''
          : JSON.parse(window.localStorage.getItem('user' || '[]')).userId,
      userPhone:window.localStorage
          .getItem('user' || '[]') == null ? ''
          : JSON.parse(window.localStorage.getItem('user' || '[]')).userPhone,
      userPassword:window.localStorage
          .getItem('user' || '[]') == null ? ''
          : JSON.parse(window.localStorage.getItem('user' || '[]')).userPassword,
      avatar:window.localStorage
          .getItem('user' || '[]') == null ? ''
          : JSON.parse(window.localStorage.getItem('user' || '[]')).avatar,
      nickname:window.localStorage
          .getItem('user' || '[]') == null ? ''
          : JSON.parse(window.localStorage.getItem('user' || '[]')).nickname
    }
  },
  mutations: {
    //存储登录信息函数
    login (state, user) {
      state.user = user
      window.localStorage.setItem('user', JSON.stringify(user))
    }
  },
  actions: {
  },
  modules: {
  }
})
