// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/


pragma solidity >=0.7.0 <0.9.0;

import "../interfaces/IVerifier.sol";

contract RedeemerVerifier is IVerifier {
    
    uint32 constant n =   32768;
    uint16 constant nPublic =  2;
    uint16 constant nLagrange = 2;
    
    uint256 constant Qmx = 11254005739725147177560256445596992581157911242115994778379599833550399554734;
    uint256 constant Qmy = 6518289057870318331705082865094836312612925137864738789478336753109609667872;
    uint256 constant Qlx = 10057534566461810751134486711618706395335620060479680573647273854592580446535;
    uint256 constant Qly = 4960873133485188845616833361106879294286573402326489960628343587429983553349;
    uint256 constant Qrx = 3976008182097368363427177541502896944011557160113013724561035775396773323403;
    uint256 constant Qry = 6654843213241418541783742429881141762477080706528785637946586305701644004928;
    uint256 constant Qox = 11287284560269185532433026876904690761582089749525927448466986130370922425310;
    uint256 constant Qoy = 14629326067692858328737770179711189315886646242391998851086142129922788457784;
    uint256 constant Qcx = 8484979996233498187316321114640684154095560906417127823093428038504246411179;
    uint256 constant Qcy = 6970004110677314758312886535896261437914873318029995567814389817634314738253;
    uint256 constant S1x = 6092897766283347723369541203513850314766097507862786832452374916601791911119;
    uint256 constant S1y = 11635158048864144194877311733119448701110825233313681442309278122685259543076;
    uint256 constant S2x = 21625148468592716666599549968605980921242417708561089111948910168569033628326;
    uint256 constant S2y = 866741470091308325973064973985095499641931719968973670071036289941803090972;
    uint256 constant S3x = 16487308024972146474907373201147436321480974289869958560257834109453383066103;
    uint256 constant S3y = 6751738097048067137421194815415801963814844450360984581708146015969462128962;
    uint256 constant k1 = 2;
    uint256 constant k2 = 3;
    uint256 constant X2x1 = 21831381940315734285607113342023901060522397560371972897001948545212302161822;
    uint256 constant X2x2 = 17231025384763736816414546592865244497437017442647097510447326538965263639101;
    uint256 constant X2y1 = 2388026358213174446665280700919698872609886601280537296205114254867301080648;
    uint256 constant X2y2 = 11507326595632554467052522095592665270651932854513688777769618397986436103170;
    
    uint256 constant q = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    uint256 constant qf = 21888242871839275222246405745257275088696311157297823662689037894645226208583;
    uint256 constant w1 = 20402931748843538985151001264530049874871572933694634836567070693966133783803;    
    
    uint256 constant G1x = 1;
    uint256 constant G1y = 2;
    uint256 constant G2x1 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant G2x2 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant G2y1 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant G2y2 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint16 constant pA = 32;
    uint16 constant pB = 96;
    uint16 constant pC = 160;
    uint16 constant pZ = 224;
    uint16 constant pT1 = 288;
    uint16 constant pT2 = 352;
    uint16 constant pT3 = 416;
    uint16 constant pWxi = 480;
    uint16 constant pWxiw = 544;
    uint16 constant pEval_a = 608;
    uint16 constant pEval_b = 640;
    uint16 constant pEval_c = 672;
    uint16 constant pEval_s1 = 704;
    uint16 constant pEval_s2 = 736;
    uint16 constant pEval_zw = 768;
    uint16 constant pEval_r = 800;
    
    uint16 constant pAlpha = 0;
    uint16 constant pBeta = 32;
    uint16 constant pGamma = 64;
    uint16 constant pXi = 96;
    uint16 constant pXin = 128;
    uint16 constant pBetaXi = 160;
    uint16 constant pV1 = 192;
    uint16 constant pV2 = 224;
    uint16 constant pV3 = 256;
    uint16 constant pV4 = 288;
    uint16 constant pV5 = 320;
    uint16 constant pV6 = 352;
    uint16 constant pU = 384;
    uint16 constant pPl = 416;
    uint16 constant pEval_t = 448;
    uint16 constant pA1 = 480;
    uint16 constant pB1 = 544;
    uint16 constant pZh = 608;
    uint16 constant pZhInv = 640;
    
    uint16 constant pEval_l1 = 672;
    
    uint16 constant pEval_l2 = 704;
    
    
    
    uint16 constant lastMem = 736;

    function verifyProof(bytes memory proof, uint[] memory pubSignals) public view returns (bool) {
        assembly {
            /////////
            // Computes the inverse using the extended euclidean algorithm
            /////////
            function inverse(a, q) -> inv {
                let t := 0     
                let newt := 1
                let r := q     
                let newr := a
                let quotient
                let aux
                
                for { } newr { } {
                    quotient := sdiv(r, newr)
                    aux := sub(t, mul(quotient, newt))
                    t:= newt
                    newt:= aux
                    
                    aux := sub(r,mul(quotient, newr))
                    r := newr
                    newr := aux
                }
                
                if gt(r, 1) { revert(0,0) }
                if slt(t, 0) { t:= add(t, q) }

                inv := t
            }
            
            ///////
            // Computes the inverse of an array of values
            // See https://vitalik.ca/general/2018/07/21/starks_part_3.html in section where explain fields operations
            //////
            function inverseArray(pVals, n) {
    
                let pAux := mload(0x40)     // Point to the next free position
                let pIn := pVals
                let lastPIn := add(pVals, mul(n, 32))  // Read n elemnts
                let acc := mload(pIn)       // Read the first element
                pIn := add(pIn, 32)         // Point to the second element
                let inv
    
                
                for { } lt(pIn, lastPIn) { 
                    pAux := add(pAux, 32) 
                    pIn := add(pIn, 32)
                } 
                {
                    mstore(pAux, acc)
                    acc := mulmod(acc, mload(pIn), q)
                }
                acc := inverse(acc, q)
                
                // At this point pAux pint to the next free position we substract 1 to point to the last used
                pAux := sub(pAux, 32)
                // pIn points to the n+1 element, we substract to point to n
                pIn := sub(pIn, 32)
                lastPIn := pVals  // We don't process the first element 
                for { } gt(pIn, lastPIn) { 
                    pAux := sub(pAux, 32) 
                    pIn := sub(pIn, 32)
                } 
                {
                    inv := mulmod(acc, mload(pAux), q)
                    acc := mulmod(acc, mload(pIn), q)
                    mstore(pIn, inv)
                }
                // pIn points to first element, we just set it.
                mstore(pIn, acc)
            }
            
            function checkField(v) {
                if iszero(lt(v, q)) {
                    mstore(0, 0)
                    return(0,0x20)
                }
            }
            
            function checkInput(pProof) {
                if iszero(eq(mload(pProof), 800 )) {
                    mstore(0, 0)
                    return(0,0x20)
                }
                checkField(mload(add(pProof, pEval_a)))
                checkField(mload(add(pProof, pEval_b)))
                checkField(mload(add(pProof, pEval_c)))
                checkField(mload(add(pProof, pEval_s1)))
                checkField(mload(add(pProof, pEval_s2)))
                checkField(mload(add(pProof, pEval_zw)))
                checkField(mload(add(pProof, pEval_r)))

                // Points are checked in the point operations precompiled smart contracts
            }
            
            function calculateChallanges(pProof, pMem, pPublic) {
            
                let a
                let b

                
                mstore( add(pMem, 736 ), mload( add( pPublic, 32)))
                
                mstore( add(pMem, 768 ), mload( add( pPublic, 64)))
                
                mstore( add(pMem, 800 ), mload( add( pProof, pA)))
                mstore( add(pMem, 832 ), mload( add( pProof, add(pA,32))))
                mstore( add(pMem, 864 ), mload( add( pProof, add(pA,64))))
                mstore( add(pMem, 896 ), mload( add( pProof, add(pA,96))))
                mstore( add(pMem, 928 ), mload( add( pProof, add(pA,128))))
                mstore( add(pMem, 960 ), mload( add( pProof, add(pA,160))))
                
                b := mod(keccak256(add(pMem, lastMem), 256), q) 
                mstore( add(pMem, pBeta), b)
                mstore( add(pMem, pGamma), mod(keccak256(add(pMem, pBeta), 32), q))
                mstore( add(pMem, pAlpha), mod(keccak256(add(pProof, pZ), 64), q))
                
                a := mod(keccak256(add(pProof, pT1), 192), q)
                mstore( add(pMem, pXi), a)
                mstore( add(pMem, pBetaXi), mulmod(b, a, q))
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                a:= mulmod(a, a, q)
                
                mstore( add(pMem, pXin), a)
                a:= mod(add(sub(a, 1),q), q)
                mstore( add(pMem, pZh), a)
                mstore( add(pMem, pZhInv), a)  // We will invert later together with lagrange pols
                
                let v1 := mod(keccak256(add(pProof, pEval_a), 224), q)
                mstore( add(pMem, pV1), v1)
                a := mulmod(v1, v1, q)
                mstore( add(pMem, pV2), a)
                a := mulmod(a, v1, q)
                mstore( add(pMem, pV3), a)
                a := mulmod(a, v1, q)
                mstore( add(pMem, pV4), a)
                a := mulmod(a, v1, q)
                mstore( add(pMem, pV5), a)
                a := mulmod(a, v1, q)
                mstore( add(pMem, pV6), a)
                
                mstore( add(pMem, pU), mod(keccak256(add(pProof, pWxi), 128), q))
            }
            
            function calculateLagrange(pMem) {

                let w := 1                
                
                mstore(
                    add(pMem, pEval_l1), 
                    mulmod(
                        n, 
                        mod(
                            add(
                                sub(
                                    mload(add(pMem, pXi)), 
                                    w
                                ), 
                                q
                            ),
                            q
                        ), 
                        q
                    )
                )
                
                w := mulmod(w, w1, q)
                
                
                mstore(
                    add(pMem, pEval_l2), 
                    mulmod(
                        n, 
                        mod(
                            add(
                                sub(
                                    mload(add(pMem, pXi)), 
                                    w
                                ), 
                                q
                            ),
                            q
                        ), 
                        q
                    )
                )
                
                
                
                inverseArray(add(pMem, pZhInv), 3 )
                
                let zh := mload(add(pMem, pZh))
                w := 1
                
                
                mstore(
                    add(pMem, pEval_l1 ), 
                    mulmod(
                        mload(add(pMem, pEval_l1 )),
                        zh,
                        q
                    )
                )
                
                
                w := mulmod(w, w1, q)
                
                
                
                mstore(
                    add(pMem, pEval_l2), 
                    mulmod(
                        w,
                        mulmod(
                            mload(add(pMem, pEval_l2)),
                            zh,
                            q
                        ),
                        q
                    )
                )
                
                
                


            }
            
            function calculatePl(pMem, pPub) {
                let pl := 0
                
                 
                pl := mod(
                    add(
                        sub(
                            pl,  
                            mulmod(
                                mload(add(pMem, pEval_l1)),
                                mload(add(pPub, 32)),
                                q
                            )
                        ),
                        q
                    ),
                    q
                )
                 
                pl := mod(
                    add(
                        sub(
                            pl,  
                            mulmod(
                                mload(add(pMem, pEval_l2)),
                                mload(add(pPub, 64)),
                                q
                            )
                        ),
                        q
                    ),
                    q
                )
                
                
                mstore(add(pMem, pPl), pl)
                

            }

            function calculateT(pProof, pMem) {
                let t
                let t1
                let t2
                t := addmod(
                    mload(add(pProof, pEval_r)), 
                    mload(add(pMem, pPl)), 
                    q
                )
                
                t1 := mulmod(
                    mload(add(pProof, pEval_s1)),
                    mload(add(pMem, pBeta)),
                    q
                )

                t1 := addmod(
                    t1,
                    mload(add(pProof, pEval_a)),
                    q
                )
                
                t1 := addmod(
                    t1,
                    mload(add(pMem, pGamma)),
                    q
                )

                t2 := mulmod(
                    mload(add(pProof, pEval_s2)),
                    mload(add(pMem, pBeta)),
                    q
                )

                t2 := addmod(
                    t2,
                    mload(add(pProof, pEval_b)),
                    q
                )
                
                t2 := addmod(
                    t2,
                    mload(add(pMem, pGamma)),
                    q
                )
                
                t1 := mulmod(t1, t2, q)
                
                t2 := addmod(
                    mload(add(pProof, pEval_c)),
                    mload(add(pMem, pGamma)),
                    q
                )

                t1 := mulmod(t1, t2, q)
                t1 := mulmod(t1, mload(add(pProof, pEval_zw)), q)
                t1 := mulmod(t1, mload(add(pMem, pAlpha)), q)
                
                t2 := mulmod(
                    mload(add(pMem, pEval_l1)), 
                    mload(add(pMem, pAlpha)), 
                    q
                )

                t2 := mulmod(
                    t2, 
                    mload(add(pMem, pAlpha)), 
                    q
                )

                t1 := addmod(t1, t2, q)
                
                t := mod(sub(add(t, q), t1), q)
                t := mulmod(t, mload(add(pMem, pZhInv)), q)
                
                mstore( add(pMem, pEval_t) , t)

            }
            
            function g1_set(pR, pP) {
                mstore(pR, mload(pP))
                mstore(add(pR, 32), mload(add(pP,32)))
            }

            function g1_acc(pR, pP) {
                let mIn := mload(0x40)
                mstore(mIn, mload(pR))
                mstore(add(mIn,32), mload(add(pR, 32)))
                mstore(add(mIn,64), mload(pP))
                mstore(add(mIn,96), mload(add(pP, 32)))

                let success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)
                
                if iszero(success) {
                    mstore(0, 0)
                    return(0,0x20)
                }
            }

            function g1_mulAcc(pR, pP, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, mload(pP))
                mstore(add(mIn,32), mload(add(pP, 32)))
                mstore(add(mIn,64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)
                
                if iszero(success) {
                    mstore(0, 0)
                    return(0,0x20)
                }
                
                mstore(add(mIn,64), mload(pR))
                mstore(add(mIn,96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)
                
                if iszero(success) {
                    mstore(0, 0)
                    return(0,0x20)
                }
                
            }

            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn,32), y)
                mstore(add(mIn,64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)
                
                if iszero(success) {
                    mstore(0, 0)
                    return(0,0x20)
                }
                
                mstore(add(mIn,64), mload(pR))
                mstore(add(mIn,96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)
                
                if iszero(success) {
                    mstore(0, 0)
                    return(0,0x20)
                }
            }

            function g1_mulSetC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn,32), y)
                mstore(add(mIn,64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, pR, 64)
                
                if iszero(success) {
                    mstore(0, 0)
                    return(0,0x20)
                }
            }


            function calculateA1(pProof, pMem) {
                let p := add(pMem, pA1)
                g1_set(p, add(pProof, pWxi))
                g1_mulAcc(p, add(pProof, pWxiw), mload(add(pMem, pU)))
            }
            
            
            function calculateB1(pProof, pMem) {
                let s
                let s1
                let p := add(pMem, pB1)
                
                // Calculate D
                s := mulmod( mload(add(pProof, pEval_a)), mload(add(pMem, pV1)), q)
                g1_mulSetC(p, Qlx, Qly, s)

                s := mulmod( s, mload(add(pProof, pEval_b)), q)                
                g1_mulAccC(p, Qmx, Qmy, s)

                s := mulmod( mload(add(pProof, pEval_b)), mload(add(pMem, pV1)), q)
                g1_mulAccC(p, Qrx, Qry, s)
                
                s := mulmod( mload(add(pProof, pEval_c)), mload(add(pMem, pV1)), q)
                g1_mulAccC(p, Qox, Qoy, s)

                s :=mload(add(pMem, pV1))
                g1_mulAccC(p, Qcx, Qcy, s)

                s := addmod(mload(add(pProof, pEval_a)), mload(add(pMem, pBetaXi)), q)
                s := addmod(s, mload(add(pMem, pGamma)), q)
                s1 := mulmod(k1, mload(add(pMem, pBetaXi)), q)
                s1 := addmod(s1, mload(add(pProof, pEval_b)), q)
                s1 := addmod(s1, mload(add(pMem, pGamma)), q)
                s := mulmod(s, s1, q)
                s1 := mulmod(k2, mload(add(pMem, pBetaXi)), q)
                s1 := addmod(s1, mload(add(pProof, pEval_c)), q)
                s1 := addmod(s1, mload(add(pMem, pGamma)), q)
                s := mulmod(s, s1, q)
                s := mulmod(s, mload(add(pMem, pAlpha)), q)
                s := mulmod(s, mload(add(pMem, pV1)), q)
                s1 := mulmod(mload(add(pMem, pEval_l1)), mload(add(pMem, pAlpha)), q)
                s1 := mulmod(s1, mload(add(pMem, pAlpha)), q)
                s1 := mulmod(s1, mload(add(pMem, pV1)), q)
                s := addmod(s, s1, q)
                s := addmod(s, mload(add(pMem, pU)), q)
                g1_mulAcc(p, add(pProof, pZ), s)
                
                s := mulmod(mload(add(pMem, pBeta)), mload(add(pProof, pEval_s1)), q)
                s := addmod(s, mload(add(pProof, pEval_a)), q)
                s := addmod(s, mload(add(pMem, pGamma)), q)
                s1 := mulmod(mload(add(pMem, pBeta)), mload(add(pProof, pEval_s2)), q)
                s1 := addmod(s1, mload(add(pProof, pEval_b)), q)
                s1 := addmod(s1, mload(add(pMem, pGamma)), q)
                s := mulmod(s, s1, q)
                s := mulmod(s, mload(add(pMem, pAlpha)), q)
                s := mulmod(s, mload(add(pMem, pV1)), q)
                s := mulmod(s, mload(add(pMem, pBeta)), q)
                s := mulmod(s, mload(add(pProof, pEval_zw)), q)
                s := mod(sub(q, s), q)
                g1_mulAccC(p, S3x, S3y, s)


                // calculate F
                g1_acc(p , add(pProof, pT1))

                s := mload(add(pMem, pXin))
                g1_mulAcc(p, add(pProof, pT2), s)
                
                s := mulmod(s, s, q)
                g1_mulAcc(p, add(pProof, pT3), s)
                
                g1_mulAcc(p, add(pProof, pA), mload(add(pMem, pV2)))
                g1_mulAcc(p, add(pProof, pB), mload(add(pMem, pV3)))
                g1_mulAcc(p, add(pProof, pC), mload(add(pMem, pV4)))
                g1_mulAccC(p, S1x, S1y, mload(add(pMem, pV5)))
                g1_mulAccC(p, S2x, S2y, mload(add(pMem, pV6)))
                
                // calculate E
                s := mload(add(pMem, pEval_t))
                s := addmod(s, mulmod(mload(add(pProof, pEval_r)), mload(add(pMem, pV1)), q), q)
                s := addmod(s, mulmod(mload(add(pProof, pEval_a)), mload(add(pMem, pV2)), q), q)
                s := addmod(s, mulmod(mload(add(pProof, pEval_b)), mload(add(pMem, pV3)), q), q)
                s := addmod(s, mulmod(mload(add(pProof, pEval_c)), mload(add(pMem, pV4)), q), q)
                s := addmod(s, mulmod(mload(add(pProof, pEval_s1)), mload(add(pMem, pV5)), q), q)
                s := addmod(s, mulmod(mload(add(pProof, pEval_s2)), mload(add(pMem, pV6)), q), q)
                s := addmod(s, mulmod(mload(add(pProof, pEval_zw)), mload(add(pMem, pU)), q), q)
                s := mod(sub(q, s), q)
                g1_mulAccC(p, G1x, G1y, s)
                
                
                // Last part of B
                s := mload(add(pMem, pXi))
                g1_mulAcc(p, add(pProof, pWxi), s)

                s := mulmod(mload(add(pMem, pU)), mload(add(pMem, pXi)), q)
                s := mulmod(s, w1, q)
                g1_mulAcc(p, add(pProof, pWxiw), s)

            }
            
            function checkPairing(pMem) -> isOk {
                let mIn := mload(0x40)
                mstore(mIn, mload(add(pMem, pA1)))
                mstore(add(mIn,32), mload(add(add(pMem, pA1), 32)))
                mstore(add(mIn,64), X2x2)
                mstore(add(mIn,96), X2x1)
                mstore(add(mIn,128), X2y2)
                mstore(add(mIn,160), X2y1)
                mstore(add(mIn,192), mload(add(pMem, pB1)))
                let s := mload(add(add(pMem, pB1), 32))
                s := mod(sub(qf, s), qf)
                mstore(add(mIn,224), s)
                mstore(add(mIn,256), G2x2)
                mstore(add(mIn,288), G2x1)
                mstore(add(mIn,320), G2y2)
                mstore(add(mIn,352), G2y1)
                
                let success := staticcall(sub(gas(), 2000), 8, mIn, 384, mIn, 0x20)
                
                isOk := and(success, mload(mIn))
            }
            
            let pMem := mload(0x40)
            mstore(0x40, add(pMem, lastMem))
            
            checkInput(proof)
            calculateChallanges(proof, pMem, pubSignals)
            calculateLagrange(pMem)
            calculatePl(pMem, pubSignals)
            calculateT(proof, pMem)
            calculateA1(proof, pMem)
            calculateB1(proof, pMem)
            let isValid := checkPairing(pMem)
            
            mstore(0x40, sub(pMem, lastMem))
            mstore(0, isValid)
            return(0,0x20)
        }
        
    }
}