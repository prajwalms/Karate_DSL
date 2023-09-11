function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiURL: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
   config.userEmail='prajwaltest@gmail.com'
   config.userPass='Rooneymails5*1'
  }
  if (env == 'qa') {
     config.userEmail='prajwaltest@gmail.com'
     config.userPass='Rooneymails5*1'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature',config).authtoken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}