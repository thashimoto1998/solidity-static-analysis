# solidity-static-analysis

このレポジトリは以下の２点をまとめたもの。
- Reentrancy Attackの攻撃ベクトルのあるコードを静的解析した結果
- 論文[A seurvey of attacks of Ethereum smart contracts](https://eprint.iacr.org/2016/1007.pdf)から参照した機弱性のあるコード


## Reentrancy Attackの静的解析
静的解析はsolidityの静的解析ツール[solhint](https://github.com/protofire/solhint)を用い行った。

Reentrancy Attackの攻撃ベクトルのあるコードは以下のコーディングアンチパターンに当てはまるものである。

コーディングアンチパターン：ETHの転送を行うtransfer関数を呼び出した後に、global stateの状態遷移を行う。

### コード例１ ReentrancyVulnerable1.sol

[ReentrancyVulnerable1.sol](./contracts/Reentrancy/ReentrancyVulnerable1.sol)はsolhintの[reentracy security rule](https://github.com/protofire/solhint/blob/master/docs/rules/security/reentrancy.md)から参照した。

solhintで静的解析した結果
```
$ solhint ./contracts/Reentrancy/ReentrancyVulnerable1.sol

./contracts/Reentrancy/ReentrancyVulnerable1.sol
  10:9  warning  Possible reentrancy vulnerabilities. Avoid state changes after transfer  reentrancy

✖ 1 problem (0 errors, 1 warning)
```
ReentrancyVulnerable1.solは上記のコーディングアンチパターンに当てはまるため、静的解析ツールsolhintでReentrancyAttackの攻撃ベクトルがあることが
検知された。

このコードはコーディングアンチパターンを回避する、つまりglobal stateの状態遷移を行った後に、transfer関数を呼び出すことで機弱性を修正することができる。
[ReentrancyInvulnerable1.sol](./contracts/Reentrancy/ReentrancyInvulnerable1.sol)は機弱性を修正したコード。

### コード例2 ReentrancyVulnerable2.sol
[ReentrancyVulnerable2.sol](./contracts/Reentrancy/ReentrancyVulnerable2.sol)は[Ethereum Smart Contract Best Practices(Known Attacks)](https://consensys.github.io/smart-contract-best-practices/known_attacks/)から参照した。

このコードの機弱性はコード例１と同様にコーディングアンチパターンを回避することで、修正することができる。
[ReentrancyInvulnerable2.sol](./contracts/Reentrancy/ReentrancyInvulnerable2.sol)は機弱性を修正したコード。

solhintで静的解析した結果
```
$ solhint ./contracts/Reentrancy/ReentrancyVulnerable2.sol

./contracts/Reentrancy/ReentrancyVulnerable2.sol
  17:9  warning  Possible reentrancy vulnerabilities. Avoid state changes after transfer  reentrancy

✖ 1 problem (0 errors, 1 warning)
```
静的解析ツールsolhintでReentrancyAttackの攻撃ベクトルがあることが検知された。

### コード例３ ReentrancyVulnerable3.sol
[ReentrancyVulnerable3.sol](./contracts/Reentrancy/ReentrancyVulnerable3.sol)は[Ethereum Smart Contract Best Practices(Known Attacks)](https://consensys.github.io/smart-contract-best-practices/known_attacks/)から参照した。

solhintで静的解析した結果
```
$ solhint ./contracts/Reentrancy/ReentrancyVulnerable3.sol

```
静的解析ツールsolhintでReentrancyAttackの攻撃ベクトルがあることが検知されなかった。

このコードは静的解析ツールsolhintで攻撃ベクトルがあることが検知されなかったが、18行目でtransferの処理を内部に有する`withdrawReward`関数を呼び出した後、
19行目でglobal stateの状態遷移を行っているためReentrancy Attackのコーディングアンチパターンに当てはまる。

静的解析ツールsolhintは一つの関数のブロック内でのみコードがReentrancy Attackのコーディングアンチパターンに当てはまるかどうか検査しているため、
検知できなかったのではないかと予想する。


このコードの機弱性はコーディングアンチパターンを回避することで修正することができる。
[ReentrancyInvulnerable3.sol](./contracts/Reentrancy/ReentrancyInvulnerable3.sol)は機弱性を修正したコード。

## 論文A seurvey of attacks of Ethereum smart contractsから参照した機弱性のあるコード
この論文はEthereumとそのHigh-levelプログラミング言語であるsolidityのセキュリティ機弱性について説明している。

[AttacksExample](./contracts/AttacksExample)はこの論文から参照した機弱性のあるコード例。

