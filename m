Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA16157
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 12:07:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBMH73I27158
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 17:07:03 GMT
Received: from mail.simplyaquatics.com ([66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id gBMH73f27154 for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 17:07:03 GMT
Received: from ed (ed1 [192.168.1.10])
	by mail.simplyaquatics.com (Postfix) with ESMTP id 074C38440D8
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 12:06:14 -0500 (EST)
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "Selinux" <selinux@tycho.nsa.gov>
Subject: Freeswan breaks lsm kernel build
Date: Sun, 22 Dec 2002 12:06:14 -0500
Message-ID: <000201c2a9dc$6fb3d170$0a01a8c0@simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I am working with 2.4.20 kernel and applying lm_sensors, i2c, freeswan
v1.99 and lsm.  After installing freeswan and I attempt to apply lsm
(lsm_2002.12.12-2_all.deb) it does not apply cleanly.

Testing whether LSM Support for Linux patch for 2.4.20 applies (dry
run):
1 out of 2 hunks FAILED -- saving rejects to file
arch/i386/defconfig.rej
LSM Support for Linux patch for 2.4.20 does not apply cleanly

Ed

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.431 / Virus Database: 242 - Release Date: 12/17/2002
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
