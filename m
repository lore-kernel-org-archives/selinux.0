Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC411C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E06C20818
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 21:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mpHmjokZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfBUVcK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:32:10 -0500
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:6135 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUVcK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 16:32:10 -0500
X-EEMSG-check-017: 201583743|UPBD19PA07_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Feb 2019 21:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550784715; x=1582320715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wN3a4nWfEAA3EahJtOzh0xBor492hxfReRMw5WlwoOo=;
  b=mpHmjokZcGZ1w+7qbQfuJx8NUVCIk7R7h3Tu9GrY/+dkjTyFSmjcQByQ
   PfysYCcuDy3uRmMW/S8uxNL5xmMc1ht+658oZ6kJV1iGvsNy/6qsbHAU3
   5uhcKa+9Vw2lFdxt96wNutXAotwQvjNdmeTaLi7Y3AZevs9JEWRqqxral
   0jAeL5K2QFMZXXa4RIekn+I88twGPLt/HUdZ8SCmJNm29qF/vk8h3sMec
   TKrLod/U+2h3keSHRjpVSPNOJ94vwCWr9u5WVYdXIjpldDP04XtuM1DU0
   xw9DHkCWCQRcVQB/plaOBPexEKvdVfOlkb4fty2MtOrIdTy4iyp3CtCLD
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,396,1544486400"; 
   d="scan'208";a="20771723"
IronPort-PHdr: =?us-ascii?q?9a23=3A8lhMNBKof5aDdr1KItmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKvvxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9Qr4uWT?=
 =?us-ascii?q?Sm8qxlVhnmhikaPDI96W3blNB8gKddrRm8pRJw3pTUbZmVOvRgY63Tc9AUS2?=
 =?us-ascii?q?1OUcheTCFNHoCxYpETA+cbIepUs4/wrEYOoxukAgmsAfvixCJUhnDoxa060/?=
 =?us-ascii?q?ouEQfb1wI9GtIBqnDUrNHrO6YSTOu4y7LIwijYb/5NxTf86JTHchAmof2WW7?=
 =?us-ascii?q?JwatDexVMgFwPCkFWdsIroNC6b2OQKtmiU9etgVeS3hmE8sQ5xoSKjxsIyio?=
 =?us-ascii?q?XRnoIVzVTE9SRlz4c1P9G3VFR0YcKiHZBNtC+aL5N7Tt4tTmxnoio3yqAKtY?=
 =?us-ascii?q?SlcCUF1pgr3QPTZvqaeIaS+B3jTvyeITJgiXJgf7Kwmgi9/FC7yu35Ssm0yF?=
 =?us-ascii?q?FKrjdZktXUtnACyRjT6s+fR/th5EihwzeP1x3I6u1ePUA1lbbUK54mwrIqkJ?=
 =?us-ascii?q?ocrV/DETPslEXzja+Wcl0o+umu6+v5frXrvoKQOoB7hw3kMqkih9azDfo3Pw?=
 =?us-ascii?q?QQRWSX5Pyw1Lj58k34RLVKgOc2kq7csJ3CPsQUu7W5DhRJ0ocj9xm/DzCm3M?=
 =?us-ascii?q?4enXkcNl1JYh2Hj4/3O13WOvD3Ee+/g0iwkDds3/3GJaPuApHMLnjFjbfgcq?=
 =?us-ascii?q?1w61BTyAUt19BT/ZFUBa8bIPL1REDxsMbUDhgjMwy72+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKL7dsViN5uIuJemMZZMauDXnJ/gq/f7ujHE5mUMGcKa0w5QXZm63HvJ9I0?=
 =?us-ascii?q?qHfXXgmNEBEWMStAokUOPqkEGCUSJUZ3uqR6Iz/Cw7CIa9AIfbXI+tnbiB0D?=
 =?us-ascii?q?6+Hp1RYWBGEE6DHW30eIWDXvdfIB6Vd9dojzgsTbG8T8ok0ha0uUnxzL80AP?=
 =?us-ascii?q?DT/3gjqZ/71NVzr9bWnBU2+C08W9+RyEmRXmp0mSUOXDZw06dh9x8ugmyf2L?=
 =?us-ascii?q?R11qQLXedY4OlEB0JgbZM=3D?=
