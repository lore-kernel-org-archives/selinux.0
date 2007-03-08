Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FdoVC007795
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:39:50 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FdnY3015308
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:39:49 GMT
Message-ID: <45F02E3D.2070503@redhat.com>
Date: Thu, 08 Mar 2007 10:39:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Fix dosfs handling in the interface
Content-Type: multipart/mixed;
 boundary="------------050407040702020704000708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050407040702020704000708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Allow xend to use dosfs for ia64 boot.

--------------050407040702020704000708
Content-Type: text/x-patch;
 name="dosfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dosfs.patch"

--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/kernel/filesystem.if	2007-03-08 08:42:37.000000000 -0500
@@ -1110,11 +1110,31 @@
 		type dosfs_t;
 	')
 
+	manage_dirs_pattern($1,dosfs_t,dosfs_t)
 	manage_files_pattern($1,dosfs_t,dosfs_t)
 ')
 
 ########################################
 ## <summary>
+##	read files
+##	on a DOS filesystem.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fs_read_dos_files',`
+	gen_require(`
+		type dosfs_t;
+	')
+
+	read_files_pattern($1,dosfs_t,dosfs_t)
+')
+
+########################################
+## <summary>
 ##	Read eventpollfs files.
 ## </summary>
 ## <desc>
--- nsaserefpolicy/policy/modules/system/xen.te	2007-01-02 12:57:49.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/system/xen.te	2007-03-08 08:42:37.000000000 -0500
@@ -357,3 +373,11 @@
 xen_append_log(xm_t)
 xen_stream_connect(xm_t)
 xen_stream_connect_xenstore(xm_t)
+
+#Should have a boolean wrapping these
+fs_list_auto_mountpoints(xend_t)
+files_search_mnt(xend_t)
+fs_write_nfs_files(xend_t)
+fs_read_nfs_files(xend_t)
+fs_getattr_all_fs(xend_t)
+fs_read_dos_files(xend_t)

--------------050407040702020704000708--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
