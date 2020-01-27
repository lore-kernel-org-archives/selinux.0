Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22434C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26BB2467B
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="j/Rvcdvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0Uyk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:54:40 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:46042 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0Uyk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 15:54:40 -0500
X-EEMSG-check-017: 49669166|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,371,1574121600"; 
   d="scan'208";a="49669166"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Jan 2020 20:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580158475; x=1611694475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Frlvrr9qBiytXbO/5Rw34WYKuUwFE6XFpOw9ix0cGMg=;
  b=j/Rvcdvk1r/9W2kglK/Wno8Zqqr6dqLYJ0OI2GM5GV1/0mayws/78BAK
   sQIvokAAJZ39mt7eRGE6hbcLuEXrXMwzBnH7XgOT+LXEYvjV9IjGP8FXV
   q4zReIMeUYAxscgEdnO3hYbuhk6QTFMjYxXyLP79Cxy85GDqsj7OO1IkM
   k51/exxbwgxqbPSguZt2jx0FFJ2zToh/FqYfpfd8V+MX7JDpl+4b5jccw
   ML7nFjuIQTJENutQIcZkVwv3qQ+VbawDiQ0g7JT4SObONKgYbzVHc8ZPu
   SligwMY6oEeJkwax3ruuQ14JdknZT4hBKLpn8u4NaJHbcYHY8bj/IRLtz
   A==;
X-IronPort-AV: E=Sophos;i="5.70,371,1574121600"; 
   d="scan'208";a="38309541"
IronPort-PHdr: =?us-ascii?q?9a23=3AwLSm+x8Hxgp/vv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21+kcTK2v8tzYMVDF4r011RmVBNmdsKgP0rGH++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMj4ZuNKk9xg?=
 =?us-ascii?q?bHr3ZMZu9awX9kKU+Jkxvz+8u98oRv/zhMt/4k6sVNTbj0c6MkQLJCET8oKX?=
 =?us-ascii?q?o15MrltRnCSQuA+H4RWXgInxRLHgbI8gj0Uo/+vSXmuOV93jKaPdDtQrAvRT?=
 =?us-ascii?q?ui9aZrRwT2hyoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7Wct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYMM+JVo4z7qlATrxWxGBOsCfvvxDFWm3H406403e?=
 =?us-ascii?q?MuHg/JxwEsA9EDvW7IoNjvKKseTea4x7TIwzXZaPNW3C/w5pXUch8/ufGMXa?=
 =?us-ascii?q?x/cczMwkcyEgPKlFGQqYj7MDKVy+8AtHOb4Pd7Ve+0l24mqx1+ojioxss2jI?=
 =?us-ascii?q?nJnZgaxkrL9SV+3oY4PNu1Q1N1b96jFZtfrSCaN41uT8MtQmFopCY6yqAdtp?=
 =?us-ascii?q?KhYCcKz5EnyhjCYPKEa4iF+g/vWemeLDtihH9pZaiziwi9/ES+0OHwS8+520?=
 =?us-ascii?q?tQoCVfiNnDrHUN2gTW6siAV/Ry4F+s2S2K1wDP8uFEJl00lbbDJ54h3LEwkp?=
 =?us-ascii?q?0TvFzfHiDsgkX2jbKWdl4+9uip7eTnbLLmpoSCOIBokA3+LqQvldC/AeQ/KA?=
 =?us-ascii?q?QOWXSU+f+g27H5+E35QbFKguU3kqnfrp/aOdwWqrO2DgJayIou6wuzAy243N?=
 =?us-ascii?q?kXg3ULNk9JdAqCj4fzOlHOJP74De24g1SpiDpr3O3JPqb6D5XRLnnMjLfhfb?=
 =?us-ascii?q?Fn505a0wo818pT551TCrEfOP7zQFP+tMTEDh8lNAy52+HnCNB61oMFX2KAGL?=
 =?us-ascii?q?OWP73JvF+S+O0gPumMa5UJuDrnN/cl4Pvuh2cjmVABZampwYcXaHegE/R9PU?=
 =?us-ascii?q?qZZXvsgtEcEWYFpQc+UuPqh0OYUTJJZHa9Qbg85jclB4KiF4vDQZqtgLOZ1i?=
 =?us-ascii?q?ehApJWfnxGCkyLEXrwb4WLQeoMaCaJL895iDMESLyhR5Yk1RGpsw/60aRoIv?=
 =?us-ascii?q?DI9S0fsJKwnORysvXaiBUa7TVpC4GY1GaXQid/mWZbaSUx2fVEvUFlylqFmZ?=
 =?us-ascii?q?N9ivhcGM0bs+hFSS8mJJXcyKp8ENm0VQXfKITaAG26S8mrVGliBuk6xMUDNg?=
 =?us-ascii?q?MmStg=3D?=
