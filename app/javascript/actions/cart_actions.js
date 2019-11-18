export const RECEIVE_CART = "RECEIVE_CART";
import * as API from '../util/api';

export const receiveCart = (response) => {
    return {
        type: RECEIVE_CART,
        response
    }
}

export const createCart = () => (dispatch) => {
    return API.createCart().then((response) => {
        dispatch(receiveCart(response));
    })
}

export const fetchCart = () => (dispatch) => {
    return API.fetchCart().then((response) => {
        dispatch(receiveCart(response));
    })
}

export const updateCart = (items) => (dispatch) => {
    return API.updateCart(items).then((response) => {
        dispatch(receiveCart(response));
    })
}