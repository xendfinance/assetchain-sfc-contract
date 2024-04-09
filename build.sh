#!/bin/bash

mkdir -pv build/contracts/pkg

for f in "./build/contracts"/*.json; do
	jq '.abi' "$f" > "${f%.json}.abi"
	jq '.bytecode' "$f" > "${f%.json}.bin"
	jq '.deployedBytecode' "$f" > "${f%.json}.bin-runtime"
done


for f in "./build/contracts"/{SFC,}.json; do
	abigen --bin="${f%.bin}" --abi="${f%.abi}" --pkg

	# 1. delete "" from bin file
	# 2. copy bin-runtime as last variable in go file
	# var ContractBinRuntime =
	#
	# //go:generate go run github.com/ethereum/go-ethereum/cmd/abigen --bin=./contract/solc/SFC.bin --abi=./contract/solc/SFC.abi --pkg=sfc100 --type=Contract --out=contract/sfc100/contract.go

done
