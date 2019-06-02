Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB7C28CC5
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CABF2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="h8HS9bMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfFBQy1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:27 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:43423
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbfFBQy1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494465; bh=zgFSe6tWYXYAPxCMjdvNLFgshVy6juLl1RtnFRkSwpk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=h8HS9bMzJLqgeKZaahYTm8GSvYLPDMMwVK/MAufm92g4IimYCTDmnjy+5E3dtNz5S6C7ibi3yWNWqP9Ay/QzXKb7xJH5nkCW63V+siKrXjgsCLOP+doG8U/Bl4AWnZN9SsgwFhyR25KADSxC0W0y2cQqnGqq1CskKNWq27C8BD0gH/EV2SBE5yIMP14c5kSWlaT7zG4lId/DxhNsxn3YM6Nru3PSjnxHnZdSd6qflVHdvqqQPmq0MaGDtNJ0YU5ejMNbMSOZ/XRGwYpJyCPqMpvWi4EA4BiZXv3Yu06nw7suOTmIM46NF8RIcBicd9izOmNkO4O35S76hIrHiZn+Mg==
X-YMail-OSG: Mb1i93AVM1nu2kjuuf5vBSb3CasYpakc5K.q2fNlVL1kgzheVoZUcEnkhupFx_h
 y0JOb.7urSFKUhbo8e0jRuKefB7zob1SmSwsR6BRX5tzRwCxE7NH_i3IBKekWQqwvxEFeD_ql02p
 xkDO6CnHFumoqtbJDNiGb5c59aFFw6ipxchh4FNe.Y3syOYxQuMpcus5jZkyG0pd50n00MhdOUce
 TLF7OMj9GDlBYCKSaXH6r.KP6QrQn6PMZXV5gSN.HbdA10vDRWc2FiQW9ZJB6KGbocrnEfeGNmZA
 Jap6gaBKnd7CGBS7v1FTKqwgZ4C9DtsDw8N14YmJd9N1FfRyc9p9CLWJZJ0SKLUWL83A1ksN75tU
 INl.ZfwcPExUhnTwIk_kH1muRk5_q1QtfCnl6g0nwdGi.Bq2NDGn9yOmFOa7T.UOZiHN6M9rRFGi
 pRCrjargD7T3HsP9tR8AN9ryL_QxdYk4UqpjEGkjpMKqtI0LPaOjYV1dpfdUt3lk6NHJuywW0ywB
 JLufdWmd.Gcpuchv95a11HR09J4LVJDFUeaWSPqxf1vXdrcHd5U7qmRzhCriX3lYtiOeK6PrdI8C
 KCP9GubYZ3n1q5IkMOSv5gHHogsHj7a3.IkLB4O6NjFEwRTEAcJk7T7agmcNUfsr6EW_Y3Ii.Xrd
 a3oRajeolg2J3flJfNuHODGZLH072hL.gzHbRrSgu_8RnQ6oPAacwaHFLdOmYIeK92Lh7z5qSAs_
 J958Z2gKSI43qqnUXHv04sdLrZTxlWO8.mBZYszzttu_FEx76c_sjhxWXY4cTESA_AAcA2xcaw5u
 _tN9qmAnE7syWEWl6U2P6TNvQEY9qadcHaY_8F1GBW_AMhYU_YjuUJS_x_MtthgR_qql_9Ka.PwW
 t_50j8.GCt00FYewEntWxM5_eON7QBe.L_yyM2ECUztnv_rk1reny2gr9nQGkGlDV1gPJzINbsJU
 aV_zw71C12ND_qZzl_B3.UmF0hgBvibJUmYPJNz7KOI2uWzR9HHCKPWsVfJ1NHeeGcPxTXxAFmbj
 z12PRZLxkFcDSyLlJMho3XQLG_FjUuB9D8lX5LfIk8ebvz_2cwI80GgRD5gKNr7fnIIsp4sxkxJQ
 uI6DRUXCudIZsVG00G3hcN9XDYDM71Uqe_PJwWx5LPUE3piF_7DUwOgplMuOwqvHbOwgOJ.x8WvY
 YWIMGYa8.KDPE79bQNr79WY33YsuCNBwgiSUR3kz4bl3SxmYYDy5X09O8xyBKA1L.pLllhdESa78
 qfaxdc.H..HIm0vdut92GmmF2_0LNoQ5IzOPK0K2eol2bAY80E57M
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0b8226328c4965373e1d598ce42fc97b;
          Sun, 02 Jun 2019 16:54:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 54/58] LSM: Remove unused macro
Date:   Sun,  2 Jun 2019 09:50:57 -0700
Message-Id: <20190602165101.25079-55-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The call_one_void_hook macro is unused since the change
to how releasing a secctx was made. Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index 363647cf1ae8..ae43735575d6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -698,16 +698,6 @@ int lsm_superblock_alloc(struct super_block *sb)
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
-#define call_one_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			P->hook.FUNC(__VA_ARGS__);		\
-			break;					\
-		}						\
-	} while (0)
-
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
-- 
2.19.1

