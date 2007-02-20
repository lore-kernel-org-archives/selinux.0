Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHTD1W003324
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:29:13 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KHUUQc025279
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:30:30 GMT
Message-ID: <45DB3034.2070303@redhat.com>
Date: Tue, 20 Feb 2007 12:30:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Prelink needs to be able to relabel from prelink_tmp_t
Content-Type: multipart/mixed;
 boundary="------------090906090306080801040607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090906090306080801040607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

prelink creates temporarly files that it then needs to relabel.



--------------090906090306080801040607
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_admin_prelink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_admin_prelink.patch"

--- nsaserefpolicy/policy/modules/admin/prelink.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/admin/prelink.te	2007-02-19 16:01:52.000000000 -0500
@@ -43,6 +43,7 @@
 allow prelink_t prelink_tmp_t:file { manage_file_perms execute };
 files_tmp_filetrans(prelink_t, prelink_tmp_t, file)
 fs_tmpfs_filetrans(prelink_t, prelink_tmp_t, file)
+allow prelink_t prelink_tmp_t:file relabelfrom;
 
 # prelink misc objects that are not system
 # libraries or entrypoints

--------------090906090306080801040607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
