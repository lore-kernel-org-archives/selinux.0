Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9952C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A07E2192D
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jlclyFdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfBOOvL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:51:11 -0500
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:22525 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfBOOvL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 09:51:11 -0500
X-EEMSG-check-017: 170598026|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Feb 2019 14:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550242251; x=1581778251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sEiJaTpfz8Urh1JK5ukgDhAZGZCNTrFAWX3I5ETgAVE=;
  b=jlclyFdE9hH/HSkNZjsayC9KOd5c9B9ytg5JjaLp+MaiffUI0ypD7BCw
   exY1USFJBZKtQ6oFCC04dZgztqqh5w0ksJe439DJKstGh2R4LAr6DdW4P
   UA4AgztJ/XBX8b1PYKIsFHWMKa11MDSdX5PGvuqzWV5mKZNYXK4f3tdFX
   eHO+9zFBZYMQ26HykDFwwKATz+WzbY62I2Di8Z0xo4ngh519CdJNjb/yv
   3/n8x0gyI7fSPJquWe60RtRePBXdHhRLxO9k3OUeVp+AYoMoCKVSCJ8TF
   HA9b/Dhd7l69N3kcUqs5ZFQJZBxykODlMXvfKi3PPXvuWP70dyFQRADwx
   w==;
X-IronPort-AV: E=Sophos;i="5.58,372,1544486400"; 
   d="scan'208";a="20595617"
IronPort-PHdr: =?us-ascii?q?9a23=3A+xhouhYZPmIGutxw5nyMay7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMS9bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?us9adrTALjhjkBOTA37WrbjtV8gLxHrB6koRF03ozab5yPNPdmfq3TY84US2?=
 =?us-ascii?q?RCUMhWWCNPDZixY5cMAucbIepVtZXxq0cIoBCjBQesHuTvyjpQi3Hrwa01zf?=
 =?us-ascii?q?whEQHY0wwmAtkArXHUo8/xNKcWT++0zLTDwDLYb/xLwjfw85TIcxA9rvGMWr?=
 =?us-ascii?q?J8a8zRyVI1GA/fgVWQrpLlMiqT2+8QsGab9/JtWf+ghmMosQ18oiWjyt0yho?=
 =?us-ascii?q?TGmI4Z0E3I+CNky4gvP9K4UlR0Ydu8HZtVsCGVKpV5T9s5Q2FtpCY60roGuY?=
 =?us-ascii?q?OnfCQSyJQo2Rrfa/uffoiU+B3jTueRISpjhH5/ZLK+hwq98UinyuHmUMm7zE?=
 =?us-ascii?q?1KoTZfntnJt3AN0wTf6smBSvRj4keswSuD2g/c5+1eIU04iLDXJ4Auz7IujJ?=
 =?us-ascii?q?YfrFzPHirsl0X3iK+WeF8k+u+t6+n/ebXpu4ScOpRoigD+Lqsumsu/Df4+Mg?=
 =?us-ascii?q?gVRWeX4+u81Lr9/UHhWrVFkuU2krXFsJDdPckbvbC2AwtU0oYl9ha+ACyr0M?=
 =?us-ascii?q?oXnXYZNlJJYhGHgJbzO1HIPv/4Ce2zg1O2kDdk3/rGJKHuAo3RLnjfl7fsZa?=
 =?us-ascii?q?595FRByAo31t1f/4hbCqwFIP7qX0/xs9vYDgUnPACu3+nnD9B9hcsiXjeXC7?=
 =?us-ascii?q?KdGLvbrFvN4+UoOeTKb4gQ6xjnLP1w3OLjlX80nxcmeKCt2ZYGICSjEu9OP1?=
 =?us-ascii?q?SSYX2qhMwIV2gNoFxtH6TRlFSeXGsLND6JVKUm62R+Utqr?=
