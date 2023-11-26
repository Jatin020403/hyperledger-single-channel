
# Delete existing artifacts
rm genesis.block mychannel.tx 
rm -rf ../../channel-artifacts/*
rm -rf ./crypto-config

#Generate Crypto artifactes for organizations
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/


# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "peerChannel"
CHANNEL_NAME_IOT="iotchannel"
CHANNEL_NAME_PEER="peerChannel"

echo $CHANNEL_NAME_IOT

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_IOT.tx -channelID $CHANNEL_NAME_IOT

# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_PEER.tx -channelID $CHANNEL_NAME_PEER

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors.tx -channelID $CHANNEL_NAME_IOT -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org2MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org2MSPanchors.tx -channelID $CHANNEL_NAME_IOT -asOrg Org2MSP

echo "#######    Generating anchor peer update for Org3MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org3MSPanchors.tx -channelID $CHANNEL_NAME_IOT -asOrg Org3MSP

