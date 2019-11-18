import { connect } from 'react-redux';
import { createCart, updateCart, fetchCart } from '../actions/cart_actions';
import { fetchCost } from '../actions/cost_actions';
import { fetchItems } from '../actions/items_actions';
import Interface from './interface';

const msp = (state) => {
    return {
        items: state.items,
        cart: state.cart,
        cost: state.cost,
        formType: 'SHOP',
    };
};

const mdp = (dispatch) => ({
    createCart: () => dispatch(createCart()),
    updateCart: (items) => {dispatch(updateCart(items))},
    fetchCost: () => dispatch(fetchCost()),
    fetchItems: () => dispatch(fetchItems()),
    fetchCart: () => dispatch(fetchCart())
});

export default connect(msp, mdp)(Interface);