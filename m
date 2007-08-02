Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KggdX025719
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:42:42 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KgfM1008471
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:42:41 GMT
Date: Thu, 2 Aug 2007 16:42:38 -0400
Message-Id: <200708022042.l72Kgc0v032643@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_rhgb changes rhgb searches /root
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/rhgb.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/rhgb.te	2007-08-02 11:02:02.000000000 -0400
@@ -109,6 +109,7 @@
 
 userdom_dontaudit_use_unpriv_user_fds(rhgb_t)
 userdom_dontaudit_search_sysadm_home_dirs(rhgb_t)
+userdom_dontaudit_search_all_users_home_content(rhgb_t)
 
 xserver_read_xdm_xserver_tmp_files(rhgb_t)
 xserver_kill_xdm_xserver(rhgb_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
