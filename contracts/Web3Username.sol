// SPDX-License-Identifier: MIT OR Apache-2.0

/// @author raldblox
/// @title Web3 Username

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {StringUtils} from "./libraries/StringUtils.sol";

contract Web3User is ERC721URIStorage {
    address payable public owner;

    mapping(string => address) public usernames;
    mapping(string => string) public qts;
    mapping(string => string) public socs;
    mapping(string => string) public mojis;
    mapping(string => string) public urls;
    mapping(string => string) public brnds;
    mapping(string => string) public clrs;
    mapping(string => string) public mts;
    mapping(string => string) public fts;
    mapping(string => string) public rts;
    mapping(string => string) public nameowners;
    mapping(string => uint256) public newTokenIds;

    constructor() payable ERC721("WEB3 USERS", "WEB3USER") {
        owner = payable(msg.sender);
    }

    //Set username and tokenid based on user name input and wallet address
    function registerName(string calldata name) public payable {
        require(usernames[name] == address(0));
        require(
            StringUtils.strlen(name) >= 1 && StringUtils.strlen(name) <= 18
        );

        //Generate token id based on sender wallet address
        string memory nameid = Strings.toString(uint256(uint160(msg.sender)));
        uint256 newTokenId = uint256(uint160(msg.sender));
        _safeMint(msg.sender, newTokenId);

        string memory nameowner = name;

        usernames[name] = msg.sender;
        nameowners[nameid] = nameowner;
        newTokenIds[name] = newTokenId;
    }

    /** GETTER FUNCTIONS **/

    function setRts(string calldata name, string calldata rt) public payable {
        require(usernames[name] == msg.sender);
        rts[name] = rt; //set rear nft styling
    }

    function setFts(string calldata name, string calldata ft) public payable {
        require(usernames[name] == msg.sender);
        fts[name] = ft; //set frontal nft styling
    }

    function setMts(string calldata name, string calldata mt) public payable {
        require(usernames[name] == msg.sender);
        mts[name] = mt; //set mid nft styling
    }

    function setQt(string calldata name, string calldata qt) public payable {
        require(usernames[name] == msg.sender);
        qts[name] = qt; //set nft quotes
    }

    function setBrnd(string calldata name, string calldata brnd)
        public
        payable
    {
        require(usernames[name] == msg.sender);
        brnds[name] = brnd; //set branding
    }

    function setMoji(string calldata name, string calldata moji)
        public
        payable
    {
        require(usernames[name] == msg.sender);
        mojis[name] = moji; //set background emoji
    }

    function setClr(string calldata name, string calldata clr) public payable {
        require(usernames[name] == msg.sender);
        clrs[name] = clr; //set background color
    }

    function setSoc(string calldata name, string calldata soc) public payable {
        require(usernames[name] == msg.sender);
        socs[name] = soc; //set social account link
    }

    function setURL(string calldata name, string calldata url) public payable {
        require(usernames[name] == msg.sender);
        urls[name] = url; //set external url
    }

    /** GETTER FUNCTIONS **/

    function getTokenId(string calldata name) public view returns (uint256) {
        return newTokenIds[name];
    }

    function getNameId() public view returns (string memory) {
        return Strings.toString(uint256(uint160(msg.sender)));
    }

    function getNameID(uint x) public pure returns (string memory) {
        return Strings.toString(uint256(uint160(x)));
    }

    function getName(string memory s) public view returns (string memory) {
        return nameowners[s];
    }

    /** NFT VISUAL GENERATOR **/

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return _buildTokenURI(tokenId);
    }

    function _buildTokenURI(uint256 tokenId)
        internal
        view
        returns (string memory)
    {
        require(_exists(tokenId), "nonexistent token");

        string memory nm = nameowners[StringUtils.toString(tokenId)];
        bytes memory image = abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(
                bytes(
                    abi.encodePacked(
                        '<?xml version="1.0" encoding="UTF-8"?><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 400 400" preserveAspectRatio="xMidYMid meet">',
                        '<filter id="A" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse" height="450" width="450"><feDropShadow dx="0" dy="1" stdDeviation="1.2" flood-opacity="1" width="200%" height="200%"/></filter>',
                        '<style type="text/css"><![CDATA[text{font-family: Work Sans; font-size: 15px;}.G {fill: none; stroke: #ffffff; text-transform: uppercase; animation: stroke-offset 60s infinite linear alternate-reverse;} @keyframes stroke-offset{ 0% {stroke-dasharray: 2 10; animation-timing-function: cubic-bezier(0.95,0,1,1) } 100% {stroke-dasharray: 200 10 200}} .G:hover {stroke: #00ff00; animation: stroke-offset 10s infinite linear alternate-reverse forwards; stroke-dasharray: 0;}]]></style>',
                        rts[nm],
                        '<rect class="R" width="400" height="400" fill="',
                        clrs[nm],
                        '"/><text class="M" x="-8" y="300" style="font-size:300px" filter="url(#A)">',
                        mojis[nm],
                        '</text><text class="G" x="40" y="60" style="font-size:30px" filter="url(#A)">',
                        brnds[nm],
                        "</text>",
                        '<a xlink:href="',
                        socs[nm],
                        '"><text class="G" x="310" y="60" fill="#ffffff" filter="url(#A)" style="font-size:30px">.me</text></a>',
                        mts[nm],
                        unicode'<text id="W" class="G" x="80" y="175" style="font-size:90px" filter="url(#A)">WE₿3</text><text id="U" class="G" x="85" y="260" style="font-size:90px" filter="url(#A)">U$ER</text><text id="U" class="H" x="40" y="355" fill="#ffffff" filter="url(#A)">',
                        qts[nm],
                        '</text><a xlink:href="',
                        urls[nm],
                        '"><text class="G" filter="url(#A)" x="40" y="325" style="font-size:30px">',
                        nm,
                        "</text></a>",
                        fts[nm],
                        "</svg>"
                    )
                )
            )
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                nm,
                                '", "image":"',
                                image,
                                '", "description": "',
                                qts[nm],
                                '",',
                                '"external_url": "',
                                urls[nm],
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    /** MODIFIERS **/

    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }

    function setUp() public onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Hello World!");
    }

    function donate() public payable {}
}
