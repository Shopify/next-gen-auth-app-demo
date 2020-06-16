import {gql} from "apollo-boost";
import React from "react";
import {useQuery} from "@apollo/react-hooks";

const TEST_QUERY = gql`query { testField }`;

export default function TestData() {
    const {loading, error, data} = useQuery(TEST_QUERY);

    if (loading) {
        return (
            <div>'Loading'</div>
        );
    } else if (error) {
        console.log(error)
        return (
            <div>Something went wrong {error.message}</div>
        );
    } else {
        return (
            <p>{data.testField}</p>
        );
    }
}
