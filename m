Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C17C282E1
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46F1217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DzzUJSNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfDSAs4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:56 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:40265
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbfDSAs4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634934; bh=O0IeCsut2lmwjAFie1gHcZBQCGvPQaJTqoCsbXdNgtQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DzzUJSNhMd4YFiszblAelG/LSrRU4CmT1KpwYYGft/6rZzOgf9miP8yR48pObyY1ntqQpiGF8M2dNPzKOOeGNX6TSEQCuSFC0VLmbAPcyYaAuKJzPC+Q+XgVOLGFPFPz0bpjkni2g55wP296LleL4xDjMJr/kerk7+ubHUdhVEP8PmEQ8UO/b4O/t1KtmZCuZKtj+4rlQH8gP/EQglkiyyCSkihED47Ika9XvqCQhmWiZ7o3/dc3T7sf9fDP/xeKJdSNPflMRa8x+XhayXTCmRBt17ljdAuXbgwPXy1fi6166u8/REP9qUWufLnFbP+u9Z02Om74AKZFakUJe17rFQ==
X-YMail-OSG: Gem5FuQVM1nKG9t6Qvsblwkoo8QGqZtymIS9_vaz_.iCFl0iEAchjHDgJaaqzzV
 tt9v9AY7NvIohEPUZHTuyy2zSKw2D7fyOuLujzzMEqi65nwmDE18JwzLiQy8ElWJn_usDjtk5HKj
 XwYxYoE6nlOJujwD_hDqSyaGpy91.rzfSHQKOxxTPKwyyAMnU0lnXW5tXrCmad8yt0sRCn.EPDLs
 0jB4lGTQ0rs7Qm80QByNQE16FyU8Hi9Bsv1.0S7BlTEJbOQV_NTSuP9_HNBK33ZGf3YXpfSvjvMu
 _qkYdNNywSKPAQqTnO2046fMT2rb1unvEGSB0Ybwjd5nCOwXUyBLwSeKhotfTiQk_hPvoGKcTAel
 fvZgs7Q2sH8VhakJB3hWzmJHHHwZxrA0Hf_Hzwcx.8sl2rprnnURSmaF2YbVCOQOFPr2X2pg10iG
 EU6vpgp0cy08wZPN6wF1IOTGLj.25KxEksClr8fsDbSyInSq8cSkpPBOmozgFqizhri8BetXVQ3c
 8oZifsnIl38TO5_2RJwOja2rTIQqheB90pLDHkHb3u6c2W9h2iUReNfXFpwz_fgSZuLTZoqPyqLs
 nHZWMNEVApEL0Dc_YtLQPTYK9yJAQGKZuJS.BzrF2T76tpt2yyzfEG0BfYeXlms8ciyaTQxojs2S
 7sbg8Fe0WV9n95FXAZFaSPmxluy3Rrk62hndxVFTcCddYl7JyQ63caXwqH4kVlkXi3FKtUpkXdUb
 K_vTfPlyfOuK3ELbQcnCVhtLHtIiV_tsKx2V17aCMd9QSjaVFE2ZykDvJUammwjO9EJCotQbNBgu
 JFmE7HneVHDT69DZg3_x95libtFu1V2fICrmvILg3IU.MjReLIMGEdSI1BS5lvK08laOYVPr7855
 YZkaSRyLbs3I0F.q1jxOaLaDZAXDCn2hhSO2aueO8Rglpm5Hze14NYlvcbFKff4yGSBTyDfs_JM0
 kJWlFLdRle0MMliJfJIMpf1lDiQpWsFolul8A.UepppokxAeIq2.7Cg0lXt6z9joB7hxpS3Cg1gR
 gPtioTPmlU0ZTixR6kxGInU6WzIDLv6FbNDWAk8i7mlVTwvPZ9PIfqzFLVlsre5YHT7Fv9zivsg6
 TMjh5u5Q74HoeNozGVvwRKYkjhS_g5rE9X17dhDlnGxhxhEB1LHg_sf5eFkReDlMvL3pr7uwIijy
 CIN7fVEHnJLHC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 406f9efc49df2aab5b39f3872aa73829;
          Fri, 19 Apr 2019 00:48:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 65/90] LSM: Add secmark refcounting to call_one list
Date:   Thu, 18 Apr 2019 17:45:52 -0700
Message-Id: <20190419004617.64627-66-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
 security/security.c       | 44 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 711f9b3eb265..5135b8d1d759 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2049,6 +2049,8 @@ struct lsm_one_hooks {
 	union security_list_options secctx_to_secid;
 	union security_list_options socket_getpeersec_stream;
 	union security_list_options secmark_relabel_packet;
+	union security_list_options secmark_refcount_inc;
+	union security_list_options secmark_refcount_dec;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index f99845aae595..d36e5bf594dd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -459,6 +459,12 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
@@ -740,6 +746,14 @@ int lsm_superblock_alloc(struct super_block *sb)
 	RC;							\
 })
 
+#define call_one_void_hook(FUNC, ...) ({			\
+	struct lsm_one_hooks *LOH = current->security;		\
+	if (LOH->FUNC.FUNC)					\
+		LOH->FUNC.FUNC(__VA_ARGS__);			\
+	else if (LOH->lsm == NULL && lsm_base_one.FUNC.FUNC)	\
+		lsm_base_one.FUNC.FUNC(__VA_ARGS__);		\
+})
+
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	struct lsm_one_hooks *LOH = current->security;		\
@@ -2010,6 +2024,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		union security_list_options secctx_to_secid;
 		union security_list_options socket_getpeersec_stream;
 		union security_list_options secmark_relabel_packet;
+		union security_list_options secmark_refcount_inc;
+		union security_list_options secmark_refcount_dec;
 
 		if (size == 0 || size >= 100)
 			return -EINVAL;
@@ -2056,6 +2072,28 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
 
@@ -2075,6 +2113,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		loh->secctx_to_secid = secctx_to_secid;
 		loh->socket_getpeersec_stream = socket_getpeersec_stream;
 		loh->secmark_relabel_packet = secmark_relabel_packet;
+		loh->secmark_refcount_inc = secmark_refcount_inc;
+		loh->secmark_refcount_dec = secmark_refcount_dec;
 
 		return size;
 	}
@@ -2327,13 +2367,13 @@ EXPORT_SYMBOL(security_secmark_relabel_packet);
 
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
2.19.1

