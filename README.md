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
         ┌───────────────┐     ┌──────────────┐
        │ P2P Sync (Rust)│ --> │ L1 Ring Buffer │
        └─────────────── ┘     └──────────────┘
                  │
                  ▼
       (mmap) MemTable / SSTable (Rust)
                  │
                  ▼
     ┌─────────────────────┐
     │ Dart Isolate (FFI)  │  <-- Runs in background
     └─────────────────────┘
                  │
                  ▼
     ┌──────────────────────┐
     │ RxDart Stream (Push) │  <-- Streams new posts
     └──────────────────────┘
                  │
                  ▼
     ┌──────────────────────┐
     │ EventBuffer<T> (Cache)│  <-- Keeps 100 posts in memory
     └──────────────────────┘
                  │
                  ▼
     ┌──────────────────────┐
     │ GridView (Flutter UI) │  <-- Updates only affected tiles
     └──────────────────────┘

```

### Contributing

Contributions are welcome! Please read the [contributing guidelines](CONTRIBUTING.md) first.

### License

This project is licensed under the Mozilla Public License 2.0 - see the [LICENSE](LICENSE) file for details.