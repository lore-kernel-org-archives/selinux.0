Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE5C3B1BF
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DC0222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rgUTfyym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBNXp6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:45:58 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:39654
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728405AbgBNXp5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723956; bh=kiR1fAfASnrLSNJIBdQL70/PHVrJKSucioMphf4/9pc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rgUTfyym9T/NI3bqlY5APUkcYQTiHA/u8mp7UipnFERzsS/TSra4XHhaSKeyq/QbSEhQG5vgzQaRHUZNlsMEnhjUpvZXSZUtXZxYfJ8RowHc/nax7Lh1c7NX1UJ0xO58+PFWg+qUGsWb/bMomJBjxUrNHv0fSJPHCmbc0zwkvVGVeDlGCNvzTs0Hkp8Yyy6F5MF2KYvSdEdsL2oq52dDSmriM8erILq9YJmwA9Cr2o1hQq1/E/8G6qj5yA76e5EEcwWU4aYAktCGa3Z8oQk1AEV5XsnT2d5eGsyP5pfp80m8lLeFsOeunFoddtjCapblfZiQOE4lpvvIfPeWp6rbGQ==
X-YMail-OSG: 5T0M3rMVM1meDatpn5HUqZvPHfKj7o4R.0_cQA0X7qNeD_KeqDc8ciZqIPprQF3
 ebr5m5k3_eO_zwoABANRzuXnQlgk222vaspqdaLQb_FzIt6YDLUho1r_ygNleVC50yK5RK7OGEju
 mU.ammRk9CEh4rsSMUHOPghrBqfY0yyoxBrfs.RD7DIWhrlEzpHA_9Lw3v0zJLQzdznXTHenpRLw
 v2n8ry3kFdqeCLFbY7f4AEYeHAezt3_olJc0gqSgst5JwuyyS_XrrqHY6rpx3GuupOzTIODTgF2I
 MT8WwYgT79va2.bj4MB8SH6WWMlvoe4qkR6mKVPY0cR7DEFUAw4pNf5jsWAcIbjisEXXcW0PoSRV
 TV54ZqA3B4d0Vo8FHIqayoV_rzV4tISm2mEFc7QO16f9UcNzqe.HDoEjfZdPze82yZBQo329oWil
 E_3B8cG2Hs96HiG80NX45zc9CV7GGnnAbM6aM0qXo_efQ124uD8snxNueZ3UCKev7nS9RGk5NMW5
 gXaOHnQSolkfzIVWk_WTZmCLsXwyugwHBg2vvGL4L8AJfGC.5ioC5BKEz7nRlcUlZ_H8NoZfNKVh
 kt0FtfIBMg4cwwwHwSQMy8LvWuAPQNdOjAnMgNPSTh61Z.MiEyJnFpR4C9vbe1Fc8vThVU.cGfcc
 qaMnlLzK1qTWSoN3P7f518cpHg9s2a5Qo8x2uu.OotqW3fIwSPfee2vlKThXQbyVNUNK7zHxY32N
 gkJ8MSmkqZrsFgaa3V5S40cQmac8ZMTgNyjo1_5kjMVBmBPLt6Hmg1LasXiNSHousP3WRGdv.HE5
 SDxzzR5qIxAhT35MZFW0tu9dZgvLyD0ei6pNLLHG03jLCOSVV1zafkQp9o00rNHtBEP7wrJZJHYO
 cSqfS0pGy8HjvEG5LExw5eG.Bbil0d20iSxG3rSqJ8mc5QvixkotAVZaBz5Ri8XEIXgVLhjsTkel
 CtiIDChnj6IXS4TeJ8D3YVeYmFReopQ1fJK.DKiMpPx36N_w3CzuxN9u7F9d6c8Bp.eWrD538pFm
 vtdnd7r873Vwn1SmqemYWqblZIheQSCwHwdxPCRenzQA95bTi5fwyzR28ikvtcZZrrMMF2RraL9B
 wlzplor96ykKehfthjznCHNfRjmXEujO_6hBBcyddoHGGM61MkRoubeyccattiHhkdzTk_BDg.h6
 yokO4dWaMm65brqrZZjYqj2TR_.NLOrxURN7gn2lJSuVoSsjo0hKh7p_QbwLYFgAPWzifx0j3o_N
 .aIsr6OEsC1TSUJgjkMwNT7ASMryEzVQFljNLw0s_YzNLltnfhUr6Z1NrCWDtAyVSubOsLoKJac6
 NR868rSU4PJG1_K84Q3JmgK80GA4y2DAlCwnKDr6wC.exEhFDcp_GKvFwOdwpTxrJONBNt6YNeBh
 aH_NkHiqM0f5q5xsBhAYDQRPBXp_u.B3LlBlPEJPOT_CrSznUMVLjyfgPmRgfFA297w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:45:56 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d59e699c21931303bcffa3291bec6e27;
          Fri, 14 Feb 2020 23:45:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Fri, 14 Feb 2020 15:42:02 -0800
Message-Id: <20200214234203.7086-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
---
 Documentation/security/lsm.rst       | 22 ++++++++++
 fs/proc/base.c                       |  1 +
 include/linux/lsm_hooks.h            |  6 +++
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              |  8 +++-
 security/apparmor/procattr.c         | 22 +++++-----
 security/security.c                  | 63 ++++++++++++++++++++++++++++
 security/selinux/hooks.c             |  2 +-
 security/smack/smack_lsm.c           |  2 +-
 9 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index aadf47c808c0..faec18e7e7d1 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -199,3 +199,25 @@ capability-related fields:
 -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
 
 -  ``fs/proc/array.c``::c:func:`task_cap()`
