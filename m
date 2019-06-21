Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C4C48BE5
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862FF208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZS70m45I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFUSxV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:21 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:38336
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbfFUSxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143200; bh=eD4uz2pMB3leJNdsxJNOeAjq9L2JGxXhjFZebg5tyqU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZS70m45IqTwXeFqQ5Ro/6bRDcrPDXgF7uBCte+C/naOPGiHr2/fvwbLGrKObH+w0GEKWbLFAv1E1ymIK06mHMnwUryDr3a7NbQFsqSNfrSNmE3XJzYlgJZNo63yItuBn5pnxzv12ecnSVO5WaxksODVBmbBY/mpfCoFOTxecZwLCsb0FPMjb5DBa9Hpcvfmorh5lwHhBcO2HEJ1VATEL51GYQLWcoch4am2PFyPluUSzAKlKfI6TTP0MxsVKRgDfnfkJzOFAYrqCeaBbBCvQL2Hd7+nFVEs9oC/uyvWpMrW8eF13HPjnlahQUs+qV+6E0U+yaSHz4FbILR6bZ4LFyg==
X-YMail-OSG: 4liDZ_cVM1kjRgpKiOniKFkDSNhtXgo2HcmGUsqOzCCNcqyYIXcTc41KezvzEas
 yKydWg9RVgnrziadzIaCuM.APklw1RLnq_EBNyiY31Eu5aRXxxJD6sHohIqw9OkQhsJTVWSaAuMc
 ifo2cH7bc_CeMoKXEUwhQAAAmxwTvDmvahKED36PvxziaU2FoGe4CcWhBrycS8Qk.WYaFPQXXIif
 98urPcMeOrDRfd3ZntCOs3IX6E1zjpadh3PEIw_MwIKtVTcAmRgpa_qo431fjFVo8ZBldkshMgLJ
 6TEi1MD7QcYy7BLu_XJ8Z92lsw8cIWxoczPvUTZ45Fr0Z9dSuL.pudU_QCeVpsnV5s0tPhkiYufc
 tce2Irt9G3dche1HI42.emOjavVhKd__zbNWyIERFU1MYHxlGqJ5GBay.vKjDAv_hEywPPgV9Nmm
 JcavuCqC41R93OaYCbJSd5GE7kgFYNzUfs304xk8Qpqx.P7YhfDLUBfWeiRvQHm.SwlmysZXu.RX
 62Zyv7xptq3aYBaUaQvJdt2my7q0LY9VB_CJCShiymAic.qIq1XFp1rRIN31cqhqpBw9zHMHoeEU
 poAQj_jTPWfc_gy_4Gi8M08hiqaXmigwYu0abLxrWb.Npaxpw6eAxnKB3DboqilmQE0urUIOPOvZ
 moiX2YAM87gD9OEdBPFSfQcRfqGKbtF05Bs8QJRCk9bIsNXGEoZrcHdOM3MiRGcrOJLMUDcxQKn3
 PyetDzPj_2g36iIZJDZf9eGT6jamGYN_a88vVyTvpZojfFnzBXRrEpKirakNVQQ6CfkH8kWPIYRK
 VkLue4wVBf0sSXJ8tnpwr82cp6Dyqvm4jNOmKsObxtXxxdKQSZ3Yy9xy1oM78MAR76QMueckFBsD
 e2u.lrOvOhUSb3klpZmb7cA7Cvl8f2AxmFLR4afw0bDOxH8rn32S0vqzWSSWpmYTbts5r_7UZvJx
 0eJv5aNCFIVeQrGPt5JmUpabFrjEicXRXKpSEVkiOD.LsMlKL3H7H37oHgMKGwb15hwoXK.5f23y
 tHy7CazgI8sQ3tX8XRtnRgzYKyuw85r7JNuMgcLvTbKrcxze15p6gjMXHMJsqz3tIZHbTtGsa7H.
 D7jXtnE_YbRH1Zx0_NFPVQna3QOB9toJUmET3EgbWr2RnoEHWjTI1UCVJC9cc8c.kswBkMS..Xl6
 30c9GYzWVQmR1CLLNJYkNhafBDW2B2yK2pZQwymoD1_eQTVdLtDydV.mUDMuGpWuJvMGG0fzetCt
 IjltdYP_XCvXDtiF9QeInbfwtLehHVA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:20 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1ed0fb368539bdd05266211e81f02718;
          Fri, 21 Jun 2019 18:53:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 15/24] LSM: Specify which LSM to display
Date:   Fri, 21 Jun 2019 11:52:24 -0700
Message-Id: <20190621185233.6766-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c      |   1 +
 security/security.c | 110 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 90 insertions(+), 21 deletions(-)

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
index aa8e1c73a062..92c5aa427b53 100644
--- a/security/security.c
+++ b/security/security.c
@@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(int),	/* slot number for the "display" LSM */
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -583,6 +585,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *display;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -591,6 +595,15 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	/*
+	 * The start of the task blob contains the "display" LSM slot number.
+	 * Start with it set to the invalid slot number, indicating that the
+	 * default first registered LSM be displayed.
+	 */
+	display = task->security;
+	*display = LSMBLOB_INVALID;
+
 	return 0;
 }
 
@@ -1579,14 +1592,24 @@ int security_file_open(struct file *file)
 
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
+	if (ndisplay && odisplay)
+		*ndisplay = *odisplay;
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -1972,10 +1995,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int *display = current->security;
+
+	if (!strcmp(name, "display")) {
+		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
+				     list) {
+			if (*display == LSMBLOB_INVALID ||
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
+		if (lsm == NULL && *display != LSMBLOB_INVALID &&
+		    *display != hp->slot)
+			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return -EINVAL;
@@ -1985,10 +2026,27 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
+		if (lsm == NULL && *display != LSMBLOB_INVALID &&
+		    *display != hp->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return -EINVAL;
@@ -2008,14 +2066,12 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int *display = current->security;
 
-	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->slot],
-					      secdata, seclen);
-		if (rc != 0)
-			return rc;
-	}
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)
+		if (*display == LSMBLOB_INVALID || *display == hp->slot)
+			return hp->hook.secid_to_secctx(blob->secid[hp->slot],
+							secdata, seclen);
 	return 0;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
@@ -2024,22 +2080,27 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int *display = current->security;
 
 	lsmblob_init(blob, 0);
-	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->slot]);
-		if (rc != 0)
-			return rc;
-	}
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)
+		if (*display == LSMBLOB_INVALID || *display == hp->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+							&blob->secid[hp->slot]);
 	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int *display = current->security;
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (*display == LSMBLOB_INVALID || *display == hp->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2164,8 +2225,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
+		if (*display == LSMBLOB_INVALID || *display == hp->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-- 
2.20.1

