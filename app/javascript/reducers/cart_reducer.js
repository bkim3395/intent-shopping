import { RECEIVE_CART } from '../actions/cart_actions';

export default ( state = {}, action) => {
    Object.freeze(state);
    switch(action.type) {
        case RECEIVE_CART:
            return action.response.cart;
        default:
            return state;
    }
}