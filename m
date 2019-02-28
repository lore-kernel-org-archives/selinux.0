Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2237C10F0A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B002184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gVh72C71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfB1WUR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:17 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:44017
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729999AbfB1WUL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392410; bh=cklG7OKdERKwHoDLgL4wvFaGiWKJoB9sH4j2U4c+Pwg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gVh72C719/qOHhBSpF0nJSOOZlFoPp4h9oFPEQdIUmimazERte8byBM9ErWHIsL824ZbrFt81VXxNuOeeFqkt6GeZLOXZoYjXXcJByH0hUKmkZrGl91gv1Co/MmBYi3y7DJQzP+egknqc9+nmOrZdco/wcNDo3zDkkNeNd51NKN67pvLieSdT3fNCXBcDxH9GvDzg8EYC6dl5d4bHSa+jqX9hL5YpNbw4YzGtWEBBrt+AdZwgg8Uti35G23OLYbEljYHIStPpQSgOYVcxNpXCGUQ/IFe/Cv0abWg3eidAyDGDJgr/GOqE6Ucd6gV0z7EHICKaHHF0LinEqwzdM+lOQ==
X-YMail-OSG: FNn9dFYVM1lyNw17PQpNmgCkGQ7zPnoOdNMvbEtV.JkdLo.Q63yfIfcBDvRK6VK
 1ESRV3KYwwxBT3UyaeZFPsNajiaownboT9DQKolV4tRigNDlqSRWAPIzi_S1tGg2ALQc8Ya2qo2I
 bS8vWa7wngsFsH6G6Q1zohb.Hp.Rm9Goq.8Rb8qQ3R69myQ.0q.uD84dPKkOHpmNmag0UWecmoWe
 KClBxVSR.A04KtwdgShKR63IKDEK4XOQa3P3lxcok5vOuWheL4rriOt6wXxtG5BK7eN41IBNddlb
 8lSOHmTtwluiFxFdkbNodiFBJUR5r7yXeURgv33KIYjns0WzmQxi7_MNC31xQh87NmiLhTjDrWKO
 F9TvaEOBcAkVZfkvveiif0fbrDXqkSVH_uMoyMWpbspNuRzNfFaFcTF_kS1SuRizKN7fB5QVoxcp
 dUYJxABtQuXQKAR1eqncZg1mjmKe8zwe_vpbS5Z0ZSFr06R5nzJf4Gdo9SaK7I5GF7ds8aht_vKY
 DECnc6I0.3hCW1LY3sZTDSfWjB46YreWFyBNdg21wQq.SReLoxCdgxFORsNjNGKy0gHe_L85vGKc
 5hM4icBysmDQ3bcEqvo53czwPnhTLQvcJppmn9MLgNVygpBizBzYhC3j1oI942MVUiesmxX4V0SN
 avcfFnW9RrAqaxLcIUwkh9aVTsRwsG0Nqzk4IT0SZkTB2k.tF1gPQhWDW8XTKidGTDZv7_kFpesk
 C3uW6K1qSC9NYHyhI1p1Mi4L1Dnh5sd90hM8XKUCNHSB42XKVPkMD44Tgoev8zdPtrX7KPB_KEg9
 NTKOm4gHjXimSStoIl7Bantu8G7TL8veIW3Ql1MtYOBZ4Qc0JlW4I9ig.6hBAIopQWwitkYLg95o
 ygNt8IydlbtY6mbog_uoXlo1RDUlktHZ3OlwtFwIkpM7tY4WW6mkXL9_8F0lPpzg6ZFcT6NJ3gLv
 UxG5H2K3ok..NvrIHsVUGk.gwgiRWC4vLRxiB3J12.sTXDI5ulUfVgSV4u7NW2.Pzxihckbofc7Z
 WL1p_vuyqfMYV4gcQRr_pBYFjYMOnzZHqVFGQ5i.y.KLJWa6uRRKtU2zHge9Nwn0gj3AWEQnIhGw
 vQX5wRx6WORps_wOqG5oJUjWi_bFmRfoviXE0NZXrFveQFHll
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 38/97] LSM: Remove lsm_export scaffolding functions
Date:   Thu, 28 Feb 2019 14:18:34 -0800
Message-Id: <20190228221933.2551-39-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The scaffolding functions lsm_export_secid and lsm_export_to_all
are no longer required. Remove them.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 43 ----------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6659ffa8cacc..b8c67da7409e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -114,49 +114,6 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
-/**
- * lsm_export_secid - pull the useful secid out of a lsm_export
- * @data: the containing data structure
- * @secid: where to put the one that matters.
- *
- * Shim that will disappear when all lsm_export conversions are done.
- */
-static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
-{
-	switch (data->flags) {
-	case LSM_EXPORT_NONE:
-		*secid = 0;
-		break;
-	case LSM_EXPORT_SELINUX:
-		*secid = data->selinux;
-		break;
-	case LSM_EXPORT_SMACK:
-		*secid = data->smack;
-		break;
-	case LSM_EXPORT_APPARMOR:
-		*secid = data->apparmor;
-		break;
-	case LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK | LSM_EXPORT_APPARMOR:
-		/* For scaffolding only */
-		*secid = data->selinux;
-		break;
-	default:
-		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
-			data->flags);
-		*secid = 0;
-		break;
-	}
-}
-
-static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
-{
-	data->selinux = secid;
-	data->smack = secid;
-	data->apparmor = secid;
-	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
-		      LSM_EXPORT_APPARMOR;
-}
-
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
 /* These functions are in security/commoncap.c */
-- 
2.17.0

