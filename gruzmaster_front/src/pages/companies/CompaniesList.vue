<template>
  <div>
    <base-card>
      Companies
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
          :id="company.id"
        >
        </company-item>
    </ul>
    <base-card v-else>
      <h3>You haven't got any companies yet!</h3>
    </base-card>
  </div>
</template>

<script>
import CompanyItem from '../../components/companies/CompanyItem.vue';
import BaseCard from '../../components/ui/BaseCard.vue';

export default {
  components: { CompanyItem, BaseCard },
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
      return this.$store.getters['companies/companies'].length > 0
    }
  }
}
</script>
