# Concurrency

勝手にchannel派(キューの両端にくるスレッドが固定されない)とメールボックス派(キューの出口にくるスレッドが固定)というふうに分類してる.

## Channel派

### Go

スレッドセーフなMPMC実装.
[概要](https://docs.google.com/document/d/1yIAYmbvL3JxOKOjuCyon7JhW4cSv1wy5hC0ApeGMV9s/pub)

### Rust

[crossbeam-channel](https://github.com/crossbeam-rs/crossbeam-channel). スレッドセーフなMPMCキュー実装. GoのchannelとJavaのjava.util.concurrentをよく調査して実装されている.
詳細は [RFCs](https://github.com/crossbeam-rs/rfcs/blob/master/text/2017-11-09-channel.md) をみるのが一番いい.

### Nim

ChannelはスレッドセーフなMPMCキュー実装で, こちらもGoから大きく影響が見受けられている感じがしている.

## メールボックス派

### D

標準ライブラリの[std.concurrnecy](https://dlang.org/phobos/std_concurrency.html). スレッドごとにMPSCキューを持つ.
キューは連結リストで実装され動的にサイズを変更可能(unbounded Linked-lsit MPSC Queue).
通信はスレッドIDを指定してsendキューに積み、receiveでキューから取り出す。receiveは暗黙に自身のスレッドにbindしているキューから取り出すのでスレッドIDの指定は不要.

