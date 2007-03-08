Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FigCE008058
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:44:42 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FifY3016061
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:44:42 GMT
Message-ID: <45F02F63.9050704@redhat.com>
Date: Thu, 08 Mar 2007 10:44:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Resend of cpuspeed.patch
Content-Type: multipart/mixed;
 boundary="------------000500050306080003060806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000500050306080003060806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Included interface definition also.

--------------000500050306080003060806
Content-Type: text/x-patch;
 name="cpuspeed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuspeed.patch"

--- nsaserefpolicy/policy/modules/kernel/devices.if	2007-01-02 12:57:13.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/kernel/devices.if	2007-03-08 08:42:36.000000000 -0500
@@ -2449,6 +2449,24 @@
 
 ########################################
 ## <summary>
+##	Write in a sysfs directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`dev_write_sysfs_dirs',`
+	gen_require(`
+		type sysfs_t;
+	')
+
+	allow $1 sysfs_t:dir write;
+')
+
+########################################
+## <summary>
 ##	Search the sysfs directories.
 ## </summary>
 ## <param name="domain">
--- nsaserefpolicy/policy/modules/services/cpucontrol.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/cpucontrol.te	2007-03-08 08:42:37.000000000 -0500
@@ -91,6 +91,7 @@
 kernel_read_system_state(cpuspeed_t)
 kernel_read_kernel_sysctls(cpuspeed_t)
 
+dev_write_sysfs_dirs(cpuspeed_t)
 dev_rw_sysfs(cpuspeed_t)
 
 domain_use_interactive_fds(cpuspeed_t)

--------------000500050306080003060806--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
