Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2AAC433FE
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CA560F24
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbhIXSYH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:24:07 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:45596
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346329AbhIXSYG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507753; bh=14LKBDohBWZUkiLRgUbqPMHZxXFBtn3D372IN+R9v/8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OQ4D+eVTgfHuJ51jdszFxOyIGVaRcI+AW/5lfW7SCX3EQpGNpUXFCZXSrufShHWhGWLmEPQEzBcoBSSY4RsPEK1yX/cYZYB42RzPxtYGZhpM9YTpysxDy6hSP3ThxrIz9i3xZIJtpb2SMqFGAwgOhswgiMzo8NioPAWzh/K8/XeY4Pfc6lwyp/KiePddzrYRi1/LjlnmSZOVvcU+THeOFf0U0CGy9iTajL73XOfFuVtDW/IPP35p5Y0i8NJmbbbEmM6CQVu/gB9f2wnzHbjjJvh6QwRS23OTloxNDP5hC3wFq0rEMGrK3vCGpDVYfsYevmYzSQ61KFDRYXALmApj9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507753; bh=Vop+xZxyg+eFXNP7KMxWwZ6fUcnrjBB3xFR0knrLHwQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eCzRXW9wc67DrqYeoLtxcSzE9HmnotxJs3yBRo4fauDOzBDHeM5hJUJIWcT5geWFxOhXOo9pGA3FNUzzoNmQ20xHc5nnpVXaRKCGoX9idJjvcX2HUkisKkYkt+iIuv2MRK5r+e8Ch2NfEDaXGAA8E+vw+fIYwUpO86sxiPTOu3B2EMcUxTCwTyOmAbu/NVEu1ZSHxaCi6bnHqJpcuv9a6J/Nc+ihj5749cGz2hvm8SwcWs29clOd3lCkeQu5tYOgEiCrlFk48JFLTqO0PZyuTdZl1VuLO5cYCrLe/KPvomUZZHTKIl4HBwD5/nbQ8+xdZStnJ4K4cATW/Y9zFlkx7w==
X-YMail-OSG: EfOQUxoVM1kczitBNILW0p1hzTMCKge9oG2QSLzW5IgIXukJRGcFzmHnHb_ewln
 P9Q_ZmBEwSh7qOcXVTTyfdJp17hlBzV4KW592wPDOcpHpti_cu95XoVlEzA_SKR6059svu3L6ZBL
 J2XJpxnZq9EAI1xsopp.IOYR.mFCf7rQKj0wDDyzlg_Yw8ueGDt2LiX.KMT0pZwVNJn80gBy2GIG
 3kveUH9EYYjP5ogKi7LBg7ZqL6EkB7fay.bLquiRvIreUgT5wrmI0YAHWxY0sehWhzNaz5pENhSt
 yKCVVGzem1Bc.YWeUK4JDo9MIioZq_mxe5X9BolBetCc19HoIKs8qStEY.eXHr6e0EJJeTxTt21U
 0Lqx.xiOG7eUrt1pipYpOFKxLnmWP8B.7j8dyfBZsA52wbNR.jQUZxfOwi_C9CuPzpOoz3mq_DzH
 2UP5.4_G_vOOzV8sURVjhM.F7ZyB5CaFDehIdbPLAmr0ZZ4iqgCPPUTHPciRHi3H2KBj2wlairqY
 1fNyVc69tZSUz0I5d0Mq3jaw6tYVzxUnNoq.6_qsd06Oq0o5AYwmUu9_wU0ZUMOm1vNAfnAvvNa_
 UxDcjBzvIqpZ0vnjdxsw2ikb5nyrZLM24aKLYDe72_s62MF.qfeKBs2ycjAAU725gz06rxMvZdGr
 ckbwUCwaj4WHnPhamKbFSo4pqqbghhwKj._GxfuN8QkbROR5Ba8e6KV8O9LyuakIeEi_aWs3meDK
 DsBtZqTV36boBNunRSlUxotxd2hT1M5e17nrDTi0IsbPBV.YCnNnwSC._3nFRLUXtU5yh1Ru.VgR
 eA92dV6ntzOUf_z231vah49Fu0ZJPTVj6IvHF4pD3cuL6Wygn2d2Wmhzd_14Yw21qtL4AU_xoyl0
 8ztjUVsdFqUDLVQY16H3a60gHSCKV4jdPghjuh3mnKiLI0MY7nvTYfmrciQx00Hu1rqJDoGELjeW
 1JRma.EPIUW0n3Cu_KigyqKO_4.1ck38GetMbrLVsBvU7eGDuWu9Gi83oybtgTch31TefrihXN.1
 l6vGDkB4Af38wnzWTHfK0uxhnbGkm211gfGZTgzOTFz8zZ8b7fDH4_hgGxPekONmocywlp6s9Tz7
 lSLU86cSHKIYaFJsQ09adakmIqjgSEkQ5u8QpiAu9GQmLKtRwH6PamER7EXqpbNjUM4i99NzGFcu
 reBbzV4nkMLXvigjMY6a1t5YRY3VbTVLQZNvi17J8IsCxL3w6i1kCUlYThcifm3geH7znezlEEHX
 0qeBBwgcZpSnelm9tGHjanXnLaO4BWvVNjDXtGMObgP1MjFIcaZCWRDyKGBCucTYkOE_DKtsqU5L
 qArnb0pYr08h.kctMuuz2IMpOeRddl2QOAEG6c5hEIoxihtMkoqVfnQ24alp_PKkJnQrNH4kWiRt
 oq6DJaup0cmSPoLXiz1ZNd41.kYbHWDpjL5W.V0dZfELqVYDQ1I.gy2no0fa5tvrfv44WzkDENhN
 PSs.sizleFsFaYXwxhERSPw9TJcP5pXPSDgyaUzD4ixGNtIk4vxvzTVjVUf65ElEkTKCISnvBFZV
 vJgqKiTcN0O5YTnw4wpIK1ZGvGJBaSW_XLk7T_SPn6u.slzpq3cfsZmejY5wSJkRjk8oJp1upelD
 3Eyje1RXgOZzN82_ph8khoUKPlcnHwqYaKBCy58gjVmO8DlXi9GB7gKcNnw3AkuVXdmpmYOlOmHQ
 A93lI2QonX1osEoJRt.j1Iaq0O5lT_ixF.GiVDzNBfof1cNLxPrYlph4HRZF.C6yOEHWnUmnjc0B
 zbdC9St5lYnyr9rbLYseA2YTr07NO06UjXIVkSIeaU9deNdzL887eVIEXIfCu4OFe1yYY0dTxqmJ
 KcBNKmyfjwXucgsxEGtPesQeGCKhqi57bNBgdlx3vVa_dUPz1Zq5sPQ4J0lI2pi5sXw6d57YE5Yw
 731eD0HZqFNxNbKzbvYmobWpYP2FVPjQjjaXsPIEGubF.ktCcwYBlV_ZlA6n1YV77nmSaWHJ.5tp
 n.wEKBevm7Phnl27iZZylUgw_Spufwtar8jEG3DExTDGbDERhHEtLgyTqJfbD0jzyfq_aFw5tr24
 M0s1sf_8LUi65zvj3I3WwsrnipoYG7KxEKKGoJXkbxaz7LNep6O1AvYiHKwlk.QXfpdEot7eUHK3
 a6HcPYQcgVglDFWKWIKVzwPwUb2V7_joousSIGFs1kOCJY.dUhEgwNFszXONcbeDtVBbN6qnfnyY
 cqR8lDoQJ1f6rpi70fdOGb.ISoGpORGvlhaLnkqjpBhJVjiv.KGyp7PZzsotE2Rm.ZvFUNWlHxSK
 THtRNDdmXm8Q7Pjx9Z89C9i3NJrVJBvfW
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:22:33 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID daf64c32c75f0a5032edf5ebe6eb21f7;
          Fri, 24 Sep 2021 18:22:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 25/28] Audit: Add record for multiple task security contexts
