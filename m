Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL4efP024595
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:04:41 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL4c5T025075
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:04:39 GMT
Message-Id: <20080719210252.378262127@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:10 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 08/23] secadm policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If auditd is not running, secadm needs dmesg to get the avc messages.
If auditd is running the same info is available through auditd
anyway.

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/roles/secadm.te serefpolicy-3.5.0/policy/modules/roles/secadm.te
--- nsaserefpolicy/policy/modules/roles/secadm.te	2008-06-12 23:25:06.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/roles/secadm.te	2008-07-15 14:05:12.000000000 -0400
@@ -48,6 +48,10 @@
 ')
 
 optional_policy(`
+	dmesg_exec(secadm_t)
+')
+
+optional_policy(`
 	netlabel_run_mgmt(secadm_t, secadm_r, { secadm_tty_device_t secadm_devpts_t })
 ')
 

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
