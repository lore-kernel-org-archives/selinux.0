Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2FEhODo029501
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 09:43:24 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2FEbWNq021140
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 14:37:32 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2FEbTLY025070
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 09:37:30 -0500 (EST)
Subject: restorecon read symlink
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-OOc+De2mipMK+RG9yHy6"
Date: Tue, 15 Mar 2005 09:42:15 -0500
Message-Id: <1110897735.3769.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OOc+De2mipMK+RG9yHy6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Without this restorecon sdir/* fails, where sdir is a symlink to a
directory. Is this a security hole, or can it be patched?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-OOc+De2mipMK+RG9yHy6
Content-Disposition: attachment; filename=restorecon_read_symlink.diff
Content-Type: text/x-patch; name=restorecon_read_symlink.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old/domains/program/restorecon.te policy/domains/program/restorecon.te
--- policy.old/domains/program/restorecon.te	2005-03-14 18:12:45.000000000 -0500
+++ policy/domains/program/restorecon.te	2005-03-14 18:13:17.000000000 -0500
@@ -37,6 +37,7 @@
 r_dir_file(restorecon_t, policy_config_t)
 
 allow restorecon_t file_type:dir r_dir_perms;
+allow restorecon_t file_type:lnk_file read;
 allow restorecon_t file_type:{ dir file lnk_file sock_file fifo_file } { getattr relabelfrom relabelto };
 allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfrom };
 allow restorecon_t unlabeled_t:dir read;

--=-OOc+De2mipMK+RG9yHy6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
