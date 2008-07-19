Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL2uFs024231
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:02:56 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL2tTc006527
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:02:56 GMT
Message-Id: <20080719210251.774736957@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:06 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 04/23] kismet policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is needed by /usr/bin/kismet_server

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/kismet.te serefpolicy-3.5.0/policy/modules/admin/kismet.te
--- nsaserefpolicy/policy/modules/admin/kismet.te	2008-06-12 23:25:08.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/admin/kismet.te	2008-07-15 14:05:12.000000000 -0400
@@ -26,6 +26,7 @@
 #
 
 allow kismet_t self:capability { net_admin setuid setgid };
+allow kismet_t self:packet_socket create_socket_perms;
 
 manage_files_pattern(kismet_t, kismet_log_t, kismet_log_t)
 allow kismet_t kismet_log_t:dir setattr;

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
