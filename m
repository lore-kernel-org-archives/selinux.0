Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C52CA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C621929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W/FELaYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJXUyS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:18 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:33584
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbfJXUyS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950457; bh=Gen3PaL3pkmOVCQPARAPGQb5PsYssjp5YDawFrxyC/4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=W/FELaYqcQ1akFc4b6K9t7DVcHNqPlpL8p9john3VsQuklv55sSAAaKpai1xE7gPiGFkwosJK9zEapv5draNjezExIzjsbDef5UafzvL12dOgQnimEQZCJTgzMjRz+/9YJJMuup0uFcovbLNiWWFPkqR7nqWe8j5s5Hl0AKtgrU4j1gl8rdWPDP2b/WTRbkMrJiWQlFQiSyOovCyOHGgjcUqD6EkdK9Zd7eniqnEZiwV6GTICaa3U/C3JbX8sIh/aAzGzuEkN8tnoxS+p5tEeU8k+KnwPNKPKQ3NEpT0L+Ql33HwsFLPnnAQrQ7WrX3pc2lssPV8puSBqb5wcE3ahQ==
X-YMail-OSG: yVkMUbYVM1nudrN1m8cn79PUMIfO4E.mdvx1HcDFkeKttjww2oPGiR9MHvGOGnu
 gbkyLkIorLqyisMQBY09dzi8zDnhN9aFMGLlfk3fPojIQDejAENsMOYJRCq8.42jCctSealg9e2e
 9KkatOHonPOcfr4i6BEkIiU.3dJKUWjzdYMGqc9Ao4eifrbbMuE04iW6dbROURAQiH6Qizdo6bb1
 NGeDRWeO_Umhfl21Ysus546_ZmRbL3bH5g9YI40mBpNg2ZmUJfP3eWi71AfQj0DG9JZa6y1TksJ_
 dxJpj2MqZnjVtYhBIGWGcpX.g.7n_cfF1vQRRKRYzY.W.z0DckznjnhDegg81V9TG1Ekb3LmU2L3
 mTUb1cUkoSxI2hv4e2Rt05RAhbB6fg7nObrxwDXG2GLQwfgbwrlbX9R8hmbnItYsIVZy6yWgq2PE
 O5Pt8fnqw3sflZgetNGogmFkZzii6Q2glLuGCXZR5EoQmVj4ouj.r9yJZX5diiTpjGCAjPNmgt_J
 FgMCM2Dyv3oeU_qZUUQgJ9JGBnUy6XFHDvkfpb2UTaLPeV4FJEtbcY18rbSC6aVilzNo4kZ4hlDB
 5tLMKucR7AJn_a5_cj9wyD.Ds5qw_PSZvMKc6JdfVoZJI5l5X7xvAQs6Xj_uiwuXnlJHNzGCeMw.
 _Yx5EYZvKbhfZXrPCPJuKDIOUCGU6Z0MGcJuRzevd.PDB8h8YayRGujNjK1fo.Xl1FVpIYtJM8MG
 hdOpdktYfSbfy8nXLlwh1Hr1foj_LAcOcZlgdN_3igJsDN9qHbG0mbsG5TmM8pz8a.8TKZqsTTV6
 cEuCyHqP6y_w33AZXkd4NRHETdav.l5NpTdsKov8UQIQtWnDi4PYAr3uBpPylxyeOC6Qdul3N5xq
 cOM3kYZ2uyRv9KKy4qA9Tz7NQqtuFHaj8BeyOCfn5ei0zwB7iqxncACrjiaq3b.uftdJBYbssPqc
 fZVAFeN9y0P2QKmVDcqB77DweMu_IDQ_GaCqi0AWOcvQpFAL38J3M8veeE9ZhLlUFLLlog0ksVY8
 s8aThWQgoLBhp2awgdaSjKWs.v9SyEmDoKLZAWZCiKV8DoSTsInSuuek8.9PY1A5pz4DCOGSDO4q
 kBSfe69ozSDYpI8t_oIZkcCnne.mhiqNlMfX9TWWW4p5a1VBka1UDPEnzuttOH2.dmWaV00gyj4f
 VaOst8NS4xZEVRUOSHRe38Xzz6k5tSaJb399C2mDPJUi3IKMxu2hy1_4OCOE6Fv1G6PhWBSG0HCc
 wP2wr4AF9vYr7nrgJKkoc8WqZ6xKmKQBegGp21RGcdriwvOgcyg.VwrWWyGv6SRHKvFBGW2iUJCp
 BPEo2gHpcfvz1mX.Z6lAsI8ei.mqGfJH4AN9UoyJQAITAQ7TotuyZzpAjpWYEF7DA_gsy3Fcon2z
 WvaG_7__Pa4zPbw_e3Gj2zmMG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2019 20:54:17 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 656d248acb5116d5cebde187ab2fdbab;
          Thu, 24 Oct 2019 20:54:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Thu, 24 Oct 2019 13:52:27 -0700
Message-Id: <20191024205228.6922-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
---
 fs/proc/base.c      |  1 +
 security/security.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7bf70e041315..79600df5f7a2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2619,6 +2619,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 91626536343d..c925b8ee057f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2050,6 +2050,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2067,6 +2071,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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

