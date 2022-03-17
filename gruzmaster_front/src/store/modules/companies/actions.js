export default {
  async loadCompanies (context, data){
    data;
    const url = "http://localhost:3000/companies"
    const headers = {
      'Authorization': `Bearer ${context.rootGetters.token}`,
      'Content-Type': 'application/json'
    }
    const response = await fetch(url, {
      method: 'GET',
      headers: headers
      })
      
    const responseData = await response.json();

    if (!response.ok) {
      const error = new Error(responseData.message || 'Failed to authenticate.');
      throw error;
    }

    const companies = []
    for (const key in responseData) {
      const company = {
        id: responseData[key].id,
        company_name: responseData[key].company_name,
        company_description: responseData[key].company_description
      };
      companies.push(company);
    }

    context.commit('setCompanies', companies);
  }
};
