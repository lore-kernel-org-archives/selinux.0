Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AF2C28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D70D26FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mVcMplc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEaXLz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:11:55 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:45125
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbfEaXLz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344314; bh=e+8uXyTo2CH/SxRFMxOILZ2iZwykcjjY1wTO6Nmz4rg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mVcMplc/EbFca0JaIVupLF/wKkLZif+Z4kQlt+wvIM69SCFwOQpM0Q/LgiVY7HrddsZIs58QXsUiEfZ5JWTfgvcrr6JlhaSLKTLqLeqspp1eFPQv3uqth7vZQ5hEmY8hHjbBrlo7NrMBN333X8P4xk9XuRKjGqvKTOtwtrqwRV0FGa0+BeiBJVLjcuCdSJ3q/G//RJiyFXbJWQiNRBG/T00S0J0A+YLzdaA+s26Bbug/P00GVYCrhw08n+psdtGqOI3Q7JtsT3PfUOhkNb+HdeFNr4O3lacMNKn9BX/PqJ4D7mtE48LORtACEL2Ox/e/Wu+GxBTBBKLKaUSen0PPlg==
X-YMail-OSG: 1deOM60VM1meOdd0F3fiGsXzpK61pn4dhLxQFouyTc4lvsjmlLpVhIbNEgM5Np6
 hvUMw5PeXSOtptM9wI1sxmGGCRszDQAmi7JY5E_TyLb.1WHy89H6hthkdexirxjX6eo9cX.yBBix
 TAbt10SE4Bw5EgkFYCgd2yimo_QQI9BzuvGiMWCkGNuGXwV4nzzMUuOuLBWExq2.dvzdf5kfgWQK
 zSzPu0daTVNiq.5LcUQx.iDJEZDuSLQqqZJJ1akoCgtaMZ4d0Kvik4kp1i1QdHAdttpRpbTBliBg
 Md7JjQd1ogHs0Pyoy5nUTWBTyMEaI2kBxqQj0H8kvKSKgPWn198vR7ozWggPuETBpN_7EZCFlkpo
 zGqXuwd1Csr_3F.pXrpvx4A1QAVEyvf6elyW9EJ8dKi3rL74jNz9bRnknNorXHPIKR56mH1gF.5V
 Yc4jMFBnkkXgJQmP2H1oAgOn.kzPz_TPqXxjMhIfoxSizEaZ3CG9_eYxROwNJ3LkRBZspCzW6pJQ
 t12CZ5UR3H3tHHv4FFCCaOCxHlE3Q5_Qk_UB9atja82TRXaaisjLk9FUc8.UBO8HGnAejzDP3E2W
 sMBQwPTMHbsGzgwuKLYS78rGSXW70g0EKDJkqU2IdVTLzkycxd5hPgH5EXldSFI7CiuXTEzKkV2K
 B0anVGyOq3_J0AV81iWeD6OQtQJ_CMPdXhCmyE0pe0h22Gz7GZzsNcXC247hKTSGZgjWTEnySVBb
 1wxxxj1wb6aByF0npWD.NvjaXXjKOc0InDESewWLryXHCdYXFbgll5Pxh96O_ZRKtKUGKW5FHG9W
 QL1UVEEbMz7AS4PJcWkybDqRt0kMkj5WdzsTsUIFvfPSPRIc_Xey8hxWOMDjOJzN4G6WHWpuiPo2
 pK.hpC.uzte89dn0YsN.g_uUBY90S0_JSTyA_aIaPxlTrPTpEvXUodICmeG9.PBaT.F1J4RzpD_s
 T8_kmlpAF2fTN7P0v0AMjXCD6yHS8077r9uUI6J9UNanY_ApHAIaMZ.SkKHzDz7h44lAyv1ppveB
 lsBs4NUz0KaMv17ery9ei4TgVIkyURU3PzjyIGcgI0NmtdyZXg4EJlUKVOZB0VZD_wV_F3j8OmxZ
 VJZG2USTZ7YNExtuCVWFcWV34ApMFVjiSoCG5HRD7QCeyck6YJ2cms61u8BTxxjIVjN8D9XSWcgm
 uf401htprgMc8amcnJBVfip3APP4M84mul5ltX8ZuM9ZQdINTzBxkjvC8.oAG9ysKa7f90BHsw.k
 yDs7fpcC0YjQMcKuveEyK6c6opxPtuRPdjfu16rt4gm2ohg8Gr24GTYW1fho-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:11:54 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ab3fd190e6a3abf4e978ef414dbc5f7b;
          Fri, 31 May 2019 23:11:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 11/58] LSM: Use lsm_export in the secid_to_secctx hooks
Date:   Fri, 31 May 2019 16:09:33 -0700
Message-Id: <20190531231020.628-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the secid_to_secctx hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_secid_to_secctx()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 5 +++--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 6 ++----
 security/security.c               | 5 ++++-
 security/selinux/hooks.c          | 6 +++++-
 security/smack/smack_lsm.c        | 9 +++++++--
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 01296e4ce474..433d98dcb928 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1319,7 +1319,7 @@
  *	This does mean that the length could change between calls to check the
  *	length and the next call which actually allocates and returns the
  *	secdata.
- *	@secid contains the security ID.
+ *	@l points to the security information.
  *	@secdata contains the pointer that stores the converted security
  *	context.
  *	@seclen pointer which contains the length of the data
@@ -1664,7 +1664,8 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
+	int (*secid_to_secctx)(struct lsm_export *l, char **secdata,
+				u32 *seclen);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index c283c620efe3..03369183f512 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,7 +26,7 @@ struct aa_label;
 #define AA_SECID_WILDCARD 1
 
 struct aa_label *aa_secid_to_label(struct lsm_export *l);
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 1546c45a2a18..ab4dc165e43e 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,15 +81,13 @@ static inline void aa_import_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int apparmor_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
-	struct lsm_export data;
 	struct aa_label *label;
 	int len;
 
-	aa_import_secid(&data, secid);
-	label = aa_secid_to_label(&data);
+	label = aa_secid_to_label(l);
 
 	AA_BUG(!seclen);
 
diff --git a/security/security.c b/security/security.c
index 60dd064c0531..adf4cb768665 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2002,7 +2002,10 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
+	struct lsm_export data;
+
+	lsm_export_to_all(&data, secid);
+	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, &data, secdata,
 				seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bfd0f1f5979f..16d902158e8a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6301,8 +6301,12 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int selinux_secid_to_secctx(struct lsm_export *l, char **secdata,
+				   u32 *seclen)
 {
+	u32 secid;
+
+	selinux_import_secid(l, &secid);
 	return security_sid_to_context(&selinux_state, secid,
 				       secdata, seclen);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a3776501965d..809af981f14c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4433,9 +4433,14 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int smack_secid_to_secctx(struct lsm_export *l, char **secdata,
+				 u32 *seclen)
 {
-	struct smack_known *skp = smack_from_secid(secid);
+	struct smack_known *skp;
+	u32 secid;
+
+	smack_import_secid(l, &secid);
+	skp = smack_from_secid(secid);
 
 	if (secdata)
 		*secdata = skp->smk_known;
-- 
2.19.1