X-IPAS-Result: =?us-ascii?q?A2A7AQCATS9e/wHyM5BmHQEBAQkBEQUFAYFqBQELAYF3B?=
 =?us-ascii?q?YEYVCESKo0XhnUBAQEBAQEGiyaRSQkBAQEBAQEBAQEbEAwBAYRAgko3Bg4CE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTcMgjspgygLAUaBUYJnPwGCViUPrgYzhUqDNoE4B?=
 =?us-ascii?q?oE4AYdAhHd5gQeBETaDG4JkAodRBI1YBIh3gSeXXoJDgkyEdo5pDBuCSJgzA?=
 =?us-ascii?q?ZAqhxqUOSOBWCsIAhgIIQ+DJ1AYDZN4F4NQinEjAzCNLV8BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Jan 2020 20:54:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00RKrjX2121884;
        Mon, 27 Jan 2020 15:53:49 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: remove unused initial SIDs and improve handling
Date:   Mon, 27 Jan 2020 15:55:07 -0500
Message-Id: <20200127205507.3317-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove initial SIDs that have never been used or are no longer
used by the kernel from its string table, which is also used
to generate the SECINITSID_* symbols referenced in code.
Update the code to gracefully handle the fact that these can
now be NULL. Stop treating it as an error if a policy defines
additional initial SIDs unknown to the kernel, or if the policy
leaves one of the unused initial SIDs without a defined context.
Fix the incorrect usage of the name from the ocontext in error
messages when loading initial SIDs since these are not presently
written to the kernel policy and are therefore always NULL.

This is a first step toward enabling future evolution of
initial SIDs. Further changes are required to both userspace
and the kernel to fully address
https://github.com/SELinuxProject/selinux-kernel/issues/12
but this takes a small step toward that end.  NB Even with
this change, one cannot yet add or remove initial SIDs in
policy without breakage; separate changes to the policy
compiler are still necessary.  Further, fully decoupling
the policy and kernel initial SID values will require a policy
format/version change to include the SID names in the
kernel policy so that they can be dynamically mapped at
policy load.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 scripts/selinux/genheaders/genheaders.c       | 11 +++-
 .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
 security/selinux/selinuxfs.c                  |  6 +-
 security/selinux/ss/policydb.c                | 28 ++++++---
 security/selinux/ss/services.c                | 26 ++++-----
 5 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index 544ca126a8a8..f355b3e0e968 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -67,8 +67,12 @@ int main(int argc, char *argv[])
 	}
 
 	isids_len = sizeof(initial_sid_to_string) / sizeof (char *);
-	for (i = 1; i < isids_len; i++)
-		initial_sid_to_string[i] = stoupperx(initial_sid_to_string[i]);
+	for (i = 1; i < isids_len; i++) {
+		const char *s = initial_sid_to_string[i];
+
+		if (s)
+			initial_sid_to_string[i] = stoupperx(s);
+	}
 
 	fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
 	fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\n\n");
