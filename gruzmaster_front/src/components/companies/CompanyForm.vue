<template>
  <div>
    <base-dialog :show="!!errors" title="An error occured" @close="handleError">
      <ul>
        <li :key="error" v-for="error in errors">{{error}}</li>
      </ul>
    </base-dialog>
    <base-card>
      <div class="title">
        <h2>Company Registration</h2>
      </div>
      <form @submit.prevent="submitForm">
        <div class="form-control">
          <label for="company_name">Company Name</label>
          <input id="company_name" v-model="company_name">
        </div>
        <div class="form-control">
          <label for="company_description">Company Description</label>
          <textarea id="company_description" v-model="company_description"></textarea>
        </div>
        <base-button>Submit</base-button>
        </form>
    </base-card>
  </div>
</template>

<script>
import BaseDialog from '../ui/BaseDialog.vue';
export default {
  components: { BaseDialog },
  data() {
    return {
      company_name: '',
      company_description: '',
      isLoading: false,
      errors: null
    }
  },
  methods: {
    handleError() {
      this.errors = null;
    },
    async submitForm() {
      this.isLoading = true;
      try {
        await this.$store.dispatch('companies/createCompany', {
          company_name: this.company_name,
          company_description: this.company_description
        });
      } catch(error) {
        this.errors = error.message.split(',');
      }
      
      this.isLoading = false;

      if(!this.errors) {
        this.$router.replace('/companies')
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
.title {
  width: 300px;
  position: inherit;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
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
