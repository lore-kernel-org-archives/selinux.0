Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL4cpG024509
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:04:38 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL4a5T025055
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:04:37 GMT
Message-Id: <20080719210253.958616054@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:20 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 18/23] miscfiles policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial change (perhaps RH specific path?)...

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/miscfiles.fc serefpolicy-3.5.0/policy/modules/system/miscfiles.fc
--- nsaserefpolicy/policy/modules/system/miscfiles.fc	2008-06-12 23:25:07.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/system/miscfiles.fc	2008-07-15 14:05:13.000000000 -0400
@@ -11,6 +11,7 @@
 /etc/avahi/etc/localtime --	gen_context(system_u:object_r:locale_t,s0)
 /etc/localtime		--	gen_context(system_u:object_r:locale_t,s0)
 /etc/pki(/.*)?			gen_context(system_u:object_r:cert_t,s0)
+/etc/sysconfig/clock	--	gen_context(system_u:object_r:locale_t,s0)
 
 #
 # /opt

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
