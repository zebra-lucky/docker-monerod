#!/bin/bash
set -e

testAlias+=(
	[monerod:trusty]='monerod'
)

imageTests+=(
	[monerod]='
		rpcpassword
	'
)
