Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72INLww012911
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:23:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72INIOD010728
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:23:18 GMT
Message-ID: <46B220FC.40807@redhat.com>
Date: Thu, 02 Aug 2007 14:22:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH] refpolicy: system_hostname changes
References: <200708021806.l72I6HNw022445@redsox>
In-Reply-To: <200708021806.l72I6HNw022445@redsox>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Allow hostname to be redirected to xen log as well 
dontaudit interaction with uncofined pipes.  system-config-network causes this
--- nsaserefpolicy/policy/modules/system/hostname.te	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.4/policy/modules/system/hostname.te	2007-07-25 12:27:26.000000000 -0400
@@ -60,3 +64,11 @@
 	xen_append_log(hostname_t)
 	xen_dontaudit_use_fds(hostname_t)
 ')
+
+optional_policy(`
+	xen_append_log(hostname_t)
+')
+
+optional_policy(`
+	unconfined_dontaudit_rw_pipes(hostname_t)

+')



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
