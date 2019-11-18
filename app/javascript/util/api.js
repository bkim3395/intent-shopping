// import $ from 'jquery'; 

export const createCart = () => (
    $.ajax({
        url: '/api/cart',
        method: 'POST'
    })
);

export const fetchCart = () => (
    $.ajax({
        url: '/api/cart',
        method: 'GET'
    })
)

export const fetchItems = () => (
    $.ajax({
        url: '/api/items',
        method: 'GET'
    })
);

export const fetchCost = () => (
    $.ajax({
        url: '/api/cost',
        method: 'GET'
    })
);

export const updateCart = (items) => {
    console.log('api', items)
    return $.ajax({
        url: '/api/cart',
        method: 'PUT',
        data: { items: items }
    })
};