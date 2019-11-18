import React from 'react';
import { Redirect, Route, withRouter } from 'react-router-dom';
import { connect } from 'react-redux';

const msp = state => {
    return { cart: state.cart,
        };
};

const Auth = ({ cart, path, exact, component: Component }) => (
    <Route
        path={path}
        exact={exact}
        render={props => (
            cart.hasOwnProperty('session_token') ? 
            <Component {...props} /> : 
            <Redirect to="/" />
        )}
    />
);

export const AuthRoute = withRouter(connect(msp, null)(Auth));