+
+LSM External Interfaces
+=======================
+
+The LSM infrastructure does not generally provide external interfaces.
+The individual security modules provide what external interfaces they
+require.
+
+The infrastructure does provide an interface for the special
+case where multiple security modules provide a process context.
+This is provided in compound context format.
+
+-  `lsm1\0value\0lsm2\0value\0`
+
+The `value` is a nul terminated bytestring. It may contain
+whitespace or non-printable characters. 
+
+The special file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
+
+The special file ``/sys/kernel/security/lsm`` provides a comma
+separated list of the active security modules.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 505331ab7a14..4cc418ce9c3e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2744,6 +2744,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2bf82e1cf347..61977a33f2c3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1321,6 +1321,12 @@
  *	@pages contains the number of pages.
  *	Return 0 if permission is granted.
  *
+ * @getprocattr:
+ *	Provide the named process attribute for display in special files in
+ *	the /proc/.../attr directory.  Attribute naming and the data displayed
+ *	is at the discretion of the security modules.  The exception is the
+ *	"context" attribute, which will contain the security context of the
+ *	task as a nul terminated text string without trailing whitespace.
  * @ismaclabel:
  *	Check if the extended attribute specified by @name
  *	represents a MAC label. Returns 1 if name is a MAC
diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
index 31689437e0e1..03dbfdb2f2c0 100644
--- a/security/apparmor/include/procattr.h
+++ b/security/apparmor/include/procattr.h
@@ -11,7 +11,7 @@
 #ifndef __AA_PROCATTR_H
 #define __AA_PROCATTR_H
 
-int aa_getprocattr(struct aa_label *label, char **string);
+int aa_getprocattr(struct aa_label *label, char **string, bool newline);
 int aa_setprocattr_changehat(char *args, size_t size, int flags);
 
 #endif /* __AA_PROCATTR_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 16b992235c11..02f305ab2c69 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -593,6 +593,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	const struct cred *cred = get_task_cred(task);
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
+	bool newline = true;
 
 	if (strcmp(name, "current") == 0)
 		label = aa_get_newest_label(cred_label(cred));
@@ -600,11 +601,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 		label = aa_get_newest_label(ctx->previous);
 	else if (strcmp(name, "exec") == 0 && ctx->onexec)
 		label = aa_get_newest_label(ctx->onexec);
-	else
+	else if (strcmp(name, "context") == 0) {
+		label = aa_get_newest_label(cred_label(cred));
+		newline = false;
+	} else
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, newline);
 
 	aa_put_label(label);
 	put_cred(cred);
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index c929bf4a3df1..be3b083d9b74 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the profile information for @profile
  * @profile: the profile to print profile info about  (NOT NULL)
  * @string: Returns - string containing the profile info (NOT NULL)
+ * @newline: Should a newline be added to @string.
  *
  * Returns: length of @string on success else error on failure
  *
@@ -30,20 +31,21 @@
  *
  * Returns: size of string placed in @string else error code on failure
  */
-int aa_getprocattr(struct aa_label *label, char **string)
+int aa_getprocattr(struct aa_label *label, char **string, bool newline)
 {
 	struct aa_ns *ns = labels_ns(label);
 	struct aa_ns *current_ns = aa_get_current_ns();
+	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED;
 	int len;
 
 	if (!aa_ns_visible(current_ns, ns, true)) {
 		aa_put_ns(current_ns);
 		return -EACCES;
 	}
+	if (newline)
+		flags |= FLAG_SHOW_MODE;
 
-	len = aa_label_snxprint(NULL, 0, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(NULL, 0, current_ns, label, flags);
 	AA_BUG(len < 0);
 
 	*string = kmalloc(len + 2, GFP_KERNEL);
@@ -52,19 +54,19 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return -ENOMEM;
 	}
 
-	len = aa_label_snxprint(*string, len + 2, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(*string, len + 2, current_ns, label, flags);
 	if (len < 0) {
 		aa_put_ns(current_ns);
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline) {
+		(*string)[len] = '\n';
+		(*string)[++len] = 0;
+	}
 
 	aa_put_ns(current_ns);
-	return len + 1;
+	return len;
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index a66786c255aa..89b635277245 100644
--- a/security/security.c
+++ b/security/security.c
@@ -754,6 +754,42 @@ static void __init lsm_early_task(struct task_struct *task)
 		panic("%s: Early task alloc failed.\n", __func__);
 }
 
+/**
+ * append_ctx - append a lsm/context pair to a compound context
+ * @ctx: the existing compound context
+ * @ctxlen: size of the old context, including terminating nul byte
+ * @lsm: new lsm name, nul terminated
+ * @new: new context, possibly nul terminated
+ * @newlen: maximum size of @new
+ *
+ * replace @ctx with a new compound context, appending @newlsm and @new
+ * to @ctx. On exit the new data replaces the old, which is freed.
+ * @ctxlen is set to the new size, which includes a trailing nul byte.
+ *
+ * Returns 0 on success, -ENOMEM if no memory is available.
+ */
+static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
+		      int newlen)
+{
+	char *final;
+	int llen;
+
+	llen = strlen(lsm) + 1;
+	newlen = strnlen(new, newlen) + 1;
+
+	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
+	if (final == NULL)
+		return -ENOMEM;
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, newlen);
+	kfree(*ctx);
+	*ctx = final;
+	*ctxlen = *ctxlen + llen + newlen;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -2073,6 +2109,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2100,6 +2140,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "context", &cp);
+			if (rc == -EINVAL || rc == -ENOPROTOOPT)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4618e2d0c032..ab2a150e28ca 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6257,7 +6257,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5bee05bd7a42..453923eee950 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3479,7 +3479,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.24.1

