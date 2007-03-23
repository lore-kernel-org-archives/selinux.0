Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJUIoc006373
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:30:18 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJUHU1003282
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:30:17 GMT
Message-ID: <46042AC3.6050006@redhat.com>
Date: Fri, 23 Mar 2007 15:30:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: netlabel can be run in init scripts I think?
Content-Type: multipart/mixed;
 boundary="------------030405050904070406030707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030405050904070406030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I believe this patch came from netlabel guys.

Dan

--------------030405050904070406030707
Content-Type: text/x-patch;
 name="netlabel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netlabel.patch"

--- nsaserefpolicy/policy/modules/system/netlabel.te	2006-11-16 17:15:24.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/netlabel.te	2007-03-22 15:06:59.000000000 -0400
@@ -8,8 +8,7 @@
 
 type netlabel_mgmt_t;
 type netlabel_mgmt_exec_t;
-domain_type(netlabel_mgmt_t)
-domain_entry_file(netlabel_mgmt_t,netlabel_mgmt_exec_t)
+init_daemon_domain(netlabel_mgmt_t,netlabel_mgmt_exec_t)
 
 ########################################
 #

--------------030405050904070406030707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
