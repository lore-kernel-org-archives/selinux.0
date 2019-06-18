Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F6C31E60
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8E020863
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lgluqUrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfFRXGr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:47 -0400
Received: from sonic311-31.consmr.mail.gq1.yahoo.com ([98.137.65.212]:36524
        "EHLO sonic311-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730955AbfFRXGq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899205; bh=EjKWXEY6xPqpaUbwquVNtzOnsRWGJ8vsihlnY6OPrA8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lgluqUrUPGJolIo7hW4m/MECDnDEyt0KguCxmHbS2WWl7OowL3hAjloJ0y/9ylnlW3LZh7cPvfnhaVOYcCnVP2Fcm67PJ4I0Y/aOR0dDHabd/PzZX3AiNxvzYVlbE3ITNDpJxuRIlNu/ymS4HNmwrD+1AVb5r5ek6hUuoJsE38AcSEo0+gUV/gLfZCoQXPWF2/pvPwCNrxxL+5YAVOtDIdgJeE3Gr3O3+PCNAFMjIA5RgM2CmixtQsaygx4plgb6m/21y2SshqL2tOqv7Gf/ivN+Qm+uAA4458K4je+ZduHkfUPLrt2pHmzeu1JZrsRwTGgZK8rjeP3zCNNkXn+YaA==
X-YMail-OSG: deim0ucVM1nP0PuauulbdwMtVnqXZ4Kaw1ni_ziLrcZe18ZPrTpfDZus.qwA1R7
 u3VSlaPcofe0o9YfDi.P0xgXzIICkAp6VwrDLOJoLBPdgb8IloRtXiwr0Izvp_2JSihmUnFeFKMs
 akZX.GvAx5OhW9zQZgW5kAK7kAnDDCXK05WdmLSN0r9oMoNIeXkOUX7S4c0MjNNVEqF83GMEWJJJ
 U.HfeqqfaXZ3MJFco9O3lNG1Rq.DUxmX7bZLElq80qB20c7sLxLd6GzSlDrMt7bzCSUy1IR_ra8y
 Pn0dDw_zGtlFAKjbU2sl8n5D03i3728jw2DYpcQF2IUsja4YTY0EJ6S6ChZM7Uylynml0XDKdt0H
 KAWeLSmNsYLbkUVWl8WvNKUjZR0XQ_Ff6e_L0ET2.98dyvOf7_hZUewPk6cdqqzYC1I5Q4GNXon3
 Sx3fY.EaS.w.PuyeksZip0kUxGqriRrrXDp___dpakKlfov1ptv0H8tj4GGP7KqrWy3ad0pjIDg1
 5JyLyerY0n1h3s9aH0Dt8rL02bWIK76Zqixwm8IjN5aOXXPIL4yCqj9_Zd1oefTw7BHqOtSWJX4w
 e4dvRSFCO7zgQZx3TfKl.Ds1qwt2P3Cjv2dDVe4o9yham28ycjltuw5PcxWlGYfnbY7bTCMawd0V
 k6Yoy_0Aa75eFiOd3HoLiKDbVd3RmFdmpsoNuL65PAcvSHlL1FMhQxZ_J9RHPNIC5vquTtrqa44q
 RtWaF5vbE8G4AyFz1mkyBCqmxn9gqXOXNjLYYma7wkqk6QOX4.eAI5s37fDyDbpBnkHRsPbVN8wQ
 kIbgfmyHId8W7LXyDIk5IsTGj4i_p0Y7_KLSVkWHzhPsUrNPwXXu6HiFUBPAlRMyK0Asj4Aat5Fa
 u99.BUydWETUXyb80bhbIdRZbAUhHehX_CtXcYliD4loDd4NKij2xRcGi6gO8vvrIRfI6YNDkw02
 6nWvjCXLGaDGAVA3MNB5LVi0RGMadeDNSPr6TNoaHVBQrTWXFZYrgtLeQbo5lLV0dm_cdvoUiRav
 s2.F3aIghcp.6D0o4dsuzC0dOpvY6UpDju3T8rYLgvybXotDGHvCqVnLu2JgYvDuakWxUuq2lSW5
 CEIKCfS2yq0rve9QF._x.eoranRrQTMF2hwFMyGALVUw7A0WkakGVquMjdhWumXuFfcLEKxixVyM
 mcBtH9yilGjy84XGwHkNX_kDWoiZUkkBlsEbSaQ3IGGRN_1q7WtubXw5xq_PiGsPRvJeD4yNgoJm
 DvsBJT7pmMBXvdOn_OQl2xb0LSQ1YysVkWSYg2VQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:45 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b5c484e6312471c03acab1f233ace257;
          Tue, 18 Jun 2019 23:06:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 15/25] LSM: Specify which LSM to display
