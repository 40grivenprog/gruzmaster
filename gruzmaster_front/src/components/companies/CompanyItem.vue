<template>
  <li>
    <div>
      <h2>{{ company_name }}</h2>
    </div>
    <p>{{ company_description }}</p>
  </li>
</template>

<script>
export default {
  props: ['company_name', 'company_description'],
  data() {
    return {}
  }
}
</script>
