a solidity ^0.4.0;
contract CarInsurance {
    
    enum Location{ longtitute, latitude  }
    enum ActionChoices { GoLeft, GoRight, GoStraight, GoBack}
    
    uint private idGen = 1;
    uint private carIDGen = 1;
    
    struct Car{
        uint mileage;
        Insuree owner;
        bool paid;
        uint carID;
    }
    
    struct Insuree{
        mapping(string => Car) carsOwned;
        address owner;
        uint ID;
    }
    
    mapping(uint => Insuree) users;
    mapping(uint => uint) insurance;
    mapping(uint => uint) insurancePrice;
    mapping(uint => uint) tripDistance;
    mapping(uint => bool) paid;
    
    modifier onlyBy(address user)
    {
        require(msg.sender == user);
        _;
    }
    
    function startPolicy() returns(string){
        //this.ID = idGen;
        idGen += 1;
    }
    
    function registerCar(Insuree person, uint miles, string name) public returns(bool){
        require(msg.sender == person.owner);
        Car newCar;
        newCar.mileage = miles;
        newCar.owner = person;
        newCar.paid = true;
        newCar.carID = carIDGen;
        carIDGen += 1;
        person.carsOwned[name] = newCar;
        return true;
    }
    
    function getPrice(Insuree person, string name) public returns(uint){
        uint carID = person.carsOwned[name].carID;
        return insurancePrice[carID];
    }
    
    function getCarID(Insuree person, string name) public returns(uint){
        return person.carsOwned[name].carID;
    }
    
    function takeATrip(Insuree person, string name){
        uint carID = person.carsOwned[name].carID;
        tripDistance[carID] += 1;
    }
    
    function getInsuranceTripCost(Insuree person, string name) public returns(uint){
        uint car = person.carsOwned[name].carID;
        uint totalDistance = tripDistance[car];
        uint price = insurancePrice[car];
        return totalDistance * price;
    }
    
    //function isEnough()
    
    
    function(){
        revert();
    }
}

