Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kx3Hg027977
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:59:03 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Kx2M1011223
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:59:03 GMT
Date: Thu, 2 Aug 2007 16:58:59 -0400
Message-Id: <200708022058.l72Kwxgg000728@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_avahi changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/avahi.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/avahi.te	2007-08-02 11:02:02.000000000 -0400
@@ -57,6 +57,7 @@
 
 fs_getattr_all_fs(avahi_t)
 fs_search_auto_mountpoints(avahi_t)
+fs_list_inotifyfs(avahi_t)
 
 domain_use_interactive_fds(avahi_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
