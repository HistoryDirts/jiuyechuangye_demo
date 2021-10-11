<template>
  <div class="box">
    <div class="logo">
      <img src="../assets/lanLOGO.png" alt="Reg logo">
    </div>
    <div style="width: 400px; margin: 100px auto">
      <div style="font-size: 30px; text-align: center; padding: 30px 0">欢迎登录</div>
      <el-form ref="form" :model="form" size="normal" :rules="rules">
        <el-form-item prop="userid">
          <el-input class="input_box" prefix-icon="el-icon-user" v-model="form.userid" placeholder="请输入工号/学号"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input class="input_box" prefix-icon="el-icon-lock" v-model="form.password" show-password placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item>
         <div style="display: flex">
           <el-input prefix-icon="el-icon-key" v-model="form.validCode" style="width: 50%; position: relative; left:10%" placeholder="请输入验证码"></el-input>
           <ValidCode style="position: relative; right:-15%" @input="createValidCode" />
         </div>
        </el-form-item>
        <el-form-item class="input_box">
          <el-radio v-model="form.role" :label="1">学生用户</el-radio><br>
          <el-radio v-model="form.role" :label="2">导师用户</el-radio><br>
          <el-radio v-model="form.role" :label="3">企业及外部人员</el-radio><br>
          <el-radio v-model="form.role" :label="4">编辑用户</el-radio><br>
          <el-radio v-model="form.role" :label="5">管理员用户</el-radio><br>
        </el-form-item>
        <el-form-item>
          <el-button class="input_box" type="primary" @click="login">登 录</el-button>
        </el-form-item>
        <el-form-item class="input_box"><el-button type="text" @click="$router.push('/register')">前往注册 >> </el-button></el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
import ValidCode from "@/components/ValidCode";

export default {
  name: "Login",
  components: {
    ValidCode
  },
  data() {
    return {
      form: {role: 1},
      rules: {
        userid: [
          {required: true, message: '请输入学号/工号', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
      },
      validCode: ''
      // 加背景图片
      // bg: {
      //   backgroundImage: "url(" + require("@/assets/bg.jpg") + ")",
      //   backgroundRepeat: "no-repeat",
      //   backgroundSize: "100% 100%"
      // }
    }
  },
  created() {
    sessionStorage.removeItem("user")
  },
  methods: {
    // 接收验证码组件提交的 4位验证码
    createValidCode(data) {
      this.validCode = data
    },
    login() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          if (!this.form.validCode) {
            this.$message.error("请填写验证码")
            return
          }
          if(this.form.validCode.toLowerCase() !== this.validCode.toLowerCase()) {
            this.$message.error("验证码错误")
            return
          }
          request.post("/user/login", this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "登录成功"
              })
              sessionStorage.setItem("user", JSON.stringify(res.data))  // 缓存用户信息
              this.$router.push("/")  //登录成功之后进行页面的跳转，跳转到主页
            } else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
  .logo{
    position: absolute;
    left: 18%;
  }
  .box{
    width: 100%; 
    height: 100vh; 
    overflow: hidden;
    background: rgb(237, 238, 235) no-repeat;
    background-size: 100% 100%;
  }
  .input_box{
    width: 80%;
    position: relative;
    left: 10%;
  }
</style>
