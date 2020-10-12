Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B8C433DF
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3992087E
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iXSg8euB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgJLU1Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:27:16 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:43280
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729153AbgJLU1Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534434; bh=3d4LI/YqFkKErHJ5WNfa4qJ0fu1SNHfUBUMBwlsU5VE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iXSg8euBcdxqcKzvmk1pV9mvf6ka4jzaQOBcyFl9m/Qy8zvqCk4xN8dc+KPDKcPWLBvPa1B9hk3AO46JAisnoMEXjCdzpNXq9NDpx6lp363CxvbXklSCZNRMupAjoCocoCzTW4SswI5GNAsGo87DQcfWm5uyBOiJI/RmXD85vVvpPrJioy0wmBvdwn3bBGp+SOI63zT7u4N0a4ri0BbKXVN6nC8lVSEE6bJX1jMY0sQf4EyPs+xMoUH5zBho948a3Tvk2WLgGZ1owcaXdTGQTz2WUhT1X7A8soWz79jUGzDji1W85+p2hcsshETiKq5Hys71/pWq9N4aOkt6+GxmcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534434; bh=5Oj59/rzhl0P/P4SSEuayHIGpG9W/FQntIVB/W/dDgn=; h=From:To:Subject:Date; b=n3W4FKMOzLMtWLIEHjxTWRndhXyKNFsk9Hv+C6FEuE/jqfiIvwRr25s5x4yD5PkSeIULpYN/sZcHzNVxrrFgBWlHtKqC1WxNsDLqEkCeSpIS0kkoRV/McxAF0RqJzOrRODmRdVJNvKCXcmIamac87qXQqjTv3CDTzzI6iK8dW/IKSNMPY9HU5D8Sak3v03KMOeZzPPLJ+482ABjxYMDSZmwQrOnlbepArEaj/J+WHx6XxgW8Elt98E+UeJtzwXzr2hVPD29wQyaZo0IjYlto0z7kzLsAr0bxuD/YLyUiIWbwkDzjKKed7UIujc3PYyJQih7XPswAp6CgTsNowrXFfQ==
X-YMail-OSG: m8UqKdQVM1kCwRrTrHfoOOcvrFMGvGnAhUEeUYpd8oSgZvPylkgGYyAKjJoDmMn
 1obgYcfJzbSpg4gCcZu5ChnzYD4XE2gCdupcQMuzxqT2pwTySfPTN0hf1cSye.C7azzWMuO5JH1Q
 q7soE.ekB1spzNIUY_pF_jTydH0RIBbM5DHQVuG3bti4.OwYm8m_ezNEJ7F8XCy66ll8T1j0zzv3
 Mb3Z2dkrichKsqeJE.N63dQxm._.QEqcUgUzmF5opQk3FJwXSGrW6SmnU2dO.wozTKZkP0aak5UI
 LBlAEohCS.rRixc8wt8WMhYz1kouykUQxveKQqyHiK6RX6..7DCH.tC2nRtN98JI1CU5hUu9WeHq
 4clDQpgg63YLorymiGAUh3qDuaMb1QvVHDDat.g3mLoVRSlHVk37WpVQy2x4yoVlTGw0Cq48AABL
 .1fC.w5dx2OhokLdygofKl5lnpGaVT9hFfQqB.9gzFbKImZ45NDPZYygINbipojEfhEtt2jEJBqK
 UI_mqKDXeu74a8s81l53pm_7x967dHbm1HzrtXZs6UowJA3_eAfmPl.eT3quvZArOpy0C2m1A2n9
 7ODtEP8uANddOgX_jj.Z0hgGLCWfSDMWUdHcl3HfnVBIHp5XPCjhH2dALOWhFeyZLFP2L9H.i9I7
 H2YpyNuofu8DA22qzreLbjlMZshnfflMTJSu2sOQu6uvlxSfzFs3XRVdLHeGu59b0GbfG1ejSImj
 euAAEO7vg28oW8ZYEczmFRTc58MWj3BMV6hHRfbAMtyWdxCMxg_KH97o1yFZy1OIQdVNArofLH8e
 zS1eaqnocp.6u6V.0WAjG_clEZaroDHD68wmFi6R21hFNVcwrhZZ7o3vrKMZreDH58u8MOuC5fMz
 TkMbb4bu4rtaa9y4W5m9OpNs0gr.FjjRF6WF5836I9u1_ukNDazo9rO1.uXBRZSSsirk9iH30eBj
 G_FxuP4n5tbp6y2UHsFnz7qmme4tw4odJF3vZgKyukc9sIuawy2CbICVlTUkPxT2FI1JHzkaPr4E
 OHg.u7GM0mwboXtTpJ9ChX9g_p6XeS_MbZM7cpCtqiXt28ERZbvULZG0q1GLw0rEKw.rT9seU4Tg
 KRq3cRAes6RnWMRX7hFPkH5JyJ_qlMW6r4pQyNLDH48Ml7mjcayb1xRyoXXd5fB34Px_XGImLy_j
 .Vl58643JiQsZaqrO1OYyUF72KuL3kQFMRjfGpi29rdJrqloRXwKge9FSjc95rsSdY0ltENMeHle
 J1hp3oSYuBi1cHxPNi5F9W05CK8SCRo8iRcfU0Sf2npFR87e_f37GMuQQEvUo_skJwb0Bn6sfqbW
 9v7EwaSKxCUJ0Rf2jDMl55PJJ9efHoBzMHu9_xUyxu60XQggnCEwYxekM1zxvVf0q2tt3f.FArh7
 52.4bhbxP1Grnw7zwAyXLEVtIOz883GHmUz984LqhnsxZe4Ap_s5orpPSalIaPfIo1A5vzLiLQzh
 xufcSqdarVplTrPCPsLSQO.Yn26NjoEGdRwOryOReGnOTm8xXSJdwFV8QyLXGgP2aNIv2pUILlhg
 k27sG0x2RCKMGT8McQIBkwizbfzC_0joMC1XoAfsHJpDDqnBI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:27:14 +0000
Received: by smtp415.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 98ea85600c76d59dda96b1fdc8715d06;
          Mon, 12 Oct 2020 20:27:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 07/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon, 12 Oct 2020 13:19:08 -0700
Message-Id: <20201012201924.71463-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ab7fc9849186..9dc11a8d9b60 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -494,7 +494,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1215,9 +1215,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 5f9bdd62f78d..35d6bd0526a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2341,11 +2341,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 135e8d4d50af..b6ea2f6dab9a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1866,10 +1866,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.24.1

