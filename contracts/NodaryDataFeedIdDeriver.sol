// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/INodaryDataFeedIdDeriver.sol";

abstract contract NodaryDataFeedIdDeriver is INodaryDataFeedIdDeriver {
    bytes32 private constant NODARY_FEED_ENDPOINT_ID =
        keccak256(abi.encode("Nodary", "feed"));

    address public immutable override nodaryAirnodeAddress;

    constructor(address _nodaryAirnodeAddress) {
        require(
            _nodaryAirnodeAddress != address(0),
            "Nodary Airnode address zero"
        );
        nodaryAirnodeAddress = _nodaryAirnodeAddress;
    }

    function deriveNodaryDataFeedId(
        bytes32 feedName
    ) internal view returns (bytes32 dataFeedId) {
        dataFeedId = keccak256(
            abi.encodePacked(
                nodaryAirnodeAddress,
                keccak256(
                    abi.encodePacked(
                        NODARY_FEED_ENDPOINT_ID,
                        abi.encode(bytes32("1s"), bytes32("name"), feedName)
                    )
                )
            )
        );
    }
}
