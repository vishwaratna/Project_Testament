# Project_Testament
Smart Contract that executes a Will after the death of a person.

# **Idea:**

###### Granny's WILL on BlockChain

**Ramzo Sharma** is my Friend. His Granny has some fortune and she want it to pass it to Ramzo and Samzo(Ramzo's elder brother).

Few days back I visited Ramzo's home and had some talk with the Granny. She told me , Vishwa you are are Blockchain enthusiast could you 
deploy a Smart Contract which will automatically settle my inheritance delivered down to my family through means of a will(Testament) when I pass away.

A traditional will is a legal document which documents who gets what, how much and when.
At the time of execution of traditinal will, a Judge from court needs to revise the document and make the decision accordingily by passing the inheritance legally
to respected parties.
A common situation is that during the execution of will family tends to get into feud on the ground of who gets what, and this leads to 
neverending saltiness in family relations, and usually destroy the bonding between families.

As the matter gets worst, the emotions and repetetive hearings could influence the decision of the judge, which could inturn result in unfair results.

I thought for a while and then nodded by head in affirmation and came up with the below smart contract on Ethereum Blockchain.


Granny has 50,000 USD as saving, I converted them all to ethereum at 100$ per Ethereum.
So, we have now a fixed number of ethereum i.e. 500 ETH.

According to Granny's WILL:

###### She want to give 2/5 portion or 40%  of her whole wealth to Ramzo and 3/5 or 60% of her whole wealth to Samzo.

We started to model our smart contract with the version of smart contract:

`pragma solidity ^0.5.14;`

Next we define the name of contract as GrannyTestament, a contract must be prepended with word “contract”, followed by open/close curly brackets 
to contain the logic.

`contract GrannyTestament {
//Our Logic goes Here
}`

Defining Granny's Fortune, Owner of Will , mechanism to detect if Granny is alive or if dead

Let’s start by declaring each one by one:

**1.** The amount of ETH Granny has left behind

**2.** The owner of the contract (WIll Referred Here)

**3.** A Mechanism that tells us if Granny is still alive or Dead.

**4.** A constructor function that sets these values.This special function will execute automatically upon the contract’s deployment.


`
        contract GrannyTestament {
        uint  fortune;
        address owner;
        bool isNoMore;
	    constructor() public payable{
        owner = msg.sender;
        fortune = msg.value;
        isNoMore = false;
    }
}`

Public means that the function can be called within the contract and outside of it by someone else or another contract.
"`payable`" is a modifier that can be added to a function. It allows the function to send and receive ether, without payable the function will not accept payment or send one.
The constructor has this modifier so that when we deploy the contract we can initialize it with an ether balance, in this case 500.
 
When the contract receives ether, it will store it in its own address.
Here, we set the owner to "`msg.sender`", which is a built-in global variable representative of the address that is calling the function. 
In this case, it will be granny.

**Modifier**:

A modifier allows you to control the behavior of your smart contract functions. 
It includes a variety of use cases, such as restricting who has the ability to run a given function, 
unlocking functions at a certain time frame or when a certain condition is met etc.

`modifier onlyOwner{
        require(msg.sender == owner);
        _;  // It act as anchor which tends to return to calling method.
    }
    modifier sureNoMore{
        require(isNoMore == true);
        _; // It act as anchor which tends to return to calling method.
    }`

Combining modifier (onlyOwner ) with functions as below:

`function dead() onlyOwner{
    isNoMore = true;
        payout();
    }

function payout() private sureNoMore{
        for(uint i=0;i<familyWallets.length;i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }`
  
Remember in the begenning at the constructor call we made isNoMore to false, and it will only be turned by the grandma to true i.e she is no more alive.
I know you have question that how the hell grandma can turn this from false to true when she herself is no more.
Please bear with me, you will understand everything soon as our contract completes.

The function dead when execute only when the modifier sureNoMore is turned to true, and it can only be turned true by the grandma's address, i.e contract owner.
As soon as the dead function is executed ,i.e the grandma is no more then it will inturn trigger the payout(), where the distribution logic is written.

But wait a second, we need to define who gets what, and more importantly we need to add the address of the two sons where the wealth(ETH) will go.
The condition of adding the successor of grandma's wealth must be done only by her, no one else should alter her will.
For that we will write a function where grandma will set up the address of her successors and the amount they all will get each, Remember: No one else should be able to addor alter address or amount in this function.

Setting up the addresses of successors:

As we stated before, Ramzo will receive 40 ETH and Samzo will inherit 60. 
Let’s create a list to store their wallet addresses and a function that sets the inheritance for each address.

    address payable [] familyWallets;
    mapping(address => uint) inheritance;
	
Here we created an array of type addresses which will hold both brothers address.
Mapping is just a data structure which has mapping for all address in universe to its size i.e address=>uint, by default the all address in this universe is mapped to zero until unless defined otherwise.	

function setInheritance(address payable wallet, uint inheritAmount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet]= inheritAmount;
    }

Now coming to function setInheritance which will be executed only by granny, here we pass son's address and the amount to each one by one.
Now , we utilise the array familyWallets. We add each son address to this array.
We also added the amount as value by inheritance[wallet]= inheritance.

**Now our smart contract is ready and we are now ready to deploy it on ethereum blockchain. But wait, before we deploy this smart contract on the Ethereum Blockchain 
we must discuss one last question, one you may have been wondering throughout the journey. 
How on earth is granny suppose to call the function if she’s dead?!? 
A futuristic solution would be to somehow have an IOT device that can remotely track a heartbeat that would have the power to execute the function 
if the beat stopped for more than x amount of time. Here Comes the Combined power of IOT and Blockchain.**
