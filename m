Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3NboWt003429
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 18:37:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA3NbnKl028271
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 23:37:49 GMT
Received: from ics09.uncc.edu (ics09.uncc.edu [152.15.42.137])
        by jazzband.ncsc.mil  with ESMTP id hA3Nbn5m028268 for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 23:37:49 GMT
Received: from ics09.uncc.edu (localhost [127.0.0.1])
	by localhost.uncc.edu (Postfix) with ESMTP id 8476835835
	for <selinux@tycho.nsa.gov>; Mon,  3 Nov 2003 18:37:40 -0500 (EST)
Received: from uncc.edu (aragorn-pc.uncc.edu [152.15.25.56])
	by ics09.uncc.edu (Postfix) with ESMTP id 5B9C43582C
	for <selinux@tycho.nsa.gov>; Mon,  3 Nov 2003 18:37:40 -0500 (EST)
Message-ID: <3FA69267.40408@uncc.edu>
Date: Mon, 03 Nov 2003 18:37:43 +0100
From: Dhruv Gami <dgami@uncc.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: selinux/2.6 on knoppix 3.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello everyone,

im a new user for selinux, and am trying to compile selinux for kernel 
2.6 on a knoppix 3.3 hdinstall (its basically a debian install).

I managed to compile the kernel (2.6), but only after removing certain 
modules which were preventing compilation of the kernel.

Now when i tried to compile the selinux-usr packages, libselinux asks 
for attr/xattr.h in some of the files, and i am unable to find libattr 
for debian. i tried googling for it, but only found RPM packages for 
libattr.

am i doing something wrong here ? am i supposed to install/use something 
else ?

any help would be most appreciated.

regards,
Gami


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
