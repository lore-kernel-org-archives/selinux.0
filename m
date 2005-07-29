Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6T2QegA026862
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 22:26:42 -0400 (EDT)
Received: from dragon.ti.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6T2Jucq022743
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 02:19:56 GMT
Received: from dlep30.itg.ti.com ([157.170.139.157])
	by dragon.ti.com (8.13.1/8.13.1) with ESMTP id j6T2Kmrn014073
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 21:20:48 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep30.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6T2KHeD014001
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 21:20:17 -0500 (CDT)
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6T2KF0f024184
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 21:20:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: SELinux for embedded devices...
Date: Fri, 29 Jul 2005 07:50:13 +0530
Message-ID: <45F366B1BC4F7C4A895F0F34C41E61A5511366@dbde01.ent.ti.com>
From: "Sriram, Kannan" <ksriram@ti.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello all,

 I'm a newbie to SELinux, trying to figure out if SELinux is applicable/
suitable to embedded system security, especially mobile terminals/
smartphones. I have the following very basic questions... Pls help me
out, or redirect me to the appropriate forum.

1. Is SELinux applicable and suitable for mobile equipment, where the
end user always has root privileges? Has SELinux been ported to any
embedded device yet (some ARM platform??).

2. Assuming I have made the kernel on the flash to be tamperproof (can't
replace the SElinux image on the flash with the "SE" part disabled),
isn't  it still possible at runtime to disable the security server?

3. Same as above, is it possible to change the security policy files, or
reload a different set of policies (given root access).

And now the big question, is there a way to prevent both (2) and (3)??
Or have I completely misunderstood the whole thing??

Thanks in advance,
Sriram.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
