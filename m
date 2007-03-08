Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FI5n6006411
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:18:05 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FI4wk015184
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:18:04 GMT
Message-ID: <45F0292A.3000301@redhat.com>
Date: Thu, 08 Mar 2007 10:18:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Add kvmfs support
Content-Type: multipart/mixed;
 boundary="------------090604030507060007080808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090604030507060007080808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090604030507060007080808
Content-Type: text/x-patch;
 name="kvmfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvmfs.patch"

--- nsaserefpolicy/policy/modules/kernel/kernel.te	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/kernel/kernel.te	2007-03-08 08:42:45.000000000 -0500
@@ -51,6 +51,15 @@
 genfscon debugfs / gen_context(system_u:object_r:debugfs_t,s0)
 
 #
+# kvmFS
+#
+
+type kvmfs_t;
+fs_type(kvmfs_t)
+allow kvmfs_t self:filesystem associate;
+genfscon kvmfs / gen_context(system_u:object_r:kvmfs_t,s0)
+
+#
 # Procfs types
 #
 

--------------090604030507060007080808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
