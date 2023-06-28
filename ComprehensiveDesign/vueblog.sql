/*
 Navicat Premium Data Transfer

 Source Server         : MyDataBase
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : vueblog

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 25/06/2021 23:40:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` int(0) NOT NULL AUTO_INCREMENT,
  `admin_name` int(0) NOT NULL,
  `admin_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `category_id` int(0) DEFAULT NULL,
  `blog_id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) DEFAULT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '简介',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `blog_create_time` datetime(0) NOT NULL,
  `status` int(0) NOT NULL COMMENT '0:未审核\n            1:已通过\n            2.未通过',
  `like_num` int(0) NOT NULL COMMENT '点赞数',
  `collection_num` int(0) NOT NULL COMMENT '收藏数',
  `comment_num` int(0) NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文章封面',
  `html_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`blog_id`) USING BTREE,
  INDEX `FK_Reference_1`(`user_id`) USING BTREE,
  INDEX `fk_blog_category_on_cid`(`category_id`) USING BTREE,
  CONSTRAINT `fk_blog_category_on_cid` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (1, 1, 1, 'Test', '1', '<p><img src=\"https://i.loli.net/2019/12/15/sYnuTIrDUwAfGgo.png\" alt=\"wjlogo.png\" /></p>\n<hr />\n<p><img src=\"https://img.shields.io/github/license/Antabot/White-Jotter\" alt=\"lisense\" /><br />\n<img src=\"https://img.shields.io/github/v/release/Antabot/White-Jotter\" alt=\"release\" /></p>\n<p>这是一个简单的前后端分离项目，主要采用 Vue.js + SpringBoot 技术栈开发。</p>\n<p>除了用作入门练习，我还希望该项目可以作为一些常见 Web 项目的脚手架，帮助大家简化搭建网站的流程。之所以叫白卷，是因为它从 0 开始，会随着时间的推移逐渐完善。</p>\n<p>欢迎加入微信圈子 【开发者】 分享、讨论学习经验：</p>\n<p><img src=\"https://i.loli.net/2020/01/17/HySWdM7wDfF8EKC.png\" alt=\"圈子\" /></p>\n<h1><a id=\"_17\"></a>整体效果</h1>\n<h2><a id=\"1_19\"></a>1.首页</h2>\n<p>作为展示页面，包括开发这个项目的主要参考资料、近期更新和 Slogan</p>\n<p><img src=\"https://img-blog.csdnimg.cn/20190403215932913.png\" alt=\"首页\" /></p>\n<h2><a id=\"2_25\"></a>2.图书馆</h2>\n<p>提供图书信息展示功能</p>\n<p><img src=\"https://i.loli.net/2019/12/03/AGLbIupct68ThBD.png\" alt=\"图书馆\" /></p>\n<h2><a id=\"3_31\"></a>3.登录页面</h2>\n<p><img src=\"https://i.loli.net/2019/04/14/5cb2fd5b78ae7.png\" alt=\"登录页面\" /></p>\n<h2><a id=\"4_35\"></a>4.后台管理</h2>\n<p>包含 dashboard、内容管理、用户及权限管理等</p>\n<p><img src=\"https://img-blog.csdnimg.cn/20191202200516251.png\" alt=\"后台\" /></p>\n<h1><a id=\"_41\"></a>技术栈</h1>\n<h2><a id=\"1_43\"></a>1.前端技术栈</h2>\n<p>1.Vue<br />\n2.ElementUI<br />\n3.axios</p>\n<h2><a id=\"2_49\"></a>2.后端技术栈</h2>\n<p>1.Spring Boot<br />\n2.Spring Data + JPA<br />\n3.MySQL<br />\n4.Shiro</p>\n<h1><a id=\"_56\"></a>部署方法</h1>\n<p>1.clone 项目到本地</p>\n<p><code>git clone https://github.com/Antabot/White-Jotter</code></p>\n<p>2.数据库脚本放在 <code>wj</code> 项目的根目录下，在MySQL中执行数据库脚本</p>\n<p>3.数据库配置在 <code>wj</code> 项目的 <code>src\\main\\resources</code> 目录下的<code>application.properties</code> 文件中，mysql 版本为 8.0.15</p>\n<p>4.在IntelliJ IDEA中运行 <code>wj</code> 项目，为了保证项目成功运行，可以右键点击 <code>pom.xml</code> 选择 maven -&gt; reimport ，并重启项目</p>\n<p>至此，服务端就启动成功了，同时，运行 <code>wj-vue</code> 项目，访问 <code>http://localhost:8080</code> ，即可进入登录页面，默认账号是 <code>admin</code>，密码是 <code>123</code></p>\n<p>如果要做二次开发，请继续看第五、六步。</p>\n<p>5.进入到 <code>wj-vue</code> 目录中，在命令行依次输入如下命令：</p>\n<pre><code class=\"lang-\"># 安装依赖\nnpm install\n\n# 在 localhost:8080 启动项目\nnpm run dev\n\n</code></pre>\n<p>由于在 <code>wj-vue</code> 项目中已经配置了端口转发，将数据转发到SpringBoot上，因此项目启动之后，在浏览器中输入 <code>http://localhost:8080</code> 就可以访问我们的前端项目了，所有的请求通过端口转发将数据传到 SpringBoot 中（注意此时不要关闭 SpringBoot 项目）。</p>\n<p>6.最后可以用 <code>WebStorm</code> 等工具打开 <code>wj-vue</code>项目，继续开发，开发完成后，当项目要上线时，依然进入到 <code>wj-vue</code> 目录，然后执行如下命令：</p>\n<pre><code class=\"lang-\">npm run build\n</code></pre>\n<p>该命令执行成功之后， <code>wj-vue</code> 目录下生成一个 <code>dist</code> 文件夹，可以将该文件夹中的两个文件 <code>static</code> 和 <code>index.html</code> 拷贝到 <code>wj</code> 项目中 <code>resources/static/</code> 目录下，然后直接运行 <code>wj</code> 项目，访问 <code>http://localhost:8443</code> ，实际上是把前端打包后作为静态文件，但不推荐使用这种方式。</p>\n<h1><a id=\"_93\"></a>教程</h1>\n<p>我在 CSDN 上分享了开发这个项目的教程，有兴趣的小伙伴可以点击下面的链接查看。</p>\n<p>1.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88925013\" target=\"_blank\">项目简介</a></p>\n<p>2.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88926242\" target=\"_blank\">使用 CLI 搭建 Vue.js 项目</a></p>\n<p>3.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88955387\" target=\"_blank\">前后端结合测试（登录页面开发）</a></p>\n<p>4.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/89294300\" target=\"_blank\">数据库的引入</a></p>\n<p>5.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/89298717\" target=\"_blank\">使用 Element 辅助前端开发</a></p>\n<p>6.<a href=\"https://learner.blog.csdn.net/article/details/89422585\" target=\"_blank\">前端路由与登录拦截器</a></p>\n<p>7.<a href=\"https://learner.blog.csdn.net/article/details/89853305\" target=\"_blank\">导航栏与图书页面设计</a></p>\n<p>8.<a href=\"https://learner.blog.csdn.net/article/details/92413933\" target=\"_blank\">数据库设计与增删改查</a></p>\n<p>9.<a href=\"https://learner.blog.csdn.net/article/details/95310666\" target=\"_blank\">核心功能的前端实现</a></p>\n<p>10.<a href=\"https://learner.blog.csdn.net/article/details/97619312\" target=\"_blank\">图片上传与项目的打包部署</a></p>\n<p>11.<a href=\"https://learner.blog.csdn.net/article/details/100849732\" target=\"_blank\">用户角色权限管理模块设计</a></p>\n<p>12.<a href=\"https://learner.blog.csdn.net/article/details/101121899\" target=\"_blank\">访问控制及其实现思路</a></p>\n<p>13.<a href=\"https://learner.blog.csdn.net/article/details/102690035\" target=\"_blank\">使用 Shiro 实现用户信息加密与登录认证</a></p>\n<p>14.<a href=\"https://learner.blog.csdn.net/article/details/102788866\" target=\"_blank\">用户认证方案与完善的访问拦截</a></p>\n<p>15.<a href=\"https://learner.blog.csdn.net/article/details/103114893\" target=\"_blank\">动态加载后台菜单</a></p>\n<p>16.<a href=\"https://learner.blog.csdn.net/article/details/103250775\" target=\"_blank\">功能级访问控制的实现</a></p>\n<p>(持续更新中)</p>\n<h1><a id=\"_131\"></a>近期更新</h1>\n<p>12-01 实现功能级权限控制<br />\n11-30 利用 vue-elment-admin 项目完善后台界面设计<br />\n11-17 重构项目，完成搭建后台基础界面，实现按角色加载菜单，取消前台访问限制<br />\n04-27 使用前端拦截器，数据库迁移至 mysql 8.0.15，后台管理页面初始化<br />\n04-13 完成图片的上传功能<br />\n04-11 完成图书分类功能<br />\n04-08 完成图书分页功能<br />\n04-06 完成图书查询功能<br />\n04-05 完成图书修改功能<br />\n04-04 完成图书删除功能<br />\n04-03 完成图书新增功能</p>\n', '1970-01-01 08:00:00', 0, 0, 0, 0, 'file:///C:/Users/CRL/Pictures/Saved%20Pictures/universe.jpg', NULL);
INSERT INTO `blog` VALUES (1, 2, 1, 'Test', '简单描述', '<p><img src=\"https://i.loli.net/2019/12/15/sYnuTIrDUwAfGgo.png\" alt=\"wjlogo.png\" /></p>\n<hr />\n<p><img src=\"https://img.shields.io/github/license/Antabot/White-Jotter\" alt=\"lisense\" /><br />\n<img src=\"https://img.shields.io/github/v/release/Antabot/White-Jotter\" alt=\"release\" /></p>\n<p>这是一个简单的前后端分离项目，主要采用 Vue.js + SpringBoot 技术栈开发。</p>\n<p>除了用作入门练习，我还希望该项目可以作为一些常见 Web 项目的脚手架，帮助大家简化搭建网站的流程。之所以叫白卷，是因为它从 0 开始，会随着时间的推移逐渐完善。</p>\n<p>欢迎加入微信圈子 【开发者】 分享、讨论学习经验：</p>\n<p><img src=\"https://i.loli.net/2020/01/17/HySWdM7wDfF8EKC.png\" alt=\"圈子\" /></p>\n<h1><a id=\"_17\"></a>整体效果</h1>\n<h2><a id=\"1_19\"></a>1.首页</h2>\n<p>作为展示页面，包括开发这个项目的主要参考资料、近期更新和 Slogan</p>\n<p><img src=\"https://img-blog.csdnimg.cn/20190403215932913.png\" alt=\"首页\" /></p>\n<h2><a id=\"2_25\"></a>2.图书馆</h2>\n<p>提供图书信息展示功能</p>\n<p><img src=\"https://i.loli.net/2019/12/03/AGLbIupct68ThBD.png\" alt=\"图书馆\" /></p>\n<h2><a id=\"3_31\"></a>3.登录页面</h2>\n<p><img src=\"https://i.loli.net/2019/04/14/5cb2fd5b78ae7.png\" alt=\"登录页面\" /></p>\n<h2><a id=\"4_35\"></a>4.后台管理</h2>\n<p>包含 dashboard、内容管理、用户及权限管理等</p>\n<p><img src=\"https://img-blog.csdnimg.cn/20191202200516251.png\" alt=\"后台\" /></p>\n<h1><a id=\"_41\"></a>技术栈</h1>\n<h2><a id=\"1_43\"></a>1.前端技术栈</h2>\n<p>1.Vue<br />\n2.ElementUI<br />\n3.axios</p>\n<h2><a id=\"2_49\"></a>2.后端技术栈</h2>\n<p>1.Spring Boot<br />\n2.Spring Data + JPA<br />\n3.MySQL<br />\n4.Shiro</p>\n<h1><a id=\"_56\"></a>部署方法</h1>\n<p>1.clone 项目到本地</p>\n<p><code>git clone https://github.com/Antabot/White-Jotter</code></p>\n<p>2.数据库脚本放在 <code>wj</code> 项目的根目录下，在MySQL中执行数据库脚本</p>\n<p>3.数据库配置在 <code>wj</code> 项目的 <code>src\\main\\resources</code> 目录下的<code>application.properties</code> 文件中，mysql 版本为 8.0.15</p>\n<p>4.在IntelliJ IDEA中运行 <code>wj</code> 项目，为了保证项目成功运行，可以右键点击 <code>pom.xml</code> 选择 maven -&gt; reimport ，并重启项目</p>\n<p>至此，服务端就启动成功了，同时，运行 <code>wj-vue</code> 项目，访问 <code>http://localhost:8080</code> ，即可进入登录页面，默认账号是 <code>admin</code>，密码是 <code>123</code></p>\n<p>如果要做二次开发，请继续看第五、六步。</p>\n<p>5.进入到 <code>wj-vue</code> 目录中，在命令行依次输入如下命令：</p>\n<pre><code class=\"lang-\"># 安装依赖\nnpm install\n\n# 在 localhost:8080 启动项目\nnpm run dev\n\n</code></pre>\n<p>由于在 <code>wj-vue</code> 项目中已经配置了端口转发，将数据转发到SpringBoot上，因此项目启动之后，在浏览器中输入 <code>http://localhost:8080</code> 就可以访问我们的前端项目了，所有的请求通过端口转发将数据传到 SpringBoot 中（注意此时不要关闭 SpringBoot 项目）。</p>\n<p>6.最后可以用 <code>WebStorm</code> 等工具打开 <code>wj-vue</code>项目，继续开发，开发完成后，当项目要上线时，依然进入到 <code>wj-vue</code> 目录，然后执行如下命令：</p>\n<pre><code class=\"lang-\">npm run build\n</code></pre>\n<p>该命令执行成功之后， <code>wj-vue</code> 目录下生成一个 <code>dist</code> 文件夹，可以将该文件夹中的两个文件 <code>static</code> 和 <code>index.html</code> 拷贝到 <code>wj</code> 项目中 <code>resources/static/</code> 目录下，然后直接运行 <code>wj</code> 项目，访问 <code>http://localhost:8443</code> ，实际上是把前端打包后作为静态文件，但不推荐使用这种方式。</p>\n<h1><a id=\"_93\"></a>教程</h1>\n<p>我在 CSDN 上分享了开发这个项目的教程，有兴趣的小伙伴可以点击下面的链接查看。</p>\n<p>1.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88925013\" target=\"_blank\">项目简介</a></p>\n<p>2.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88926242\" target=\"_blank\">使用 CLI 搭建 Vue.js 项目</a></p>\n<p>3.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88955387\" target=\"_blank\">前后端结合测试（登录页面开发）</a></p>\n<p>4.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/89294300\" target=\"_blank\">数据库的引入</a></p>\n<p>5.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/89298717\" target=\"_blank\">使用 Element 辅助前端开发</a></p>\n<p>6.<a href=\"https://learner.blog.csdn.net/article/details/89422585\" target=\"_blank\">前端路由与登录拦截器</a></p>\n<p>7.<a href=\"https://learner.blog.csdn.net/article/details/89853305\" target=\"_blank\">导航栏与图书页面设计</a></p>\n<p>8.<a href=\"https://learner.blog.csdn.net/article/details/92413933\" target=\"_blank\">数据库设计与增删改查</a></p>\n<p>9.<a href=\"https://learner.blog.csdn.net/article/details/95310666\" target=\"_blank\">核心功能的前端实现</a></p>\n<p>10.<a href=\"https://learner.blog.csdn.net/article/details/97619312\" target=\"_blank\">图片上传与项目的打包部署</a></p>\n<p>11.<a href=\"https://learner.blog.csdn.net/article/details/100849732\" target=\"_blank\">用户角色权限管理模块设计</a></p>\n<p>12.<a href=\"https://learner.blog.csdn.net/article/details/101121899\" target=\"_blank\">访问控制及其实现思路</a></p>\n<p>13.<a href=\"https://learner.blog.csdn.net/article/details/102690035\" target=\"_blank\">使用 Shiro 实现用户信息加密与登录认证</a></p>\n<p>14.<a href=\"https://learner.blog.csdn.net/article/details/102788866\" target=\"_blank\">用户认证方案与完善的访问拦截</a></p>\n<p>15.<a href=\"https://learner.blog.csdn.net/article/details/103114893\" target=\"_blank\">动态加载后台菜单</a></p>\n<p>16.<a href=\"https://learner.blog.csdn.net/article/details/103250775\" target=\"_blank\">功能级访问控制的实现</a></p>\n<p>(持续更新中)</p>\n<h1><a id=\"_131\"></a>近期更新</h1>\n<p>12-01 实现功能级权限控制<br />\n11-30 利用 vue-elment-admin 项目完善后台界面设计<br />\n11-17 重构项目，完成搭建后台基础界面，实现按角色加载菜单，取消前台访问限制<br />\n04-27 使用前端拦截器，数据库迁移至 mysql 8.0.15，后台管理页面初始化<br />\n04-13 完成图片的上传功能<br />\n04-11 完成图书分类功能<br />\n04-08 完成图书分页功能<br />\n04-06 完成图书查询功能<br />\n04-05 完成图书修改功能<br />\n04-04 完成图书删除功能<br />\n04-03 完成图书新增功能</p>\n', '2021-06-20 21:36:33', 0, 0, 0, 0, 'https://ae01.alicdn.com/kf/Hd60a3f7c06fd47ae85624badd32ce54dv.jpg', NULL);
INSERT INTO `blog` VALUES (1, 3, 2, 'woshi2', '222', '<p><img src=\"https://i.loli.net/2019/12/15/sYnuTIrDUwAfGgo.png\" alt=\"wjlogo.png\" /></p>\n<hr />\n<p><img src=\"https://img.shields.io/github/license/Antabot/White-Jotter\" alt=\"lisense\" /><br />\n<img src=\"https://img.shields.io/github/v/release/Antabot/White-Jotter\" alt=\"release\" /></p>\n<p>这是一个简单的前后端分离项目，主要采用 Vue.js + SpringBoot 技术栈开发。</p>\n<p>除了用作入门练习，我还希望该项目可以作为一些常见 Web 项目的脚手架，帮助大家简化搭建网站的流程。之所以叫白卷，是因为它从 0 开始，会随着时间的推移逐渐完善。</p>\n<p>欢迎加入微信圈子 【开发者】 分享、讨论学习经验：</p>\n<p><img src=\"https://i.loli.net/2020/01/17/HySWdM7wDfF8EKC.png\" alt=\"圈子\" /></p>\n<h1><a id=\"_17\"></a>整体效果</h1>\n<h2><a id=\"1_19\"></a>1.首页</h2>\n<p>作为展示页面，包括开发这个项目的主要参考资料、近期更新和 Slogan</p>\n<p><img src=\"https://img-blog.csdnimg.cn/20190403215932913.png\" alt=\"首页\" /></p>\n<h2><a id=\"2_25\"></a>2.图书馆</h2>\n<p>提供图书信息展示功能</p>\n<p><img src=\"https://i.loli.net/2019/12/03/AGLbIupct68ThBD.png\" alt=\"图书馆\" /></p>\n<h2><a id=\"3_31\"></a>3.登录页面</h2>\n<p><img src=\"https://i.loli.net/2019/04/14/5cb2fd5b78ae7.png\" alt=\"登录页面\" /></p>\n<h2><a id=\"4_35\"></a>4.后台管理</h2>\n<p>包含 dashboard、内容管理、用户及权限管理等</p>\n<p><img src=\"https://img-blog.csdnimg.cn/20191202200516251.png\" alt=\"后台\" /></p>\n<h1><a id=\"_41\"></a>技术栈</h1>\n<h2><a id=\"1_43\"></a>1.前端技术栈</h2>\n<p>1.Vue<br />\n2.ElementUI<br />\n3.axios</p>\n<h2><a id=\"2_49\"></a>2.后端技术栈</h2>\n<p>1.Spring Boot<br />\n2.Spring Data + JPA<br />\n3.MySQL<br />\n4.Shiro</p>\n<h1><a id=\"_56\"></a>部署方法</h1>\n<p>1.clone 项目到本地</p>\n<p><code>git clone https://github.com/Antabot/White-Jotter</code></p>\n<p>2.数据库脚本放在 <code>wj</code> 项目的根目录下，在MySQL中执行数据库脚本</p>\n<p>3.数据库配置在 <code>wj</code> 项目的 <code>src\\main\\resources</code> 目录下的<code>application.properties</code> 文件中，mysql 版本为 8.0.15</p>\n<p>4.在IntelliJ IDEA中运行 <code>wj</code> 项目，为了保证项目成功运行，可以右键点击 <code>pom.xml</code> 选择 maven -&gt; reimport ，并重启项目</p>\n<p>至此，服务端就启动成功了，同时，运行 <code>wj-vue</code> 项目，访问 <code>http://localhost:8080</code> ，即可进入登录页面，默认账号是 <code>admin</code>，密码是 <code>123</code></p>\n<p>如果要做二次开发，请继续看第五、六步。</p>\n<p>5.进入到 <code>wj-vue</code> 目录中，在命令行依次输入如下命令：</p>\n<pre><code class=\"lang-\"># 安装依赖\nnpm install\n\n# 在 localhost:8080 启动项目\nnpm run dev\n\n</code></pre>\n<p>由于在 <code>wj-vue</code> 项目中已经配置了端口转发，将数据转发到SpringBoot上，因此项目启动之后，在浏览器中输入 <code>http://localhost:8080</code> 就可以访问我们的前端项目了，所有的请求通过端口转发将数据传到 SpringBoot 中（注意此时不要关闭 SpringBoot 项目）。</p>\n<p>6.最后可以用 <code>WebStorm</code> 等工具打开 <code>wj-vue</code>项目，继续开发，开发完成后，当项目要上线时，依然进入到 <code>wj-vue</code> 目录，然后执行如下命令：</p>\n<pre><code class=\"lang-\">npm run build\n</code></pre>\n<p>该命令执行成功之后， <code>wj-vue</code> 目录下生成一个 <code>dist</code> 文件夹，可以将该文件夹中的两个文件 <code>static</code> 和 <code>index.html</code> 拷贝到 <code>wj</code> 项目中 <code>resources/static/</code> 目录下，然后直接运行 <code>wj</code> 项目，访问 <code>http://localhost:8443</code> ，实际上是把前端打包后作为静态文件，但不推荐使用这种方式。</p>\n<h1><a id=\"_93\"></a>教程</h1>\n<p>我在 CSDN 上分享了开发这个项目的教程，有兴趣的小伙伴可以点击下面的链接查看。</p>\n<p>1.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88925013\" target=\"_blank\">项目简介</a></p>\n<p>2.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88926242\" target=\"_blank\">使用 CLI 搭建 Vue.js 项目</a></p>\n<p>3.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/88955387\" target=\"_blank\">前后端结合测试（登录页面开发）</a></p>\n<p>4.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/89294300\" target=\"_blank\">数据库的引入</a></p>\n<p>5.<a href=\"https://blog.csdn.net/Neuf_Soleil/article/details/89298717\" target=\"_blank\">使用 Element 辅助前端开发</a></p>\n<p>6.<a href=\"https://learner.blog.csdn.net/article/details/89422585\" target=\"_blank\">前端路由与登录拦截器</a></p>\n<p>7.<a href=\"https://learner.blog.csdn.net/article/details/89853305\" target=\"_blank\">导航栏与图书页面设计</a></p>\n<p>8.<a href=\"https://learner.blog.csdn.net/article/details/92413933\" target=\"_blank\">数据库设计与增删改查</a></p>\n<p>9.<a href=\"https://learner.blog.csdn.net/article/details/95310666\" target=\"_blank\">核心功能的前端实现</a></p>\n<p>10.<a href=\"https://learner.blog.csdn.net/article/details/97619312\" target=\"_blank\">图片上传与项目的打包部署</a></p>\n<p>11.<a href=\"https://learner.blog.csdn.net/article/details/100849732\" target=\"_blank\">用户角色权限管理模块设计</a></p>\n<p>12.<a href=\"https://learner.blog.csdn.net/article/details/101121899\" target=\"_blank\">访问控制及其实现思路</a></p>\n<p>13.<a href=\"https://learner.blog.csdn.net/article/details/102690035\" target=\"_blank\">使用 Shiro 实现用户信息加密与登录认证</a></p>\n<p>14.<a href=\"https://learner.blog.csdn.net/article/details/102788866\" target=\"_blank\">用户认证方案与完善的访问拦截</a></p>\n<p>15.<a href=\"https://learner.blog.csdn.net/article/details/103114893\" target=\"_blank\">动态加载后台菜单</a></p>\n<p>16.<a href=\"https://learner.blog.csdn.net/article/details/103250775\" target=\"_blank\">功能级访问控制的实现</a></p>\n<p>(持续更新中)</p>\n<h1><a id=\"_131\"></a>近期更新</h1>\n<p>12-01 实现功能级权限控制<br />\n11-30 利用 vue-elment-admin 项目完善后台界面设计<br />\n11-17 重构项目，完成搭建后台基础界面，实现按角色加载菜单，取消前台访问限制<br />\n04-27 使用前端拦截器，数据库迁移至 mysql 8.0.15，后台管理页面初始化<br />\n04-13 完成图片的上传功能<br />\n04-11 完成图书分类功能<br />\n04-08 完成图书分页功能<br />\n04-06 完成图书查询功能<br />\n04-05 完成图书修改功能<br />\n04-04 完成图书删除功能<br />\n04-03 完成图书新增功能</p>\n', '2021-06-25 18:29:04', 0, 24, 5, 0, NULL, NULL);
INSERT INTO `blog` VALUES (NULL, 27, 1, 'Vue简介', 'Vue.js是一套构建用户界面的渐进式框架。', 'Vue (读音 /vjuː/，类似于 view) 是一套用于构建用户界面的渐进式JavaScript框架。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用（SPA）提供驱动。![logo.png](http://localhost:8443/api/file/hci2so.png)', '2021-06-25 19:22:13', 0, 26, 0, 0, 'http://localhost:8443/api/file/s9hh5q.png', NULL);
INSERT INTO `blog` VALUES (NULL, 28, 1, 'Vue简介', 'Vue.js是一套构建用户界面的渐进式框架。', 'Vue (读音 /vjuː/，类似于 view) 是一套用于构建用户界面的渐进式JavaScript框架。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用（SPA）提供驱动。![csdn.png](http://localhost:8443/api/file/ka95dh.png)', '2021-06-25 21:18:28', 0, 0, 0, 0, '', '<p>Vue (读音 /vjuː/，类似于 view) 是一套用于构建用户界面的渐进式JavaScript框架。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用（SPA）提供驱动。<img src=\"http://localhost:8443/api/file/ka95dh.png\" alt=\"csdn.png\" /></p>\n');

-- ----------------------------
-- Table structure for broadcast
-- ----------------------------
DROP TABLE IF EXISTS `broadcast`;
CREATE TABLE `broadcast`  (
  `broadcast_id` int(0) NOT NULL AUTO_INCREMENT,
  `admin_id` int(0) DEFAULT NULL,
  `user_id` int(0) DEFAULT NULL,
  `broadcast_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `broadcast_create_time` datetime(0) NOT NULL,
  `status` tinyint(0) DEFAULT 0,
  PRIMARY KEY (`broadcast_id`) USING BTREE,
  INDEX `FK_Reference_13`(`admin_id`) USING BTREE,
  INDEX `FK_Reference_14`(`user_id`) USING BTREE,
  CONSTRAINT `FK_Reference_13` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_14` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of broadcast
-- ----------------------------
INSERT INTO `broadcast` VALUES (1, 1, 1, '开学了！！', '2020-09-01 00:00:00', 1);
INSERT INTO `broadcast` VALUES (2, 1, 1, '放假了！！！', '2020-12-05 14:52:12', 1);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '文学');
INSERT INTO `category` VALUES (2, '流行');
INSERT INTO `category` VALUES (3, '文化');
INSERT INTO `category` VALUES (4, '生活');
INSERT INTO `category` VALUES (5, '经管');
INSERT INTO `category` VALUES (6, '科技');

-- ----------------------------
-- Table structure for collections
-- ----------------------------
DROP TABLE IF EXISTS `collections`;
CREATE TABLE `collections`  (
  `collection_id` int(0) NOT NULL AUTO_INCREMENT,
  `blog_id` int(0) DEFAULT NULL,
  `user_id` int(0) DEFAULT NULL,
  `collection_create_time` datetime(0) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`collection_id`) USING BTREE,
  INDEX `FK_Reference_4`(`blog_id`) USING BTREE,
  INDEX `FK_Reference_5`(`user_id`) USING BTREE,
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收藏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collections
-- ----------------------------
INSERT INTO `collections` VALUES (22, 3, 1, '2021-06-25 20:34:38', 0);
INSERT INTO `collections` VALUES (23, 3, 1, '2021-06-25 20:34:39', 0);
INSERT INTO `collections` VALUES (24, 3, 1, '2021-06-25 20:34:39', 0);
INSERT INTO `collections` VALUES (25, 3, 1, '2021-06-25 20:34:41', 0);
INSERT INTO `collections` VALUES (26, 3, 1, '2021-06-25 20:34:42', 0);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) DEFAULT NULL COMMENT '评论人',
  `blog_id` int(0) DEFAULT NULL COMMENT '评论的博客',
  `comment_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment_create_time` datetime(0) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0:未读 1:已读 2：消息已被删除',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `1`(`blog_id`) USING BTREE,
  INDEX `2`(`user_id`) USING BTREE,
  CONSTRAINT `1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, 1, '1', '2020-01-01 00:00:00', 2);
INSERT INTO `comment` VALUES (2, 2, 1, '2121', '2021-01-02 00:00:00', 2);
INSERT INTO `comment` VALUES (3, 1, 2, '1212', '2022-01-02 00:00:00', 2);
INSERT INTO `comment` VALUES (4, 1, 1, '我真阿萨的', '2050-02-04 00:00:00', 1);
INSERT INTO `comment` VALUES (5, 2, 2, '牛牛妞妞', '2012-05-06 00:00:00', 1);
INSERT INTO `comment` VALUES (6, 1, 1, '123', '2021-06-25 17:47:25', 1);
INSERT INTO `comment` VALUES (7, 1, 1, '123', '2021-06-25 17:47:29', 1);
INSERT INTO `comment` VALUES (8, 1, 3, 'woshitom', '2021-06-17 18:30:02', 1);

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `follow_id` int(0) NOT NULL AUTO_INCREMENT,
  `fan_id` int(0) DEFAULT NULL,
  `star_id` int(0) DEFAULT NULL,
  `follow_creat_time` datetime(0) DEFAULT NULL,
  `status` tinyint(0) DEFAULT 0,
  PRIMARY KEY (`follow_id`) USING BTREE,
  INDEX `FK_Reference_8`(`fan_id`) USING BTREE,
  INDEX `FK_Reference_9`(`star_id`) USING BTREE,
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`fan_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`star_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of follow
-- ----------------------------
INSERT INTO `follow` VALUES (2, 2, 1, '2021-01-01 00:00:00', 2);

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `like_id` int(0) NOT NULL AUTO_INCREMENT,
  `blog_id` int(0) DEFAULT NULL,
  `user_id` int(0) DEFAULT NULL,
  `like_create_time` datetime(0) NOT NULL,
  `status` tinyint(0) DEFAULT 0,
  PRIMARY KEY (`like_id`) USING BTREE,
  INDEX `FK_Reference_6`(`blog_id`) USING BTREE,
  INDEX `FK_Reference_7`(`user_id`) USING BTREE,
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '点赞' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES (53, 3, 1, '2021-06-25 20:32:12', 0);
INSERT INTO `likes` VALUES (54, 3, 1, '2021-06-25 20:32:13', 0);
INSERT INTO `likes` VALUES (55, 3, 1, '2021-06-25 20:32:14', 0);
INSERT INTO `likes` VALUES (56, 3, 1, '2021-06-25 20:32:15', 0);
INSERT INTO `likes` VALUES (57, 3, 1, '2021-06-25 20:32:15', 0);
INSERT INTO `likes` VALUES (58, 3, 1, '2021-06-25 20:34:35', 0);
INSERT INTO `likes` VALUES (59, 3, 1, '2021-06-25 20:34:35', 0);
INSERT INTO `likes` VALUES (60, 3, 1, '2021-06-25 20:34:36', 0);
INSERT INTO `likes` VALUES (61, 3, 1, '2021-06-25 20:34:36', 0);
INSERT INTO `likes` VALUES (62, 3, 1, '2021-06-25 20:34:37', 0);
INSERT INTO `likes` VALUES (63, 3, 1, '2021-06-25 20:34:38', 0);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `message_id` int(0) NOT NULL AUTO_INCREMENT,
  `sender_id` int(0) DEFAULT NULL,
  `receiver_id` int(0) DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `message_create_time` datetime(0) NOT NULL,
  `is_read` tinyint(1) NOT NULL COMMENT '0:未阅读\n            1：已阅读',
  PRIMARY KEY (`message_id`) USING BTREE,
  INDEX `FK_Reference_11`(`sender_id`) USING BTREE,
  INDEX `FK_Reference_12`(`receiver_id`) USING BTREE,
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '私信' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 1, 2, 'hekloi', '2021-06-25 20:59:24', 0);
INSERT INTO `message` VALUES (2, 1, 2, 'woaini', '2021-06-25 21:07:20', 0);
INSERT INTO `message` VALUES (3, 1, 2, 'cnmd\n', '2021-06-25 21:07:29', 0);
INSERT INTO `message` VALUES (4, 2, 1, 'lalalalla', '2021-06-25 21:07:53', 1);
INSERT INTO `message` VALUES (5, 27, 1, 'dweqe', '2021-06-25 21:09:57', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT,
  `user_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '充当账户',
  `user_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '头像',
  `user_email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_create_time` datetime(0) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '是否加入黑名单\n            0：正常状态\n            1：属于黑名单',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `user_phone`(`user_phone`) USING BTREE COMMENT '用户手机号不可重复注册'
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '12312341278', '666666', 'tom', 'http://localhost:8443/api/file/4hfq0t.png', '213@1121', '2021-06-18 10:12:04', 1);
INSERT INTO `user` VALUES (2, '13234563456', '123456', '123', 'http://localhost:8443/api/file/skvyck.png', 'test@test.com', '2021-06-25 13:12:29', 1);
INSERT INTO `user` VALUES (27, '14567896789', '123456', '123', 'http://localhost:8443/api/file/skvyck.png', 'test@test.com', '2021-06-25 13:12:29', 1);

-- ----------------------------
-- Table structure for user_broadcast
-- ----------------------------
DROP TABLE IF EXISTS `user_broadcast`;
CREATE TABLE `user_broadcast`  (
  `id` int(0) NOT NULL,
  `user_id` int(0) DEFAULT NULL,
  `broadcast_id` int(0) DEFAULT NULL,
  `status` tinyint(0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `1_idx`(`user_id`) USING BTREE,
  INDEX `2_idx`(`broadcast_id`) USING BTREE,
  CONSTRAINT `foreign_key1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `foreign_key2` FOREIGN KEY (`broadcast_id`) REFERENCES `broadcast` (`broadcast_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_broadcast
-- ----------------------------
INSERT INTO `user_broadcast` VALUES (1, 1, 1, 1);
INSERT INTO `user_broadcast` VALUES (2, 2, 1, 1);

-- ----------------------------
-- Table structure for user_settings
-- ----------------------------
DROP TABLE IF EXISTS `user_settings`;
CREATE TABLE `user_settings`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT,
  `is_comment` tinyint(1) DEFAULT 1 COMMENT '0:不提醒\\n            1：提醒\\n            下面同理',
  `is_like` tinyint(1) DEFAULT 1,
  `is_follow` tinyint(1) DEFAULT 1,
  `is_broadcast` tinyint(1) DEFAULT 1,
  `comment_w` tinyint(1) DEFAULT 1,
  `like_w` tinyint(1) DEFAULT 1,
  `follow_w` tinyint(1) DEFAULT 1,
  `broadcast_w` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `FK_Reference_15` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_settings
-- ----------------------------
INSERT INTO `user_settings` VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `user_settings` VALUES (2, 0, 0, 0, 0, 0, 0, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
