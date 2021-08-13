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



pub contract RegistryNFTContract: RegistryInterface {
    // Required from RegistryInterface
    pub var clientTenants: {Address: UInt64}

    // Required from RegistryInterface
    pub fun instance(): @Tenant {...}

    // Required from RegistryInterface
    pub fun getTenants(): {Address: UInt64} {...}

    // We define a resource interface called ITenantMinter
    // that allows this contract to call updateTotalSupply.
    pub resource interface ITenantMinter {
        access(contract) fun updateTotalSupply()
    }

    // Required from RegistryInterface
    pub resource Tenant: ITenantMinter {
        pub(set) var totalSupply: UInt64

        // Define an updateTotalSupply function to be exposed
        // by the ITenantMinter resource interface.
        access(contract) fun updateTotalSupply() {
            self.totalSupply = self.totalSupply + 1
        }

        init() {...}
    }

    pub resource NFT {
        pub let id: UInt64

        init(_tenantRef: &Tenant{ITenantMinter}) {
            _tenantRef.updateTotalSupply()
        }
    }

    pub resource NFTMinter {
        pub fun mintNFT(_tenantRef: &Tenant{ITenantMinter}): @NFT {
            return <- create NFT(_tenantRef: _tenantRef)
        }       
    }

    init() {...}
}



pub contract RegistryNFTContract: RegistryInterface {
    // Required from RegistryInterface
    pub var clientTenants: {Address: UInt64}

    // Required from RegistryInterface
    pub fun instance(): @Tenant {...}

    // Required from RegistryInterface
    pub fun getTenants(): {Address: UInt64} {...}

    // We define a resource interface called ITenantMinter
    // that allows this contract to call updateTotalSupply.
    pub resource interface ITenantMinter {
        access(contract) fun updateTotalSupply()
    }

    // Required from RegistryInterface
    pub resource Tenant: ITenantMinter {
        pub(set) var totalSupply: UInt64

        access(self) let nftMinter: @NFTMinter

        pub fun getMinterRef(): &NFTMinter {
            return &self.nftMinter as &NFTMinter
        }

        // Define an updateTotalSupply function to be exposed
        // by the ITenantMinter resource interface.
        access(contract) fun updateTotalSupply() {
            self.totalSupply = self.totalSupply + 1
        }

        init() {
            self.totalSupply = 0
            self.nftMinter <- create NFTMinter()
        }
    }

    pub resource NFT {
        pub let id: UInt64

        init(_tenantRef: &Tenant{ITenantMinter}) {
            _tenantRef.updateTotalSupply()
        }
    }

    pub resource NFTMinter {
        pub fun mintNFT(_tenantRef: &Tenant{ITenantMinter}): @NFT {
            return <- create NFT(_tenantRef: _tenantRef)
        }       
    }

    init() {...}
}
