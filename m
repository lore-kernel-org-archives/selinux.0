Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL7c8x025072
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:07:38 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL7b5T025644
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:07:38 GMT
Message-Id: <20080719210252.834349352@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:13 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 11/23] cpucontrol policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Only documentation changes...

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cpucontrol.if serefpolicy-3.5.0/policy/modules/services/cpucontrol.if
--- nsaserefpolicy/policy/modules/services/cpucontrol.if	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/cpucontrol.if	2008-07-15 14:05:12.000000000 -0400
@@ -4,9 +4,9 @@
 ## <summary>
 ##	CPUcontrol stub interface.  No access allowed.
 ## </summary>
-## <param name="domain" unused="true">
+## <param name="domain" optional="true">
 ##	<summary>
-##	Domain allowed access.
+##	N/A
 ##	</summary>
 ## </param>
 #

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
