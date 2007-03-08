Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28Eu76n005318
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:56:07 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28Eu6Ha009496
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:56:06 GMT
Message-ID: <45F02404.4060407@redhat.com>
Date: Thu, 08 Mar 2007 09:56:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: ricci_modstorage needs to transition to lvm and dontaudit ptrace
Content-Type: multipart/mixed;
 boundary="------------090607020802000801090006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090607020802000801090006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090607020802000801090006
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_ricci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_ricci.patch"

--- nsaserefpolicy/policy/modules/services/ricci.te	2007-03-06 09:53:20.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/ricci.te	2007-03-08 09:16:00.000000000 -0500
@@ -449,6 +448,7 @@
 #
 
 allow ricci_modstorage_t self:process { setsched signal };
+dontaudit ricci_modstorage_t self:process ptrace;
 allow ricci_modstorage_t self:capability { mknod sys_nice };
 allow ricci_modstorage_t self:fifo_file rw_fifo_file_perms;
 allow ricci_modstorage_t self:unix_dgram_socket create_socket_perms;
@@ -498,6 +498,10 @@
 ')
 
 optional_policy(`
+	lvm_domtrans(ricci_modstorage_t)
+')
+
+optional_policy(`
 	nscd_socket_use(ricci_modstorage_t)
 ')
 

--------------090607020802000801090006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
