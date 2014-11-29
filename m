Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sATAOLEJ023539
 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2014 05:24:22 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id AE9661A1BF
 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2014 11:24:17 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MIo2n85F_I0I for <selinux@tycho.nsa.gov>;
 Sat, 29 Nov 2014 11:24:15 +0100 (CET)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:85fc:1::6b5])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 8E2341A1A3
 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2014 11:24:15 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Add "RuntimeDirectory=setrans" to the mcstrans.service
Date: Sat, 29 Nov 2014 11:24:15 +0100
Message-Id: <1417256655-4207-1-git-send-email-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Add "RuntimeDirectory=setrans" to the mcstrans.service, this will make
systemd automatically create the /run/setrans directory before starting
the service.

This directory contains the ".setrans-unix" socket created by the
daemon.
---
 policycoreutils/mcstrans/src/mcstrans.service | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/mcstrans/src/mcstrans.service b/policycoreutils/mcstrans/src/mcstrans.service
index 64bb361..8976b97 100644
--- a/policycoreutils/mcstrans/src/mcstrans.service
+++ b/policycoreutils/mcstrans/src/mcstrans.service
@@ -4,6 +4,7 @@ ConditionSecurity=selinux
 
 [Service]
 ExecStart=/sbin/mcstransd -f
+RuntimeDirectory=setrans
 
 [Install]
 WantedBy=multi-user.target
-- 
2.1.3
