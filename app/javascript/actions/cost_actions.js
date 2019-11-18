export const RECEIVE_COST = "RECEIVE_COST";
import * as API from '../util/api';

export const receiveCost = (response) => {
    return {
        type: RECEIVE_COST,
        response
    }
}

export const fetchCost = () => (dispatch) => {
    return API.fetchCost().then((response) => {
        dispatch(receiveCost(response))
    })
}