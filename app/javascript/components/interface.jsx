import React from 'react';
import { Link } from 'react-router-dom'
import { isEqual, merge } from 'lodash';
import Item from './item';

const SHOP = 'SHOP';
const CART = 'CART';

export default class Interface extends React.Component {

    constructor (props) {
        super(props);
        this.countItems = this.countItems.bind(this);
        this.compareCartItems = this.compareCartItems.bind(this);
    }

    componentDidMount () {
        if (!this.props.cart.hasOwnProperty('session_token')) {
            this.props.createCart().then(() => (
                this.props.fetchCost()
            )).then(() => {
                if (this.props.formType === SHOP) {
                    return this.props.fetchItems();
                } else {
                    return Promise.resolve();
                }
            });
        } else {
            this.props.fetchCost().then(() => {
                if (this.props.formType === SHOP) {
                    return this.props.fetchItems();
                } else {
                    return Promise.resolve();
                }
            });
        }
    }

    componentDidUpdate (prevProps) {
        if (prevProps.cart.hasOwnProperty('items')) {
            if (!this.compareCartItems(this.props.cart.items, prevProps.cart.items)) {
                this.props.fetchCart().then(() => {
                    this.props.fetchCost();
                })
            }
        }
    }

    countItems(items) {
        let count = {}
        for ( let item of items ) {
            if (count[item.code]) {
                count[item.code]++
            } else {
                count[item.code] = 1
            }
        }
        return count
    }

    compareCartItems(a, b) {
        let first = this.countItems(a);
        let second = this.countItems(b);
        return isEqual(first, second);
    }

    render() {
        let routerButton;
        let items = []
        if (this.props.formType === SHOP) {
            routerButton = <button className="button" type="button">
                            <Link to="/cart">View Cart</Link>
                           </button>;
            for (let code in this.props.items) {
                items.push(this.props.items[code]);
            }
            items = items.map((item, idx) => {
                return(
                    <div className="item-border">
                    <Item cart={this.props.cart}
                            formType={this.props.formType}
                            item={item}
                            updateCart={this.props.updateCart}
                            key={`${item.code}_${idx}`}
                            idx={idx}
                            />
                    </div>
                );
            })
        } else {
            routerButton = <button className="button" type="button">
                            <Link to="/">See Items</Link>
                           </button>
            items = this.props.cart.items.map((item, idx) => {
                return(
                    <div className="item-border">
                    <Item cart={this.props.cart}
                            formType={this.props.formType}
                            item={item}
                            updateCart={this.props.updateCart}
                            key={`${item.code}_${idx}`}
                            idx={idx}
                            />
                    </div>
                );
            })
        }

        return(
        <> 
            <div id="container">
                <div id="button-header">
                    {routerButton}
                    <button className="button" type="button" onClick={() => this.props.updateCart([])}>
                        Clear Cart
                    </button>
                </div>
                <div id="item-list">
                    {items}
                </div>
                <div id ="cost">
                    <h2>Total Cost: {this.props.cost}</h2>
                </div>
            </div>
        </>
        )
    }
}