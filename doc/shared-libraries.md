Shared Libraries
================

## basemoncoinconsensus

The purpose of this library is to make the verification functionality that is critical to Bitcoin's consensus available to other applications, e.g. to language bindings.

### API

The interface is defined in the C header `basemoncoinconsensus.h` located in `src/script/basemoncoinconsensus.h`.

#### Version

`basemoncoinconsensus_version` returns an `unsigned int` with the API version *(currently `1`)*.

#### Script Validation

`basemoncoinconsensus_verify_script` returns an `int` with the status of the verification. It will be `1` if the input script correctly spends the previous output `scriptPubKey`.

##### Parameters
- `const unsigned char *scriptPubKey` - The previous output script that encumbers spending.
- `unsigned int scriptPubKeyLen` - The number of bytes for the `scriptPubKey`.
- `const unsigned char *txTo` - The transaction with the input that is spending the previous output.
- `unsigned int txToLen` - The number of bytes for the `txTo`.
- `unsigned int nIn` - The index of the input in `txTo` that spends the `scriptPubKey`.
- `unsigned int flags` - The script validation flags *(see below)*.
- `basemoncoinconsensus_error* err` - Will have the error/success code for the operation *(see below)*.

##### Script Flags
- `basemoncoinconsensus_SCRIPT_FLAGS_VERIFY_NONE`
- `basemoncoinconsensus_SCRIPT_FLAGS_VERIFY_P2SH` - Evaluate P2SH ([BIP16](https://github.com/basemoncoin-project/bips/blob/master/bip-0016.mediawiki)) subscripts
- `basemoncoinconsensus_SCRIPT_FLAGS_VERIFY_DERSIG` - Enforce strict DER ([BIP66](https://github.com/basemoncoin-project/bips/blob/master/bip-0066.mediawiki)) compliance
- `basemoncoinconsensus_SCRIPT_FLAGS_VERIFY_NULLDUMMY` - Enforce NULLDUMMY ([BIP147](https://github.com/basemoncoin-project/bips/blob/master/bip-0147.mediawiki))
- `basemoncoinconsensus_SCRIPT_FLAGS_VERIFY_CHECKLOCKTIMEVERIFY` - Enable CHECKLOCKTIMEVERIFY ([BIP65](https://github.com/basemoncoin-project/bips/blob/master/bip-0065.mediawiki))
- `basemoncoinconsensus_SCRIPT_FLAGS_VERIFY_CHECKSEQUENCEVERIFY` - Enable CHECKSEQUENCEVERIFY ([BIP112](https://github.com/basemoncoin-project/bips/blob/master/bip-0112.mediawiki))
- `basemoncoinconsensus_SCRIPT_FLAGS_VERIFY_WITNESS` - Enable WITNESS ([BIP141](https://github.com/basemoncoin-project/bips/blob/master/bip-0141.mediawiki))

##### Errors
- `basemoncoinconsensus_ERR_OK` - No errors with input parameters *(see the return value of `basemoncoinconsensus_verify_script` for the verification status)*
- `basemoncoinconsensus_ERR_TX_INDEX` - An invalid index for `txTo`
- `basemoncoinconsensus_ERR_TX_SIZE_MISMATCH` - `txToLen` did not match with the size of `txTo`
- `basemoncoinconsensus_ERR_DESERIALIZE` - An error deserializing `txTo`
- `basemoncoinconsensus_ERR_AMOUNT_REQUIRED` - Input amount is required if WITNESS is used

### Example Implementations
- [NBitcoin](https://github.com/NicolasDorier/NBitcoin/blob/master/NBitcoin/Script.cs#L814) (.NET Bindings)
- [node-libbasemoncoinconsensus](https://github.com/bitpay/node-libbasemoncoinconsensus) (Node.js Bindings)
- [java-libbasemoncoinconsensus](https://github.com/dexX7/java-libbasemoncoinconsensus) (Java Bindings)
- [basemoncoinconsensus-php](https://github.com/Bit-Wasp/basemoncoinconsensus-php) (PHP Bindings)
