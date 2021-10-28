package com.twice.crud.controller;

import java.util.HashMap;

/**
 * @program: 1.ssm-maven-crud
 * @author: ChenCanYU
 * @create: 2021-10-24 23:42
 **/
public class Msg {

    /**
     * 状态码，返回页面执行信息。
     */
    private int code;

    /**
     * 提示信息
     */
    private String message;

    /**
     * 存储浏览器请求域信息
     */
    private HashMap<String, Object> store = new HashMap<String, Object>();

    /**
     * 向store中添加数据
     */
    public Msg add(String org, Object dest) {
        this.store.put(org, dest);
        return this;
    }

    public static Msg success() {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMessage("处理成功");
        return msg;
    }

    public static Msg fail() {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMessage("处理失败");
        return msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public HashMap<String, Object> getStore() {
        return store;
    }

    public void setStore(HashMap<String, Object> store) {
        this.store = store;
    }
}
