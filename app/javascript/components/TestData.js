import AxiosClient from '../utilities/AxiosClient';
import React from "react";

export default class TestData extends React.Component {
  state = {
    isLoading: true,
    data: null,
    error: null
  }

  fetchData() {
    const TEST_QUERY = `query { testField }`;

    AxiosClient.post('/graphql', { query: TEST_QUERY })
      .then((result) => {
      this.setState({
        data: result.data.data.testField,
        isLoading: false
      });
    }).catch((error) => {
      this.setState({ error, isLoading: false });
    });
  }

  componentDidMount() {
    this.fetchData();
  }

  render () {
    const { isLoading, data, error } = this.state;
    return (
      <React.Fragment>
        {error ? <p>{error.message}</p> : null}
        {!isLoading ? <p>{data}</p> : <p>Loading...</p>}
      </React.Fragment>
    );
  }
}
