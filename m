Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB25dNRb012490
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 00:39:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB25dMqY013536
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 05:39:22 GMT
Received: from localhost.localdomain (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
        by jazzband.ncsc.mil  with ESMTP id hB25dL0o013533 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 05:39:21 GMT
Subject: What causes this??
From: Nick <nagray@austin.rr.com>
Reply-To: nagray@austin.rr.com
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1070343553.12870.1.camel@hawaii>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 23:39:14 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just rebuilt a system and when I try to change roles I get this


[root@hawaii SELinux]# newrole -r sysadm_r
cannot find your entry in the passwd file.
[root@hawaii SELinux]#

-- 
Nick (Nix) Gray
Senior Systems Engineer
Bruzenak Inc.
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
