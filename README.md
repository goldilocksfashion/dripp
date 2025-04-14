# Dripp.ai


## P2P Decentralized App

This project is a peer-to-peer (P2P) decentralized application built using Flutter. It aims to provide a secure and efficient way for users to interact directly without the need for intermediaries.

### Features

- Decentralized network architecture
- Secure peer-to-peer communication
- User-friendly interface
- Cross-platform support

### Installation

To get started with this project, follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/goldilocksfashion/dripp.git
    ```
2. Navigate to the project directory:
    ```sh
    cd dripp
    ```
3. Install dependencies:
    ```sh
    flutter pub get
    ```
4. Run the application:
    ```sh
    flutter run
    ```

### 
Some details on whats at work here (more detailed documentation to follow):

```ascii 
               ┌────────────────────────────────────────────────┐
             │  ZeroID + OneChain + Xaeroflux (dripp‑backend) │
             │                                                │
             │  • Identity (DID, zk proofs)                   │
             │  • Blockchain (OneChain, NFTs, anchoring)      │
             │  • Data Sync, Merkle‑based diffs, integrated     │
             │    network (P2P with IPv6/QUIC/Tor fallbacks)    │
             └────────────────────────────────────────────────┘
                                 │
                                 ▼
             ┌────────────────────────────────────────────────┐
             │  Crossbeam Bounded Channel                     │
             │  (Acts as an event ring buffer; equivalent to    │
             │   a ring buffer in traditional architectures)  │
             └────────────────────────────────────────────────┘
                                 │
                                 ▼
             ┌────────────────────────────────────────────────┐
             │  Dart Isolate (FFI Bridge)                     │
             │  (Runs in the background, enabling FFI         │
             │   communication with the Flutter app)          │
             └────────────────────────────────────────────────┘
                                 │
                                 ▼
             ┌────────────────────────────────────────────────┐
             │  RxDart Stream (Push Model)                    │
             │  (Streams new posts to the Flutter UI)         │
             └────────────────────────────────────────────────┘
                                 │
                                 ▼
             ┌────────────────────────────────────────────────┐
             │  EventBuffer<T> (In-Memory Cache)              │
             │  (Keeps the latest ~100 posts available)       │
             └────────────────────────────────────────────────┘
                                 │
                                 ▼
             ┌────────────────────────────────────────────────┐
             │  GridView (Flutter UI Layer)                   │
             │  (Updates only affected tiles on-screen)       │
             └────────────────────────────────────────────────┘

```

### Contributing
This initiative is powered by blockxaero open source projects here: https://github.com/block-xaero
Head over there to contribute in building privacy focussed social networks or any other dreams of cloudless, privacy focussed apps you wish to for better of community.

### License

This project is licensed under the Business Source License (All underlying plumbing is MPL v 2 (see block-xaero for more details) - see the [LICENSE](LICENSE) file for details.
