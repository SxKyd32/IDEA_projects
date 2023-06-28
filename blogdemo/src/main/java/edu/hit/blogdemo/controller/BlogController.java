package edu.hit.blogdemo.controller;

import edu.hit.blogdemo.pojo.Blog;
import edu.hit.blogdemo.pojo.Collections;
import edu.hit.blogdemo.pojo.Likes;
import edu.hit.blogdemo.pojo.User;
import edu.hit.blogdemo.result.Result;
import edu.hit.blogdemo.result.ResultFactory;
import edu.hit.blogdemo.service.BlogService;
import edu.hit.blogdemo.service.CollectionsService;
import edu.hit.blogdemo.service.CommentService;
import edu.hit.blogdemo.service.LikesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;


@RestController
public class BlogController {
    @Autowired
    BlogService blogService;
    @Autowired
    LikesService likesService;
    @Autowired
    CollectionsService collectionsService;
    @Autowired
    CommentService commentService;

    @CrossOrigin
    @GetMapping("/api/blog/{size}/{page}")
    //分页查询博文信息
    public Result listArticles(@PathVariable("size") int size, @PathVariable("page") int page) {
        return ResultFactory.buildSuccessResult(blogService.list(page - 1, size));
    }
    @CrossOrigin
    @GetMapping("/api/blog/{id}")
    //根据博文Id获取博文信息
    public Result getOneArticle(@PathVariable("id") int blogId) {
        return ResultFactory.buildSuccessResult(blogService.findByBlogId(blogId));
    }



    @CrossOrigin
    @GetMapping("/api/searchblog/{title}")
    //搜索文章
    public Result searchArticle(@PathVariable("title") String title) {
        return ResultFactory.buildSuccessResult(blogService.search(title));
    }


    @CrossOrigin
    @PostMapping("/api/likeblog/{id}")
    @ResponseBody
    //点赞博文
    public Result likeBlog(@PathVariable("id") int blogId,@RequestBody Likes likes ) {
        Blog blog = blogService.findByBlogId(blogId);
        //用户之前未点赞
        if(likesService.findByBlogIdAndUserId(blogId,blog.getUserId()) == null){
            //更新点赞数
            blog.setLikeNum(blog.getLikeNum()+1);
            //更新文章点赞数
            blogService.addOrUpdate(blog);
            //更新用户-点赞数据
            likesService.addOrUpdate(likes);
            System.out.println("成功点赞！");
            return ResultFactory.buildSuccessResult(blog);
        }
        //用户已点过赞
        else{
            //删除用户-点赞数据信息
            likesService.deleteUserLikes(likesService
                    .findByBlogIdAndUserId(blogId,blog.getUserId()).getLikeId());
            //文章点赞数-1
            blog.setLikeNum(blog.getLikeNum()-1);
            //更新文章点赞数
            blogService.addOrUpdate(blog);
            System.out.println("取消点赞！已删除点赞数据！");
            return ResultFactory.buildSuccessResult("取消点赞");
        }
    }



    @CrossOrigin
    @GetMapping("/api/checklikeblog/{id}")
    @ResponseBody
    //点赞博文
    public Result checkLikeBlog(@PathVariable("id") int blogId) {
        Blog blog = blogService.findByBlogId(blogId);
        //用户之前未点赞
        if(likesService.findByBlogIdAndUserId(blogId,blog.getUserId()) == null){
            //Do Nothing just Check
            return ResultFactory.buildSuccessResult("未点赞");
        }
        //用户已点过赞
        else{
            return ResultFactory.buildSuccessResult("已点赞");
        }
    }

    @CrossOrigin
    @GetMapping("/api/searchuserlikes")
    //查询用户-点赞数据
    public List<Likes> searchAllUserLikes() {
        return likesService.searchAllUserLikes();
    }








    @CrossOrigin
    @PostMapping("/api/collectionblog/{id}")
    @ResponseBody
    //收藏博文
    public Result collectionBlog(@PathVariable("id") int blogId,@RequestBody Collections collections ) {
        Blog blog = blogService.findByBlogId(blogId);
        //用户之前未收藏
        if(collectionsService.findByBlogIdAndUserId(blogId,blog.getUserId()) == null){
            //更新收藏数
            blog.setCollectionNum(blog.getCollectionNum()+1);
            //更新文章收藏数
            blogService.addOrUpdate(blog);
            //更新用户-收藏数据
            collectionsService.addOrUpdate(collections);
            System.out.println("成功收藏！");
            return ResultFactory.buildSuccessResult(blog);
        }
        //用户已收藏
        else{
            //删除用户-收藏数据信息
            collectionsService.deleteUserCollections(collectionsService
                    .findByBlogIdAndUserId(blogId,blog.getUserId()).getCollectionId());
            //文章收藏数-1
            blog.setCollectionNum(blog.getCollectionNum()-1);
            //更新文章收藏数
            blogService.addOrUpdate(blog);
            System.out.println("取消收藏！已删除收藏数据！");
            return ResultFactory.buildSuccessResult("取消收藏");
        }
    }

    @CrossOrigin
    @GetMapping("/api/checkcollectionblog/{id}")
    @ResponseBody
    //收藏博文
    public Result checkCollectionBlog(@PathVariable("id") int blogId) {
        Blog blog = blogService.findByBlogId(blogId);
        //用户之前未收藏
        if(collectionsService.findByBlogIdAndUserId(blogId,blog.getUserId()) == null){
            //Do Nothing just Check
            return ResultFactory.buildSuccessResult("未收藏");
        }
        //用户已收藏
        else{
            return ResultFactory.buildSuccessResult("已收藏");
        }
    }

    @CrossOrigin
    @GetMapping("/api/searchusercollections")
    //查询用户-收藏数据
    public List<Collections> searchAllUserCollections() {
        return collectionsService.searchAllUserCollections();
    }



    @CrossOrigin
    @GetMapping("/api/comment/{size}/{page}")
    //分页查询评论信息
    public Result listComments(@PathVariable("size") int size, @PathVariable("page") int page) {
        return ResultFactory.buildSuccessResult(commentService.list(page - 1, size));
    }
    @CrossOrigin
    @GetMapping("/api/comment/{id}")
    //根据commentId获取评论信息
    public Result getOneComment(@PathVariable("id") int commentId) {
        return ResultFactory.buildSuccessResult(commentService.findByCommentId(commentId));
    }



    //新增评论信息


}
