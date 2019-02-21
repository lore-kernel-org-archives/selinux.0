Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC08C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383AE2084D
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iFAjExoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbfBUSmq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:42:46 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:2378 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbfBUSmp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 13:42:45 -0500
X-EEMSG-check-017: 236232805|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Feb 2019 18:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550774546; x=1582310546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I1NO4wgKuyXOiyumtZaxfbGvPY0XPi/bphzo78s4ycY=;
  b=iFAjExoABhJj+1KKSZM0ncrGalHCSRa/cEBOroRlfjHghQ3IWGh5n879
   Wp3UFU4mmZAy3hFFbaitPZMb68Y5WeWmJqnO+8iOJAZEM1xEk+D5ZhU5b
   p6GgJ0SkhCSJSw6whNQKP7Cec49LLkGiep28gXtipMEs68I2lZfwVJxoD
   23Znvc0nRYXYnWu9+k85dGTjAXq43S69JSOZAdCL+uk/YjxJtlmlTIj6w
   9wmd9wnMpKAjiUPjErhWnF/H08GWY0nJeR2dhccmWfmzyShjIdJ7Pbb+F
   GKLkeZWfrOChCj0QfbbZd7UOg4HcqwgxWPNnW5zYpQJajT52IN+Z45ajr
   w==;
X-IronPort-AV: E=Sophos;i="5.58,396,1544486400"; 
   d="scan'208";a="20762430"
IronPort-PHdr: =?us-ascii?q?9a23=3AX4kQ9BWZCIbRq+C1Ac6M3ZOpw0fV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRSAt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KhlUh/ojDoMOSA//m/Zl8d8iLtXrAy9qxB6xYPffYObO+dkfq7Ffd0UW3?=
 =?us-ascii?q?dPUMhSWSJGDYyyYJACA/YCMOtCs4XwvUcCoQe4CAKxBO3v0DhIhnru0KMnz+?=
 =?us-ascii?q?QuDxnG3Aw+ENIIrX/asdD1O70WUeCx0qbJzSjIYvRN2Tjg84jFaQwhoPGQUr?=
 =?us-ascii?q?Jwdsrd008vFxjfgVmKpozlOC2V2/0LvmOG4eRgUuevhHQmqwF3ujWg3d0jio?=
 =?us-ascii?q?rTioIQ1FDI7T15wIExJd25VEF6YcSoH4dKuCGGMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMYIhw74smZ?=
 =?us-ascii?q?oTtkTPBCn2l1ntjKCKbEkk/+mo6+D/brXnoJ+TKZN0hxnjPqkhlcGzG+Q1Ph?=
 =?us-ascii?q?UUU2SF9umwyqfv8VDhTLVPlPI2k63ZsJ7AJcQco660GxRV3Zs46xukEzen0M?=
 =?us-ascii?q?gXnXkALF5ffhKHlJLmN0vBIPD/E/ezm06snytzx/DaIr3hBY3ALmPdn7flfL?=
 =?us-ascii?q?Z97VNcyQUowNBB6JJbFKsBLOjwWkDvrtzYCAE2Mwiuz+bgEtV92ZsUWXiTDa?=
 =?us-ascii?q?+BLKPSrViI6/oyLOmLYY8VuTD9K/k56P7tl3M5lkUdfain3ZsLc323A+ppI0?=
 =?us-ascii?q?uHbnrqmdcOD3sFshA4TOzukFeCSyJcZ26uX6Ig4TE2EJqmAp3eRoCpm7GBxD?=
 =?us-ascii?q?20HoBSZmxfD1CMFnDod5+aVPsWdC2SJcphwXQ4Uu25QpIl/QmnqQu/zr1gNO?=
 =?us-ascii?q?eS8Sod5rz5090g3PHejRE/83RPCs2Z12ycBzVvknggWy493Kc5p1d0jFiEz/?=
 =?us-ascii?q?4r0LRjCdVP6qYRAU8BPpnGwrk/UYj/?=
