Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CpJmO015340
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:51:19 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CpI7E013989
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:51:18 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 789EB5E2
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:51:17 +0200 (CEST)
Message-Id: <20080804123736.929887318@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:10 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 14/35] remotelogin policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional user homedir permissions
Index: refpolicy/policy/modules/services/remotelogin.te
===================================================================
--- refpolicy.orig/policy/modules/services/remotelogin.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/remotelogin.te	2008-08-03 18:01:36.000000000 +0200
@@ -85,6 +85,7 @@
 
 miscfiles_read_localization(remote_login_t)
 
+userdom_read_all_users_home_dirs_symlinks(remote_login_t)
 userdom_use_unpriv_users_fds(remote_login_t)
 userdom_search_all_users_home_content(remote_login_t)
 # Only permit unprivileged user domains to be entered via rlogin,

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
