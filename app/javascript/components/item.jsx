import React from 'react';

export default ({ cart, formType, item, updateCart, idx}) => {

    function addItem() {
        let arr = cart.items.map((item) => (item.code))
        updateCart(arr.concat([item.code]))
    }

    function removeItem() {
        let arr = cart.items.map((item) => (item.code))
        arr.splice(idx, 1);
        updateCart(arr);
    }

    let discount;
    let specialButton;
    if(item.volume_discounts.length) {
        discount = <>
            <p>Volume Discount Number: {item.volume_discounts[0].number}</p>
            <p>Volume Discount Price: {item.volume_discounts[1].price}</p>
        </>
    }

    if(formType === 'SHOP') {
        specialButton = <button className="special-button" type="button"
                        onClick={() => addItem()}
                        >+</button>;
    } else {
        specialButton = <button className="special-button" type="button"
                        onClick={() => removeItem()}
                        >-</button>;
    }

    return(
    <div className="item">
        <div className="item-description">
            <p>Description: {item.description}</p>
            <p>Unit Price: {item.unit_price}</p>
        </div>
        <div className="item-description">
            {discount}
        </div>
        <div className="item-description">
            {specialButton}
        </div>
    </div>)
}