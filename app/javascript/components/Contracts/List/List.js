import React from 'react';
import ListItem from './ListItem/ListItem';
import Backdrop from '../../UI/Backdrop/Backdrop';
import Spinner from '../../UI/Spinner/Spinner';

const List = (props) => {
  let listItems = props.contracts.map((contract) => (
    <ListItem
      key={contract.id}
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
};

export default List;