Date:   Fri, 24 Sep 2021 10:54:38 -0700
Message-Id: <20210924175441.7943-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1420) record is:

    type=UNKNOWN[1420]
    msg=audit(1600880931.832:113)
    subj_apparmor="=unconfined"
    subj_smack="_"

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
A AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h   |  9 ++++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 64 ++++++++++++++++++++++++++++++++------
 3 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7096a60fbbfe..cd67d801e94c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -230,6 +230,15 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 extern int lsm_name_to_slot(char *name);
 extern const char *lsm_slot_to_name(int slot);
 
+static inline bool lsm_multiple_contexts(void)
+{
+#ifdef CONFIG_SECURITY
+	return lsm_slot_to_name(1) != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
  * @blob: Pointer to the data
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index daa481729e9b..6a0ac60688b1 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -139,6 +139,7 @@
 #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
+#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 0d4aa6667125..707689605791 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -197,6 +197,9 @@ static struct audit_ctl_mutex {
 struct audit_context_entry {
 	struct list_head	list;
 	int			type;	/* Audit record type */
+	union {
+		struct lsmblob	mac_task_context;
+	};
 };
 
 /* The audit_buffer is used when formatting an audit record.  The caller
@@ -2139,6 +2142,21 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
+static int audit_add_aux_task(struct audit_buffer *ab, struct lsmblob *blob)
+{
+	struct audit_context_entry *ace;
+
+	ace = kzalloc(sizeof(*ace), GFP_KERNEL);
+	if (!ace)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ace->list);
+	ace->type = AUDIT_MAC_TASK_CONTEXTS;
+	ace->mac_task_context = *blob;
+	list_add(&ace->list, &ab->aux_records);
+	return 0;
+}
+
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	int error;
@@ -2149,16 +2167,22 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
-	if (error) {
-		if (error != -EINVAL)
-			goto error_path;
+	if (!lsm_multiple_contexts()) {
+		error = security_secid_to_secctx(&blob, &context,
+						 LSMBLOB_FIRST);
+		if (error) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", context.context);
+		security_release_secctx(&context);
 		return 0;
 	}
-
-	audit_log_format(ab, " subj=%s", context.context);
-	security_release_secctx(&context);
-	return 0;
+	audit_log_format(ab, " subj=?");
+	error = audit_add_aux_task(ab, &blob);
+	if (!error)
+		return 0;
 
 error_path:
 	audit_panic("error in audit_log_task_context");
@@ -2419,9 +2443,12 @@ void audit_log_end(struct audit_buffer *ab)
 	struct audit_context_entry *entry;
 	struct audit_context mcontext;
 	struct audit_context *mctx;
+	struct lsmcontext lcontext;
 	struct audit_buffer *mab;
 	struct list_head *l;
 	struct list_head *n;
+	int rc;
+	int i;
 
 	if (!ab)
 		return;
@@ -2448,7 +2475,26 @@ void audit_log_end(struct audit_buffer *ab)
 			continue;
 		}
 		switch (entry->type) {
-		/* Don't know of any quite yet. */
+		case AUDIT_MAC_TASK_CONTEXTS:
+			for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+				if (entry->mac_task_context.secid[i] == 0)
+					continue;
+				rc = security_secid_to_secctx(
+						&entry->mac_task_context,
+						&lcontext, i);
+				if (rc) {
+					if (rc != -EINVAL)
+						audit_panic("error in audit_log_end");
+					audit_log_format(mab, "subj_%s=?",
+							 lsm_slot_to_name(0));
+				} else {
+					audit_log_format(mab, "subj_%s=%s",
+							 lsm_slot_to_name(0),
+							 lcontext.context);
+					security_release_secctx(&lcontext);
+				}
+			}
+			break;
 		default:
 			audit_panic("Unknown type in audit_log_end");
 			break;
-- 
2.31.1