X-IPAS-Result: =?us-ascii?q?A2BeAAB7GG9c/wHyM5BlHgEGBwaBUQkLAYFZKis8gQMnm?=
 =?us-ascii?q?CwWAQEBAQEBBoExiT+OY4F7IAwMAYEqAYMVg3wiNAkNAQMBAQEBAQECAWwog?=
 =?us-ascii?q?jopgxULAUaBUYJXDD0BgWUNrVYzhUSEa4gFhEMXeIEHgRGNcwKKBoZIgQaRf?=
 =?us-ascii?q?wmHPoNvhyUMGYFxhVqLQItZjU+FFjiBVisIAhgIIQ87gmwJgh8XjjwhAzCBB?=
 =?us-ascii?q?QEBjwQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Feb 2019 21:31:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1LLVqdu028253;
        Thu, 21 Feb 2019 16:31:52 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     dominick.grift@defensec.nl, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v6] scripts/selinux: modernize mdp
Date:   Thu, 21 Feb 2019 16:31:47 -0500
Message-Id: <20190221213147.1590-1-sds@tycho.nsa.gov>
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
classes/permissions.  This appears to be a deficiency in libselinux's
selinux_set_mapping() interface and underlying implementation,
which was never fully updated to deal with unknown classes/permissions
unlike the kernel.  The same problem also occurs with XSELinux.
Programs that instead use selinux_check_access() like dbus-broker
should not have this problem.

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
Create seusers, failsafe_context, and default_contexts for use by
pam_selinux / libselinux.
Create x_contexts for the SELinux X extension.
Create virtual_domain_context and virtual_image_context for libvirtd.
Set to permissive mode rather than enforcing to permit initial autorelabel.
Update the list of filesystem types to be relabeled.
Write -F to /.autorelabel to cause a forced autorelabel on reboot.
Drop broken attempt to relabel the /dev mountpoint directory.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v6 fixes the seusers and failsafe_contexts to include :s0
as per Dominick's comments. It also adds a default_contexts
configuration for good measure, although this might not be
necessary. It creates a minimal working x_contexts configuration
to appease XSELinux, although XSELinux still has problems due
to the lack of the userspace class/perms definitions. It
creates empty virtual_*_context files to make libvirtd happy.
It writes -F to /.autorelabel as per Dominick's comments to
trigger a forced relabel. It also fixes mdp to correctly generate
fs_use rules for ext3 and ext2 when using ext4 as the driver.
These days ext4 is always used to handle ext3 mounts and it can
also be used for ext2.  This version is called v6 to distinguish it from
Dominick's earlier patch sequence, which went up to v4, and then
my previous coalesced patch is logically v5.

 scripts/selinux/install_policy.sh |  92 ++++++++++-------
 scripts/selinux/mdp/mdp.c         | 165 +++++++++++++++++++++++++-----
 2 files changed, 194 insertions(+), 63 deletions(-)

diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 0b86c47baf7d..2dccf141241d 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -1,30 +1,61 @@
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
 
+echo "__default__:user_u:s0" > /etc/selinux/dummy/seusers
+echo "base_r:base_t:s0" > /etc/selinux/dummy/contexts/failsafe_context
+echo "base_r:base_t:s0 base_r:base_t:s0" > /etc/selinux/dummy/default_contexts
+cat > /etc/selinux/dummy/contexts/x_contexts <<EOF
+client * user_u:base_r:base_t:s0
+property * user_u:object_r:base_t:s0
+extension * user_u:object_r:base_t:s0
+selection * user_u:object_r:base_t:s0
+event * user_u:object_r:base_t:s0
+EOF
+touch /etc/selinux/dummy/contexts/virtual_domain_context
+touch /etc/selinux/dummy/contexts/virtual_image_context
+
 cp file_contexts /etc/selinux/dummy/contexts/files
 cp dbus_contexts /etc/selinux/dummy/contexts
 cp policy.$VERS /etc/selinux/dummy/policy
@@ -33,37 +64,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
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
+echo "-F" > /.autorelabel
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 073fe7537f6c..edaba8e51651 100644
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
@@ -108,34 +130,127 @@ int main(int argc, char *argv[])
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
+#ifdef CONFIG_EXT4_FS_SECURITY
+#ifdef CONFIG_EXT4_USE_FOR_EXT2
+	FS_USE("xattr", "ext2");
+#endif
+	FS_USE("xattr", "ext3");
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
 
@@ -144,8 +259,8 @@ int main(int argc, char *argv[])
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

