Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22971C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EA72133D
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ypio5f4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDIVlR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:17 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:34554
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfDIVlE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=fnJcv2J/MrzRf8h1makEn2/UWDvYNR2yTG2TfGic4Xg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ypio5f4YH48Oq+GLJiivwqPJo4/Yf6THJmZ/XIV8VS8NpoGZdeI3foe0jla4dOq3crx2I9nzZnEk/NeEhqE9tp+9qQULlMDkWknmLfN2Lxz0L8BRRSq9BdGnnASTc5dTFz/HbqRupXoLhiGau1AJQu50FGjKDHdhgn/gCY/q+n2QPqjoEhiA/giPritniGaL6T3wWDKeHFUpmIrPInJPkrLpsScJMU4tR0zVOlqWvLDxczAcMvjfDX5j0quGT8HJ8mTFsEknBsATU9KEIgGoFSMmDSV9I6C4jOSmXrfp2S4+WGvpItbyURPnjsn95OT1ChX4bZAphpYc3ytnWP6McA==
X-YMail-OSG: g5WvnMQVM1m3RHUQczxuuHTERk8A2jN1rpR4IlE_THH0U1emOIzaKatldN47RUx
 e3ZGFdCLUnYF9fuvo3Gfo9H6YDVluTyFIols2c_RleVJomeSFTFgXIPKsdJ6na8_wXR3hCW66SG0
 snvnenOfde_T_hocjYDam0mQNwMmfqi.BCUdZfbouDpYvaFfW3ayQ6Obk.8ibd_.xVz3lG3dtdfs
 vfu2jQXVRfNFv7tcVVgh9QexE9Oxrz3UesNrFBJig14hDUpqK2aLJ8qLh7qm.0vS.J2qq.3sfzK.
 KFnpYS6w997H94TZUaETW_k3qWgiJ5hSfM2kWw9yt0tZtraIDqYV0QSrStclf48GYV20dT1I3wJM
 OM5TpeC9ZmF1Pr1p6fdlzTOqZaYtq6M9MZ5r.wzcjfnp7RyEEIaUKMwS6ouZP0dFdnWWYWYE2ERz
 BpH_yv1t50W6gr9cu7dS3kbX9.qjN9CaHuqLhoYSOgEd.qyeVt33PVk_yzbLYEkygtl1qNOIZsHE
 qIoOAS68d_WC13JCFuUX8s_tuzYldlKy5Wsg_qCctT1CXiCuWpu3QqMHIUthClKE4DtNvQ9K_cP2
 k2_ESTXXCrizU_63qIlh.XHatUJAhcb0SzBAtK8Nrl82UmruehcjeskGvFg6im.TW8zl9QUIeXGQ
 tPbXINGQA.ZWHuAIvAvLhJz_2yJnAGvQks28NpyENK8ChXEtmqQOg0Zm9TO22tBepKbtQyObOX4z
 RaiB5lf1u4xNhFaKZJgBwXE8.PGYFYK8m8FT2SC6VVOXYlWFXftGcD8YczfravDlkS.kRwvmS381
 jN5KDh0NojAYe8y7DgwLwP.XCEsOqDOZ.NB9LA7_bMUO7NX3ik.9W0U3s12zPOjiLIdL5WPj2zmo
 JR9sLu7TIj0aYcc12GwAQqCv4q9J0tTIZ8psj9Hgo7C9I_Ox6JkcMDJs7aNRr8MovOuGauShoJ2G
 W7KcOMjcUDfafcP7HBgx1qCQk6hmW2tzSBGEnV23hFS4cHd43CD9xqdKRh3MTxlEQRPWW6bU_yEc
 50sWWz5ch32PynAzLOxyLDZVbYLNLpq7NQkVUlwYd2RPg06tS.Fy.4Tl.HWU4BLtLlQoaIhUSc9v
 CfQdafQeQD62hBEcRU7dV8MeoGr_mCgPR20eFfN3DHJMSjbxgkwJpixeQ068-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3d2ea789de6b345569f1c9b3872b02c3;
          Tue, 09 Apr 2019 21:40:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 11/59] LSM: Fix logical operation in lsm_export checks
Date:   Tue,  9 Apr 2019 14:38:58 -0700
Message-Id: <20190409213946.1667-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the logic in Smack and SELinux when checking to
see if the secid is included.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/include/objsec.h | 2 +-
 security/smack/smack_lsm.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index d7efc5f23c1e..59a3b1cd5ba9 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -61,7 +61,7 @@ static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
 
 static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
 {
-	if (l->flags | LSM_EXPORT_SELINUX)
+	if (l->flags & LSM_EXPORT_SELINUX)
 		*secid = l->selinux;
 	else
 		*secid = SECSID_NULL;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0e048c1456ed..a3776501965d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -477,7 +477,7 @@ static inline void smack_export_secid(struct lsm_export *l, u32 secid)
 
 static inline void smack_import_secid(struct lsm_export *l, u32 *secid)
 {
-	if (l->flags | LSM_EXPORT_SMACK)
+	if (l->flags & LSM_EXPORT_SMACK)
 		*secid = l->smack;
 	else
 		*secid = 0;
-- 
2.19.1

