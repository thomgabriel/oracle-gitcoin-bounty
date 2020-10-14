pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract GaugePrice is ChainlinkClient {
  
    uint256 public Price;
    
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    
    /**
     * Network: Kovan
     * Oracle: Chainlink - 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e
     * Job ID: Chainlink - 29fa9aa13bf1468788b7cc4a500a45b8
     * Fee: 0.1 LINK


     * Network: Ropsten
     * Oracle address: 0xc99B3D447826532722E41bc36e644ba3479E4365
     * JobID: e6d74030e4a440898965157bc5a08abc
     * Fee: 0.1 LINK

     */
    constructor() public {
        setPublicChainlinkToken();
        oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
        jobId = "29fa9aa13bf1468788b7cc4a500a45b8";
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }
    
    /**
     * Create a Chainlink request to retrieve API response, find the target
     */
     
    function requestPrice() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        
        // Set the URL to perform the GET request on
        request.add("get", "http://ec2-18-217-97-88.us-east-2.compute.amazonaws.com/");
        
        // Set the path to find the desired data in the API response, where the response format is:
        // {"GAU":
        // }
        // {"currencies":
        // }
        // {"index":
        // }

        request.add("path", "GAU");
        
        // Multiply the result by 10^5 to remove decimals
        int timesAmount = 10**5;
        request.addInt("times", timesAmount);
        
        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    /**
     * Receive the response in the form of uint256
     */ 
    function fulfill(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        Price = _price;
    }
}