Date:   Tue, 18 Jun 2019 16:05:41 -0700
Message-Id: <20190618230551.7475-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new entry "display" in /proc/.../attr for controlling
which LSM security information is displayed for a process.
The name of an active LSM that supplies hooks for human readable
data may be written to "display" to set the value. The name of
the LSM currently in use can be read from "display".
At this point there can only be one LSM capable of display
active.

This affects /proc/.../attr/current and SO_PEERSEC.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c      |   1 +
 security/security.c | 108 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..7bf70e041315 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "display",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 46f6cf21d33c..9cfdc664239e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(int),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -578,6 +580,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *display;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -586,6 +590,10 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	display = task->security;
+	*display = LSMDATA_INVALID;
+
 	return 0;
 }
 
@@ -1574,14 +1582,27 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int *odisplay = current->security;
+	int *ndisplay;
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
+
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
 		security_task_free(task);
-	return rc;
+		return rc;
+	}
+
+	ndisplay = task->security;
+	if (ndisplay == NULL)
+		return 0;
+
+	if (odisplay != NULL)
+		*ndisplay = *odisplay;
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -1967,10 +1988,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int *display = current->security;
+
+	if (!strcmp(name, "display")) {
+		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
+				     list) {
+			if (*display == LSMDATA_INVALID ||
+			    hp->slot == *display) {
+				*value = kstrdup(hp->lsm, GFP_KERNEL);
+				if (*value)
+					return strlen(hp->lsm);
+				return -ENOMEM;
+			}
+		}
+		return -EINVAL;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
+		if (lsm == NULL && *display != LSMDATA_INVALID &&
+		    *display != hp->slot)
+			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return -EINVAL;
@@ -1980,10 +2019,27 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	int *display = current->security;
+	int len;
+
+	if (!strcmp(name, "display")) {
+		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
+				     list) {
+			len = strlen(hp->lsm);
+			if (size >= len && !strncmp(value, hp->lsm, len)) {
+				*display = hp->slot;
+				return size;
+			}
+		}
+		return -EINVAL;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
+		if (lsm == NULL && *display != LSMDATA_INVALID &&
+		    *display != hp->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return -EINVAL;
@@ -2002,38 +2058,41 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen)
 {
+	int *display = current->security;
 	struct security_hook_list *hp;
-	int rc;
 
-	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
-		rc = hp->hook.secid_to_secctx(l->secid[hp->slot],
-					      secdata, seclen);
-		if (rc != 0)
-			return rc;
-	}
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)
+		if (*display == LSMDATA_INVALID || *display == hp->slot)
+			return hp->hook.secid_to_secctx(l->secid[hp->slot],
+							secdata, seclen);
 	return 0;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, struct lsmblob *l)
 {
+	int *display = current->security;
 	struct security_hook_list *hp;
-	int rc;
 
 	lsmblob_init(l, 0);
-	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &l->secid[hp->slot]);
-		if (rc != 0)
-			return rc;
-	}
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)
+		if (*display == LSMDATA_INVALID || *display == hp->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+							&l->secid[hp->slot]);
 	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	int *display = current->security;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (*display == LSMDATA_INVALID || *display == hp->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2158,8 +2217,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	int *display = current->security;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (*display == LSMDATA_INVALID || *display == hp->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-- 
2.20.1

