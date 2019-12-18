pragma solidity ^0.5.14;

pragma solidity ^0.5.14;

contract GrannyTestament {
    address owner;
    uint  fortune;
    bool isNoMore;
    address payable [] familyWallets;
    mapping(address => uint) inheritance;

    function setInheritance(address payable wallet, uint inheritAmount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = inheritAmount;
    }

    function payout() private sureNoMore {
        for (uint i = 0; i < familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    function dead() onlyOwner {
        isNoMore = true;
        payout();
    }
    constructor() public payable{
        owner = msg.sender;
        fortune = msg.value;
        isNoMore = false;
    }
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    modifier sureNoMore{
        require(isNoMore == true);
        _;
    }

}

