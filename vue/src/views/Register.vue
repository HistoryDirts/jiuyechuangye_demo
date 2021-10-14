<template>
  <div class="box">
    <div class="logo">
      <img src="../assets/lanLOGO.png" alt="Reg logo">
    </div>
    <div style="width: 400px; margin: 100px auto">
      <div style="font-size: 30px; text-align: center; padding: 30px 0"></div>
      <el-form ref="form" :model="form" size="normal" :rules="rules">
        <el-form-item class="input_box" prop="name">
          <el-input prefix-icon="el-icon-user-solid" v-model="form.name" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item class="input_box" prop="number">
          <el-input prefix-icon="el-icon-user" v-model="form.number" maxlength="12" placeholder="请输入学号/工号(12位以内)"></el-input>
        </el-form-item>
        <el-form-item class="input_box" prop="password">
          <el-input prefix-icon="el-icon-lock" v-model="form.password" maxlength="12" minlength="12" show-password placeholder="请输入密码(恰好12位)"></el-input>
        </el-form-item>
        <el-form-item class="input_box" prop="confirm">
          <el-input prefix-icon="el-icon-lock" v-model="form.confirm" maxlength="12" minlength="12" show-password placeholder="请确认密码(恰好12位)"></el-input>
        </el-form-item>
        <el-form-item label="用户身份" class="input_box">
          <el-radio-group v-model="form.identity">
            <el-radio label="student" >学生</el-radio>
            <el-radio label="teacher" >导师</el-radio><br>
            <el-radio label="company" >企业</el-radio>
            <el-radio label="other" >其他</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item>
          <el-button class="input_box" type="primary" @click="register">注册</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Register",
  data() {
    return {
      form: {identity:'student'},
      rules: {
        name: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
        ],
        number: [
          {required: true, message: '请输入学号/工号', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
        confirm: [
          {required: true, message: '请确认密码', trigger: 'blur'},
        ],
      },
    }
  },
  methods: {
    register() {

      if (this.form.password !== this.form.confirm) {
        this.$message({
          type: "error",
          message: '2次密码输入不一致！'
        })
        return
      }

      this.$refs['form'].validate((valid) => {
        if (valid) {
          // 打包上传数据
          let postdata = {name: this.form.name, number: this.form.number, password: this.form.password, identity:this.form.identity}

          request.post("/user/register", postdata).then(res => {
            if (res.code === '200') {
              this.$message({
                type: "success",
                message: "注册成功"
              })
              this.$router.push("/login")  //登录成功之后进行页面的跳转，跳转到主页
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
    background-size: cover;
  }
  .input_box{
    width: 80%;
    position: relative;
    left: 10%;
  }
</style>
