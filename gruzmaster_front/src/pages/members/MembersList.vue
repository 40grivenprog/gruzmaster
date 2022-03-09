<template>
  <div>
    <ul>
      <li
        v-for="member in membersList"
        :key="member.id"
      >{{member.name}}</li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  created() {
    this.loadMembers();
  },
  methods: {
    async loadMembers() {
      try {
        await this.$store.dispatch('members/loadMembers');
      } catch (error) {
        this.error = error.message || 'Something went wrong!';
      }
    }
  },
  computed: {
    membersList() {
      return this.$store.getters['members/members']
    }
  }
}
</script>
