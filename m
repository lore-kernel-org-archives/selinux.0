Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CpKbi015364
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:51:20 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CpFpq017609
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:51:15 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id BB8B241C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:51:18 +0200 (CEST)
Message-Id: <20080804123737.088141859@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:11 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 15/35] kernel terminal policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional permissions for server ptynodes
Index: refpolicy/policy/modules/kernel/terminal.if
===================================================================
--- refpolicy.orig/policy/modules/kernel/terminal.if	2008-08-03 16:46:56.000000000 +0200
+++ refpolicy/policy/modules/kernel/terminal.if	2008-08-03 18:01:38.000000000 +0200
@@ -525,11 +525,13 @@
 interface(`term_use_generic_ptys',`
 	gen_require(`
 		type devpts_t;
+		attribute server_ptynode;
 	')
 
 	dev_list_all_dev_nodes($1)
 	allow $1 devpts_t:dir list_dir_perms;
 	allow $1 devpts_t:chr_file { rw_term_perms lock append };
+	allow $1 server_ptynode:chr_file { getattr read write ioctl };
 ')
 
 ########################################
@@ -547,9 +549,11 @@
 interface(`term_dontaudit_use_generic_ptys',`
 	gen_require(`
 		type devpts_t;
+		attribute server_ptynode;
 	')
 
 	dontaudit $1 devpts_t:chr_file { getattr read write ioctl };
+	dontaudit $1 server_ptynode:chr_file { getattr read write ioctl };
 ')
 
 ########################################

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
