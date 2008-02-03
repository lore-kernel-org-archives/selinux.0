Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1398PAJ009446
	for <selinux@tycho.nsa.gov>; Sun, 3 Feb 2008 04:08:25 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1398OmH022737
	for <selinux@tycho.nsa.gov>; Sun, 3 Feb 2008 09:08:24 GMT
Subject: [refpolicy] samba
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: SE Linux <selinux@tycho.nsa.gov>, cpebenito@tresys.com
Content-Type: multipart/mixed; boundary="=-ns7CQ7/EC3DKP/Qqgx+R"
Date: Sun, 03 Feb 2008 10:07:27 +0100
Message-Id: <1202029647.2674.1.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ns7CQ7/EC3DKP/Qqgx+R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Debian machines smbd needs append rights for samba logfiles.

--=-ns7CQ7/EC3DKP/Qqgx+R
Content-Disposition: attachment; filename=samba.te.patch
Content-Type: text/x-patch; name=samba.te.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20071214/policy/modules/services/samba.te	2007-12-14 15:23:18.000000000 +0100
+++ policy/modules/services/samba.te	2008-02-03 10:02:54.000000000 +0100
@@ -223,6 +223,7 @@
 
 create_dirs_pattern(smbd_t,samba_log_t,samba_log_t)
 create_files_pattern(smbd_t,samba_log_t,samba_log_t)
+append_files_pattern(smbd_t,samba_log_t,samba_log_t)
 allow smbd_t samba_log_t:dir setattr;
 dontaudit smbd_t samba_log_t:dir remove_name;
 

--=-ns7CQ7/EC3DKP/Qqgx+R--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
