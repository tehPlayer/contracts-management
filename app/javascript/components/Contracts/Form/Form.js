import React, { Component } from 'react';
import axios from '../../axios_local';

import Spinner from '../../UI/Spinner/Spinner';

export default class Form extends Component {
  state = {
    selectedVendor: null,
    selectedCategory: null,
    showSpinner: false,
    vendors: this.props.vendors,
    categories: [],
  };

  pullCategories = () => {
    this.setState({categories: [], showSpinner: true})
    axios.get('/categories.json', {vendor_id: this.state.selectedVendor})
      .then(response => {
        console.log(response);
        this.setState({categories: response.data, showSpinner: false,});
      })
      .catch(error => {
        this.setState({showSpinner: false});
      });
  }

  vendorOptions = () => {
    return this.state.vendors.map((vendor) => (
      <option key={vendor.id} value={vendor.id}>{vendor.name}</option>
    ))
  }

  render() {
    return (
      <React.Fragment>
        <Spinner show={this.state.showSpinner} />
        <form action="/contracts" method="post">
          <div className="form-group">
            <label htmlFor="vendor">Vendor</label>
            <select
              className="form-control"
              onChange={this.pullCategories}
              name="vendor_id">
              {this.vendorOptions()}
            </select>
          </div>
          <div className="form-group">
            <label htmlFor="category">Category</label>
            <select className="form-control" name="category_id">
              {this.state.categoryOptions}
            </select>
          </div>
        </form>
      </React.Fragment>
    );
  }
}


