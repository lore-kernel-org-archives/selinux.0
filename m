Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL4evd024569
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:04:40 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL4c5T025070
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:04:38 GMT
Message-Id: <20080719210254.370409871@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:23 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 21/23] raid policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The original patch also added dev_read_realtime_clock(mdadm_t)
which I removed since I couldn't find a version of mdadm in
Debian or RedHat which actually read /dev/rtc (and likewise
for /sbin/mdmpd on RH).

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/raid.te serefpolicy-3.5.0/policy/modules/system/raid.te
--- nsaserefpolicy/policy/modules/system/raid.te	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/system/raid.te	2008-07-15 14:05:13.000000000 -0400
@@ -19,7 +19,7 @@
 # Local policy
 #
 
-allow mdadm_t self:capability { dac_override sys_admin ipc_lock };
+allow mdadm_t self:capability { dac_override mknod sys_admin ipc_lock };
 dontaudit mdadm_t self:capability sys_tty_config;
 allow mdadm_t self:process { sigchld sigkill sigstop signull signal };
 allow mdadm_t self:fifo_file rw_fifo_file_perms;
@@ -86,3 +86,7 @@
 optional_policy(`
 	udev_read_db(mdadm_t)
 ')
+
+optional_policy(`
+	unconfined_domain(mdadm_t)
+')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
