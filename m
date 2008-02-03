Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m139AUH1009625
	for <selinux@tycho.nsa.gov>; Sun, 3 Feb 2008 04:10:30 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m139ASmH023291
	for <selinux@tycho.nsa.gov>; Sun, 3 Feb 2008 09:10:29 GMT
Subject: [refpolicy] pam_mount
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-Vv17jckT0nIKyw2PW2am"
Date: Sun, 03 Feb 2008 10:10:06 +0100
Message-Id: <1202029806.2674.4.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Vv17jckT0nIKyw2PW2am
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

pam_mount needs proper labeling. Tested on Fedora 8

--=-Vv17jckT0nIKyw2PW2am
Content-Disposition: attachment; filename=authlogin.fc.patch
Content-Type: text/x-patch; name=authlogin.fc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20071214/policy/modules/system/authlogin.fc	2007-12-12 16:55:21.000000000 +0100
+++ policy/modules/system/authlogin.fc	2008-02-01 21:40:10.000000000 +0100
@@ -40,5 +40,5 @@
 /var/log/wtmp.*		--	gen_context(system_u:object_r:wtmp_t,s0)
 
 /var/run/console(/.*)?	 	gen_context(system_u:object_r:pam_var_console_t,s0)
-
+/var/run/pam_mount(/.*)?	gen_context(system_u:object_r:pam_var_run_t,s0)
 /var/run/sudo(/.*)?		gen_context(system_u:object_r:pam_var_run_t,s0)

--=-Vv17jckT0nIKyw2PW2am--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
