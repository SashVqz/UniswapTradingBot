# Solidity smart contract
 
pragma solidity ^0.6.6;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IERC20.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";

contract SlippageBot {
    address public owner;
    IUniswapV2Router02 public uniswapRouter;
    IUniswapV2Factory public uniswapFactory;

    event TokensSwapped(address tokenIn, address tokenOut, uint amountIn, uint amountOut);
    event LiquidityAdded(address tokenA, address tokenB, uint amountA, uint amountB);

    constructor(address _router) public {
        owner = msg.sender;
        uniswapRouter = IUniswapV2Router02(_router);
        uniswapFactory = IUniswapV2Factory(uniswapRouter.factory());
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this function");
        _;
    }

    receive() external payable {}

    function getPair(address tokenA, address tokenB) public view returns (address) {
        return uniswapFactory.getPair(tokenA, tokenB);
    }

    function swapTokens(address tokenIn, address tokenOut, uint amountIn, uint amountOutMin, uint deadline) public onlyOwner {
        require(IERC20(tokenIn).approve(address(uniswapRouter), amountIn), "Token approval failed");

        address;
        path[0] = tokenIn;
        path[1] = tokenOut;

        uniswapRouter.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amountIn,
            amountOutMin,
            path,
            msg.sender,
            deadline
        );

        emit TokensSwapped(tokenIn, tokenOut, amountIn, amountOutMin);
    }

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        uint deadline
    ) public onlyOwner {
        require(IERC20(tokenA).approve(address(uniswapRouter), amountADesired), "Token A approval failed");
        require(IERC20(tokenB).approve(address(uniswapRouter), amountBDesired), "Token B approval failed");

        (uint amountA, uint amountB, ) = uniswapRouter.addLiquidity(
            tokenA,
            tokenB,
            amountADesired,
            amountBDesired,
            amountAMin,
            amountBMin,
            address(this),
            deadline
        );

        emit LiquidityAdded(tokenA, tokenB, amountA, amountB);
    }

    function withdrawETH() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No ETH available for withdrawal");
        msg.sender.transfer(balance);
    }

    function withdrawTokens(address token) public onlyOwner {
        uint balance = IERC20(token).balanceOf(address(this));
        require(balance > 0, "No tokens available for withdrawal");
        IERC20(token).transfer(msg.sender, balance);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getTokenBalance(address token) public view returns (uint) {
        return IERC20(token).balanceOf(address(this));
    }
}