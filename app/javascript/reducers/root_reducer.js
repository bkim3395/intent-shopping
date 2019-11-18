import { combineReducers } from 'redux';
import cart from './cart_reducer';
import items from './items_reducer';
import cost from './cost_reducer';

export default combineReducers({
    cart,
    items,
    cost
})