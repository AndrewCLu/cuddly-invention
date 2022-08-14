const { expect } = require("chai");

const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("Redeemer verifier contract depth 2", function () {
  async function deployVerifier() {
    const Verifier = await ethers.getContractFactory("RedeemerVerifierDepth2");
    const verifier = await Verifier.deploy();

    return verifier;
  }

  describe("Verification", function () {
    it("Should verify a correct proof", async function () {
      const verifier = await loadFixture(
        deployVerifier
      );
      // This is a valid proof
      const proof = '0x061acda0b888993b7baf827b6d2f99ca10ad1ca2a1a1e91da286e0b604ff83e52fa0b5954ebe03f673b0aa19cd3ac876986daa5c20fe9e9396754840bf859e9f2a47ba9d6aa600cc232eb582023e749326ee1fb2f265cf7b9542661b6eb82dcd2afd7143164356ae37b539f408e835e259dfa2b0490ebce5e3c761b25d0a3be2300dcb39da3e98927f570b8b26ed5434c3838e666c53cd578762e0cdf61ff4da25aaa30360ca6ad56f8f29edb768549e8e49e3d50c240dfb4adf5f7d40fd71ac113facbf516665159296fb434f41d9e65863d16ab383e74aafbd689e4349fc680cc69261c3263f07e5ba756943107c491889b55aa8a5447139a7c1db1595451812234e8763861a683f256d17c5d3721afe3b3e08e44f16fe6044d4793358ac132590b88fef3d5d8a9770e70266cf55609b338b8e5da718f107db456d6c2356ca1c33a3088c79dca3fc23b444e0e194af074f758b25d754781dcd13fed13e65f52b6663d466975948e307ca978ad19fc0e9c80d02e41d528d86b499b33232f4e214e303464e70b559c9c58970129acfab6ecc3103aeb52c25da2015192120b50607a55751f66d36382b0d57e1fed8aa6130a7de4c5332b3f6292b442b853b5d152f5ee7cdb345375a3f33ac3b5036822eb9f5ab2b7da9db2b661c51e229d7fab8106271d1f437e9b74bf9b5ffefe665baf0caa777b37b7431798118689b199f0220c0ad5fe369272bc4b3bbcec069573aa803c4996d028729d48bdf8e780b8c03211a680091dcc65810e4e0a730366965c00a9e779c5845304dab3de37dee751b1fe38a5d7365451da61d9b463d28546aae0ffa9499719bbfa3a7ff235205400607f1513d63df7ca929b9dfbf94302b52e6a1385a37eda2dcda4ebbf4283bee220ecb5b874ba04c08466ab83fde5c37339176621f4579c1afb6467f103a861be12f15ec3b08289030752b0cb1345ee9e55bc66e4f7290731d0a1c3e979c99aa671585ed79c5a99ef78fe1d75565e8ecf4d6a9b37043a0786f12905e37c1be3e6a03a7c8b8d692fca04fadbae323d70f00988b944f9a0ec6dcd1de35ec5513e3b9189f8d8f146a0bd9d90201f7df009f5a3f250bcfed49a06de2391b835db465b2';
      const pubSignals = ["0x15d43e90d1f4eb13959d17eb6453778007b6f24127495e0d49a0d43e1479b206","0x25f437b9782db24a95188fe75962395e5bffc863e5fca736deef606e37466be4"];
      expect(await verifier.verifyProof(proof, pubSignals)).to.equal(true)
    });

    it("Should fail to verify an incorrect proof", async function () {
      const verifier = await loadFixture(
        deployVerifier
      );
      // This is a invalid proof
      const proof = '0x161acda0b888993b7baf827b6d2f99ca10ad1ca2a1a1e91da286e0b604ff83e52fa0b5954ebe03f673b0aa19cd3ac876986daa5c20fe9e9396754840bf859e9f2a47ba9d6aa600cc232eb582023e749326ee1fb2f265cf7b9542661b6eb82dcd2afd7143164356ae37b539f408e835e259dfa2b0490ebce5e3c761b25d0a3be2300dcb39da3e98927f570b8b26ed5434c3838e666c53cd578762e0cdf61ff4da25aaa30360ca6ad56f8f29edb768549e8e49e3d50c240dfb4adf5f7d40fd71ac113facbf516665159296fb434f41d9e65863d16ab383e74aafbd689e4349fc680cc69261c3263f07e5ba756943107c491889b55aa8a5447139a7c1db1595451812234e8763861a683f256d17c5d3721afe3b3e08e44f16fe6044d4793358ac132590b88fef3d5d8a9770e70266cf55609b338b8e5da718f107db456d6c2356ca1c33a3088c79dca3fc23b444e0e194af074f758b25d754781dcd13fed13e65f52b6663d466975948e307ca978ad19fc0e9c80d02e41d528d86b499b33232f4e214e303464e70b559c9c58970129acfab6ecc3103aeb52c25da2015192120b50607a55751f66d36382b0d57e1fed8aa6130a7de4c5332b3f6292b442b853b5d152f5ee7cdb345375a3f33ac3b5036822eb9f5ab2b7da9db2b661c51e229d7fab8106271d1f437e9b74bf9b5ffefe665baf0caa777b37b7431798118689b199f0220c0ad5fe369272bc4b3bbcec069573aa803c4996d028729d48bdf8e780b8c03211a680091dcc65810e4e0a730366965c00a9e779c5845304dab3de37dee751b1fe38a5d7365451da61d9b463d28546aae0ffa9499719bbfa3a7ff235205400607f1513d63df7ca929b9dfbf94302b52e6a1385a37eda2dcda4ebbf4283bee220ecb5b874ba04c08466ab83fde5c37339176621f4579c1afb6467f103a861be12f15ec3b08289030752b0cb1345ee9e55bc66e4f7290731d0a1c3e979c99aa671585ed79c5a99ef78fe1d75565e8ecf4d6a9b37043a0786f12905e37c1be3e6a03a7c8b8d692fca04fadbae323d70f00988b944f9a0ec6dcd1de35ec5513e3b9189f8d8f146a0bd9d90201f7df009f5a3f250bcfed49a06de2391b835db465b2';
      const pubSignals = ["0x15d43e90d1f4eb13959d17eb6453778007b6f24127495e0d49a0d43e1479b206","0x25f437b9782db24a95188fe75962395e5bffc863e5fca736deef606e37466be4"];
      expect(await verifier.verifyProof(proof, pubSignals)).to.equal(false)
    });
  });
});