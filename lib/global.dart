import 'package:znn_sdk_dart/znn_sdk_dart.dart';
import 'package:znn_ledger_dart/znn_ledger_dart.dart';

const znnDaemon = 'znnd';
const znnCli = 'znn-cli';
const znnCliVersion = '0.0.6';

final Zenon znnClient = Zenon();
final KeyStoreManager keyStoreManager =
    KeyStoreManager(walletPath: znnDefaultWalletDirectory);
final List<WalletManager> walletManagers = [
  keyStoreManager,
  LedgerWalletManager()
];
late final WalletDefinition walletDefinition;
late final WalletOptions? walletOptions;
late final int accountIndex;
late final Address address;
late final List<String> args;
bool verbose = false;

List<String> commandsWithWallet = [
  'send',
  'receive',
  'receiveAll',
  'autoreceive',
  'unreceived',
  'unconfirmed',
  'plasma.list',
  'plasma.fuse',
  'plasma.cancel',
  'sentinel.list',
  'sentinel.register',
  'sentinel.revoke',
  'sentinel.collect',
  'sentinel.depositQsr',
  'sentinel.withdrawQsr',
  'stake.list',
  'stake.register',
  'stake.revoke',
  'stake.collect',
  'pillar.register',
  'pillar.registerLegacy',
  'pillar.revoke',
  'pillar.delegate',
  'pillar.undelegate',
  'pillar.collect',
  'pillar.depositQsr',
  'pillar.withdrawQsr',
  'pillar.getDepositedQsr',
  'token.issue',
  'token.mint',
  'token.burn',
  'token.transferOwnership',
  'token.disableMint',
  'wallet.dumpMnemonic',
  'wallet.deriveAddresses',
  'wallet.export',
  'az.donate',
  'spork.create',
  'spork.activate',
  'htlc.create',
  'htlc.reclaim',
  'htlc.unlock',
  'htlc.denyProxy',
  'htlc.allowProxy',
  'htlc.monitor',
  'bridge.wrap.token',
  'bridge.unwrap.redeem',
  'bridge.unwrap.redeemAll',
  'bridge.guardian.proposeAdmin',
  'liquidity.stake',
  'liquidity.cancelStake',
  'liquidity.collectRewards',
  'liquidity.guardian.proposeAdmin',
  'orchestrator.changePubKey',
  'orchestrator.haltBridge',
  'orchestrator.updateWrapRequest',
  'orchestrator.unwrapToken',
];

List<String> commandsWithoutWallet = [
  'frontierMomentum',
  'balance',
  'version',
  'createHash',
  'pillar.list',
  'plasma.get',
  'token.list',
  'token.getByStandard',
  'token.getByOwner',
  'wallet.createNew',
  'wallet.createFromMnemonic',
  'wallet.list',
  'spork.list',
  'htlc.get',
  'htlc.inspect',
  'htlc.getProxyStatus',
  'stats.osInfo',
  'stats.networkInfo',
  'stats.processInfo',
  'stats.syncInfo',
  'bridge.info',
  'bridge.security',
  'bridge.timeChallenges',
  'bridge.orchestratorInfo',
  'bridge.fees',
  'bridge.network.list',
  'bridge.network.get',
  'bridge.wrap.list',
  'bridge.wrap.listByAddress',
  'bridge.wrap.listUnsigned',
  'bridge.wrap.get',
  'bridge.unwrap.list',
  'bridge.unwrap.listByAddress',
  'bridge.unwrap.listUnredeemed',
  'bridge.unwrap.get',
  'liquidity.info',
  'liquidity.security',
  'liquidity.timeChallenges',
  'liquidity.getRewardTotal',
  'liquidity.getStakeEntries',
  'liquidity.getUncollectedReward',
];

List<String> commandsWithoutConnection = [
  'version',
  'wallet.createNew',
  'wallet.createFromMnemonic',
  'wallet.list',
  'wallet.dumpMnemonic',
  'wallet.deriveAddresses',
  'wallet.export',
  'createHash',
];

List<String> adminCommands = [
  'bridge.admin.emergency',
  'bridge.admin.halt',
  'bridge.admin.unhalt',
  'bridge.admin.enableKeyGen',
  'bridge.admin.disableKeyGen',
  'bridge.admin.setTokenPair',
  'bridge.admin.removeTokenPair',
  'bridge.admin.revokeUnwrapRequest',
  'bridge.admin.setMetadata',
  'bridge.admin.nominateGuardians',
  'bridge.admin.setMetadata',
  'bridge.admin.changeAdmin',
  'bridge.admin.setOrchestratorInfo',
  'bridge.admin.setNetwork',
  'bridge.admin.removeNetwork',
  'bridge.admin.setNetworkMetadata',
  'liquidity.admin.emergency',
  'liquidity.admin.halt',
  'liquidity.admin.unhalt',
  'liquidity.admin.changeAdmin',
  'liquidity.admin.nominateGuardians',
  'liquidity.admin.unlockStakeEntries',
  'liquidity.admin.setAdditionalReward',
  'liquidity.admin.setTokenTuple',
];
