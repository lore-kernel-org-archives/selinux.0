Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0155EC2D0D0
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7AA206CB
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mZthcrWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLXXXR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:23:17 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:41135
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbfLXXXR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229795; bh=GxEWr5HgHGsSBsXd9YqS3jNBdjUlWzqzucoAC9IGxLI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mZthcrWetLKa06EFwKR15wDmzqE/pqJ1vGkjkJzklB5SwVtJMFK7YklHi72DnWRaFrByl5n0NnvUBvANjAzKwPQ93SCUtFNbSzldjBF1U14fzwUTJsseNlKZ/VD7NBG7sGWW8me+nFjt/AA6wQc6AQWR0LRRBjNGpkwYSDJs6VVUd775Aa7DSNAlHuall80wZMg9JfLbWOIS4ocOPpWQkI/b/2kwOcDoKrYViUHquIPr/SqK5kYY7TVQ1yYNc9DW4G1UVBcPBs41s9sbIoGj4Beyd4j+36SPS5MCAwTWqs3Vi9RVN25GCAOwYqtSmDj1utB66rUREZmckgc8LFVg0A==
X-YMail-OSG: dVs.gtAVM1nbFCbGBm6uq94pUzIF7dRGlBZ9dmNfFzpkp39IdBg1XDbkHZxFna_
 2VdQuyDYybqh4SX8IvqBP6TGB8eCaactH_ANwEq8C7.qH8MfuFQzbfELGx.jc0ASYP.SZb92i4uP
 ntryzfKc16yqByfaFAHEirsC4jiBGn4IeLrQ22KpqI5JYG4mgIDsAETaS1tlkC2HKBgsQ.dUQ.Kd
 dlVDIk1xevo8pArZTSE6QHweZLRCbFKtc37VOT_eV1oC1yPqTmJSuJxmNSL9xHYaNtqrQKxrAFfl
 vQ.FGntgvhSuoS9SmEZ92gEub3yz7XSVdv4OaXXMeOsudVsNJlgJlpA2Mm8cfY1syjxyYjHMo.jD
 rlM6S_JayZyn4P3PWQ5gFk.MNLCG69zlNzEhbqhIIhJcEQmWqmuhdwAG.oQQBZRt9ykvkQzIog6A
 g8sEVdpfrIZDH6NMIAoBCILtq5aRZydi4Cmqkfs5irWlpNGheIvHa1rPvopz3RJPtOQ3vCRZhWgo
 pQiaC2hIrQxCK5f0U3vfhkdC6RLYOGWLNDDrOxz7ACoOTJrjplxYRA1s7UAjjiy0FZsBs7U94iXc
 Lb8d74ZMudIX6HX5kYCzrVEb3W3ft5Q7Oj7IYxxC5FEToTnbxIHaUvZ1.qavMKCA3T_h7wIu8aJx
 gzyAzChrhdK6t..ScItUdyNUlI2wMgShAzz3kLmG_Xd7bIMl.l29mrhDVuhRCqwtrTr81Xb_lvPd
 dxUQakL.0qOr8D16jUNqHIaSyRJAJUV_7pNvG98IDpmpXo.42M_ApjzYSUs6ne_cOWKzH.HJPSah
 zwZdv4al1d1nuf1uDZn.cVOpHhrUUKxwlu01UrI4oCfFiV08_2d599MaW4nBEVdW9LBtUMz.W__D
 BHKQPcoXPoHKknHELpSfDxjjOyZSTLsfpdJbmbE.rD8sY.MKrN.Q2nVKv5hVyrLXjJlAf88dc7qS
 .fOg8EDbMf2PUTYqIroxNudZSEh1RFK7.aygOrb.b0M3pIwX25i2j7qT7Ghn7oGU.XktV_Y8ge3F
 KzY9MutkhQehaQll6smvUXhMG7juk4wyylyFUSHH.lLRoyi5_QUbbjN8hCp0LI8fFuW1r6p0jOX2
 25xE8lVmTzIiFIlHhtAprjHOmj.oUcSlU671B_6MGRCs67_HlzzTvd3SuqLu6T.rSys4Kgg61dbW
 L7XAQfzZ1fq06WFMzu5uo.4kYmqqjKE8K90894NE5v3V8Lsx1RRIYjQs6jQKf4gyJP9Jwyyskg1z
 hj9vWAJvSbZ41dY6L16W1lUGlh.Fp_rvsOoOEEuT5_QswL26Mdi8oxA5LTlAsAKvJJCH_MzwQLxM
 uT4xg2fjg1iWBBqxKGpxCY_IxrJbSCjuGiM0y7s78nBOpbD9EuA1TFOH0JQOT8S3nfWMyJaZhWcm
 Y4rCaH1vV2sUuqzpHXTvnxh6oQY9tFJs0AVWqA5JqYM962tLIpPCpdxyKO1CETER2sgA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:23:15 +0000
Received: by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9bc54365a424de579ba55ddb8289553e;
          Tue, 24 Dec 2019 23:23:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Tue, 24 Dec 2019 15:19:14 -0800
Message-Id: <20191224231915.7208-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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
index 1afe245f3246..e55789fc4cd3 100644
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

