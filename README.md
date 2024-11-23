# Backpack Tools Checker

This project is a Roblox system designed to ensure that players' tools in their backpacks are consistent with what the server expects. The system includes:

- A **LocalScript** that scans the player's backpack and sends the tool data to the server every 10 seconds.
- A **Server Script** that validates the tools sent by the client and kicks the player if:
  - The tool data doesn't match what the server detects.
  - The player fails to send their tool data within the allowed 10-second window.

---

## Features

- **Backpack Validation:** Ensures that the tools in the player's backpack are not manipulated by exploits.
- **Heartbeat Mechanism:** Tracks whether players are sending tool data regularly.
- **Server-Side Authority:** The server validates all tool data, ensuring security against client-side tampering.

---

## How It Works

1. **LocalScript**:
   - Runs on the client side.
   - Scans the player's backpack every 10 seconds.
   - Sends the player's name and tool data to the server via a pre-existing `ToolsChecker` RemoteEvent.

2. **Server Script**:
   - Listens for tool data from the client.
   - Compares the client-sent tool list with the actual tools in the server's version of the player's backpack.
   - Tracks the last communication time for each player to ensure they are sending data regularly.
   - Kicks players if:
     - The tool data mismatches.
     - The player fails to send data within 10 seconds.

---

## Installation

1. Clone or download this repository to your local machine.
2. Add the **LocalScript** to `StarterPlayerScripts`.
3. Add the **Server Script** to `ServerScriptService`.
4. Ensure a `RemoteEvent` named `ToolsChecker` exists in `ReplicatedStorage`.

---

