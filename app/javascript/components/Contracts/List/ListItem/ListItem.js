import React from 'react';
import moment from 'moment';

const ListItem = (props) => {
  return (
    <table className="table">
      <thead>
        <tr>
          <th scope="col">Vendor name</th>
          <th scope="col">Category</th>
          <th scope="col">Costs</th>
          <th scope="col">Ends on</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{props.vendor}</td>
          <td>{props.category}</td>
          <td>$ {props.costs.toFixed(2)}</td>
          <td>{parseDate(props.endsOn)}</td>
        </tr>
      </tbody>
    </table>
  )
}

function parseDate(date) {
  return moment(date).format("MMM D, YYYY")
}

export default ListItem;