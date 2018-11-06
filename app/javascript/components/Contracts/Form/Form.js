import React, { Component } from 'react';
import axios from '../../axios_local';
import DatePicker from 'react-date-picker';
import moment from 'moment';

import Spinner from '../../UI/Spinner/Spinner';

export default class Form extends Component {
  state = {
    selectedVendor: this.props.contract.vendor_id,
    selectedCategory: this.props.contract.category_id,
    showSpinner: false,
    vendors: this.props.vendors,
    categories: this.props.categories || [],
    costs: this.props.contract.costs,
    endsOn: this.props.contract.endsOn
  };

  vendorChanged = (event) => {
    let vendor = event.target.value;
    this.setState({selectedVendor: vendor, categories: [], showSpinner: true})
    axios.get('/categories.json?vendor_id=' + vendor)
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

  categoryOptions = () => {
    return this.state.categories.map((category) => (
      <option key={category.id} value={category.id}>{category.name}</option>
    ))
  }

  setEndsOn = (date) => this.setState({endsOn: date})

  render() {
    return (
      <React.Fragment>
        <Spinner show={this.state.showSpinner} />
        <form className="user-form" action={this.props.targetAction} method="post">
          <input type="hidden" name="authenticity_token" value={this.props.csrfToken} />
          <div className="form-group">
            <label htmlFor="vendor">Vendor</label>
            <select
              className="form-control"
              onChange={this.vendorChanged}
              name="contract[vendor_id]"
              defaultValue={this.state.selectedVendor || ''}>
              <option value="" disabled>Select a vendor</option>
              {this.vendorOptions()}
            </select>
          </div>
          <div className="form-group">
            <label htmlFor="category">Category</label>
            <select
              className="form-control"
              name="contract[category_id]"
              defaultValue={this.state.selectedCategory || ''}>
              <option value="" disabled>Select a category</option>
              {this.categoryOptions()}
            </select>
          </div>
          <div className="form-group">
            <label htmlFor="costs">Costs</label>
            <input className="form-control" type="text" name="contract[costs]" value={this.state.costs} />
          </div>
          <div className="form-group">
            <label htmlFor="ends_on">Ends on</label>
            <DatePicker
              name="contract[ends_on]"
              className="form-control"
              onChange={this.setEndsOn}
              value={this.state.endsOn}/>
          </div>
          <input type="submit" className="btn" value="Submit" />
        </form>
      </React.Fragment>
    );
  }
}