X-IPAS-Result: =?us-ascii?q?A2AoAAB98G5c/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VkqKzyBAyeMIYwLFgEBAQEBAQaBMYk/jmOBeyAMDAGBKgGDFYN8IjQJDQEDA?=
 =?us-ascii?q?QEBAQEBAgFsKII6KYMVCwFGgVGCYz0BgWUNrWUzhUSEa4gFhEMXeIEHgRGNc?=
 =?us-ascii?q?wKKBoZIgQaRfwmHPoNvhyUMGYFxhVqKXGMBi1mNT4UWOIFWKwgCGAghDzuCb?=
 =?us-ascii?q?AmCHxeOPCEDMIEFAQGPBAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Feb 2019 18:42:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1LIgNxB002688;
        Thu, 21 Feb 2019 13:42:24 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     dominick.grift@defensec.nl, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] scripts/selinux: modernize mdp
Date:   Thu, 21 Feb 2019 13:42:13 -0500
Message-Id: <20190221184213.31303-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Derived in part from a patch by Dominick Grift.

The MDP example no longer works on modern systems.  Fix it.
While we are at it, add MLS support and enable it.

NB This still does not work on systems using dbus-daemon instead of
dbus-broker because dbus-daemon does not yet gracefully handle unknown
classes/permissions.  This is a deficiency in libselinux's
selinux_set_mapping() interface and underlying implementation,
which was never fully updated to deal with unknown classes/permissions
unlike the kernel.  Programs that instead use selinux_check_access()
like dbus-broker do not have this problem.

Other known issues:
- Not everything appears to be relabeled, so some files are left with invalid
contexts and remapped to the unlabeled SID/context.
- X will fail due to lack of a x_contexts file
- libvirtd will fail due to lack of a virtual_domain_context file
- crond reports an error with "No security context"

Changes to mdp:
Add support for devtmpfs, required by modern Linux distributions.
Add MLS support, with sample sensitivities, categories, and constraints.
Generate fs_use and genfscon rules based on kernel configuration.
Update list of filesystem types for fs_use and genfscon rules.
Use object_r for object contexts.

Changes to install_policy.sh:
Bail immediately on any errors.
Provide more helpful error messages when unable to find userspace tools.
Refuse to run if SELinux is already enabled.
Unconditionally move aside /etc/selinux/config and create a new one.
Build policy with -U allow so that userspace object managers do not break.
Build policy with MLS enabled by default.
Add default seusers mapping and failsafe context for use by
pam_selinux / libselinux.
Set to permissive mode rather than enforcing to permit initial autorelabel.
Update the list of filesystem types to be relabeled.
Create /.autorelabel to trigger an autorelabel on reboot.
Drop broken attempt to relabel the /dev mountpoint directory.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 scripts/selinux/install_policy.sh |  82 ++++++++-------
 scripts/selinux/mdp/mdp.c         | 164 +++++++++++++++++++++++++-----
 2 files changed, 183 insertions(+), 63 deletions(-)

diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 0b86c47baf7d..09eab4d0da5c 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -1,30 +1,51 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+set -e
 if [ `id -u` -ne 0 ]; then
 	echo "$0: must be root to install the selinux policy"
 	exit 1
 fi
+
 SF=`which setfiles`
 if [ $? -eq 1 ]; then
-	if [ -f /sbin/setfiles ]; then
-		SF="/usr/setfiles"
-	else
-		echo "no selinux tools installed: setfiles"
-		exit 1
-	fi
+	echo "Could not find setfiles"
+	echo "Do you have policycoreutils installed?"
+	exit 1
 fi
 
-cd mdp
-
 CP=`which checkpolicy`
+if [ $? -eq 1 ]; then
+	echo "Could not find checkpolicy"
+	echo "Do you have checkpolicy installed?"
+	exit 1
+fi
 VERS=`$CP -V | awk '{print $1}'`
 
-./mdp policy.conf file_contexts
-$CP -o policy.$VERS policy.conf
+ENABLED=`which selinuxenabled`
+if [ $? -eq 1 ]; then
+	echo "Could not find selinuxenabled"
+	echo "Do you have libselinux-utils installed?"
+	exit 1
+fi
+
+if selinuxenabled; then
+    echo "SELinux is already enabled"
+    echo "This prevents safely relabeling all files."
+    echo "Boot with selinux=0 on the kernel command-line or"
+    echo "SELINUX=disabled in /etc/selinux/config."
+    exit 1
+fi
+
+cd mdp
+./mdp -m policy.conf file_contexts
+$CP -U allow -M -o policy.$VERS policy.conf
 
 mkdir -p /etc/selinux/dummy/policy
 mkdir -p /etc/selinux/dummy/contexts/files
 
