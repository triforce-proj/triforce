// SPDX-License-Identifier: MIT	
	
pragma solidity 0.6.12;	
	
/**	
 * @dev Interface of the ERC20 standard as defined in the EIP.	
*/
	
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


interface IPancakeFactory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}


interface IPancakePair {
    function sync() external;   
}


interface IPancakeRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB, uint256 liquidity);
    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external payable returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);
}

interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);


    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;


            bytes32 accountHash
         = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-
	 * checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?
	 * highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(
            data
        );
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */

abstract contract Context {
    function _msgSender() internal virtual view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal virtual view returns (bytes memory) {
        this;	// silence state mutability warning without generating bytecode
				// - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol";
abstract contract ReentrancyGuard {
    
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() internal {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

contract RewardWallet {
    constructor() public {
    }
}

contract Balancer {
    constructor() public {
    }
}
		
contract PYUKUMUKU is Context, IERC20, Ownable, ReentrancyGuard {	
    using SafeMath for uint256;
    using Address for address;

    string private _name = "PYUKUMUKU";
    string private _symbol = "pYUK";
    uint8 private _decimals = 18;

    mapping(address => uint256) internal _reflectionBalance;
    mapping(address => uint256) internal _tokenBalance;
    mapping(address => mapping(address => uint256)) internal _allowances;

    uint256 private constant MAX = ~uint256(0);
    uint256 internal _tokenTotal = 5_000_000e18; // 5 million total supply
    uint256 internal _reflectionTotal = (MAX - (MAX % _tokenTotal));

    mapping(address => bool) internal isExcludedFromFee;
    mapping(address => bool) internal _isExcluded;
    address[] internal _excluded;

    //the fee contains two decimal places so 300 = 3%
    uint256 public constant _feeDecimal = 2;
    uint256 public _taxFee = 100; //1% of a transaction's pYUK tokens will be collected as tax fee
    uint256 public _burnFee = 500; // 5% of a transaction's pYUK tokens will be burned 
    uint256 public _liquidityFee = 300; // 3% of a transaction's pYUK tokens will be collected as liquidity fee
    uint256 public _lpRewardFee = 0;

    uint256 public _liquidityRemoveFee = 300;  //3% of liquidity will be used for rebalancing mechanism
    uint256 public _rebalanceCallerFee = 500; // 5% of pYUK tokens are given to the caller of the rebalancer
    uint256 public _swapCallerFee = 100e18;   // 100 pYUK tokens will be given to the caller of transaction

    uint256 public _maxTxAmount = 15000e18;  // maximum allowed 15000 pYUK tokens per transaction

    uint256 public _taxFeeTotal;	
    uint256 public _burnFeeTotal;
    uint256 public _liquidityFeeTotal;
    uint256 public _lpRewardFeeTotal;	

    bool public tradingEnabled = false;
    bool public sellingEnabled = false;
    
    bool private inSwapAndLiquify;
    bool public swapAndLiquifyEnabled = false;
    bool public rebalanceEnabled = true;

    uint256 public minTokensBeforeSwap = 5000e18; // Contract's pYUK token balance >= 5000 pYUK Tokens
    uint256 public minTokenBeforeReward = 10e18; // Reward wallet balance >= 10 pYUK tokens for rewarding LP

    uint256 public lastRebalance = now;
    uint256 public rebalanceInterval = 1 hours; // rebalancing after every 1 hour

    IPancakeRouter02 public pancakeRouter;
    address public pancakeswapPair;
    address public rewardWallet;	
    address public ownerWallet;
    address public balancer;

    event TradingEnabled(bool enabled);
    event SellingEnabled(bool enabled);
    
    event SwapAndLiquifyEnabledUpdated(bool enabled);
    event SwapAndLiquify(uint256 tokensSwapped,uint256 ethReceived, uint256 tokensIntoLiqudity);
    event Rebalance(uint256 amount);
    event MaxTxAmountUpdated(uint256 maxTxAmount);
	
	event TaxFeeUpdated(uint256 amount);
	event BurnFeeUpdated(uint256 amount);
	event LiquidityFeeUpdated(uint256 amount);
	event LPRewardFeeUpdated(uint256 amount);
	event LiquidityRemoveFeeUpdated(uint256 amount);
	event RebalanceCallerFeeUpdated(uint256 amount);
	event SwapCallerFeeUpdated(uint256 amount);
	event MinTokensBeforeSwapUpdated(uint256 amount);
	event MinTokenBeforeRewardUpdated(uint256 amount);
	event RebalanceIntervalUpdated(uint256 amount);
	event RebalanceEnabled(bool enabled);

    modifier lockTheSwap {
	inSwapAndLiquify = true;
	_;
	inSwapAndLiquify = false;
    }

    constructor() public nonReentrant{	

	IPancakeRouter02 _pancakeRouter = IPancakeRouter02(0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F);
	// Create a pancakeswap pair for this new token

	pancakeswapPair = IPancakeFactory(_pancakeRouter.factory())
	    .createPair(address(this), _pancakeRouter.WETH());

	pancakeRouter = _pancakeRouter;

	rewardWallet = address(new RewardWallet());
	balancer = address(new Balancer());
	
	ownerWallet = msg.sender;

	isExcludedFromFee[_msgSender()] = true;
	isExcludedFromFee[address(this)] = true;

	_reflectionBalance[_msgSender()] = _reflectionTotal;
	emit Transfer(address(0), _msgSender(), _tokenTotal);
    }

    function name() public view returns (string memory) {
	return _name;
    }

    function symbol() public view returns (string memory) {
	return _symbol;
    }

    function decimals() public view returns (uint8) {
    	return _decimals;
    }

    function totalSupply() public override view returns (uint256) {
	return _tokenTotal;
    }

    function balanceOf(address account) public override view returns (uint256) {
    	if (_isExcluded[account]) return _tokenBalance[account];
	return tokenFromReflection(_reflectionBalance[account]);	
    }

    function transfer(address recipient, uint256 amount)	
    public	
	override	
	virtual	
	returns (bool)	
    {	
       _transfer(_msgSender(),recipient,amount);
	return true;
    }	

    function allowance(address owner, address spender)	
	public	
	override	
	view	
	returns (uint256)	
    {	
	return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)	
    public	
	override
	virtual	
	returns (bool)	
    {	
	_approve(_msgSender(), spender, amount);
	 return true;
    }	

    function transferFrom(	
    	address sender,	
	address recipient,	
	uint256 amount	
    ) public override virtual nonReentrant returns (bool) {
	
	_transfer(sender,recipient,amount);
	_approve(
	    sender,
	    _msgSender(),
	    _allowances[sender][_msgSender()].sub(
	        amount,
	        "BEP20: transfer amount exceeds allowance")
	    );
	return true;
    }	

    function increaseAllowance(address spender, uint256 addedValue)	
	public	
	virtual	
	returns (bool)	
    {	
	_approve(	
	    _msgSender(),	
	    spender,	
	    _allowances[_msgSender()][spender].add(addedValue)	
	);	
	return true;	
    }	

    function decreaseAllowance(address spender, uint256 subtractedValue)	
	public	
	virtual	
	returns (bool)	
    {	
	_approve(	
	   _msgSender(),	
	   spender,	
	   _allowances[_msgSender()][spender].sub(	
		subtractedValue,	
		"BEP20: decreased allowance below zero")
	    );
	return true;	
    }	

    function isExcluded(address account) public view returns (bool) {	
	return _isExcluded[account];
    }

    function reflectionFromToken(uint256 tokenAmount, bool deductTransferFee)	
    public	
	view	
	returns (uint256)	
    {	
	require(tokenAmount <= _tokenTotal, "Amount must be less than supply");	
	if (!deductTransferFee) {	
	    return tokenAmount.mul(_getReflectionRate());	
	} else {	
	    return	
		tokenAmount.sub(tokenAmount.mul(_taxFee).div(10**(_feeDecimal + 2))).mul(	
		   _getReflectionRate());	
	}
    }

    function tokenFromReflection(uint256 reflectionAmount)	
	public	
	view	
	returns (uint256)	
    {
	require(	
	    reflectionAmount <= _reflectionTotal,	
            "Amount must be less than total reflections"	
	);	
	
	uint256 currentRate = _getReflectionRate();	
	return reflectionAmount.div(currentRate);	
    }	

    function excludeAccount(address account) external onlyOwner() {	

	require(	
	    account != 0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F,	
	    "PYUKUMUKU: We can not exclude Pancakeswap router."	
	);

	require(account != address(this), 'PYUKUMUKU: We can not exclude contract self.');	
	require(account != rewardWallet, 'PYUKUMUKU: We can not exclude reward wallet.');	
	require(!_isExcluded[account], "PYUKUMUKU: Account is already excluded");	

	if (_reflectionBalance[account] > 0) {	
	   _tokenBalance[account] = tokenFromReflection(	
		_reflectionBalance[account]	
	   );
	}	
	_isExcluded[account] = true;	
	_excluded.push(account);	
    }

    function includeAccount(address account) external onlyOwner() {	
	
    	require(_isExcluded[account], "PYUKUMUKU: Account is already included");
    	uint256 length = _excluded.length;
    	for (uint256 i = 0; i < length; i++) {	
    	    if (_excluded[i] == account) {	
    		_excluded[i] = _excluded[length - 1];	
    		_tokenBalance[account] = 0;	
    		_isExcluded[account] = false;	
    		_excluded.pop();	
    		break;	
    	    }	
    	}
    }	

    function _approve(	
    	address owner,	
    	address spender,	
    	uint256 amount	
    ) private {	
    	require(owner != address(0), "BEP20: approve from the zero address");	
    	require(spender != address(0), "BEP20: approve to the zero address");	
    	require(sellingEnabled || owner == ownerWallet, "Trading is locked.");	//d3vgen |===|}>
    	_allowances[owner][spender] = amount;	
    	emit Approval(owner, spender, amount);	
    }

    function _transfer(	
    	address sender,	
    	address recipient,	
    	uint256 amount	
    ) private nonReentrant {	
    	require(sender != address(0), "BEP20: transfer from the zero address");	
    	require(recipient != address(0), "BEP20: transfer to the zero address");	
    	require(amount > 0, "Transfer amount must be greater than zero");	
    	require(tradingEnabled || sender == owner() || recipient == owner() ||	
    		isExcludedFromFee[sender] || isExcludedFromFee[recipient], "Trading is locked");	
    
    	if(sender != owner() && recipient != owner() && !inSwapAndLiquify) {	
    		require(amount <= _maxTxAmount, "PYUKUMUKU: Transfer amount exceeds the maxTxAmount.");	
    	}	

    	//swapAndLiquify or rebalance(don't do both at once or it will cost too much gas)	
    
    	if(!inSwapAndLiquify) {	
    	    bool swap = true;	
    	    if(now > lastRebalance + rebalanceInterval && rebalanceEnabled){	
    		uint256 lpBalance = IERC20(pancakeswapPair).balanceOf(address(this));	
    		if(lpBalance > 100) {	
    		    _rebalance(lpBalance);	
    		    swap = false;	
    		}	
    	    }
    	    if(swap) {	
    		uint256 contractTokenBalance = balanceOf(address(this));	
    		bool overMinTokenBalance = contractTokenBalance >= minTokensBeforeSwap;	
    		if (overMinTokenBalance && sender != pancakeswapPair && swapAndLiquifyEnabled) {	
    		    swapAndLiquify(contractTokenBalance, sender);	
    		    rewardLiquidityProviders();	
    		}	
    	    }	
    	}	

    	uint256 transferAmount = amount;	
    	uint256 rate = _getReflectionRate();	
    
    	if(!isExcludedFromFee[_msgSender()] && !isExcludedFromFee[recipient] && !inSwapAndLiquify){	
    	    transferAmount = collectFee(sender,amount,rate);	
    	}	
    
    	//transfer reflection	
    	_reflectionBalance[sender] = _reflectionBalance[sender].sub(amount.mul(rate));	
    	_reflectionBalance[recipient] = _reflectionBalance[recipient].add(transferAmount.mul(rate));	
    
    	//if any account belongs to the excludedAccount transfer token	
    	if (_isExcluded[sender]) {	
    	    _tokenBalance[sender] = _tokenBalance[sender].sub(amount);	
    	}	
    
    	if (_isExcluded[recipient]) {	
    	    _tokenBalance[recipient] = _tokenBalance[recipient].add(transferAmount);	
    	}	
    
	emit Transfer(sender, recipient, transferAmount);	
    }	
    
    function collectFee(address account, uint256 amount, uint256 rate) private returns (uint256) {	
    	uint256 transferAmount = amount;	
    
    	//tax fee	
    	if(_taxFee != 0) {	
    	    uint256 taxFee = amount.mul(_taxFee).div(10**(_feeDecimal + 2));	
    	    transferAmount = transferAmount.sub(taxFee);	
    	    _reflectionTotal = _reflectionTotal.sub(taxFee.mul(rate));	
    	    _taxFeeTotal = _taxFeeTotal.add(taxFee);	
    	}	
    
    	//take liquidity fee	
    	if(_liquidityFee != 0) {	
    	    uint256 liquidityFee = amount.mul(_liquidityFee).div(10**(_feeDecimal + 2));	
    	    transferAmount = transferAmount.sub(liquidityFee);	
    	    _reflectionBalance[address(this)] = _reflectionBalance[address(this)].add(liquidityFee.mul(rate));	
    	    _liquidityFeeTotal = _liquidityFeeTotal.add(liquidityFee);	
    	    emit Transfer(account,address(this),liquidityFee);	
    	}	
    
    	//take lp Reward fee	
    	if(_lpRewardFee != 0)  {	
    	    uint256 lpRewardFee = amount.mul(_lpRewardFee).div(10**(_feeDecimal + 2));	
    	    transferAmount = transferAmount.sub(lpRewardFee);	
    	    _reflectionBalance[rewardWallet] = _reflectionBalance[rewardWallet].add(lpRewardFee.mul(rate));	
    	    _lpRewardFeeTotal = _lpRewardFeeTotal.add(lpRewardFee);	
    	    emit Transfer(account,rewardWallet,lpRewardFee);	
    	}	
    
    	//take burn fee	
    	if(_burnFee != 0) {	
    	    uint256 burnFee = amount.mul(_burnFee).div(10**(_feeDecimal + 2));	
    	    transferAmount = transferAmount.sub(burnFee);	
    	    _tokenTotal = _tokenTotal.sub(burnFee);	
    	    _reflectionTotal = _reflectionTotal.sub(burnFee.mul(rate));	
    	    _burnFeeTotal = _burnFeeTotal.add(burnFee);	
    	    emit Transfer(account,address(0),burnFee);	
    	}	
    
    	return transferAmount;	
    }	

    function _getReflectionRate() private view returns (uint256) {	
    	uint256 reflectionSupply = _reflectionTotal;	
    	uint256 tokenSupply = _tokenTotal;	
    	uint256 length = _excluded.length;
    	for (uint256 i = 0; i < length; i++) {	
    	    if (	
    		_reflectionBalance[_excluded[i]] > reflectionSupply ||	
    		_tokenBalance[_excluded[i]] > tokenSupply	
    	    ) return _reflectionTotal.div(_tokenTotal);	
    	    reflectionSupply = reflectionSupply.sub(	
    		_reflectionBalance[_excluded[i]]	
    	    );	
    	    tokenSupply = tokenSupply.sub(_tokenBalance[_excluded[i]]);	
    	}	
    	if (reflectionSupply < _reflectionTotal.div(_tokenTotal))	
    	    return _reflectionTotal.div(_tokenTotal);	
    	return reflectionSupply.div(tokenSupply);	
    }

    function swapAndLiquify(uint256 contractTokenBalance, address sender) private nonReentrant lockTheSwap {	

    	// split the contract balance except swapCallerFee into halves	
    	uint256 lockedForSwap = contractTokenBalance.sub(_swapCallerFee);	
    
    	// split the contract balance into halves	
    	uint256 half = lockedForSwap.div(2);	
    	uint256 otherHalf = lockedForSwap.sub(half);	
    
    	/* capture the contract's current ETH balance.	
    	 * this is so that we can capture exactly the amount of ETH that the	
    	 * swap creates, and not make the liquidity event include any ETH that	
    	 * has been manually sent to the contract 	
    	 */	
    
    	uint256 initialBalance = address(this).balance;	
    
    	// swap tokens for ETH	
    	swapTokensForEth(half); 	
    
    	// how much ETH did we just swap into?	
    	uint256 newBalance = address(this).balance.sub(initialBalance);	
    
    	// add liquidity to pancakeswap	
    	addLiquidity(otherHalf, newBalance);	
    
    	emit SwapAndLiquify(half, newBalance, otherHalf);	
    
    	//give the swap caller fee	
    	_transfer(address(this), sender, _swapCallerFee);	
    }	

    function swapTokensForEth(uint256 tokenAmount) private {	

    	// generate the pancakeswap pair path of token -> weth	
    	address[] memory path = new address[](2);	
    	path[0] = address(this);	
    	path[1] = pancakeRouter.WETH();	
    
    	_approve(address(this), address(pancakeRouter), tokenAmount);	
    
    	// make the swap	
    	pancakeRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(	
    	    tokenAmount,	
    	    0, // accept any amount of ETH	
    	    path,	
    	    address(this),	
    	    block.timestamp	
    	);	
    }	

    function swapEthForTokens(uint256 EthAmount) private {	
    	address[] memory path = new address[](2);	
    	path[0] = pancakeRouter.WETH();	
    	path[1] = address(this);	
    
    	pancakeRouter.swapExactETHForTokensSupportingFeeOnTransferTokens{value: EthAmount}(	
    		0,	
    		path,	
    		address(balancer),	
    		block.timestamp	
    	    );	
    }	

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {	

    	// approve token transfer to cover all possible scenarios	
    	_approve(address(this), address(pancakeRouter), tokenAmount);	
    
    	// add the liquidity	
    	pancakeRouter.addLiquidityETH{value: ethAmount}(	
    	    address(this),	
    	    tokenAmount,	
    	    0, // slippage is unavoidable	
    	    0, // slippage is unavoidable	
    	    address(this),	
    	    block.timestamp	
    	);
    }

    function removeLiquidityETH(uint256 lpAmount) private returns(uint256 ETHAmount) {	

    	IERC20(pancakeswapPair).approve(address(pancakeRouter), lpAmount);	
    
    	(ETHAmount) = pancakeRouter.removeLiquidityETHSupportingFeeOnTransferTokens(	
    		address(this),	
    		lpAmount,	
    		0,	
    		0,	
    		address(this),	
    		block.timestamp	
    	    );	
    }

    function rewardLiquidityProviders() private {	

    	uint256 tokenBalance = balanceOf(rewardWallet);	
    
    	if(tokenBalance > minTokenBeforeReward) {	
    	    uint256 rewardAmount = reflectionFromToken(tokenBalance, false);	
    	    _reflectionBalance[pancakeswapPair] = _reflectionBalance[pancakeswapPair].add(rewardAmount);	
    	    _reflectionBalance[rewardWallet] = _reflectionBalance[rewardWallet].sub(rewardAmount);	
    	    emit Transfer(rewardWallet, pancakeswapPair, tokenBalance);	
    	    IPancakePair(pancakeswapPair).sync();	
    	}	
    }

    function rebalance() public {	
    	require(now > lastRebalance + rebalanceInterval, 'PYUKUMUKU: Not yet time for Rebalance');
    	require(balanceOf(_msgSender()) >= 500e18, 'PYUKUMUKU: Not allowed Rebalance.');	
    
    	uint256 lpBalance = IERC20(pancakeswapPair).balanceOf(address(this));	
    	require(lpBalance > 100, "LP balance of contract should be greater than 100");	
    
    	_rebalance(lpBalance);	
    }

    function _rebalance(uint256 lpBalance) private nonReentrant lockTheSwap {	

    	lastRebalance = now;	
    
    	uint256 amountToRemove = lpBalance.mul(_liquidityRemoveFee).div(10**(_feeDecimal + 2));	
    
    	// how much tokens we have before swap now, so we don't burn the liqudity tokens as well	
    	removeLiquidityETH(amountToRemove);	
    
    	// pancakeswap doesn't allow for a token to by itself
    	// so we have to use an external account, which in this case is called the balancer	
    	swapEthForTokens(address(this).balance);	
    
    	// how much tokens we swaped into	
    	uint256 swapedTokens = balanceOf(address(balancer));	
    	uint256 rewardForCaller = swapedTokens.mul(_rebalanceCallerFee).div(10**(_feeDecimal + 2));	
    	uint256 amountToBurn = swapedTokens.sub(rewardForCaller);	
    
    	uint256 rate =  _getReflectionRate();	
    
    	_reflectionBalance[_msgSender()] = _reflectionBalance[_msgSender()].add(rewardForCaller.mul(rate));	
    	_reflectionBalance[address(balancer)] = 0;	
    
    	_burnFeeTotal = _burnFeeTotal.add(amountToBurn);	
    	_tokenTotal = _tokenTotal.sub(amountToBurn);	
    	_reflectionTotal = _reflectionTotal.sub(amountToBurn.mul(rate));	
    
    	emit Transfer(address(balancer), _msgSender(), rewardForCaller);	
    	emit Transfer(address(balancer), address(0), amountToBurn);	
    	emit Rebalance(amountToBurn);
    }	

    function setEnableTrading(bool enabled) external onlyOwner() {	
    	tradingEnabled = enabled;	
    	emit TradingEnabled(enabled);	
    }	

    function setEnableSelling(bool enabled) external onlyOwner() {	
    	sellingEnabled = enabled;	
    	emit SellingEnabled(enabled);	
    }

    function setExcludedFromFee(address account, bool excluded) external onlyOwner {	
    	isExcludedFromFee[account] = excluded;	
    }	

    function setSwapAndLiquifyEnabled(bool enabled) external onlyOwner {	
	swapAndLiquifyEnabled = enabled;	
	emit SwapAndLiquifyEnabledUpdated(enabled);	
    }	

    function setMaxTxAmount(uint256 maxTxAmount) external onlyOwner() {	
    	require(maxTxAmount >= 500e18 , 'PYUKUMUKU: maxTxAmount should be greater than 500');	
    	_maxTxAmount = maxTxAmount;	
    	emit MaxTxAmountUpdated(maxTxAmount);	
    }

    function setTaxFee(uint256 fee) external onlyOwner {
		require(fee <= 1000e18 , 'PYUKUMUKU: Tax Fee should not be greater than 10%');	
    	_taxFee = fee;
		emit TaxFeeUpdated(fee);
    }	

    function setBurnFee(uint256 fee) external onlyOwner {
		require(fee <= 1000e18 , 'PYUKUMUKU: Burn Fee should not be greater than 10%');
		_burnFee = fee;
		emit BurnFeeUpdated(fee);
    }	

    function setLiquidityFee(uint256 fee) external onlyOwner {
		require(fee <= 1000e18 , 'PYUKUMUKU: Liquidity Fee should not be greater than 10%');
		_liquidityFee = fee;
		emit LiquidityFeeUpdated(fee);
    }	

    function setLpRewardFee(uint256 fee) external onlyOwner {	
		require(fee <= 1000e18 , 'PYUKUMUKU: LPReward Fee should not be greater than 10%');
		_lpRewardFee = fee;
		emit LPRewardFeeUpdated(fee);
    }	

    function setLiquidityRemoveFee(uint256 fee) external onlyOwner {	
		require(fee <= 1000e18 , 'PYUKUMUKU: LiquidityRemove Fee should not be greater than 10%');
		_liquidityRemoveFee = fee;
		emit LiquidityRemoveFeeUpdated(fee);
		
    }

    function setRebalanceCallerFee(uint256 fee) external onlyOwner {	
		require(fee <= 5000e18 , 'PYUKUMUKU: LiquidityRemove Fee should not be greater than 50%');
		_rebalanceCallerFee = fee;
		emit RebalanceCallerFeeUpdated(fee);
    }	

    function setSwapCallerFee(uint256 fee) external onlyOwner {	
		require(fee <= 1000e18 , 'PYUKUMUKU: LiquidityRemove Fee should not be greater than 10%');
		_swapCallerFee = fee;
		emit SwapCallerFeeUpdated(fee);
    }	

    function setMinTokensBeforeSwap(uint256 amount) external onlyOwner {	
		require(amount > 0, "MinTokensBeforeSwap should be more than zero");
		minTokensBeforeSwap = amount;
		emit MinTokensBeforeSwapUpdated(amount);
    }	

    function setMinTokenBeforeReward(uint256 amount) external onlyOwner {	
		require(amount > 0, "MinTokensBeforeReward should be more than zero");
		minTokenBeforeReward = amount;
		emit MinTokenBeforeRewardUpdated(amount);
    }	

    function setRebalanceInterval(uint256 interval) external onlyOwner {	
		rebalanceInterval = interval;
		emit RebalanceIntervalUpdated(interval);
    }
    
    function setRebalanceEnabled(bool enabled) external onlyOwner {	
    	rebalanceEnabled = enabled;
		emit RebalanceEnabled(enabled);
    }

    // Admin function to remove tokens mistakenly sent to this address
    function transferAnyBEP20Tokens(address _tokenAddr, address _to, uint256 _amount) external onlyOwner {
        require(IERC20(_tokenAddr).transfer(_to, _amount), "Transfer failed");
    }

    function transferBNB(address payable recipient, uint256 amount) external onlyOwner  {
		
		require(recipient != address(0), "Address cannot be a zero address");
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    receive() external payable {}
}
