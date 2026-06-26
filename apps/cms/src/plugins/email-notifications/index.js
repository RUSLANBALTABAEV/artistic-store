'use strict';

module.exports = () => ({
  register: ({ strapi }) => {
    // Plugin registration logic
    console.log('Email notifications plugin loaded');
  },
  bootstrap: ({ strapi }) => {
    // Plugin bootstrap logic
    console.log('Email notifications plugin bootstrapped');
  },
});
