Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFEDC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56395206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aHncW10S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfB1WoL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:11 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:42963 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbfB1WoK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393848; bh=jJFDAlCya7gSJRhnJKH9YHfyscZbftGuXLNV9EhATAo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aHncW10SfNr94k78TI7JDa0wfGN5TzOKUB9QuaJNUvVNoSEGmw8LdhFwszQFbHk809KfE/KpWCL3v52LjdxGVn5nXFH1q4r0RmR2Ioz0xqGAkx6PB8px/B3DR8sbZNvLspNVZzuWI4Roy2HAl++6o3Z6lC6zsOir4Hl31jiAnyqOp69LJUjTCEPVN51kyVLtQatMaT0x5EnVXlEqou8mglE7z8IC5POB6XbKKYbswf5TrB8NnFf/dl9HtRVa12FqSPLDRWy9mDZJdHfQFwt/p9VTNQjNs18nA0zeDJW8ykZ/22+9WJOzsgQVp/1EMcr0E7esX4+xY2WXHLtbzaUk4A==
X-YMail-OSG: au9nDHoVM1kYBHOFFMzOj6uu1tKcr7Dk76ybJA0sRelx29MH0Ve3o1tqCwUgVu4
 PtaxDdv9tbLZn.3qA9Y9WrMrNY47EiGBtwl30f4m.PWOT6d4uq0sV4OcSmq0y7GYgnHUMNot8BV.
 sWZz0UdpWAMy3lewMvwRRtM60VLS_mG8bbKb1X_4epNoQ3bHF0c9Wlm8NuflW0cSYuyrVLuCjUSZ
 mDF.tIavxgvL2ur1.B21ZYEnkLe5WRw21V8PkeTSD1cNFHC7crQEWaHR_TbC.jvd6QYyrFNKNkp_
 l8fdTAz7kj3kw5mhjix0XXD43HP3yNwI5rtbgYvCdWNbdAdbPhYxl_MaSNfEn5NojFfit6VoEvhc
 b8XhMRvhJuO_tt.8uboOkuuKDJmB9WgO6cQS3OFknpKC4h5bbGOab47ITR_aTKLoniS0QB6.ICBK
 FwJ98IwBJq55qgm_tOnThwfFeczISBDAvQt6cZH4c3gpHoG.FqBnc1ibtObf9Y.PNQ6u4eGTyQ3Q
 F2.KZG48UNd6LBzs1KrW5IEnRRwqNeTEIY0to4ytYHC7qX1kG9QFw6rREEhFslYxEe_j1WZyczJ2
 znqkTmTQED9llFfYot_pogi1eVIBXrKuHx98EriI30lk_Gbkg_OfbX_5u2M2DfIQhQHs4DfeooIx
 rP6KEc9totrVE.NDAkl4G5lEHATHGRmjPTCC3ibT28R6.zHRSknTxwXg2qpcFGSf28TEQb3xPSgG
 M1aM7viuxkOuflx.fAa0kqRf_RjyytZlEYqDhTyI4NiU_Cj4GBePIa76FZ8h9PjhPR3I0VFm5v_O
 KzosF31KmmTPua54JqfaMQCK_Xs3dwvW34aClKEd.5p7i_TZ5Dw_8J0Nov1mwTo7PenTWXUNp7H6
 3Gy_JTXn14vfULtapT4sYb5tZi9_jE5hfR0P32ijxS6GqWB7vl0RMElf1.Au0XKuzwwPU0lG2LPW
 aPB6bdcr7LKWosfaYC0xvfzUEOUv2exfSls3dzykONBdswjCk.UI7evO.Ql_wRWacYG0juO1XmRd
 VZa_yB3N2kheR3Z10wdYIFH.RrL.XDdVvu.VP7Nha5H3OYbOLSIN3D6hZyHv4J7JS.Wx.eXYa5TX
 buyYJ2MSwFyZJ_GMaRyTlntU.Wj042IbXny4rek683FaelUaw5Gig3rM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 71/97] LSM: Add secmark refcounting to call_one list
Date:   Thu, 28 Feb 2019 14:43:30 -0800
Message-Id: <20190228224356.2608-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add secmark_refcount_dec and secmark_refcount_inc to the
LSM hooks for which only the designated module is called.
This is in support of consistant secmark behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  2 ++
 security/security.c       | 42 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e76e5cd05180..4020e13f0669 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2029,6 +2029,8 @@ struct lsm_one_hooks {
 	union security_list_options secctx_to_secid;
 	union security_list_options socket_getpeersec_stream;
 	union security_list_options secmark_relabel_packet;
+	union security_list_options secmark_refcount_inc;
+	union security_list_options secmark_refcount_dec;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 024601db215e..af3f6a89ee88 100644
--- a/security/security.c
+++ b/security/security.c
@@ -472,6 +472,12 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		else if (hooks[i].head ==
 				&security_hook_heads.secmark_relabel_packet)
 			lsm_base_one.secmark_relabel_packet = hooks[i].hook;
+		else if (hooks[i].head ==
+				&security_hook_heads.secmark_refcount_inc)
+			lsm_base_one.secmark_refcount_inc = hooks[i].hook;
+		else if (hooks[i].head ==
+				&security_hook_heads.secmark_refcount_dec)
+			lsm_base_one.secmark_refcount_dec = hooks[i].hook;
 		else
 			continue;
 		if (lsm_base_one.lsm == NULL)
@@ -752,6 +758,14 @@ int lsm_superblock_alloc(struct super_block *sb)
 	RC;							\
 })
 
+#define call_one_void_hook(FUNC, ...) ({			\
+	struct lsm_one_hooks *LOH = current_cred()->security;	\
+	if (LOH->FUNC.FUNC)					\
+		LOH->FUNC.FUNC(__VA_ARGS__);			\
+	else if (LOH->lsm == NULL && lsm_base_one.FUNC.FUNC)	\
+		lsm_base_one.FUNC.FUNC(__VA_ARGS__);		\
+})
+
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	struct lsm_one_hooks *LOH = current_cred()->security;	\
@@ -2022,6 +2036,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		union security_list_options secctx_to_secid;
 		union security_list_options socket_getpeersec_stream;
 		union security_list_options secmark_relabel_packet;
+		union security_list_options secmark_refcount_inc;
+		union security_list_options secmark_refcount_dec;
 
 		if (size == 0 || size >= 100)
 			return -EINVAL;
@@ -2068,6 +2084,28 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 				break;
 			}
 		}
+		secmark_refcount_inc.secmark_refcount_inc = NULL;
+		hlist_for_each_entry(hp,
+				&security_hook_heads.secmark_refcount_inc,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				secmark_refcount_inc = hp->hook;
+				found = true;
+				break;
+			}
+		}
+		secmark_refcount_dec.secmark_refcount_dec = NULL;
+		hlist_for_each_entry(hp,
+				&security_hook_heads.secmark_refcount_dec,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				secmark_refcount_dec = hp->hook;
+				found = true;
+				break;
+			}
+		}
 		if (!found)
 			return -EINVAL;
 
@@ -2339,13 +2377,13 @@ EXPORT_SYMBOL(security_secmark_relabel_packet);
 
 void security_secmark_refcount_inc(void)
 {
-	call_void_hook(secmark_refcount_inc);
+	call_one_void_hook(secmark_refcount_inc);
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
 void security_secmark_refcount_dec(void)
 {
-	call_void_hook(secmark_refcount_dec);
+	call_one_void_hook(secmark_refcount_dec);
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
-- 
2.17.0

