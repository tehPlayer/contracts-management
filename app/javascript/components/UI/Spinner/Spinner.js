import React from 'react';

import Backdrop from '../Backdrop/Backdrop';

import './Spinner.css';

const spinner = (props) => (
  <Backdrop show={props.show}>
    <div className="Loader">Loading...</div>
  </Backdrop>
);

export default spinner;
