# Proof of Snack

The global food supply chain faces challenges including food safety concerns, traceability issues, and inefficiencies. Traditional paper-based 
methods are prone to errors, making it difficult to trace contamination sources or ensure product authenticity. 

Our project is a blockchain-based food supply chain management system that uses a decentralized ledger to provide secure, transparent, traceable and immutable tracking of food products from farm to fork.

## Sections

[Go to Features](#features)
[Usage](#usage)

## Features

### Tokenization
We integrate NFT's to create a decentralized and tamper-proof ledger. Every new batch of food is registered as an ERC721 Non-Fungible Token
 via the `FoodToken.sol` smart contract. This token stores immutable product metadata such as origin, category, batch size, harvest date, and expiry date.

ERC721 is a standard for ethereum blockchain that has a unique identifier and contract address to make then unique.
They have metadata stored in `tokenURI`. They also have build in owner tracking ie ownerOf approve etc.


### 2. End-to-End Product Traceability
The `SupplyChain.sol` contract enables seamless tracking of the food journey. 
It records discrete checkpoints across four main stages: Farm, Processing, Distribution, and Retail. 
Stakeholders log the location, handler address, and critical conditions like storage temperature. 
The system also includes automated safety mechanisms, such as emitting a `ContaminationAlert` if recorded temperatures fall outside safe thresholds.

### 3. Compliance and Certification Registry
To ensure adherence to food safety regulations, the `ComplianceRegistry.sol` contract records third-party approvals and standards (e.g., FSSAI, ISO 22000, Organic India). 
Certificates are stored with issuing authority details and validity periods. A product's compliance can be instantly verified on-chain by checking if its associated certificates are active and unrevoked.

### 4. Interactive Decentralized Application (dApp) Frontend
A single-page HTML/JS frontend provides an intuitive interface for interacting with the smart contracts. It features:
* **Live Dashboard:** Displays global metrics, recent transactions, and real-time visualization of Ganache blocks.
* **Trace & Track:** Allows consumers and stakeholders to look up a product's ID to view its complete journey, QR verifications, and compliance status.
* **Ledger View:** A transparent, tamper-proof history of all supply chain actions.

---

## Usage

### Prerequisites
* **Ganache:** For running a local Ethereum blockchain.
* **Remix IDE:** For compiling and deploying the smart contracts.
* A modern web browser.

### Step 1: Start Ganache
1. Open the Ganache GUI.
2. Create a **New Workspace**.
3. Set the RPC Server to `http://127.0.0.1:7545` and Network ID to `5777`.
4. Click **Start**. Verify that 10 funded test accounts are generated.

### Step 2: Compile Contracts in Remix
1. Go to [Remix IDE](https://remix.ethereum.org).
2. Create three new files in the workspace: `FoodToken.sol`, `SupplyChain.sol`, and `ComplianceRegistry.sol`.
3. Paste the respective smart contract code into each file.
4. Go to the **Solidity Compiler** tab, set the compiler version to `0.8.20`, and compile all three contracts.

### Step 3: Deploy Contracts
1. Go to the **Deploy & Run Transactions** tab in Remix.
2. Change the Environment to **Custom - External HTTP Provider**.
3. Enter your Ganache RPC URL (`http://127.0.0.1:7545`) and connect.
4. Deploy `FoodToken.sol`. **Copy and save its deployed address.**
5. Deploy `SupplyChain.sol`. **Copy and save its deployed address.**
6. Deploy `ComplianceRegistry.sol`. **Copy and save its deployed address.**
*(You can verify the deployment by checking the Transactions tab in the Ganache GUI).*

### Step 4: Configure the Frontend
1. Open the `FoodChain_Frontend.html` file in your web browser.
2. Navigate to the **⚙ Setup** tab on the navigation bar.
3. Paste the three copied contract addresses into their respective fields.
4. Ensure the Ganache RPC URL is correct (`http://127.0.0.1:7545`).
5. Click **Save & Connect to Ganache**.

### Step 5: Interact with the System
* **Register a Product:** Go to the **Register Product** tab. Enter the product details (e.g., Organic Mangoes, Farm name, quantity) and click "Register & Mint Token".
* **Track Journey:** Go to the **Trace & Track** tab. Select your registered product. From here, you can click **Add Checkpoint** to move the product through Processing, Distribution, and Retail.
* **Add Certificates:** Go to the **Compliance** tab. Click **Add Certificate** to attach FSSAI, ISO, or other certifications to your registered product.
* **View Ledger:** Open the **Ledger** tab to see the immutable transaction hashes and block numbers mapping your entire supply chain history.
