import { connect } from 'react-redux';
import { updateCart, fetchCart } from '../actions/cart_actions';
import { fetchCost } from '../actions/cost_actions';
import Interface from './interface';

const msp = (state) => {
    return {
        cart: state.cart,
        cost: state.cost,
        formType: 'CART',
    };
};

const mdp = (dispatch) => ({
    updateCart: (items) => {dispatch(updateCart(items))},
    fetchCost: () => dispatch(fetchCost()),
    fetchCart: () => dispatch(fetchCart())
});

export default connect(msp, mdp)(Interface);