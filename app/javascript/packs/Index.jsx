import React from 'react';
import ReactDOM from 'react-dom'
import Root from '../components/root'
import configureStore from '../store/store'

document.addEventListener('DOMContentLoaded', () => {

    // Fixes the CSRF Problem by putting this on header.
    // From <%= csrf meta-tag %>
    $.ajaxSetup({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      });
    
    //BOOTSTRAPING
    let preLoadedState = {};
    if (window.currentCart) {
        preLoadedState = {
            cart: currentCart
        };
        delete window.currentCart;
    }
    //BOOTSTRAPING

    const root = document.getElementById('root');
    const store = configureStore(preLoadedState);

    ReactDOM.render(<Root store={store}/>, root);
});