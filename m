Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E90C76194
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D94F21994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ElkwmSrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfGZXkI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:40:08 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:39354
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbfGZXkI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184407; bh=BeY7BgtWnOJn41+QTNs0eXBuK9XF9TMjX+Ri/EZoeUk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ElkwmSrbWlNKSqy1jF0FiuHZcToCqurD2CRVyo7qVhkvS6FeGG6NDGeeVZJ1b14UNdA6boR28PGdE8huBDqvkQJaMxGP0ZY+EC9FxOcgG9WaXZQaaSq2dgRTavDqJFMCdrhKJF2Xy1E3oAA4S3sGF8lNs1ybJO+v9gwu6NelejdU2cpyBDLqLQnAV2lp+bw9g6hB7ls9MkT6v5ZQlMTV9/DvBvDHD+cw0W2AKh5Hqs1YhK+S5wX1wJYQcuIptWtmnNvjqLwzs85eKLV9XXwDmjWrlFsuLuS0zmTyJjt4Zwgr5jJIEFhbj+lZl1+iUJOCoJFHR8w64+cPOybzvxplrQ==
X-YMail-OSG: IMeZKuAVM1lwTPSsoVg2FmNh7IejJr3.Py6vnRtHlyoxyLWKnqm.5YuNli1Ia9w
 GnMerjWOQ5NTiFDHprgkSFoeExX1omFWSlIBPHUY5FfFrZyvmJZg7jKg9ucch7BNWNvo_en24rOC
 .cd5U4aj6lopGRxUv6T2weL4spIRqvc3nPbJ40oTysbqOSQWaeGFxIGgCKtR1VJDnCiI8wqi3kWt
 nNOUTYXfXJQYxrkGaMhw5xok_lBDaFq9j2yHW4PNvBLyn6S8ThazCENQqnQ6m_rzwJSruCnQcemn
 9DhXdPFoJweC_o8QgrcwFbevLkvYP1rIq7WIbjIsC9tVH_GmY7vTha3ERQdHzUdoENSrquiu4qi0
 KATo1K9Usf19nd3C7havmZzeOqZSxGHTTpcsMviNMfqh7JXemzQHFS8Kno8Rko35uuOBcFkMBxi7
 zfK0OMoqD3HnYvbtqbABng0Wl5q32Qe3DKLOGNCapXHygBS4DNbZmGIDHNQlfKoQFjmgwR0RtdL6
 RpU9bRNZx8YiXG_nbdhUMWqP0z3skFtqYwqNcyrTt8pBpknY6Yov4.LOqfmlASP2mhyg.GqrHe2m
 X30z.XXUe5pyYaoS1YgU5rKZiMCuZYu6YR543djbngGyxEBmiod5UKec666ON0ODL95NS9nJxhFW
 McvKDkWIujECDovrwUp6iIuJLTsnYnVD1CwRQ4i8Hhqo81QEK9PWN0k4FFILvYWjtLOAcDUVsf94
 neAxKqzGTNM5rL4.qoMG_wR2sZAzrrh.ey.L45t4ngbUij2bgHTQLXDxbsi5R7k.5.MW439y6MGa
 IS3Yo43wi5ijRo3mZ2ZUkbbACQo5C5hxrIgMXMr00I.MDulAkBBc8RD4y9v.8wrR0eEqjDQjRxoJ
 PRXEmW_wILUgMZdM5w6BgTZ4QJntnQMAB9thYmU5vhR0cHqj75xFSQ5D9w1JNS1m.MT1BUxGJrH1
 ie3RixWnwf_dkbnqfKfJ.mYzut3saB9uaEz5GqClyKK3nAJaYpYJI5sx3lS2BBZ2EaBBIoPKzsY9
 hUEVvrYGP94BP5.yf721EMMEzxiuQV2jJuYqOT0SMZnNb6lIdMHp8BODNBlasmEf67D9OV1Ss_35
 HMISYntPr3Qm.9gR2YCpG4YH5VdhF4Iyfhzk4Lxfz9vtiszFFHEQBiGt47mbBTui1R7b26jsJVSa
 YhhNZloumNo0FijW_IxLdNoRbaGZRCSYlro4.wr.auQ6RAEL_L2G.bnSUsmep9gFp3Hi3Qj.iGHn
 T2A_9Q2mvwiFJ813ZVHKtuXCHXuSndTVWj7Za4n7ChuGRlZtl_5oduA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:40:07 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 02b21d14c7b696f5715c06f7c0a494d4;
          Fri, 26 Jul 2019 23:40:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 26/27] LSM: Add /proc attr entry for full LSM context
Date:   Fri, 26 Jul 2019 16:39:22 -0700
Message-Id: <20190726233923.2570-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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
 security/security.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

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
index 5551c146c035..6a89a6b90cce 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2057,6 +2057,14 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	char *tp;
+	int rc = 0;
+	int finallen = 0;
+	int llen;
+	int clen;
+	int tlen;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2074,6 +2082,43 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
+			llen = strlen(hp->lsmid->lsm) + 1;
+			clen = strlen(cp) + 1;
+			tlen = llen + clen;
+			if (final)
+				tlen += finallen;
+			tp = kzalloc(tlen, GFP_KERNEL);
+			if (tp == NULL) {
+				kfree(cp);
+				kfree(final);
+				return -ENOMEM;
+			}
+			if (final)
+				memcpy(tp, final, finallen);
+			memcpy(tp + finallen, hp->lsmid->lsm, llen);
+			memcpy(tp + finallen + llen, cp, clen);
+			kfree(cp);
+			if (final)
+				kfree(final);
+			final = tp;
+			finallen = tlen;
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

