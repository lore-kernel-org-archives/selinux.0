Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QJGEI7017269
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 14:16:14 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QJHYW2019606
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 19:17:34 GMT
Message-ID: <45E33224.7000304@redhat.com>
Date: Mon, 26 Feb 2007 14:16:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Certain domains also require ioctl
Content-Type: multipart/mixed;
 boundary="------------030100050301040107030106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030100050301040107030106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add ioctl to mmap_file_perms

--------------030100050301040107030106
Content-Type: text/plain;
 name="nsaserefpolicy_policy_support_obj_perm_sets.spt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_support_obj_perm_sets.spt"

--- nsaserefpolicy/policy/support/obj_perm_sets.spt	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.5/policy/support/obj_perm_sets.spt	2007-02-26 11:04:23.000000000 -0500
@@ -215,7 +215,7 @@
 define(`getattr_file_perms',`{ getattr }')
 define(`setattr_file_perms',`{ setattr }')
 define(`read_file_perms',`{ getattr read lock ioctl }')
-define(`mmap_file_perms',`{ getattr read execute }')
+define(`mmap_file_perms',`{ getattr read execute ioctl }')
 define(`exec_file_perms',`{ getattr read execute execute_no_trans }')
 define(`append_file_perms',`{ getattr append lock ioctl }')
 define(`write_file_perms',`{ getattr write append lock ioctl }')

--------------030100050301040107030106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
