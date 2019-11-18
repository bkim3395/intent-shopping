import React from 'react'
import { Route } from 'react-router-dom'
import { AuthRoute } from '../util/route_util.js'
import { Switch } from 'react-router-dom'
import Shop from './shop_container'
import Cart from './cart_container'

export default (props) => {
    return(
        <>
        <Switch>
            <AuthRoute path="/cart" component={Cart} />
            <Route exact path="/" component={Shop} />
        </Switch>
        </>
    );
}