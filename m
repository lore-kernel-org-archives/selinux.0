Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE49C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A9B27982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H3B65eLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfFBQwM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:12 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:39521
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbfFBQwM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494331; bh=affcoRY2PaaUmEgcqS6C9HybTLSyjRteSCEEdycSbI0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=H3B65eLcQdW5ThivYODY2ixkPmLegalA9QHXVkxATe9EEX2EtccpAdi5fdo/lGYfl0QsEWF9A5jcWHxDGo7dpB/XulENPi+7sakxvcNyseaFqd+ipW9AO3HOfVZEeaxUabeRRSHTKulnhhSeKZwqEve5DQxMDKUg3KHTFMbwZ2Dl0Ul7/QOFqWIu/0nsMr5+7ivEqHZgjtiPCg6jGCw4l2g5IjiT7PwlSb6oa7xbgfhi29BqWJnEwR3cunuJDwG/n/hCisgY7OHscdLqck+bu5iJkKiwqv9mYB2D035pSBV0wRj9UP0kOq9JBi9AAu3LrJOoCmI/djY/gbAzqdTtfw==
X-YMail-OSG: qO..GKMVM1m6oGxdL40rM0IuNvU0Y5DQg7IOQiOucA5txTmt9SxAhplKNx31hPZ
 2GHQ8hmHTdujWFiofAkVnGBexMJFAOQkZ5Z6_2wkDzMMcN1H719UTCi9pEiDrZTeOLM1eR80n7V5
 eafYjapWJBV8U1oL2mJfd7s9XrBTVKCFgOCFGIcflFW5KPscvrIpzLi6QukiWaksBlJxX7lumLcZ
 XTKtebrvS9AhZ0az_Caj6wZ5Jm3cnjW2H0jT1x.8fu4XyzWHuki_VgymhtHhbNVBZ7bkcjSslk3h
 ImSj8WYT1Ii3F5HsTlG6YUlRoqk2r7iX88RX6OjVKibWTDhCPeVES0RO3FLcFRM8hrWi.nwwLcZU
 dO7i2_7pLaM9T0eO3aKm2AWsTX1EydRRuir9wOIwUUgsNmkddAsdeEp8N32zKuuezlbjirczt2Jo
 iD7rlrHW_16JWdKd0YYcQixCjcxCk9q9_jyEgobgtaI6UBuljd8C1IM_kdozcddaG3Oa9pE.kbfl
 kbFtx8CLvy97xc6NAQwSe.xkjXQ7lEmf59iX8RyNhI85mzT5_AvDsmcKCzQfRB_35cgadA5XFlBh
 JVXoAX6ZO.As.vxxnW.qO3xALK3428DIA4mFf3nMseAeWfsf_CRHalSw9UHtsUxx4ATN6ksLf2Gk
 UtBdCc9q6Rvt0PMc.humop5YyFZ5DCDz6GqGeMPonTMdm2A.jy8VbJaDuEmX6.rSAF1gJrB6o8WL
 uRmayjqEvhVjIAyWyEv92ArwGGLHdjZQqn2tJpn_6pfLgR3mKOvAALURYRlWeB37W4F33rd93yQi
 HywScIEaBiBrVVP0nSsZLyNOELNA17JEzBk2iu8I3YJ_b7gUSz8pAljCLO5AUZli21KpgNmKZmBe
 l8OpNtUrk7O4hHqCydcJ1m5qlqqrLADh2HblUz2yrqA3RslQYBmquWib7vrNhBdY9cqHOHDxb7lY
 JcgiL9hqvVPcnvSG.aheweGhaL4hPe1mxIQIRadwT6ocLQNRxpTqplN91Srsy9wFOBmO7unI3x6R
 IQnd0lVFaAk4lQydRVEt8FlBCEo9tRulb8rwTNxQW5AKFDBeaXVzsGn58AIyi88TgyVhNEDmiFm4
 ZaylV87mozqj2EtWVge9._XPSf4zSYYRHr6QhSuOI46ve3mJ5JWjPrlMcjsDySzx55ys1F0t8vdL
 i23FIdesTzruaqgY8wgC69E.JAHJIewXyteHahq5zs_qbbXeKsz7fk8jpXYqIPsdjI4tomRW2kw6
 TfstI7pQSp2EFFjoDrOEVG5AXgGn9e9_1u091gOFPJKqlz4WnZoh_ANs060o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:11 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp423.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fe9f27128ba4a09bc4aa17914eac4de2;
          Sun, 02 Jun 2019 16:52:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 18/58] LSM: Use lsm_export in security_ipc_getsecid
Date:   Sun,  2 Jun 2019 09:50:21 -0700
Message-Id: <20190602165101.25079-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_ipc_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 7 ++++---
 kernel/auditsc.c         | 4 +++-
 security/security.c      | 8 +++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5cea6260bbd9..6ac48c7c4a41 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -411,7 +411,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsm_export *l);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1096,9 +1096,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsm_export *l)
 {
-	*secid = 0;
+	lsm_export_init(l);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 83aba0336eac..eabbf78fee96 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2266,11 +2266,13 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsm_export le;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &le);
+	lsm_export_secid(&le, &context->ipc.osid);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index b6a096be95ac..6ba1187c9655 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1775,12 +1775,10 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(ipc_getsecid, ipcp, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(ipc_getsecid, ipcp, l);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.19.1

