///SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.28;
//Contract
contract InsurePay {

    // Estructura para almacenar datos de seguro y destino
    struct Insurance {
        address company;       // Wallet company
        address wallet;        // Billetera destino
        uint256 amount;         // Monto requerido (en wei)
        string insuranceType;   // Tipo de seguro (ej: "Vida", "Auto")
        bool isActive;   
    }

    // Mapeo: ID de seguro => Datos del seguro
    mapping(uint256 => Insurance) public insurances;
    address public owner;
    // Eventos para registrar acciones
    event InsuranceAdded(uint256 id, address company,address wallet, uint256 amount, string insuranceType);
    event PaymentProcessed(uint256 id, address payer, uint256 amount);
    event InsuranceRemoved(uint256 indexed id);
    event InsuranceUpdated(uint256 id, address newWallet, uint256 newAmount); // Nuevo evento
    // Solo el administrador puede agregar/editar seguros
  
    constructor (){
        owner = msg.sender;
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el administrador puede ejecutar esto");
        _;
    }

    // Agregar o actualizar un seguro
    function addInsurance(
        uint256 _id,
        address _company,
        address _wallet,
        uint256 _amount,
        string memory _insuranceType
    ) external onlyOwner {
        require(insurances[_id].isActive == false, "El ID ya esta en uso"); // Nueva verificacion
        insurances[_id] = Insurance(_company, _wallet, _amount, _insuranceType, true);
        emit InsuranceAdded(_id, _company, _wallet, _amount, _insuranceType);
    }

    // Eliminar seguro
    function removeInsurance(uint256 _id) external onlyOwner {
        require(insurances[_id].wallet != address(0), "Seguro no existe");
        delete insurances[_id];
        emit InsuranceRemoved(_id);
    }
    // Función para actualizar seguros existentes
    function updateInsurance(
        uint256 _id,
        address _newWallet,
        uint256 _newAmount
    ) external onlyOwner {
        require(insurances[_id].isActive, "Seguro no existe");
        insurances[_id].wallet = _newWallet;
        insurances[_id].amount = _newAmount;
        emit InsuranceUpdated(_id, _newWallet, _newAmount);
    }

    // Pagar un seguro específico
    function payInsurance(uint256 _id) external payable {
        Insurance memory insurance = insurances[_id];
        require(msg.value == insurance.amount, "Monto incorrecto");
        require(insurance.wallet != address(0), "Seguro no registrado");

    // Enviar el pago a la billetera destino
        (bool success, ) = insurance.wallet.call{value: msg.value}("");
        require(success, "Transferencia fallida");

        emit PaymentProcessed(_id, msg.sender, msg.value);
    }
}
