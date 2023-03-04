pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    struct Monster {
        string name;
        uint level;
        string img;
    }

    Monster[] public monsters;
    address public gameOwner;

    constructor () ERC721 ("Monster", "MNT") {
        gameOwner = msg.sender;
    } 

    modifier onlyGameOwner() {
      require(msg.sender == gameOwner, "Only game owner");
      _;
    }

    function createNewMonster(string memory _name, address _to, string memory _img) public onlyGameOwner() {
        uint id = monsters.length;
        monsters.push(Monster(_name, 1,_img));
        _safeMint(_to, id);
    }

    modifier onlyOwnerOf(uint _monsterId) {
        require(msg.sender == ownerOf(_monsterId), "Only monster owner");
        _;
    }

    function battle(uint _attackingMonsterId, uint _defendingMonsterId) public onlyOwnerOf(_attackingMonsterId) {
        Monster storage attacker = monsters[_attackingMonsterId];
        Monster storage defender = monsters[_defendingMonsterId];

        if(attacker.level >= defender.level) {
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            defender.level += 2;
        }
    }
}
