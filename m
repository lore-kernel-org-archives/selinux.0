Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8EC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942D126FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VFQh+v7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfEaXPN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:15:13 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:39076 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbfEaXPM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344511; bh=gEWZCQzFlqcooAYwsHr2Nt701eG0L+I40RIrEVg4i3g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VFQh+v7XaqOAF+HyWFBkExT1GoJAvq4Rs7w7ZRgYgPWi9XUGbCuOHkTGIZ1fWi0UdM2sBfbsWIDXZ2YxY9hbzhpN+tjJZUgpX8lkwJbiRpS/kya8kKcXB/d0CNrpV6QDk8A8SBmqvPWc8vePSnev7qGY4QJ51P7vd6JWQE4jyPmw9DCaWYrRTHTo8Vr3fAG2N2GMiZtTuDtP1WuByX1pL88lCgmUUvBL6LXVCS5K0TJl+4EnrRuXj1Niyn2w33df3hQXIdqwdMtyilQchvkbBoltBeTozljlge5LC+Ih5B6hl/yi+8QecIJ5sa2ByDrdSI+mxXLhGL2HKjcx/crbGQ==
X-YMail-OSG: VT4V.OkVM1ns5cdM_cpsnqwloGx6K_FpJQYtaIbzfGozTY4.WdeojANP1ASo9ik
 CiR3_kfUPBCrTkWyxddfr2qIBy1ziy_QZvM.BSO3fqS7K8tLD_y2SdQMQuntxL1I77XvQaQkJ_Qy
 bmAlkGtj50CvKIZSKbh.NpuksN73WYAHj5IuvAH9a2pRRYHEYWLNN4h5aftQSryspqwybQZ1XNDN
 QZgPqZNW19BeDxlDSk1Lk4qM7NHe5D70IWDGb4VjxtrIGlsxM0vEOlTgBpq0pB1tcQR9sywJfzbL
 J7cuJrOkjxT7v1ZL2kh7pWhT.ONfzwr.n_Z.S4y12yY7vy64qvq9yzFYKWD1463VYAXXFERpD_GL
 SKn0K_VF7apfLPOfIaRRNlVH7gKdtB3I5Vo02VSbCdrlA4k1OxWPOSJ.MtTUCRZu9LHEa6GsNWem
 zcsOmV7iQPQX_GaZPyrwvXyA_H3sSQBAE8kedcrklsV8W_0kFNbdPnCMLgn2poVDgIAtFSZT5_69
 ygYVRxHKQDbeqYCisezpr37.HgEtuLo1s_ZkGpOabxj2OnesuhUlXEU.3bPw3gHbNO4_1bxMq2Tu
 _.dI8Uzds3T2Um4QiIXcRioY_Zb3jJEChpGJFfOfBMcHDFbB9WaKfaVyv84fB4TRzJ5lirt.HOR5
 LdCTBULNpbn33rRsHF5GMOFO8DkZFI9Un4S_uxgcU3ZcTGOGhM0fRIsP5fNAFb3LHvu8jRJWNnM9
 K6X3jbAT9M4LDMi0K86sBNkBUyU2ZoBheQtMwjfvn5vORqKLSt9UUPKyUgeJsLmkfOJ.g3oeLHEb
 vwhZ21_vsMo59ejN4deSiSHBiOI_acz19g0NRCY7V9yukuQxSC7F4HNbjg0E_Qty7z8zaEY_o7us
 KJCaO4zVjcAPwXPcSGEhT3s7.ms_oJeyD1VOkp1JVFRu7ksqvKdlqPVUlJd3KYG9noWJMSVrC420
 QIfDF_aInOwVjn2eTolL8HVyAmdfTSBSFvWNeH2FSvMSeJKvQgtQerQ_Wfi9t0uU5oAcuqt3Wxyq
 wH8aKsx8ZkJiihGbhnXb8454ZMqVhAhD4PvFvMNCGk6NWwJ3yId5wGYLcesvr5lUNEe63bpLCE8E
 OfeZDBQoMIvKL9yypQEKLq3eVhphLuLCf0.B0xF9YLWVbHvSgROhs3MeA2VbUDMWA7UqO3_R4Q76
 V29c24_PjQx1R5kxJ4b7_SSA34wUnn3RGsbMHv6UmRNobH7iRRFZzlOV6O4550XJrXy_8w118232
 RjToLh9lZ0H6T_8PgEgp7yYs8KYKdXR6YjS_x02rX0Relil3O7sUiUsnG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:15:11 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8bf20f07042e719b018df2a0e547b97a;
          Fri, 31 May 2019 23:15:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 31/58] LSM: Remove lsm_export scaffolding functions
Date:   Fri, 31 May 2019 16:09:53 -0700
Message-Id: <20190531231020.628-32-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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
index 9d8115b3d679..dde36e850cf0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,49 +116,6 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
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
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

