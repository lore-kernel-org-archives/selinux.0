Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Ck611014056
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:46:06 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Ck0pq016352
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:46:01 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 451DC5E2
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:45:59 +0200 (CEST)
Message-Id: <20080804123736.418748193@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:07 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 11/35] hotplug policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Should all be trivial changes

Index: refpolicy/policy/modules/system/hotplug.te
===================================================================
--- refpolicy.orig/policy/modules/system/hotplug.te	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/hotplug.te	2008-08-03 17:52:58.000000000 +0200
@@ -121,6 +121,7 @@
 	optional_policy(`
 		# for arping used for static IP addresses on PCMCIA ethernet
 		netutils_domtrans(hotplug_t)
+		netutils_signal(hotplug_t)
 		fs_rw_tmpfs_chr_files(hotplug_t)
 	')
 	files_getattr_generic_locks(hotplug_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
