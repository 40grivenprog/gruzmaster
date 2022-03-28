<template>
  <div>
    <base-dialog :show="!!errors" title="An error occured" @close="handleError">
      <ul>
        <li :key="error" v-for="error in errors">{{error}}</li>
      </ul>
    </base-dialog>
    <base-dialog :show="!!message" title="An error occured" @close="handleMessage">
      <p>{{message}}</p>
    </base-dialog>
    <base-dialog :show="isLoading" fixed>
      <p>Authenticating</p>
      <base-spinner></base-spinner>
    </base-dialog>
    <base-card>
      <form @submit.prevent="submitForm">
        <div class="form-control">
          <label for="email">E-Mail</label>
          <input type="email" id="email" v-model="email">
        </div>
        <div class="form-control">
          <label for="password">Password</label>
          <input type="password" id="password" v-model="password">
        </div>
        <base-button>{{ submitButtonCaption }}</base-button>
        <base-button type="button" mode="flat" @click="switchAuthMode">{{ switchModeButtonCaption }} instead</base-button>
        </form>
    </base-card>
  </div>
</template>

<script>
import BaseDialog from '../../components/ui/BaseDialog.vue';
import BaseSpinner from '../../components/ui/BaseSpinner.vue';
export default {
  components: { BaseDialog, BaseSpinner },
  data() {
    return {
      email: '',
      password: '',
      formIsValid: true,
      mode: 'login',
      isLoading: false,
      errors: null,
      message: null
    }
  },
  computed: {
    submitButtonCaption() {
      if (this.mode === 'login') {
        return 'Login';
      } else {
        return 'Signup';
      }
    },
    switchModeButtonCaption() {
      if (this.mode === 'signup') {
        return 'Login';
      } else {
        return 'Signup';
      }
    }
  },
  methods: {
    handleError() {
      this.errors = null;
    },
    handleMessage() {
      this.message = null;
    },
    async submitForm() {
      this.isLoading = true;
      
      if (this.mode === 'login') {
        await this.$store.dispatch('login', {
          email: this.email,
          password: this.password
        }).catch((err) => {
          this.errors = err.message.split("\n") || ["Failed to sinup"];
        })
      } else {
        await this.$store.dispatch('signup', {
          email: this.email,
          password: this.password
        }).catch((err) => {
          this.errors = err.message.split("\n") || ["Failed to sinup"];
        })
      }

      this.isLoading = false;
      if(this.errors){
        return;
      }

      if(this.$store.getters.isAuthenticated) {
        this.$router.replace('/companies');
      } else {
        this.message = "Signed up successfully. Please login.";
        this.mode = 'login';
      }
    },
    switchAuthMode() {
      if (this.mode === 'login'){
        this.mode = 'signup';
      } else {
        this.mode = 'login';
      }
    }
  }
}
</script>

<style scoped>
form {
  margin: 1rem;
  padding: 1rem;
}

.form-control {
  margin: 0.5rem 0;
}

label {
  font-weight: bold;
  margin-bottom: 0.5rem;
  display: block;
}

input,
textarea {
  display: block;
  width: 100%;
  font: inherit;
  border: 1px solid #ccc;
  padding: 0.15rem;
}

input:focus,
textarea:focus {
  border-color: #3d008d;
  background-color: #faf6ff;
  outline: none;
}

.errors {
  font-weight: bold;
  color: red;
}

.actions {
  text-align: center;
}
</style>
