package com.example.demo.common;

import com.sun.org.apache.bcel.internal.generic.RET;

import java.sql.ResultSet;

public class Result<T> {
    private int code;
    private String msg;
    private T data;

    public int getCode(){
        return code;
    }

    public T getData() {
        return data;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public Result() {
    }

    public static Result success(){
        Result result = new Result();
        result.setCode(0);
        result.setMsg("成功");
        return result;
    }

    public static <T>  Result<T> success(T data){
        Result result = new Result();
        result.setCode(0);
        result.setMsg("成功");
        result.setData(data);
        return result;
    }

    public static Result error(int code, String msg){
        Result result = new Result();
        result.setMsg(msg);
        result.setCode(code);
        return result;
    }
}