X-IPAS-Result: =?us-ascii?q?A2AwAAB+0WZc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VkpgWonjCCLZEwBAQEBAQEGim6OXoF7IBgBhECDbCI0CQ0BAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCOimDFQsBRoFRgmM9gWYNrFEzhUSEa4gDhEEXeIEHjwQCkEOBBpFxCYsrh?=
 =?us-ascii?q?x8MGZJ6niU4gVYrCAIYCCEPO4JsgigXjjwhAzCBBQEBjzEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Feb 2019 14:50:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1FEokCe004834;
        Fri, 15 Feb 2019 09:50:46 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3] scripts/selinux: add basic mls support to mdp
Date:   Fri, 15 Feb 2019 09:50:45 -0500
Message-Id: <20190215145045.31945-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add basic MLS policy support to mdp.  Declares
two sensitivities and two categories, defines
mls constraints for all permissions requiring
dominance (ala MCS), assigns the system-high
level to initial SID contexts and the default user
level, and assigns system-low level to filesystems.

Also reworks the fs_use and genfscon rules to only
generate rules for filesystems that are configured
in the kernel.  In some cases this depends on a specific
config option for security xattrs, in other cases security
xattrs are unconditionally supported by a given filesystem
if the filesystem is enabled, and in some cases the filesystem
is always enabled in the kernel.  Dropped obsolete pseudo
filesystems.

NB The list of fs_use_* and genfscon rules emitted by mdp
is very incomplete compared to refpolicy or Android sepolicy.
We should probably expand it.

Usage:
scripts/selinux/mdp/mdp -m policy.conf file_contexts
checkpolicy -M -o policy policy.conf

Then install the resulting policy and file_contexts as usual.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v3 fixes up the file contexts generation code to also use SYSTEMLOW and
collapse down to a single fprintf call per line.
 scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 28 deletions(-)

diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 073fe7537f6c..4223e2fea441 100644
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
@@ -108,34 +130,87 @@ int main(int argc, char *argv[])
 	for (i = 0; secclass_map[i].name; i++)
 		fprintf(fout, "allow base_t base_t:%s *;\n",
 			secclass_map[i].name);
-	fprintf(fout, "user user_u roles { base_r };\n");
-	fprintf(fout, "\n");
+	fprintf(fout, "user user_u roles { base_r }");
+	if (mls)
+		fprintf(fout, " level %s range %s - %s", SYSTEMHIGH,
+			SYSTEMLOW, SYSTEMHIGH);
+	fprintf(fout, ";\n");
+
+#define USERROLETYPE "user_u:base_r:base_t"
 
 	/* default sids */
 	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
+		fprintf(fout, "sid %s " USERROLETYPE "%s\n",
+			initial_sid_to_string[i], mls ? ":" SYSTEMHIGH : "");
 	fprintf(fout, "\n");
 
-	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
-
-	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
-
-	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
-
-	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
+#define FS_USE(behavior, fstype)			    \
+	fprintf(fout, "fs_use_%s %s " USERROLETYPE "%s;\n", \
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
+
+	/*
+	 * Filesystems whose inodes are labeled from allocating task.
+	 */
+	FS_USE("task", "pipefs");
+	FS_USE("task", "sockfs");
+#ifdef CONFIG_POSIX_MQUEUE
+	FS_USE("task", "mqueue");
+#endif
+
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
+
+
+#define GENFSCON(fstype, prefix)			     \
+	fprintf(fout, "genfscon %s %s " USERROLETYPE "%s\n", \
+		fstype, prefix, mls ? ":" SYSTEMLOW : "")
+
+	/*
+	 * Filesystems whose inodes are labeled from path prefix match
+	 * relative to the filesystem root.  Depending on the filesystem,
+	 * only a single label for all inodes may be supported.
+	 */
+	GENFSCON("proc", "/");
+	GENFSCON("selinuxfs", "/");
 
 	fclose(fout);
 
@@ -144,8 +219,8 @@ int main(int argc, char *argv[])
 		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
 		usage(argv[0]);
 	}
-	fprintf(fout, "/ user_u:base_r:base_t\n");
-	fprintf(fout, "/.* user_u:base_r:base_t\n");
+	fprintf(fout, "/ " USERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
+	fprintf(fout, "/.* " USERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
 	fclose(fout);
 
 	return 0;
-- 
2.20.1

