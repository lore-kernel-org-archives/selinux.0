Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1505AC6377B
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7ED360FF1
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGVAOL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:14:11 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:41486
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229818AbhGVAOK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915286; bh=C801dTzIhnDoBWWUmHprUDTM6VkmEQiqt6XqiHlC7oo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IZn4bhbCHh197v2BuL5YT43AtPF4o2VZ4Ot0EDRUYDQ/vLPrOtuzj2yAzNU1VAHVhkHfw0yZ6Qltqeys4cJeUfwqftotY1uMoipWxXoPAgUuCM77gfoOyIa5OJEyrBz5fsGWO3asjrlWjISoZ2+X2u3WzUy/VcFEQUMp32w986BMBU26aaRgFLuOb+Bd1uHYbR9v5FvpaH8TaL6W+/AdA+Na/NbdszVV0ir+tNxKRoutsLTJ6r73Q0IfwK2NvXWxg+cOlGgB6MF/0P3qGW+BYrXnF80TPR6ffBT9GELve5dctKRbWw5I58KyNcxXnxg6DCrXjFbh2BNXyzhNYwkEQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915286; bh=z3Wd6GxJNFfJNoDzKmWS3H4na/rvfWASlByQvt4EpIC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eiIzD5d4ouw9iEWPS3FS0vAEVg7MWs40FqSK4jyIg2gtZO5eMf+mES/rIZDj/AH+zMF7y4dBfXjDN1TRy0/HJzF0CNg4rzFhnyOANEaPxKA1TFI8G0YC3belXfUZnSIs0PTPW2TPFGFyJGKgjOoj8TS26iwwHDBDgjRapkfcguKgR2RynaLVxCHwkgSBi9+UMcIr0Kixe/Z8fUlNf05reWRlPC07ycA+W2QAXSOWYpTDhYxrEg/JjjZ1/FtL2G065YZqnJCok+hrwn3KM5eh7x8Zge+fLI25vJ5wlG1mqVTEK1IzZsCRVu4QY7i+YHVIYbQgVozY3c01khoeBg4fjA==
X-YMail-OSG: 4cRZWC0VM1mAUJx.mN72Ta7wy3gU2x76OblnxoKi3pkWh0QrJZVm11oIRmRpiZR
 8zQYBRt.NCygsyhqbMHPQ8tGqHWnahtuKBDze5tdVc8pJx8c6O0T6mCfjGt0Ws2t5z5sXBH_o..w
 vHNOwHH6.QS4mF6J5XvSUbjTZl5l1WqoDfIOzCoY4fdPXD_8cpWwJfmInEvKDISUi4Ww_lP.WPrI
 IEq7WRCOvpzGjfL7AxHHHZMXjvAm14QBZHDDjpDYxJ2rsZRe0b5s1grqx5y0QSkYwekHtpjJ67rw
 HrtRTkDSPI.9G5GabYDfBo5nh2Uo4q_ib9uwX6BsylVgd3bwaDbFmOHRz8fpUph7FeVDm9PFaYe6
 sj4MdbOwYYsV_qQo0Wc_r7yBkbShuym0Ird3VnIbppOWnZ3KF66ldeGhpDswVVVKjzllWlcMc3tG
 ISR5YCG2HkefOKArPYXG40RtzSvdUxvK_4VMJ0Ic79YBMP76vIih8.z_oPKP3oesdpl.rI0YC9xj
 lh4z8013c7TrTLIBc8MD9yWmeR5aAg9YzZed5mWzyqzMYGJcXoN.n5DtALQbmUww_rudsc3yzlTb
 zFdgis7Lu5.7Cwpk2pWdivPOah9eUOGcqvVUuFreV5I8bI610TEzsz2SjaR4EQB5Zst6A_M27NN2
 yDyqB82wUGmsh2D2zb5lyWSoos7ik5i.7HRsIMlSnk7L_MaOFpWedKD4ksC83l5VS2M.eT566Ovy
 z1frBqJNdJsJm5BJvKVUQ2uBEqmGYpn6ip8292bXf3hFv8zX5crnklk6xZyNl7PXVCeKntVKuO9q
 .YpsTSXIf25QiJne2tooIKfEZUyLnCWMoZe3DTu7UPXgfStOrtnDqOo.hl_IWU_bBN3Saue3qx36
 leMFU4zK7WaM1Z.9CPLhHWkxrj_k0L1kLXT6bY9JKzK97hTSM7rqhhiPOtwujDOJa8K_iQVbdCfk
 VA7irrzG_yMsIJXz5QdFNyOZUoPvWHLTTLr8Gr5xMQ9VUIfAZoq0GcmbaAMBOciB26cSAjeIhFS8
 5D966SzsMYJKF.A2b_Yn9xpa.UJ7lsWJHVqjgEDqCXsxiGzfiAoA4rs2c418pvmRAzs4EToDTTks
 1ZfonwejgLmxUYfwSciPEI1QSyH1Zuzs294vXaMHxhI8Olk_NYYhVqEQcGymeChq56CwDmLTPOqR
 WgBkn2Q4UEVnw2NIF0dhvYZLqF7qZaLmIWBXUC1xBSUAfRT6ln9VhJLqso9VLxcP6OTFa6DygJEL
 PfwsFJjoTI2AkLZZ5eJxIxLS8krTJLRZ3gB.dbpLV4LqZ8aDenQh5Zu2aU7AoGTS7r4_xMiEelzD
 xgo5FgSQZhftQtUn8DhssDtRbGmC3tG06oexOHiGskxvqmACeqd6hoko8482sVjfU6gOK79eJy5W
 DP572jiZ5zR5KEGe0Mcan6KVvYSiaVBPGQE.Nc6taz0sCNXuaLbYG1hmH6d4An97TOxa1dkgkKIi
 TwT6OpWRWcTAup11gMEt_6Gb.Bx3b6b4k0AwJwNHI0ViR.Ah15wKuUfjqx2K.l21Ad7B32gqAUa3
 IgM0WK6LBx0L2BrS67943jaOtnzQJfFHsgfnQMi..yp69dhC9TekwgECoyOGYbShqNjUZk8fTxNa
 GOTxb3jV3Em_mN5NrgTcRN.TDwofGUV7sjLPB1ydAQgOpiWOSvU.kmGLprUyp3Z05lV61M3OS4ET
 mxYjb.VoePJRKRGlUo3eHPEQ4Hyf.EJpYBryk0sag3m.fN0Nd154SZSEGB6Mu7VVgw9YzjQFTMVW
 2837s8oHOiyTaQBHRrRHjGipTIHTouSicneKwHoZQa7ui8_5kaIp2wLfB7UTLk70I24Q_cz.QJ0X
 cTJBNRXEytyLZoxhuzTGqZU213UzKXpZSawE810Z9qHwsGoBDhv4lkokzukqNKoNroWiLdJEjeD3
 R4djDE3_ahO6a_tqjzuYPkjS8LVM9qkzob2dNy3WTPVpVNPtnWMPy1Rro3Rbt.uRmFzObIfz9LyL
 tYtBNwSg5djPrDXVo9p6wi87RVdB5.uBq.ESfs1FXO3Mhnrc460RwxEKx5oSHg72SeGYSvjZHNwX
 MJpJHlZKc.hSyeIEjFUY_r75Lx6dtEvs_EOiZKX9vL6MR8w.zfo1Wpna1LxNWYGq.RNavvd_u0PH
 Vfx.Rm8HLelXjrV0NW39dhy8QPPTGHHMcyqVwlBXZcfQdONZ6tkvPq9VSvICtlPOsz5DUI9Hc8dJ
 BIDF6ZmcXpBTVaVdKF_wl06bzKRdRtaqKvJoOhjudZ3HOrUc4tBcH75.eJolpwXM_zRD4hSP0dCi
 TxmH5fFoe7M3I.rRw8z2Svucyka_Q0DzZTJh_Hp3GZXa2cBhlgqs_AnZ_AyhuHjLqAGQ8vHb5ZH5
 7MwzXTpmDIgOtZiexnX0Y9D_BpVXecPPGfJhXHBEoavE41tyqkeKT36L0JskYbiTC_3XgWoZZCCh
 zWApM0q6x1mpjpi8E5hlj02ZivAXFiUxRdLyzxFrIVBHBQcWs7ZNWftd_PcO0D5l1SwdXsCb5QFG
 rXy8jHMv5Rb7Yh0mwo50B0xhcu4GuJUv7ibTpEqxCG0MLO_4dhVQjbTvUWk3LHz.E2yCsjGGmyx2
 Tayy0IJf0hSJC5KpY.YxH64FnSobYJCRLgVQhs6sIMV4rn8G.jPeyMJi_B5FhNL_TPcX37VNUI4b
 5mQfqNBitHc0fUaf0cXxWlaMUE8dzV.H8ZuL3dgfeQAI.aAAyy1DCYMv_JUEyjirziYD72G8QU68
 7NFwIDGlRTAVifM8R4u161d_VCJ4wdATGI.f2kwBepKWjZP4dR.OfplC.kFXVPcqV2yvktvn.6Vs
 UqOrkkWdtbXW_9hHNyxv1do2qxKzzMSkDvoFQOGK.LNgktMEOFfKNUU7xP.iIBI8sKrbM6D9yUBp
 GYU5LSEQK9AHGaTGLvAB3ndijN3EgW5Oy_6JuKamFg1KFZ8lulF_82VyadiXpgU1BvM_0ua8I2e_
 QLtr8fzdBIt9fNho3B5MdUrrLN7pZiB1U7tTUKM4sw1F55DhP1OZ8msu1B3NRX1a6mU4f4tzx8ap
 oZJsmZpj93P0wbhpAk1Ir0D_j1ezId3M0i1VbfjpRPHpUD.cGJHRY6Y0T6g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 00:54:46 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID bbffecf312ba1b4a2b03f03dacb2a286;
          Thu, 22 Jul 2021 00:54:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v28 06/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed, 21 Jul 2021 17:47:39 -0700
Message-Id: <20210722004758.12371-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is updated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
To: David Howells <dhowells@redhat.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index fcbc6885cc09..eb02e8514239 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 8290f6263b6d..332df8a1cd4d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -461,7 +461,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1103,7 +1103,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index e6fd2b3fc31f..ea36ec6e1ad8 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -774,14 +774,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -797,6 +797,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -804,7 +805,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 3c035faa2c37..69474918be8b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1798,9 +1798,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.31.1

