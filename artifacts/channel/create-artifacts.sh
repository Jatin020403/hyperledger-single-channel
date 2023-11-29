#!/bin/bash

# Delete existing artifacts
rm genesis.block mychannel.tx 
rm -rf ../../channel-artifacts/*
rm -rf ./crypto-config

#Generate Crypto artifactes for organizations
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/


# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "peerChannel"
CHANNEL_NAME_IOT1="iotchannel1"
CHANNEL_NAME_IOT2="iotchannel2"
CHANNEL_NAME_IOT3="iotchannel3"
CHANNEL_NAME_PEER="peerchannel"

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_IOT1.tx -channelID $CHANNEL_NAME_IOT1

# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_IOT2.tx -channelID $CHANNEL_NAME_IOT2

# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_IOT3.tx -channelID $CHANNEL_NAME_IOT3

# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_PEER.tx -channelID $CHANNEL_NAME_PEER

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors.tx -channelID $CHANNEL_NAME_IOT1 -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org2MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org2MSPanchors.tx -channelID $CHANNEL_NAME_IOT2 -asOrg Org2MSP

echo "#######    Generating anchor peer update for Org3MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org3MSPanchors.tx -channelID $CHANNEL_NAME_IOT3 -asOrg Org3MSP
