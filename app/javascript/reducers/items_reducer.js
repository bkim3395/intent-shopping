import { RECEIVE_ITEMS } from '../actions/items_actions';

export default ( state = {}, action) => {
    Object.freeze(state);
    switch(action.type) {
        case RECEIVE_ITEMS:
            return action.response.items;
        default:
            return state;
    }
}