@@ -82,7 +86,8 @@ int main(int argc, char *argv[])
 
 	for (i = 1; i < isids_len; i++) {
 		const char *s = initial_sid_to_string[i];
-		fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
+		if (s)
+			fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
 	}
 	fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
 	fprintf(fout, "\nstatic inline bool security_is_socket_class(u16 kern_tclass)\n");
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 4f93f697f71c..465ea0923a7c 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,34 +1,33 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* This file is automatically generated.  Do not edit. */
 static const char *initial_sid_to_string[] =
 {
-    "null",
-    "kernel",
-    "security",
-    "unlabeled",
-    "fs",
-    "file",
-    "file_labels",
-    "init",
-    "any_socket",
-    "port",
-    "netif",
-    "netmsg",
-    "node",
-    "igmp_packet",
-    "icmp_socket",
-    "tcp_socket",
-    "sysctl_modprobe",
-    "sysctl",
-    "sysctl_fs",
-    "sysctl_kernel",
-    "sysctl_net",
-    "sysctl_net_unix",
-    "sysctl_vm",
-    "sysctl_dev",
-    "kmod",
-    "policy",
-    "scmp_packet",
-    "devnull",
+	"null",
+	"kernel",
+	"security",
+	"unlabeled",
+	NULL,
+	"file",
+	NULL,
+	NULL,
+	"any_socket",
+	"port",
+	"netif",
+	"netmsg",
+	"node",
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	"devnull",
 };
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79c710911a3c..daddc880ebfc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1692,7 +1692,11 @@ static int sel_make_initcon_files(struct dentry *dir)
 	for (i = 1; i <= SECINITSID_NUM; i++) {
 		struct inode *inode;
 		struct dentry *dentry;
-		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
+		const char *s = security_get_initial_sid_context(i);
+
+		if (!s)
+			continue;
+		dentry = d_alloc_name(dir, s);
 		if (!dentry)
 			return -ENOMEM;
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2aa7f2e1a8e7..6ea2dab339ad 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -865,16 +865,27 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
-		rc = -EINVAL;
-		if (!c->context[0].user) {
-			pr_err("SELinux:  SID %s was never defined.\n",
-				c->u.name);
+		u32 sid = c->sid[0];
+		const char *name;
+
+		if (sid == SECSID_NULL) {
+			pr_err("SELinux:  SID null was assigned a context.\n");
 			sidtab_destroy(s);
 			goto out;
 		}
-		if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
-			pr_err("SELinux:  Initial SID %s out of range.\n",
-				c->u.name);
+
+		/* Ignore initial SIDs defined for future kernels. */
+		if (sid > SECINITSID_NUM)
+			continue;
+
+		name = security_get_initial_sid_context(sid);
+		rc = -EINVAL;
+		if (!c->context[0].user) {
+			/* Ignore undefined SIDs that are not in use. */
+			if (!name)
+				continue;
+			pr_err("SELinux:  SID %s was never defined.\n",
+				name);
 			sidtab_destroy(s);
 			goto out;
 		}
@@ -883,11 +894,10 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 			sidtab_destroy(s);
 			goto out;
 		}
-
 		rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
-				c->u.name);
+				name);
 			sidtab_destroy(s);
 			goto out;
 		}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 216ce602a2b5..bd924a9a6388 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1323,23 +1323,22 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	if (!selinux_initialized(state)) {
 		if (sid <= SECINITSID_NUM) {
 			char *scontextp;
+			const char *s = initial_sid_to_string[sid];
 
-			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
+			if (!s)
+				return -EINVAL;
+			*scontext_len = strlen(s) + 1;
 			if (!scontext)
-				goto out;
-			scontextp = kmemdup(initial_sid_to_string[sid],
-					    *scontext_len, GFP_ATOMIC);
-			if (!scontextp) {
-				rc = -ENOMEM;
-				goto out;
-			}
+				return 0;
+			scontextp = kmemdup(s, *scontext_len, GFP_ATOMIC);
+			if (!scontextp)
+				return -ENOMEM;
 			*scontext = scontextp;
-			goto out;
+			return 0;
 		}
 		pr_err("SELinux: %s:  called before initial "
 		       "load_policy on unknown SID %d\n", __func__, sid);
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 	read_lock(&state->ss->policy_rwlock);
 	policydb = &state->ss->policydb;
@@ -1363,7 +1362,6 @@ static int security_sid_to_context_core(struct selinux_state *state,
 
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
-out:
 	return rc;
 
 }
@@ -1553,7 +1551,9 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext2)) {
+			const char *s = initial_sid_to_string[i];
+
+			if (s && !strcmp(s, scontext2)) {
 				*sid = i;
 				goto out;
 			}
-- 
2.24.1

