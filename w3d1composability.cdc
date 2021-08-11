pub contract NFTContract {
    pub var totalSupply: UInt64

    pub resource NFT {
        pub let id: UInt64

        init() {
            NFTContract.totalSupply = NFTContract.totalSupply + 1
        }
    }

    pub resource NFTMinter {
        pub fun mintNFT(): @NFT {
            return <- create NFT()
        }       
    }

    init() {...}
}

/**/

pub contract RegistryNFTContract: RegistryInterface{
    // Required from RegistryInterface
    pub var clientTenants: {Address: UInt64}

    // Required from RegistryInterface
    pub fun instance(): @Tenant {...}

    // Required from RegistryInterface
    pub fun getTenants(): {Address: UInt64} {...}

    // Required from RegistryInterface
    pub resource Tenant {
        pub(set) var totalSupply: UInt64

        init() {...}
    }

    pub resource NFT {
        pub let id: UInt64

        init(_tenantRef: &Tenant) {
            _tenantRef.totalSupply = _tenantRef.totalSupply + 1
        }
    }

    pub resource NFTMinter {
        pub fun mintNFT(_tenantRef: &Tenant): @NFT {
            return <- create NFT(_tenantRef: _tenantRef)
        }       
    }

    init() {...}
}
