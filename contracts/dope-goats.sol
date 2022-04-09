// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract DopeGoats is ERC721URIStorage {

     event DopeGoatsMinted(address sender, uint256 tokenId);

    string svgPart1 = '<svg version="1.0" xmlns="http://www.w3.org/2000/svg" width="350.000000pt" height="288.000000pt" viewBox="0 0 1280.000000 1052.000000" preserveAspectRatio="xMidYMid meet"><rect width="100%" height="100%" fill="';
    string svgPart2 = '"/><metadata>Created by potrace 1.15, written by Peter Selinger 2001-2017</metadata><g transform="translate(0.000000,1052.000000) scale(0.100000,-0.100000)" fill="';
    string scgPart3 = '" stroke="none"> <path d="M10430 10514 c0 -3 39 -54 86 -112 252 -315 412 -623 524 -1008 l32 -107 -22 -71 c-12 -39 -27 -88 -34 -108 l-11 -37 -102 137 c-265 354 -582 641 -967 877 -122 75 -286 159 -294 151 -3 -3 -3 -7 -1 -9 452 -352 783 -746 1012 -1204 l46 -91 -74 -47 c-120 -74 -251 -181 -388 -314 -121 -118 -184 -187 -526 -578 -88 -101 -166 -180 -206 -208 -115 -82 -243 -129 -505 -184 -80 -17 -170 -38 -200 -47 -30 -9 -107 -22 -170 -29 -63 -8 -144 -19 -180 -25 -36 -7 -155 -15 -265 -19 -193 -7 -202 -8 -260 -36 -57 -27 -58 -29 -30 -32 40 -5 135 -34 135 -42 0 -3 -26 -7 -58 -9 -31 -2 -128 -19 -215 -38 -87 -18 -160 -34 -163 -34 -2 0 -4 -3 -4 -7 0 -5 24 -8 53 -8 28 0 66 -4 82 -9 l30 -9 -45 -12 c-25 -7 -97 -33 -160 -58 -63 -25 -136 -48 -162 -52 -27 -4 -48 -11 -48 -15 0 -4 21 -11 48 -15 l47 -7 -55 -25 c-100 -44 -313 -121 -450 -162 -554 -164 -1107 -245 -1760 -258 -538 -10 -901 22 -1305 115 -155 35 -167 37 -355 37 -213 0 -278 -9 -460 -67 -291 -92 -586 -250 -1176 -630 -214 -138 -359 -210 -484 -241 -181 -45 -259 -34 -502 74 -233 104 -323 130 -463 136 -129 6 -191 -8 -272 -62 -44 -29 -133 -128 -133 -148 0 -3 15 -1 32 4 18 5 47 9 65 9 l31 0 -57 -57 c-57 -58 -91 -129 -91 -190 0 -24 1 -24 33 10 32 34 87 57 137 57 53 0 168 -31 237 -64 71 -34 72 -34 130 -21 32 7 59 12 60 11 1 -1 -13 -25 -32 -54 l-35 -51 42 -12 c43 -11 174 -8 216 6 l24 8 -21 -41 c-12 -23 -21 -44 -21 -47 0 -19 203 4 273 31 17 6 18 3 12 -40 l-7 -47 43 7 c104 15 204 55 268 109 17 15 31 25 31 23 0 -2 -9 -28 -20 -57 -11 -30 -18 -57 -15 -59 12 -13 162 73 213 122 l57 54 1 -161 c2 -269 44 -456 219 -957 124 -357 156 -456 189 -585 46 -184 48 -206 26 -292 -85 -336 -278 -675 -593 -1038 -38 -44 -78 -97 -89 -119 -57 -111 -72 -246 -64 -559 19 -747 19 -867 0 -992 -24 -159 -24 -293 2 -365 25 -73 50 -78 89 -18 19 29 30 38 33 28 8 -26 45 -60 120 -112 l72 -51 -6 -46 c-7 -58 13 -112 52 -138 24 -15 55 -19 214 -22 427 -8 409 -9 473 22 l58 29 -88 91 c-115 119 -175 199 -167 221 9 23 -17 49 -116 113 -117 77 -189 153 -239 255 -50 101 -69 185 -77 343 -7 137 9 428 31 557 48 276 156 480 320 603 33 25 63 45 67 45 9 0 109 -418 156 -655 79 -394 122 -765 122 -1045 0 -102 3 -130 15 -140 23 -19 59 19 107 117 41 82 41 82 67 68 35 -18 79 -67 129 -140 22 -34 47 -67 56 -74 12 -10 15 -23 10 -48 -8 -43 10 -87 42 -102 14 -6 62 -11 107 -11 45 -1 114 -5 152 -10 221 -31 345 -40 418 -30 67 8 127 20 127 24 0 0 -68 70 -151 154 -139 140 -150 154 -133 167 30 21 4 58 -81 112 -232 147 -316 206 -366 260 -79 82 -97 123 -114 256 -8 61 -29 202 -46 312 -48 314 -59 428 -59 610 0 255 33 409 124 580 50 95 322 506 432 655 98 133 243 278 308 310 88 42 124 36 261 -46 409 -244 775 -379 1207 -445 160 -25 135 -25 1486 -21 938 2 1200 15 1662 82 107 15 197 26 199 24 2 -2 -4 -97 -13 -211 -34 -421 -43 -781 -27 -1063 8 -124 7 -126 -40 -345 -135 -627 -170 -860 -149 -1008 13 -91 34 -125 85 -138 71 -19 84 -27 90 -56 16 -78 28 -106 46 -110 11 -3 19 -14 19 -25 0 -88 149 -162 393 -194 117 -15 289 -15 329 1 11 4 21 -3 34 -24 10 -17 32 -37 49 -46 23 -10 35 -25 43 -53 6 -21 25 -51 43 -67 l30 -30 132 -1 c73 0 152 -6 177 -13 61 -17 181 -8 286 20 46 13 84 26 84 29 0 3 -48 57 -107 120 -75 82 -114 133 -134 176 -33 72 -51 83 -188 113 -188 41 -208 71 -256 376 -56 357 -56 704 0 1020 17 96 28 210 35 365 23 504 37 613 100 793 40 117 64 221 90 400 23 161 42 235 71 283 10 17 60 58 111 91 281 184 440 440 477 768 37 330 93 472 361 914 157 259 207 354 251 474 37 101 89 305 129 512 60 310 112 465 163 486 30 13 87 76 87 96 0 7 7 13 16 13 9 0 32 16 51 35 30 30 42 35 81 35 26 1 67 5 92 10 25 4 47 7 49 5 1 -2 -11 -21 -28 -42 -88 -111 -89 -281 -1 -460 34 -69 57 -98 155 -194 130 -128 175 -198 175 -273 0 -39 -6 -52 -36 -86 -20 -22 -32 -40 -27 -40 30 0 158 41 218 71 55 27 92 56 177 142 130 131 142 157 136 284 -3 48 -15 142 -27 207 -20 114 -21 194 -1 225 5 9 20 4 53 -18 133 -91 288 -84 343 14 12 20 39 47 59 59 61 34 80 67 82 145 1 49 7 77 22 102 41 67 18 160 -65 264 -31 39 -101 138 -157 220 -144 214 -199 287 -287 379 -42 44 -85 97 -95 116 -16 31 -31 156 -37 300 0 14 16 64 36 113 50 118 87 263 93 369 7 100 -1 118 -51 118 -49 -1 -102 -30 -231 -130 -201 -154 -218 -159 -389 -101 -65 22 -119 41 -121 43 -2 2 -19 58 -39 125 -152 517 -483 1013 -898 1346 -93 74 -108 84 -108 71z"/> </g> </svg>';

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct DopeGoatAttributes {
        bool isMale;
        uint id;
        uint motherId;
        uint fatherId;

    }

    constructor() ERC721("Dope Goats Hprf", "DGHPRF") {
        console.log("The Dope Goats Are Born");
        _tokenIds.increment();
    }

    function makeDopeGoat(string memory background, string memory goatColour, bool isMale) public payable {
        require(msg.value >= 0.01 ether, "Not enough ETH sent: check price.");

        uint256 newItemId = _tokenIds.current();
        string memory finalSvg = string(abi.encodePacked(svgPart1, background, svgPart2, goatColour, scgPart3));
        console.log(finalSvg);

        string memory gender;
        if (isMale) {
            gender = 'Male';
        } else {
            gender = 'Female';
        }

        string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "Dope Goat (',Strings.toString(newItemId),')", "description": "A Dope Goat.", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),'","attributes": [ {"trait_type": "Gender", "value": "',gender,'" }]}'
                )
            )
        )
    );

    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    console.log(finalTokenUri);

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, finalTokenUri);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();

    //Log the NFT to the console.
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    //emit
    emit DopeGoatsMinted(msg.sender, newItemId);

    }
}