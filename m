Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9E8jNNs004217
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 04:45:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9E8hBHa020625
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 08:43:12 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 35EF761B04
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 18:43:26 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29436-06 for <selinux@tycho.nsa.gov>;
	Fri, 14 Oct 2005 18:43:25 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3D91E61B01
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 18:43:25 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id C80C958
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 18:43:22 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: trivial patch
Date: Fri, 14 Oct 2005 18:43:16 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q+2TDBHRNXgTLev"
Message-Id: <200510141843.22595.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_q+2TDBHRNXgTLev
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I believe that the attached patch should be applied to all MCS and MLS 
versions of the policy.

Currently viewing the "mls" and "mcs" files in "less" takes an unreasonably 
large number of page-down operations.  This is annoying and the solution as 
described in my patch has no down-side.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_q+2TDBHRNXgTLev
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- mcs.orig	2005-10-14 17:50:55.000000000 +1000
+++ mcs	2005-10-14 17:50:56.000000000 +1000
@@ -18,262 +18,70 @@
 #
 # Each category has a name and zero or more aliases.
 #
-category c0;
-category c1;
-category c2;
-category c3;
-category c4;
-category c5;
-category c6;
-category c7;
-category c8;
-category c9;
-category c10;
-category c11;
-category c12;
-category c13;
-category c14;
-category c15;
-category c16;
-category c17;
-category c18;
-category c19;
-category c20;
-category c21;
-category c22;
-category c23;
-category c24;
-category c25;
-category c26;
-category c27;
-category c28;
-category c29;
-category c30;
-category c31;
-category c32;
-category c33;
-category c34;
-category c35;
-category c36;
-category c37;
-category c38;
-category c39;
-category c40;
-category c41;
-category c42;
-category c43;
-category c44;
-category c45;
-category c46;
-category c47;
-category c48;
-category c49;
-category c50;
-category c51;
-category c52;
-category c53;
-category c54;
-category c55;
-category c56;
-category c57;
-category c58;
-category c59;
-category c60;
-category c61;
-category c62;
-category c63;
-category c64;
-category c65;
-category c66;
-category c67;
-category c68;
-category c69;
-category c70;
-category c71;
-category c72;
-category c73;
-category c74;
-category c75;
-category c76;
-category c77;
-category c78;
-category c79;
-category c80;
-category c81;
-category c82;
-category c83;
-category c84;
-category c85;
-category c86;
-category c87;
-category c88;
-category c89;
-category c90;
-category c91;
-category c92;
-category c93;
-category c94;
-category c95;
-category c96;
-category c97;
-category c98;
-category c99;
-category c100;
-category c101;
-category c102;
-category c103;
-category c104;
-category c105;
-category c106;
-category c107;
-category c108;
-category c109;
-category c110;
-category c111;
-category c112;
-category c113;
-category c114;
-category c115;
-category c116;
-category c117;
-category c118;
-category c119;
-category c120;
-category c121;
-category c122;
-category c123;
-category c124;
-category c125;
-category c126;
-category c127;
-category c128;
-category c129;
-category c130;
-category c131;
-category c132;
-category c133;
-category c134;
-category c135;
-category c136;
-category c137;
-category c138;
-category c139;
-category c140;
-category c141;
-category c142;
-category c143;
-category c144;
-category c145;
-category c146;
-category c147;
-category c148;
-category c149;
-category c150;
-category c151;
-category c152;
-category c153;
-category c154;
-category c155;
-category c156;
-category c157;
-category c158;
-category c159;
-category c160;
-category c161;
-category c162;
-category c163;
-category c164;
-category c165;
-category c166;
-category c167;
-category c168;
-category c169;
-category c170;
-category c171;
-category c172;
-category c173;
-category c174;
-category c175;
-category c176;
-category c177;
-category c178;
-category c179;
-category c180;
-category c181;
-category c182;
-category c183;
-category c184;
-category c185;
-category c186;
-category c187;
-category c188;
-category c189;
-category c190;
-category c191;
-category c192;
-category c193;
-category c194;
-category c195;
-category c196;
-category c197;
-category c198;
-category c199;
-category c200;
-category c201;
-category c202;
-category c203;
-category c204;
-category c205;
-category c206;
-category c207;
-category c208;
-category c209;
-category c210;
-category c211;
-category c212;
-category c213;
-category c214;
-category c215;
-category c216;
-category c217;
-category c218;
-category c219;
-category c220;
-category c221;
-category c222;
-category c223;
-category c224;
-category c225;
-category c226;
-category c227;
-category c228;
-category c229;
-category c230;
-category c231;
-category c232;
-category c233;
-category c234;
-category c235;
-category c236;
-category c237;
-category c238;
-category c239;
-category c240;
-category c241;
-category c242;
-category c243;
-category c244;
-category c245;
-category c246;
-category c247;
-category c248;
-category c249;
-category c250;
-category c251;
-category c252;
-category c253;
-category c254;
-category c255;
+category c0; category c1; category c2; category c3;
+category c4; category c5; category c6; category c7;
+category c8; category c9; category c10; category c11;
+category c12; category c13; category c14; category c15;
+category c16; category c17; category c18; category c19;
+category c20; category c21; category c22; category c23;
+category c24; category c25; category c26; category c27;
+category c28; category c29; category c30; category c31;
+category c32; category c33; category c34; category c35;
+category c36; category c37; category c38; category c39;
+category c40; category c41; category c42; category c43;
+category c44; category c45; category c46; category c47;
+category c48; category c49; category c50; category c51;
+category c52; category c53; category c54; category c55;
+category c56; category c57; category c58; category c59;
+category c60; category c61; category c62; category c63;
+category c64; category c65; category c66; category c67;
+category c68; category c69; category c70; category c71;
+category c72; category c73; category c74; category c75;
+category c76; category c77; category c78; category c79;
+category c80; category c81; category c82; category c83;
+category c84; category c85; category c86; category c87;
+category c88; category c89; category c90; category c91;
+category c92; category c93; category c94; category c95;
+category c96; category c97; category c98; category c99;
+category c100; category c101; category c102; category c103;
+category c104; category c105; category c106; category c107;
+category c108; category c109; category c110; category c111;
+category c112; category c113; category c114; category c115;
+category c116; category c117; category c118; category c119;
+category c120; category c121; category c122; category c123;
+category c124; category c125; category c126; category c127;
+category c128; category c129; category c130; category c131;
+category c132; category c133; category c134; category c135;
+category c136; category c137; category c138; category c139;
+category c140; category c141; category c142; category c143;
+category c144; category c145; category c146; category c147;
+category c148; category c149; category c150; category c151;
+category c152; category c153; category c154; category c155;
+category c156; category c157; category c158; category c159;
+category c160; category c161; category c162; category c163;
+category c164; category c165; category c166; category c167;
+category c168; category c169; category c170; category c171;
+category c172; category c173; category c174; category c175;
+category c176; category c177; category c178; category c179;
+category c180; category c181; category c182; category c183;
+category c184; category c185; category c186; category c187;
+category c188; category c189; category c190; category c191;
+category c192; category c193; category c194; category c195;
+category c196; category c197; category c198; category c199;
+category c200; category c201; category c202; category c203;
+category c204; category c205; category c206; category c207;
+category c208; category c209; category c210; category c211;
+category c212; category c213; category c214; category c215;
+category c216; category c217; category c218; category c219;
+category c220; category c221; category c222; category c223;
+category c224; category c225; category c226; category c227;
+category c228; category c229; category c230; category c231;
+category c232; category c233; category c234; category c235;
+category c236; category c237; category c238; category c239;
+category c240; category c241; category c242; category c243;
+category c244; category c245; category c246; category c247;
+category c248; category c249; category c250; category c251;
+category c252; category c253; category c254; category c255;
 
 
 #

--Boundary-00=_q+2TDBHRNXgTLev--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
