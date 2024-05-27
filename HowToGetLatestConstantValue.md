#  How to get up to date constants info


1. `cd` into contracts repo and attach to truffle console

`npx truffle console --network testnet`


2. Bind SFCI ABI to SFC contract to get the latest version of ConstantsManager addr

- SFC is always located at 0xFC00FACE00000000000000000000000000000000

- command below created instance

`const sfcI = await new web3.eth.Contract(SFCI.abi, '0xFC00FACE00000000000000000000000000000000')`

3. Print all SFCI metadata

`sfcI` <- just type variable name

3. Get the most up to date consts manager addr

```
truffle(testnet)> await sfcI.methods.constsAddress().call();
'0xA21E405CB2CbAEC7988bdc6746B87A2149D2987C'

```

4. create consts manager instance

`truffle(testnet)> const constsMngr = new web3.eth.Contract(ConstantsManager.abi, '0xA21E405CB2CbAEC7988bdc6746B87A2149D2987C');`


5. Print debug info

`truffle(testnet)> constsMngr`

6. Call required method and get param info 

```
truffle(testnet)> await constsMngr.methods.burntFeeShare().call();
'200000000000000000'
```
