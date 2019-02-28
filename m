Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F71BC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35039218AE
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LPQhkxA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfB1WoY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:24 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:39453 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728946AbfB1WoY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393863; bh=TzQHmUUpIugfXaNsfKgpGmemY9fdQW/IsocvY7CubrA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LPQhkxA1ommSYPBRQGsaV2kmbFQ2ro9dPPU2L2hdC5Zz4aQA3orhHvKQbKf0+IScnrJxFya27Ujq+71YCJNiBiCE8bBpSLkScD5K0ZxhtaLauM6Ase+bLUoOpycRY8pjstyXJViBhycAKJJcov64CLazVDS7YhU407HgZDN5GZ83XARCDHTRA3SE09CUFT0U8VoU8qeBqy+7D31hSu6F6R0awfrxLQFru9zgzgx4/U/NdtMSO9IlSgnx6EiTfcs6OfcsxY/F41BpZUV/j9BmEQkxJ/N5/nGlhtknO8o0h/zhx7CKuDn2F0JLUAd963cLMKdvgSwhYWqap6gqDxs6pg==
X-YMail-OSG: rHxqlIUVM1ntjIleLcjVf_p35_qx_VosemNMlGzcqJ8g96gsRqeihugXYbPnr8X
 sHFppleMOfD5_IO0Vy5tsxeQM2VNK_GeNQwS_aCcCgT_UBeS_plSvhMWGcoc5WgHFtn19OBrc1cy
 fzUZC8WAYUija0PRg5hF1Woa3kpv8HajctnBFua.grLRTVF4jQLQ4ry8D23y.yeUeQOGnWhqDAdo
 GFLUYXAhUCAdlQ5mqTx76Sm0aurZCc_EQCxd3r3T8J2nGRCR1kvS3GIN3G3mqgT0Sul9t9DVqrVO
 Te6Vgf4dP65OULanx8Ho4HWVx1_RNaVcy_3yicxDd2TNAXepDYy2GOKK0vV1Q0.uHomZyxhlmQhU
 lRzRctDiTVNK650yk37w7XNXu1tfoShrz8GYBK_Xwh5tC4.m1uygmbmLwPAP4L6ohcPAIyrBYkyt
 V8I_MAfwWb5MPPl4KFYtMKyeZNg.4gYCjub0PbT_JuAy7tcgBe29EBuWb8iV3DJgj1ZE4vgdxFv9
 uvuaotpHf0ni5szdiMIPwcyWeEpkEf.o72nOTOBkgP_07sYqIEPTPvzM0Mdb_BLqmTe5zPN_nWmj
 H1tfmFgD97CAGUTK9oFIx.shmJtCSUfKEFxR.aChbrbEGD8h2PYDjXQUzACXkq_o4ObkaQRz4tRT
 9WaubTPenMQnTWEw3mLSXxlIMvPTN0Ftnj0UyWW3neN4OFA0hj.oxqx73NoLn2xF2PTVmtxTMkTq
 yC_TZVo1ZZ9txY0uAtbRy8eUhnQRxEQVtWpar6CJWHLs4cb7tjSHt5mq.leN_bPhmoDLiwKUdFAp
 VlKMqhX5IMKkl3eY0hEPnBss2uZR75WC3JP7dubgf4Cbc5lUVzGtG8MZSTJRZ.EtmXKMocS7B.QY
 uG2dw2EbhJgFlsrL8NLoLF5rbkrdaNqD_AuDgr2SK8b3rFZUmyig5kOGGKkpxJDCJK7IEi4bTRfa
 6.Po0_5Q5dNoZ7ay6zfLy7n4GB05bIH79N_SWcNXvcHH3cxbeYgCBSgdJ8sU2beEPHNVECqPxDyJ
 mzyVvdv54lDzPtJqb5zhseN_BwJbzKpjcQgFbceZFtxN1uZYVjHWxmPKsaqM8Nj_aeJTJSJFM8bn
 6mOxYCnDOThhAbZQla2DQJhID7jgR4vbDPqfEjgecPbMamQqUKkn2Mw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 83/97] Smack: Set netlabel flags properly on new label import
Date:   Thu, 28 Feb 2019 14:43:42 -0800
Message-Id: <20190228224356.2608-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure that all netlabel flags are correctly set on the
netlabel attribute of a newly imported Smack label.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smackfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index abaa5325c32f..0abfa4315fb1 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -931,6 +931,9 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 		smack_catset_bit(cat, mapcatset);
 	}
 
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
 	if (rc >= 0) {
 		netlbl_catmap_free(skp->smk_netlabel.attr.mls.cat);
-- 
2.17.0

