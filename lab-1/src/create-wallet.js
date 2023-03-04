const bip32 = require("bip32");
const bip39 = require("bip39");
const bitcoin = require("bitcoinjs-lib");

console.log("Creating testnet account...\n");

// Network
const network = bitcoin.networks.testnet;

// Derivation
const path = "m/49'/1'/0'/0";

// Mnemonic
const mnemonic = bip39.generateMnemonic();
const seed = bip39.mnemonicToSeedSync(mnemonic);

// Account root
const root = bip32.fromSeed(seed, network);

// Accounts
const accounts = root.derivePath(path);

// Account 0
const account_0 = accounts.derive(0).derive(0);

// Address 0
const address_0 = bitcoin.payments.p2pkh({
  pubkey: account_0.publicKey,
  network: network
}).address;

console.log(`Mnemonic:\n`);
console.log(`\t${mnemonic}\n`);

console.log(`Account 0:\n`);
console.log(`\tprivate key: ${account_0.toWIF()}`);
console.log(`\taddress:     ${address_0}\n`);
