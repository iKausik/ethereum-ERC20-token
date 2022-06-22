import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-waffle";
import { ethers } from "hardhat";
import { expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

describe("PandaCoin", () => {
  let deployer: SignerWithAddress,
    user: SignerWithAddress,
    user2: SignerWithAddress,
    coinContractFactory: any,
    coinContract: any;

  beforeEach(async () => {
    [deployer, user, user2] = await ethers.getSigners();

    coinContractFactory = await ethers.getContractFactory("PandaCoin");
    coinContract = await coinContractFactory.deploy();
    await coinContract.connect(deployer).deployed();
  });

  it("Test additional PAC minting", async () => {
    // after the initial minting, the owner can also mint additional coins
    expect(await coinContract.connect(deployer).mint(user.address, 10));
  });

  it("Test PAC burning", async () => {
    expect(await coinContract.connect(deployer).burn(5));
  });

  it("Test request PAC by a user", async () => {
    expect(await coinContract.connect(user).requestToken(user2.address, 10));
  });

  it("Test check balance", async () => {
    expect(await coinContract.connect(user).requestToken(user2.address, 10));
    expect(await coinContract.connect(user2).myTokenBalance()).to.equal(10);
  });
});
