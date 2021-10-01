<template>
  <div class="home">
<!--    <img alt="Vue logo" src="../assets/logo.png">-->
    <CorsTest />
  </div>

</template>

<script>
// @ is an alias to /src
import CorsTest from '../components/CorsTest.vue'

export default {
  name: 'Home',
  components: {
    CorsTest
  },


}
</script>
