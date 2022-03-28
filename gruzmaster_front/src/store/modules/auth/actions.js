export default {
  async login(context, payload) {
    await context.dispatch('auth', {
      ...payload,
      mode: 'login'
    })
  },
  async signup(context, payload) {
    await context.dispatch('auth', {
      ...payload,
      mode: 'signup'
    })
  },
  async logout(context) {
    let headers = {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${context.rootGetters.token}`
    }

    let url = 'http://localhost:3000/users/sign_out';

    const response = await fetch(url, {
      method: 'DELETE',
      headers: headers
      })

    const responseData = await response.json();

    if (!response.ok) {
      const error = new Error(responseData.message || 'Failed to log out.');
      throw error;
    }

    localStorage.removeItem('token');
    localStorage.removeItem('userId');

    context.commit('setUser', {
      token: null,
      userId: null,
      tokenExpiration: null
    })
  },
  async auth(context, payload) {
    const mode = payload.mode;
    
    let headers = {
      "Content-Type": "application/json",
    }

    let url = 'http://localhost:3000/users/sign_in';

    if (mode === 'signup'){
      url = 'http://localhost:3000/users';
      headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    }

    const response = await fetch(url, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({
        user: {
          email: payload.email,
          password: payload.password,
        }
      })
      })

      const responseData = await response.json();

      if (!response.ok) {
        const error = new Error(responseData.messages.join("\n") || ['Failed to authenticate.']);
        throw error;
      }

      localStorage.setItem('token', responseData.token);
      localStorage.setItem('userId', responseData.user_id);
      localStorage.setItem('isAdmin', responseData.is_admin);

      context.commit('setUser', {
        token: responseData.token,
        userId: responseData.user_id,
        isAdmin: responseData.is_admin,
        tokenExpiration: responseData.expiresIn
      })
    },
    tryLogin(context) {
      const token = localStorage.getItem('token');
      const userId = localStorage.getItem('userId');
      const isAdmin = JSON.parse(localStorage.getItem('isAdmin'));

      if (token && userId) {
        context.commit('setUser', {
          token: token,
          userId: userId,
          isAdmin: isAdmin,
          tokenExpiration: null
        })
      }
    }
  }
