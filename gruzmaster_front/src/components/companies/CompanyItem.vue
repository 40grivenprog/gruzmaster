<template>
  <base-card>
    <li>
      <div>
        <h2>{{ company_name }}</h2>
      </div>
      <p class="desc">{{ company_description }}</p>
    </li>
    <base-button @click="removeCompany" mode="delete">Delete</base-button>
  </base-card>
</template>

<script>
import BaseCard from '../ui/BaseCard.vue'
export default {
  components: { BaseCard },
  props: ['id', 'company_name', 'company_description'],
  data() {
    return {}
  },
  methods: {
    removeCompany() {
      this.$store.dispatch('companies/deleteCompany', { id: this.id });
    }
  }
}
</script>

<style scoped>
  .card {
    padding: 1rem 2rem;
  }
  .desc {
    border: 1rem;
  }
</style>
