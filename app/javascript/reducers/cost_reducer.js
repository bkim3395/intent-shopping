import { RECEIVE_COST } from '../actions/cost_actions';

const _nullState = null;

export default ( state = _nullState, action) => {
    Object.freeze(state);
    switch(action.type) {
        case RECEIVE_COST:
            return action.response.cost;
        default:
            return state;
    }
}