<template>
  <div>
    <base-card>
      Company Card
    </base-card>
    <div v-if="isLoading">
      <base-spinner></base-spinner>
    </div>
    <ul v-else-if="!isLoading && hasCompanies">
      <company-item
        v-for="company in companiesList"
        :key="company.id"
        :company_name="company.company_name"
        :company_description="company.company_description"
      >
      </company-item>
    </ul>
    <h3 v-else>You haven't got any companies yet!</h3>
  </div>
</template>

<script>
import CompanyItem from '../../components/companies/CompanyItem.vue';

export default {
  components: { CompanyItem },
  data() {
    return {
      isLoading: false,
    }
  },
  created() {
    this.loadCompanies();
  },
  methods: {
    async loadCompanies() {
      this.isLoading = true;
      try {
        await this.$store.dispatch('companies/loadCompanies');
      } catch (error) {
        this.error = error.message || 'Something went wrong!';
      }
      this.isLoading = false;
    }
  },
  computed: {
    companiesList() {
      return this.$store.getters['companies/companies']
    },
    hasCompanies() {
      return this.$store.getters['companies/companies']
    }
  }
}
</script>
