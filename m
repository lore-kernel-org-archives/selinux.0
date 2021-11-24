Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D24C433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 01:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhKXBye (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:54:34 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com ([66.163.187.39]:43303
        "EHLO sonic308-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236366AbhKXByd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 20:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718681; bh=EBxxjY8HejFxSXh3rI/36jrcmdb6/eBEzzs0STL4Jzk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=frr2jzCVToVgiH1Yy1dp47lO7otKY1VGlgXECi/Vp6DUWzngkaBLsLh4iSiOhxOvGk+7FsrsIjD/eaMQXpWRgL40QRtUF3zYoAXimkYWgDyrjCeYHKVw6VW05hPGTrq/gcW+vzgSzGLSHj8lGXgZHKiqjJ8gBfyDo3ilwFJfEKHN8IZTK0aHbDCW4deJoe90tpoiyuYZCenCWEDD42J5njOnz5jSMsmkfu23MtI4JpOcznYE1HaigVG1V56Gw0RkMrtwAzXPrjE3l+cMfFJais2Od4+zjzFoexoqm3o1EBNIsI4JYId3Ql7OxlVpBp0YFHjMfxIsF0q7I5FlEb2+RQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718681; bh=jpJYD2zH5oEMqk9iGd3KVZ0pavAkPNyogBAps63gZPY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QqSVAtQh3dw0yQGqIlOWoqCxb/Y3/hY+L5UGNe5RQ7sSUW8DxYO+zXK1CWBnMXneJSLT7n9YLCrzXFS9yeNyp1tHiHMktlJuyRQ5QyoK9Dyt4olzc1i0lczW3FD/Hv+8m/qrO5aZa7mR9scxLOlOG+ImoGqRIXit9SZ7B+GC35EkKvYFH7n61dzKjy57zhCDnGG3vXMLKAeU2uK6UzUv26qjiZffja685RRkob92vmOyCDFFkUvHO2kDMc+xsm+Zws/8g4tLt0Lk71Mul5JY/a61oj29omS443IjRWen7zWb7BTfMlxvjZwBRrEMzdYGZQjp/73QgRMI35ecWRqx6A==
X-YMail-OSG: 19onif0VM1ntavtDQ7sSB0Cxu1TzQFMGv8BQ1yXKXqAQ64_kwJpsnBAtz6yda3R
 OqEYE.iIKba99MdJZFNBhjejQiJDHZhPRyFtHOLO3CdAY0CcKnkOXGr4dX4osSVv2hMRPJbBl_Nw
 0nJDC9JnBTJj9LptgJLrKb8RvrlkAImC58qeaixHCgCb3rfMAAOVWIibMK06SpCve.4uTJHoN6_g
 8yPLGGPidlYvqAdyfaicbLWwuD7i.h1OXMf3chbknJu5l9HbjISFdziJ7YlHSt1kf3Hsk3rMtm3R
 wzZQOWjokZbxiD9iZOK3ZLv1eIo_K_KU_Iwdc1kdePgBhfBomqQ9rlnViRSMGb_Nufj84_6ONkAg
 rLisw_Y7.NT8bXrZx.V6AOBBOLMllwCyhd7Rn1sFduCVXaYz28Fg9s2u7ry9uyKLaFQY.H8F5mEg
 vc7K7nT36BFXINptNqVFmFObIMibKPQXi9vG0XZCyPaYBcCBq9hflJ2._afm.f4xewJS2SrRnm.H
 TCWRCUnS0mgCNrBp384J3OtVxgt6RtiVpeu0e1FH8qD8EELp2JuNuSFzksgiMMqRuJXNd1Mhsxz9
 QKn5yQy4WmKshguAF4Q596PUU8yOBYQIOmbTgwQT0JEKqk2fUw6ygphQi.sR7ahmh5F72wG.H2vf
 aYPvWAcrI0obQlhRdOPALcOyLzp3knb.CyL1INT9i1XnAdK1dQvhFC1qW1zzhHeCa8_82iFKGOoH
 3K7_ocAFUMUyBRdSOZU6rG47.o3vR._07DIreln4E8UpDr6lKUofYuM1JKQLaTTB9Yot38zbmav6
 EWb6ipGIGF9_6ofEl6PDMrbofsKf1P56ofTG1AfF.hR810Sy31likXM8znzSgo_P22WYzTVkvhNy
 PQTT1.6XO5lUc_MJdj5MRAOm3plcN09cyvGp5KJviWBYFO9JsasfdWfpvx90ixEo778UMpJ2ktRz
 An.xt9cigRAlv9hc79.k.339A9o5EHxRR_fvreg3X1_BVfT3aiYVi8bzA02lOfm5eWVuyJO4w6RG
 LJvxpWo5rElbztcKZzDuMqqo7LUL_FgeucgQp6LLnssdoWzXBEOHptcC0RoljvQ2tZTVbBFXKnt3
 AEpXn1lOs1gkutoEGLYyVjQD.5DnaVbTbXlG75XSE5qtOH8dgI4hSQdZr6TrlNFRuKc99bgq6.NZ
 2RrUUdHh43jF7Dl6Q2F3dyqUZ2oto6OqEFR4haYN.39b6G1m2ZeN6lL9rV4OgH4PeK_yk2KzyzhC
 oy5PSqm8lkzWD6nOhYGbnxBtn9ODh4kSNwE_BQ3zZwWaJMWNS1npqtx8ThMigqVBHwiTv90MuGrM
 uVe.NtFe0I8ZPajyxPz_ShczZ9K8lYeF3BDpmU10GJclcPEWhP894c6rHmf3OBwq0b1cKVRigvef
 0QQLvBWmJZbixgpD0csP27kq9e2hB05W89w2qBf_ckO7sat9A5Go4xEGFDLS6RtD5pzbwX5bEEVo
 pTr.A0NCMNoS2ELhwzV21ImY3dk78z1asb.kPPhOXzfcjq_hKuw.gK.F_URFz8C7yfWZDZTbxTAI
 uIRFfhFHBnx9Ra1oemjtlePyn.p8napk8A5Hp4tOYDWXWhNLgDEdvUtzbTOXKWUoRRKEVKofpa4S
 SA77mOW9T73ZjMZHs2CNLDsWbLjDgJmyUgwEK9XwGlaU335ljwWBD_1f2nSL5OM3bP0LLIuC6a2Z
 L6E7UkDGugWE17740eTSsOLutKmGQRtTXIr5l0MmsdvUG0gvzWLc65.wJs9guMiMCLSm.72n79jo
 fVosvXI8QdISryueZZEO6d4I2SWayMRcXSFQ4IPyL5it2D53sOxmJbyxUSEqkO0O5LRHfbir8lbd
 XayjyQVh.OOi.clI3brS7c7T4yNAjDXfoqtkj8kybagKyMXbqj8uEbxzP1MBKD1Ky5.Z9gP2xiI6
 2Dv4a0ZB3.czqS9oqi0BbG_q.wIX4z6CRKZHYWdckKpOnCB0l1MzGptwUK57KQ2IfokH7Q0dpWMJ
 h6SK_6x01CSKVjlSopMerQFyGyBL7xadLSEWa1pEDSh5DRdieDG1ISHRcT8zWKUIFHtoRRy7nzwr
 QbXoyGSx0jlwiMLnUJqKJbiHzT04xkQ4PkXBqIC2AI85YJ3GFOt.luV_dfTM6Jl8GQr1wqKSY.4E
 6qx1rm6hLJ_PFPbSgw4.4scLhmepbV3rFt7QqvkAHJ6U73FQzcP1fFlwVqH1jMl3bOGI6kg9pKjR
 9t_PVUasDjti7UsGMz22sWoqm27A6
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:51:21 +0000
Received: by kubenode524.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5fe41457cad84811041d12332dccb872;
          Wed, 24 Nov 2021 01:51:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v30 07/28] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 23 Nov 2021 17:43:11 -0800
Message-Id: <20211124014332.36128-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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
index d846d90f5624..e6dd3463604e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -464,7 +464,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
@@ -1112,7 +1112,8 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = 0;
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 473d17c431f3..e5e41bd4efc3 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -772,14 +772,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -795,6 +795,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -802,7 +803,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 238541218ca5..f3d30ef512d4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1800,9 +1800,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

