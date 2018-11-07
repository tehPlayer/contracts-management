import React, { Component } from 'react';
import ListItem from './ListItem/ListItem';
import Backdrop from '../../UI/Backdrop/Backdrop';
import Spinner from '../../UI/Spinner/Spinner';

export default class List extends Component {

  editContract = (id) => {
    window.location.href = "/contracts/edit/" + id
  }

  render() {
    let listItems = this.props.contracts.map((contract) => (
      <ListItem
        key={contract.id}
        id={contract.id}
        clicked={this.editContract}
        vendor={contract.vendorName}
        category={contract.categoryName}
        costs={contract.costs}
        endsOn={contract.endsOn} />
    ));

    let message;
    if (listItems.length === 0) {
      message = (
        <div className="text-center">
          No contracts yet. Click on the "Add Contract" button to create your first contract
        </div>
      )
    }
    let show = true;

    return (
      <div className="contracts-list">
        { message || listItems }
      </div>
    );
  }
}
