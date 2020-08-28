import { gql, useQuery } from '@apollo/client';

import React from 'react';

const TEST_QUERY = gql`query { testField {
	testField
	errors
}
}`;

export default function TestData() {
  const {loading, error, data} = useQuery(TEST_QUERY);

  if (loading) {
    return (
      <div>Loading</div>
    );
  } else if (error) {
    return (
      <div>Something went wrong! {error.message}</div>
    );
  } else {
    return (
      <div>
       <p>{data.testField?.testField}</p>
       <p>{data.testField?.errors}</p>
      </div>
    );
  }
}
