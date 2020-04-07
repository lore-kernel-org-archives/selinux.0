Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B1EC2BA80
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593482072A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IyjZRp4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDGA0T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:26:19 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:39371
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDGA0S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586219176; bh=vka1aBBAcbeRN4u66HGnEFYn7K//dKe8zDap/Zxm2AY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IyjZRp4suDW1ft6imxEfwTBwLhoh+Mw2sAOiWC9YROD1TjxYQxYxqJ0/afDr4Annj88vtL+kjzXOaClAWTYoAkf/QVSJOM07EJsEgHYv/HHi+KETEgOkjBCtn1Oa83mW2O2cDIMe0NAdaQANdP8kpFk1yvNefrPUAc5d4wzJI5AcTKDbEz9vRcCJonpUVfGOBBAschfwmOA57JazsPZRbFkYgd//xmfRyNhMDyrb5of9M/N59eLr1N6sFaJJD1va2YpFIIKyeGtSq49f7vC5l7sSIAchCMaykYDwoe6cneNWzvEM0EwQh69M6iLaMpz5K+eBEp5J85bom93E3uelZA==
X-YMail-OSG: bQ7h10oVM1k7r1IezBrGbX2SoCTmGhqbE2e73jV1ueyUF1tK.pefiEnU8dQjxC6
 5LMa1YP0Y8Lz_Be10WPde5lPwnP19UaRbg_x9fZ_vLMYHSRpGGSNi.pmGWrC9Yp80JKnhz97pBaw
 .BHBZ.y.TaFwVJ6IfTb8CgiYzcXr3_cKWxgkWif.dvujn9HxEyvd74Gw0yTkWi0iQs_hzV19PGZe
 iZ_zx3o9i.LyX8IEXcd.T99776h_LH_fpaC8B8wF5Qo.p3b0D8NcmlAOyL5HwvlWMxdhbJEv3QQv
 lboXCoHw.uGrDYp1gBCCkqmB3XR41qEU_SMUlJYU4lHVHIlUv_IrSVD_0XED1XodV5h3QciPws9b
 G5119IaGeyWMfHzqddEejvlr5Tudq0S2EOcvUJeoEVwt_8cTEGEpHGG.WEa6oMEFoyzbvAB1hhqP
 AlJMrbjBKLnmwP4TxdIfhrDDmDOY9jopy2e2ahOn_YPwuDaqJN_KOsN9QLJRbKsrHhYtbaALCAkV
 DCelriC2tqGcVqFAbVX7JHtwiXvRbVSjWiQxDtrPomyYVWv7rmpGbEqiD01pXtRwroyiQecZpEf9
 BEymlJ_Rd8RhlMxMYlor_HuX007wzX8eDQvE.KDwfx2W1j1sy4lndWqDSaeZsei9MHCXuCopaoRa
 YrZJqdfRygNF4niWHFLilx.aogfvPzdbCeLPJCKhBLRv1pQKjj7PjtTsy4wlkd97LFy2BQj12Z0t
 dSb4UsJvl8zbxAbnq8zkbDnR7gK0zytgfKT4qQs3Os3unrBBG.YvhlZ1QXTKBMykf0dyz_wTBu8k
 B0fx.NWwvfa7nkncH1Ugf2DRnnUiccT3GGgb35JSGh1r8sYEb0rd.tjATzolzmh.Rv5JM7pqSxJn
 A4gHMFpvJ_.IEGuG56iXOmILlhgzE3ws9k.KqLUmsuTU51a1rvKwdB.R8QVj4BJyTH.vfs25A2mR
 2WZG7dLkNRE9PbC2ObCe40aRQYb5k4QUppwGUbFfQbd1U6jjT6FVXL0kZI96rYZiFPnLq_bK.eAs
 CuxC6QXWAknHu40WDy2S9Xi8yyTI6jhTCR.zAfiAPjTjQt.YstSpWbxenfbnupC4KbG8yiceRgDk
 c3OqbtVBHXPTu51SfWJ1sD6s8G0IUwF.OO5fdPQ0DEBjVKYLOAE1.uWGo4Xaij43oRawlYyE1Rxl
 qyRERXog_.9mupRlnOU75Je4.cnMau4BzSXakheC_eg7l.8dc9Toznde_S_vCAKjNxkQD74V2oj6
 Up_FXDFTJ0qG9YJ5ZozgLudL6ktgjQzhQ1King9Vl64qxmViqz9HZRS27p8p8Jf0fVpNhmG6AAoL
 UYkY7gt9OllM.Mm_hAE2voBBJZkfIc59xuSOfOpKU7DxHBuAyFpum_HEPDqzX3sGaalTPONZ.wAe
 wFElPl.FT405mIFCjJ8ufLhq2AQLx7GbaegwFwWlrT5aEHaR8qefoO17c3Wo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:26:16 +0000
Received: by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5dbb2418a414b5cde8b3756aac209510;
          Tue, 07 Apr 2020 00:26:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Mon,  6 Apr 2020 17:01:58 -0700
Message-Id: <20200407000159.43602-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
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
 Documentation/security/lsm.rst       | 28 +++++++++++++
 fs/proc/base.c                       |  1 +
 include/linux/lsm_hooks.h            |  6 +++
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              |  8 +++-
 security/apparmor/procattr.c         | 22 +++++-----
 security/security.c                  | 63 ++++++++++++++++++++++++++++
 security/selinux/hooks.c             |  2 +-
 security/smack/smack_lsm.c           |  2 +-
 9 files changed, 119 insertions(+), 15 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index aadf47c808c0..304260778cab 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -199,3 +199,31 @@ capability-related fields:
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
+The file ``/sys/kernel/security/lsm`` provides a comma
+separated list of the active security modules.
+
+The file ``/proc/pid/attr/display`` contains the name of the security
+module for which the ``/proc/pid/attr/current`` interface will
+apply. This interface can be written to.
+
+The infrastructure does provide an interface for the special
+case where multiple security modules provide a process context.
+This is provided in compound context format.
+
+-  `lsm\0value\0lsm\0value\0`
+
+The `lsm` and `value` fields are nul terminated bytestrings.
+Each field may contain whitespace or non-printable characters.
+The nul bytes are included in the size of a compound context.
+The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
+
+The file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
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
index d3bf71d66724..6643be07e778 100644
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
+			if (rc == -EINVAL)
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
index 75af88abb346..c5f2ff29645b 100644
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

