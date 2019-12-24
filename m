Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC91C2D0C3
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E4F20679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nPjfdppV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfLYADi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:03:38 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33431
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfLYADi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232216; bh=7RSgyAplshfmaFqp3TipkwkFPaDpAiw43FULST0eAX8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nPjfdppV373yWTOMY9vM0qrIxUKO8UZ0poOPQ6rqF3CrClDMz+ZiKizlNz/euAGfHeQ4GHyGZjwydeBAI4iS5k9o1GEejZKzAyPENMtwLUhFKSVfdrrDZ2hxfi/rGyUT2mb4qvQP/HmNI8TdzDbWCcOhsrY16lpusZukd6AfHnmNkjKxIx5Bo+rGZoY4w/3kWfGa6TKG4d817wJTbShMb/0uvgQ6fG0+3FHP1M84GtEsMhZUZsf69kvcSeugIQ4nkcoPt3+O8T8LtYmLU+izUEKy8Z1eGBdBMBeZYAepa8qxd25+5KtlS9LBggZZCRNiVvT+FpotdSRcQunBADcfWg==
X-YMail-OSG: _3UElX4VM1ljk2WN7zPqKdaUU3zARyWmRnK2vQE9tA1PxPScauzM11g1PqLUE0Z
 tgym0Ac43AnJEhkIsYjxrtrmAkbukPZc7P57AR9Kra6pKZDeyjdU8XW63P1h2zDCvrsvlmQTQxMl
 zbLTf8wum.Acjdk2lOWzFxmYf287.vIqOLHrMbAJHdQNc_8EE4P2Wo53Ti6G9jROZZ92sSlK.U97
 YUspUi9n32j.uAu8gD17TyiH9TBVGmRd1V9CpM7hzCm9JmDWaB5zqgcshKqWCdfrMk4VvK2GVUda
 mQPD4hkZ2YynbtV5oU4X_wsuKGp1uIjmUzyQZiFYoFo75va0NkkzRfRVvoeDLQsjh6EKUae_yUpF
 7J4iIs04DO5CztAma_sIGFv7pZYfJyotnKEWKpakijaEw.lmVbyq5GqN9pYlADewn.f9Qvn0aeu2
 MywO.flMKG8XExo2fb4IKBOyHKXXL3y24i9tlQsTlw4j7CUJSWD2R6Je902EndC6Lem1q_G2AZkl
 fWeQYMRRvCqEhrZcNI0mtMMW2Yajn6dvnJFgxRKzphQ8xFQRkKszb7d5H.9G76Od7r_i_fo21VnO
 w4SxzrjtScrOZmfaVlT0T7zydzBy.TZZVN7Kmpcq5PqQb1J6ml1cGxFI9bgpJ9sjtax8LG2Gh2gL
 iTcBljypR2C_BNrb.MRPdQjBIxlgFrNOd410eECo6Rw55lTxAj6xc0tqN1BcXr8MX.mth4uBrJyj
 RiQT8xmKgppc.6zfMaqW9qLihA5Km66YXldlX1vI5i7Kaww8JWOvsLJh_QAL2vaWqAwJo6tuQ7QV
 lJtWI.zSzCc6buPVnjDryPLBHoqHLlyKTTw2LsxII19msEjTn_VzlF3RkBl4DB6BZV.J3SwSdax8
 aGvaHvdghIeSW_hN1uBAySt8V9YCDO753u1vkNb2SVkYAih2f..lx8Mef33TSgynPPF_u_cyT2on
 VzU51wKJII5QX6Ou5AIMWb5unUpoOP.YvhxR4FWD9bwJgb..4DfFwMi1fpGWl6YTRgg8t.GKaG4e
 YcqgZAyQNR.3hIMgCHx383.wGZm_uMkIAYNS442FcL48ik0rdk6SfTw4tNay6eCVl7OUqogODW8X
 7ZESSZ.w2jJ1kWH7bIwJ0nBaVE7DAY6GyC3iJ2lI7NuyxwnxQ9em4ojLRg1qMdqe1x5rHtLb6vhI
 xWyPBozNDLyx9h6EeiYcQfNwEG9Z6Dvm9QXGfJjRCrglAqitVA8hfdQrFIvp_sX1dnEF8tK2Pfk1
 6xWUyz9erg9oPoKz5rSTU7CleGEL36JLDZIUyDY7zSX_qmFqUDSNEpE3dbCgSgF_m25l7Af9FQw7
 DH5Riry45wdSAaO33yvV6NmLQ8k32FX5y8sozb18vJcBl4X7P5JWpfVjAZ2sCLjlzlgkAJxS6e7I
 sVvvee86ozqgwMjOo8i1RB1l8QA_8Csr2fe_gwNvPv0Os_WKJzNQcCrcvk6Lfxo2XRcQo
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:03:36 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2faa463e998922261a55e476f3a40c8f;
          Wed, 25 Dec 2019 00:03:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Tue, 24 Dec 2019 15:59:38 -0800
Message-Id: <20191224235939.7483-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:'
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-api@vger.kernel.org
---
 fs/proc/base.c      |  1 +
 security/security.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 950c200cb9ad..d13c2cf50e4b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 80539dfd0245..e94de64e114c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2099,6 +2099,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2126,6 +2130,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "current", &cp);
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
-- 
2.20.1