+echo "__default__:user_u" > /etc/selinux/dummy/seusers
+echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
+
 cp file_contexts /etc/selinux/dummy/contexts/files
 cp dbus_contexts /etc/selinux/dummy/contexts
 cp policy.$VERS /etc/selinux/dummy/policy
@@ -33,37 +54,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
 if [ ! -d /etc/selinux ]; then
 	mkdir -p /etc/selinux
 fi
-if [ ! -f /etc/selinux/config ]; then
-	cat > /etc/selinux/config << EOF
-SELINUX=enforcing
+if [ -f /etc/selinux/config ]; then
+    echo "/etc/selinux/config exists, moving to /etc/selinux/config.bak."
+    mv /etc/selinux/config /etc/selinux/config.bak
+fi
+echo "Creating new /etc/selinux/config for dummy policy."
+cat > /etc/selinux/config << EOF
+SELINUX=permissive
 SELINUXTYPE=dummy
 EOF
-else
-	TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 | awk -F= '{ print $2 '}`
-	if [ "eq$TYPE" != "eqdummy" ]; then
-		selinuxenabled
-		if [ $? -eq 0 ]; then
-			echo "SELinux already enabled with a non-dummy policy."
-			echo "Exiting.  Please install policy by hand if that"
-			echo "is what you REALLY want."
-			exit 1
-		fi
-		mv /etc/selinux/config /etc/selinux/config.mdpbak
-		grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> /etc/selinux/config
-		echo "SELINUXTYPE=dummy" >> /etc/selinux/config
-	fi
-fi
 
 cd /etc/selinux/dummy/contexts/files
-$SF file_contexts /
+$SF -F file_contexts /
 
-mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
-$SF file_contexts $mounts
+mounts=`cat /proc/$$/mounts | \
+	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
+	awk '{ print $2 '}`
+$SF -F file_contexts $mounts
 
-
-dodev=`cat /proc/$$/mounts | grep "/dev "`
-if [ "eq$dodev" != "eq" ]; then
-	mount --move /dev /mnt
-	$SF file_contexts /dev
-	mount --move /mnt /dev
-fi
+touch /.autorelabel
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 073fe7537f6c..daad333c7252 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -33,6 +33,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/socket.h>
+#include <linux/kconfig.h>
 
 static void usage(char *name)
 {
@@ -95,10 +96,31 @@ int main(int argc, char *argv[])
 	}
 	fprintf(fout, "\n");
 
-	/* NOW PRINT OUT MLS STUFF */
+	/* print out mls declarations and constraints */
 	if (mls) {
-		printf("MLS not yet implemented\n");
-		exit(1);
+		fprintf(fout, "sensitivity s0;\n");
+		fprintf(fout, "sensitivity s1;\n");
+		fprintf(fout, "dominance { s0 s1 }\n");
+		fprintf(fout, "category c0;\n");
+		fprintf(fout, "category c1;\n");
+		fprintf(fout, "level s0:c0.c1;\n");
+		fprintf(fout, "level s1:c0.c1;\n");
+#define SYSTEMLOW "s0"
+#define SYSTEMHIGH "s1:c0.c1"
+		for (i = 0; secclass_map[i].name; i++) {
+			struct security_class_mapping *map = &secclass_map[i];
+
+			fprintf(fout, "mlsconstrain %s {\n", map->name);
+			for (j = 0; map->perms[j]; j++)
+				fprintf(fout, "\t%s\n", map->perms[j]);
+			/*
+			 * This requires all subjects and objects to be
+			 * single-level (l2 eq h2), and that the subject
+			 * level dominate the object level (h1 dom h2)
+			 * in order to have any permissions to it.
+			 */
+			fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
+		}
 	}
 
 	/* types, roles, and allows */
@@ -108,34 +130,126 @@ int main(int argc, char *argv[])
 	for (i = 0; secclass_map[i].name; i++)
 		fprintf(fout, "allow base_t base_t:%s *;\n",
 			secclass_map[i].name);
-	fprintf(fout, "user user_u roles { base_r };\n");
-	fprintf(fout, "\n");
+	fprintf(fout, "user user_u roles { base_r }");
+	if (mls)
+		fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
+			SYSTEMLOW, SYSTEMHIGH);
+	fprintf(fout, ";\n");
+
+#define SUBJUSERROLETYPE "user_u:base_r:base_t"
+#define OBJUSERROLETYPE "user_u:object_r:base_t"
 
 	/* default sids */
 	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
+		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
+			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
 	fprintf(fout, "\n");
 
-	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
+#define FS_USE(behavior, fstype)			    \
+	fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
+		behavior, fstype, mls ? ":" SYSTEMLOW : "")
+
+	/*
+	 * Filesystems whose inode labels can be fetched via getxattr.
+	 */
+#ifdef CONFIG_EXT2_FS_SECURITY
+	FS_USE("xattr", "ext2");
+#endif
+#ifdef CONFIG_EXT3_FS_SECURITY
+	FS_USE("xattr", "ext3");
+#endif
+#ifdef CONFIG_EXT4_FS_SECURITY
+	FS_USE("xattr", "ext4");
+#endif
+#ifdef CONFIG_JFS_SECURITY
+	FS_USE("xattr", "jfs");
+#endif
+#ifdef CONFIG_REISERFS_FS_SECURITY
+	FS_USE("xattr", "reiserfs");
+#endif
+#ifdef CONFIG_JFFS2_FS_SECURITY
+	FS_USE("xattr", "jffs2");
+#endif
+#ifdef CONFIG_XFS_FS
+	FS_USE("xattr", "xfs");
+#endif
+#ifdef CONFIG_GFS2_FS
+	FS_USE("xattr", "gfs2");
+#endif
+#ifdef CONFIG_BTRFS_FS
+	FS_USE("xattr", "btrfs");
+#endif
+#ifdef CONFIG_F2FS_FS_SECURITY
+	FS_USE("xattr", "f2fs");
+#endif
+#ifdef CONFIG_OCFS2_FS
+	FS_USE("xattr", "ocsfs2");
+#endif
+#ifdef CONFIG_OVERLAY_FS
+	FS_USE("xattr", "overlay");
+#endif
+#ifdef CONFIG_SQUASHFS_XATTR
+	FS_USE("xattr", "squashfs");
+#endif
+
+	/*
+	 * Filesystems whose inodes are labeled from allocating task.
+	 */
+	FS_USE("task", "pipefs");
+	FS_USE("task", "sockfs");
 
-	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
+	/*
+	 * Filesystems whose inode labels are computed from both
+	 * the allocating task and the superblock label.
+	 */
+#ifdef CONFIG_UNIX98_PTYS
+	FS_USE("trans", "devpts");
+#endif
+#ifdef CONFIG_HUGETLBFS
+	FS_USE("trans", "hugetlbfs");
+#endif
+#ifdef CONFIG_TMPFS
+	FS_USE("trans", "tmpfs");
+#endif
+#ifdef CONFIG_DEVTMPFS
+	FS_USE("trans", "devtmpfs");
+#endif
+#ifdef CONFIG_POSIX_MQUEUE
+	FS_USE("trans", "mqueue");
+#endif
 
-	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
+#define GENFSCON(fstype, prefix)			     \
+	fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
+		fstype, prefix, mls ? ":" SYSTEMLOW : "")
 
-	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
+	/*
+	 * Filesystems whose inodes are labeled from path prefix match
+	 * relative to the filesystem root.  Depending on the filesystem,
+	 * only a single label for all inodes may be supported.  Here
+	 * we list the filesystem types for which per-file labeling is
+	 * supported using genfscon; any other filesystem type can also
+	 * be added by only with a single entry for all of its inodes.
+	 */
+#ifdef CONFIG_PROC_FS
+	GENFSCON("proc", "/");
+#endif
+#ifdef CONFIG_SECURITY_SELINUX
+	GENFSCON("selinuxfs", "/");
+#endif
+#ifdef CONFIG_SYSFS
+	GENFSCON("sysfs", "/");
+#endif
+#ifdef CONFIG_DEBUG_FS
+	GENFSCON("debugfs", "/");
+#endif
+#ifdef CONFIG_TRACING
+	GENFSCON("tracefs", "/");
+#endif
+#ifdef CONFIG_PSTORE
+	GENFSCON("pstore", "/");
+#endif
+	GENFSCON("cgroup", "/");
+	GENFSCON("cgroup2", "/");
 
 	fclose(fout);
 
@@ -144,8 +258,8 @@ int main(int argc, char *argv[])
 		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
 		usage(argv[0]);
 	}
-	fprintf(fout, "/ user_u:base_r:base_t\n");
-	fprintf(fout, "/.* user_u:base_r:base_t\n");
+	fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
+	fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
 	fclose(fout);
 
 	return 0;
-- 
2.20.1

