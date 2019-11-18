export const RECEIVE_ITEMS = "RECEIVE_ITEMS";
import * as API from '../util/api';

export const receiveItems = (response) => {
    return {
        type: RECEIVE_ITEMS,
        response
    }
}

export const fetchItems = () => (dispatch) => {
    return API.fetchItems().then((response) => {
        dispatch(receiveItems(response))
    })
}