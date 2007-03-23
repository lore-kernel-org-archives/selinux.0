Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJMdsc005936
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:22:39 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJMXU1001618
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:22:33 GMT
Message-ID: <460428EB.8080904@redhat.com>
Date: Fri, 23 Mar 2007 15:22:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Remove unconfined_domain from udev
Content-Type: multipart/mixed;
 boundary="------------080307070205090003010302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080307070205090003010302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixed labeling on /dev/\.udev(/.*)?
udev searches usbfs dirs
searches ptys



--------------080307070205090003010302
Content-Type: text/x-patch;
 name="udev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udev.patch"

--- nsaserefpolicy/policy/modules/system/udev.fc	2006-11-16 17:15:24.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/udev.fc	2007-03-22 15:06:59.000000000 -0400
@@ -1,6 +1,6 @@
 # udev
 
-/dev/\.udev(/.*)?	gen_context(system_u:object_r:udev_tbl_t,s0)
+/dev/\.udev(/.*)? --	gen_context(system_u:object_r:udev_tbl_t,s0)
 /dev/\.udevdb	--	gen_context(system_u:object_r:udev_tbl_t,s0)
 /dev/udev\.tbl	--	gen_context(system_u:object_r:udev_tbl_t,s0)
 
--- nsaserefpolicy/policy/modules/system/udev.te	2007-03-20 23:38:29.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/system/udev.te	2007-03-22 15:06:59.000000000 -0400
@@ -89,6 +89,7 @@
 dev_manage_all_dev_nodes(udev_t)
 dev_rw_generic_files(udev_t)
 dev_delete_generic_files(udev_t)
+dev_search_usbfs_dirs(udev_t)
 
 domain_read_all_domains_state(udev_t)
 domain_dontaudit_ptrace_all_domains(udev_t) #pidof triggers these 
@@ -166,13 +167,14 @@
 
 	# for arping used for static IP addresses on PCMCIA ethernet
 	netutils_domtrans(udev_t)
+
+	term_search_ptys(udev_t)
+
 ')
 
 ifdef(`targeted_policy',`
 	term_dontaudit_use_unallocated_ttys(udev_t)
 	term_dontaudit_use_generic_ptys(udev_t)
-
-	unconfined_domain(udev_t)
 ')
 
 optional_policy(`

--------------080307070205090003010302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
