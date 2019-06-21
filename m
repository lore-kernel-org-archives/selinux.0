Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD0AC43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141072075E
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WyI+VMiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFUSxI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:08 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:34710
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbfFUSxI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143187; bh=yCC/VzUj6gjmQev+Yws3dylDQvcIzi1gLYUF2+WQlAU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WyI+VMiWi3ddXfUESfDTWIK23/pqYoFtUygpQ4Oz6CuTcYGSYM8d8McXO4/SlTUDNO5UfzWcm551Oo0CkKM4ehtOa9Zjx6gVi1YC7L/0zC5F2FqezJ32e8j0nKZzE0nBkkXajwODYafsZvpLd2J03LaZofNyxGQYK4uv/Od26+NCX6IXw8+rhlpd6zr1fsCdx5/LUOd+M6FpLRABapWY2SUdgXOK8vIEDt8+Q/i1cmPkGqd/qf9DxPwMXwNzQQgNHjoreQNyQUUX2JYOYd/7uHpqgjSJ1UMIeeJKoA+Qdqi8iAbcymtnWAcPgQxsI+8Yl34EPLfsPsYDOxXCUjLcxw==
X-YMail-OSG: A2Q87MsVM1laArPZEaUrWKCBEmZY2zuBXfAx03bla7y1MaHxriOsfx5UqqDEpNr
 jusUUPvgS2WAhhuPwrJH8h8PHXazk3MSy2RLVSkMAbc5J6OdvCQlMrsHdv_srpMkTaGv6R5eJjhE
 pRVdL0f9r1Ec4_bO7olmJo.rmxwK8NCRN_zqq6FgpqvIL6b4xwHrqPAJg2qkgbqgAa75Uw.vrWSV
 EqmiG5jaF9WY2DW_3Odab5bnGDfO_c5UoPTRcY7_Zd6Rj1yqQ.9AXGPu99F9GLIeV8ARXp4a__WV
 qMHaY2Y3X3ljmZ7asvXcKJQvpRjqobSmRsDj0Xuf1gNbOjTHMuKqkwfhA.1WBBJheuHs1fy94CXe
 hRe5bFFlh1DJzKkArwqGyfqdsQzNOMfnS6DoQbTJMQCOWNXg0jAtvjACuIfdZIk.dGVFBxNlSKmP
 CUTvf4Uhl8G0iC9X0w4U4qsKugkg0CmafaiVKSyhdR2NEsO7KOK2xs7MijfjfcHoxkH6LC.IHmh2
 DnlnBGiLEFJUKbpmBRg8IrjXScLxj_snLRHRs49vEzebxSZxdyJrJOkTKRTYVH5V1cyMd1KFFhTQ
 sU0cnUXrbLVJqv.g__vErrge1Dh6UTckiuHFrzB6JUsq0Xln7f5Ibze_vyEENwYsw0eBAuEQz7vr
 zfr3Mm.iv_1gTdHimYe4RzkMVN.Mwd.ctVxYs2RCTeMFLsdBsQkm6gmiP4m06D2tqRguKGyDsLTS
 yYIJP_7dqS2uGwPQSOFer6R1n9sboMtV8Xm9dHXQ_0UZ9QiZLLY6dI.sMUUEVvDYCkdWgGSa36pB
 CRVOO6eO0JV4zd4.XyAhvlSlqJzZe5FgJS.Wj7XceBThrvp2ZKzIo1QNZqJnfflfUmtaAJF4y4I5
 5HwBRnOZB1f.Kjh3B77o0scj2ezYoJt1hYe2rXkVHGQ3BcSnkJ4yVoQqj.CnfTNCeraafA9entip
 d2Ci9p.4uFdJ1JwHiS64bwluiaZGLG9jwcKO9vGbFTcfTA3mH0007UiWrgdyLOfejq9SGe3AkVk3
 F76L.kSV26cWhdnD2SSmrATcpqiY6NX.Z7CAllvtSRVlup8wI6wC.Hp6eVmfPiee_geNGRZC8Mmd
 3UpMikpzWQvP1Mkdwq2Xm58Jc5dELwX.Vq3tAAUSJfwACUNyYxqY2ZYe9fjIsFxswkVIdTMrwO3I
 srPSZ9g4bF.d5Yt99j8ZW6TXMoO7g8w2DrTxS2PnMZOnhAv_12bKMJrycShlFXFLTJ4xKOFe11Io
 yrPzv40b1mmr9RO5DEZ5jKkpkNqvvMK11G.ibsIpYMjpr8g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:07 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 989e9db4908b36ea4a327798a97c8ae5;
          Fri, 21 Jun 2019 18:53:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 10/24] Use lsmblob in security_ipc_getsecid
Date:   Fri, 21 Jun 2019 11:52:19 -0700
Message-Id: <20190621185233.6766-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 7 ++++---
 kernel/auditsc.c         | 5 ++++-
 security/security.c      | 9 ++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c6cddeff8a17..0d5e172341fc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -413,7 +413,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1098,9 +1098,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d31914088a82..148733ec3c72 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2268,11 +2268,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* scaffolding on the [0] - change "osid" to a lsmblob */
+	context->ipc.osid = blob.secid[0];
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 5ab07631df75..d55f01041f05 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1812,10 +1812,13 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.20.1

