export default {
  async loadMembers (context, data){
    console.log(context);
    console.log(data);
    const url = "http://localhost:3000/member-data"
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
      console.log(responseData);
      const error = new Error(responseData.message || 'Failed to authenticate.');
      throw error;
    }

    const members = []
    for (const key in responseData) {
      const member = {
        id: responseData[key].id,
        name: responseData[key].name,
      };
      members.push(member);
    }

    context.commit('setMembers', members);
  }
};
