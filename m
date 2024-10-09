Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689E1E3DF5
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495761; cv=none; b=PGQv/OSPqZgrw/PaHjhsyTgTDbzDmwrlx1dA6IjsWwdQ2/UuEb1kfqO55z1wzKKIBo9Q032l0gFzuIKxbXBGT1vSGStD5dgbeY3lQ/0B1Ok7mjg8PDXW5EPvWXzGhewGu+dRaylqx7A4wiz0v62E/E6xzhlLb9TmPJJqMC2EqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495761; c=relaxed/simple;
	bh=L+nT5A49Zpad39+W45iDZCJnvqQDLPCB/43/jzoByAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZgF9UrY4V2uomwSwWFy0wV4bjTgoTPBWkqz3OPx6ghL47QEP1X7JKhUQBiYuaCDvoHoapfmUDoV3y9cup3RBFH0qPKnLj+79Ri/BoPD228cvPGu7f2dfRvOckWoPFHTu5VBEMnzJ1ijXEAlcRZbfg7qCF2udkFJD8q9hPLN/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tbU9JQai; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tbU9JQai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495759; bh=Cpk51SpSswLb8zqj4JWU2D1YDhH9z3g/tkg89qumsLk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tbU9JQaijTV2gUzeDZEI2GylePl+qqTQ/7Icmv61CJHcVYQkJNt7PY3EVBNawf09mitZyV9g3iETF7kWOQ686iP/khJNdJ+V3s1b8m45tdZ1X+rhoEjusfAP5L3qglZdai0IRaVNvkRCSkIeQytjT+Qd88a+REbVokIka6eIs4VdepBsp+Z4LI3NtkTNl6gt4ZxyPyyd3SaW6sGSozJ2yPf+hp9s5TL+xhBAu+DHhHjDM/PeGH/aaO6QxjFuV2ZG6MkWT2LWI1RG9PHlq5tekp0bbDsjprcijMuVrooCYgPrWcRH6GxUEwNkT0gLjH/D/4pMNrxgxRuLQJ7+UvetkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495759; bh=MVmbfNqtkDbbWR2nMvOh6s9lnlTnH8EQKZoUWgamG+X=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XLDfAuMIe6XWwkMnzlAOH8wecXe33HRaesJnV37l7GEkr75pHHva1/B/R0YoTuL4/j3KUjfTej4I1D11nquvBd0pkQuUQEynv/SClHbTmwy1Ot7nFDxCRnn/Q2BYVvZJ0rpdD/eY0kCKZ9HVbNGRtuX9J7C84Kdokp7t97JItmT2NMxof9BKsdLsbaZ+1MZ+bkqLS2eWEja1WBg5UxrGLgYFiSzr8dfKIja/knukzEdWQu/q3znvfnRxR/sfte9xBJN/nahioK+by++QRZXGwzwrLQvEWiku0RriCJfb6BeuaMxGFbkYZHd/ejHdty1ylaAp0srDfjcgSFF4yN5zpg==
X-YMail-OSG: xGfZXK8VM1nvmTgwd_UaBD4ReNZ._fOMXmwDfzKyXGsXsZkPgUz4WCmsOydQjNN
 4vPt9dSTRoQtYJOaspB6d5Vxt7gRcS_LHYCVPDRJY.TMPhqj0f8_wS0AiVXYiIYLmaWAZHs2MD_C
 n67_zx_I2oK9exXzOvJW1uTQFAkoglkFBFRhzY9gaVq4nVFDqkUogGAd6Idb.3g..sFz2a.eIho5
 jvVPmm_ViIYNdzPnKpeOfQgdapQJXbSMhE57WhQ0vuBYtnLAkMExqdgRPqQPF8dORJQId6MY0UK6
 HhvLAnE2wt6mO8U8OOrIULom7Ekm5F7ORn0HP90ov5bqPXyM3oAjmlAy_c1S6UWRKRkbNGM_rUNa
 0ltcIME83TqKTBFF8MCktfZjVd2zt398nXYOLR5leATatIINN3X5wcnxAfjd69AIPSisJPSSr46B
 v01Ipp9lnqF9zGCzXlBdV1iyRyYhjri2rvsYBRUSSgoQ.VbULidPoCEOwBD7CkFlGxP1SK.E6vCA
 3vebnYkCsEUpJCyHKB95DZmZAGCF6nGHSptaaxnI2MrOHnULI5RQDPKCxi4xYEgWFCQt3Wp6iSIY
 2mOFkO6Hqwg5kkkrLJlc1uUtnd8soVgnOzJ9VLtg22kHZ0GM6YT9k.YbELgImAx626uAnL7A5k4T
 5m8wKPIlFc8rAd3rC.z._aSHt7y9cVPZFqQMxnBsEre2NsC8tl6ENITEE9UoEtwglxrg5YGjiL96
 GGbKNksBr61Oi4eKP.cCW8f8fKMeEexWqhCGl78gnqNYR1Lw3rLPtoJTnZ8uZYGRdTHxt4mxBXzJ
 Gxy1BnT8VjQ_snioDaq0MBDbf2HgXbCxnhuVxPROtffUyphi6AnvhLAjajQMMix87wpbA2E537y0
 GFN_9cXsOk1zLso_w3vpu98OaH5RYpYg1JGto7sy8xqoEA2mVnwuUkLZnP10IJ7AqwGxGVZ7azDg
 _Zzp1M2CFUs.0gXlG.1Wd7bKE7cFnnLLPb6LG2E6Dh1BrDQSc2sFp9dSeWhdDLPS5yXKvidL_e5f
 SGebjGZ22EsDa5m5KM4DgCN_DSIZEhPPKM7Y03YaxVFNx2c3Inq5f22Iqh1YFMZouZzSa1_TDsBM
 0.3OMm5nnmUWek24jddvy8igvzy8MmTLTBFCKh7GbNeCfvTrwQ_eDzHOfftJa9vrDLtej6_5yyIU
 SsK7lffHANSZ1DHFiSwfftOBOMfb3Vhdzjtsfkj10C7od43Ty9cvpSmFh92K8eXtW1hfghXxc4qx
 HI.hiLIaIz2Q76Ar5q8WtzKwc7MMxyw5MfTFdoFajMpnul2vhtGVGZGbUXTCkLU_nztNmBGhhp6q
 hqzj7AS_I8eynU67b30le09uvK3llVHgu43Cl8zTRmDDc9Ct4JBTl_OCZR.WqfWVQ7QTJknHNUE8
 9EcCHo6btWJMFebbqEBig9_jUYLrFe5vlaOFn95GAUNIe8s8Px1TkeJ1QR4_A8fNE_SujcDCLxHX
 ESTAPLI5kkUhtWUo4aa3tmcRlfJBw0b55v0xFupaCs8Uy3UhcVCtRuqtltAbWiZRvhCDQT1KO36v
 oIUlXYXmwNV0kH6w_gJCkm.d0TiLhpMbLv76FfTvP8hxx.tGZh0mPZXjC7zd6dEvjbiXlYIBq73M
 R_FHqig0nECUxCNFxwlbuPx2IrIWclb9PSp3_ohMR0A9QjWCIj6uZPajpgKRTWdNkvE3tEpuMGxq
 GryErj3Oz9n.yIt3xwtyv.nyyMf4yJYF9_QyFEUENdIuifRoXFdmm563BMRKWSb_6q7tbGsN.UJY
 uHx87Qas_KIvp4YeZ.j2fCnN7.AP_d0r3xhRY_abk1TA4FKeefPl2fUPLAXBEbJ1j8L99CTzQmXd
 JikX9JokLUBndEo4dWdFsv6R_7ORRePmkbYVOB4LihSovcahLlggF1oTZ5lWV7kJMU0YyKSyq7Fy
 ue6V3fizuacOc8Nzs5nfIg_fFZi20rrhO5ZrIEvayCfjtc_qBwFwxTvKhOzjs0MwdbYdeHfiwEJG
 oX6FtBxbcwHfyf2aECPTr5a9n3aAYC4fyNFruf1EGYHNoGJZL7zLrjOGudDBOEYzf8UsVuS8CgoO
 kfdlBtKbRRhPlqbwkUq1uIt6G.lzQ69_mlXpGRNsg7QB5j8E7j7Uoe2LwEe5SHV3Adt2UHRPSqKM
 1Z3R077OZOanHJIbJKKyCwNRC93L4YstuTxsoWsFTgu4dU8sRbL1InXnMFSlKNvl8nwEErRUv_8D
 yRm.Ox6e4VNibcbviyEA30WyQlzGq.idce.Z1ISu39HKXikDMt2GgvHXeBg8madiy8Xqqga7a8_m
 yiHVloFPKexxOVpYPByS2oVki3UmMfWU_gbVOAwM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c36f62ee-4271-4f63-80b7-9b25354e43d1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:42:39 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5fec0e30966313b56a0d7e944fb52df1;
          Wed, 09 Oct 2024 17:32:30 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v4 03/13] LSM: Add lsmprop_to_secctx hook
Date: Wed,  9 Oct 2024 10:32:11 -0700
Message-ID: <20241009173222.12219-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new hook security_lsmprop_to_secctx() and its LSM specific
implementations. The LSM specific code will use the lsm_prop element
allocated for that module. This allows for the possibility that more
than one module may be called upon to translate a secid to a string,
as can occur in the audit code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          | 10 +++++++++-
 security/apparmor/include/secid.h |  2 ++
 security/apparmor/lsm.c           |  1 +
 security/apparmor/secid.c         | 25 +++++++++++++++++++++++--
 security/security.c               | 21 +++++++++++++++++++++
 security/selinux/hooks.c          | 16 ++++++++++++++--
 security/selinux/include/audit.h  |  3 ++-
 security/smack/smack_lsm.c        | 31 ++++++++++++++++++++++++++-----
 9 files changed, 100 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ea7f17e37756..ed6ea0b1ec57 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -294,6 +294,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
 LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
 	 u32 *seclen)
+LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
+	 char **secdata, u32 *seclen)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
diff --git a/include/linux/security.h b/include/linux/security.h
index a4f020491e7c..f1c68e38b15d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -535,6 +535,7 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1488,7 +1489,14 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(u32 secid, char **secdata,
+					   u32 *seclen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_lsmprop_to_secctx(struct lsm_prop *prop,
+					     char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index a912a5d5d04f..cc6d1c9f4a47 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,6 +26,8 @@ extern int apparmor_display_secid_mode;
 
 struct aa_label *aa_secid_to_label(u32 secid);
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
+			       u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f5d05297d59e..a58b72ed246c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1517,6 +1517,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 #endif
 
 	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
+	LSM_HOOK_INIT(lsmprop_to_secctx, apparmor_lsmprop_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
 	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 83d3d1e6d9dc..34610888559f 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -61,10 +61,10 @@ struct aa_label *aa_secid_to_label(u32 secid)
 	return xa_load(&aa_secids, secid);
 }
 
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int apparmor_label_to_secctx(struct aa_label *label, char **secdata,
+				    u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
-	struct aa_label *label = aa_secid_to_label(secid);
 	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT;
 	int len;
 
@@ -90,6 +90,27 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+{
+	struct aa_label *label = aa_secid_to_label(secid);
+
+	return apparmor_label_to_secctx(label, secdata, seclen);
+}
+
+int apparmor_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
+			       u32 *seclen)
+{
+	struct aa_label *label;
+
+	/* scaffolding */
+	if (!prop->apparmor.label && prop->scaffold.secid)
+		label = aa_secid_to_label(prop->scaffold.secid);
+	else
+		label = prop->apparmor.label;
+
+	return apparmor_label_to_secctx(label, secdata, seclen);
+}
+
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	struct aa_label *label;
diff --git a/security/security.c b/security/security.c
index deab7f912e12..1842f1325e77 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4311,6 +4311,27 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
+/**
+ * security_lsmprop_to_secctx() - Convert a lsm_prop to a secctx
+ * @prop: lsm specific information
+ * @secdata: secctx
+ * @seclen: secctx length
+ *
+ * Convert a @prop entry to security context.  If @secdata is NULL the
+ * length of the result will be returned in @seclen, but no @secdata
+ * will be returned.  This does mean that the length could change between
+ * calls to check the length and the next call which actually allocates
+ * and returns the @secdata.
+ *
+ * Return: Return 0 on success, error on failure.
+ */
+int security_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
+			       u32 *seclen)
+{
+	return call_int_hook(lsmprop_to_secctx, prop, secdata, seclen);
+}
+EXPORT_SYMBOL(security_lsmprop_to_secctx);
+
 /**
  * security_secctx_to_secid() - Convert a secctx to a secid
  * @secdata: secctx
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc926d3cac6e..6e88faf3c6e5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6601,8 +6601,19 @@ static int selinux_ismaclabel(const char *name)
 
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_sid_to_context(secid,
-				       secdata, seclen);
+	return security_sid_to_context(secid, secdata, seclen);
+}
+
+static int selinux_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
+				     u32 *seclen)
+{
+	u32 secid = prop->selinux.secid;
+
+	/* scaffolding */
+	if (!secid)
+		secid = prop->scaffold.secid;
+
+	return selinux_secid_to_secctx(secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
@@ -7347,6 +7358,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	LSM_HOOK_INIT(lsmprop_to_secctx, selinux_lsmprop_to_secctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index c745ea2a993d..d5b0425055e4 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -49,7 +49,8 @@ void selinux_audit_rule_free(void *rule);
  * Returns 1 if the context id matches the rule, 0 if it does not, and
  * -errno on failure.
  */
-int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
+			     void *rule);
 
 /**
  * selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 535233ad7203..66da7cbcc0b7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4768,7 +4768,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 				  void *vrule)
 {
-	struct smack_known *skp;
+	struct smack_known *skp = prop->smack.skp;
 	char *rule = vrule;
 
 	if (unlikely(!rule)) {
@@ -4780,10 +4780,8 @@ static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 		return 0;
 
 	/* scaffolding */
-	if (!prop->smack.skp && prop->scaffold.secid)
+	if (!skp && prop->scaffold.secid)
 		skp = smack_from_secid(prop->scaffold.secid);
-	else
-		skp = prop->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
@@ -4814,7 +4812,6 @@ static int smack_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
 }
 
-
 /**
  * smack_secid_to_secctx - return the smack label for a secid
  * @secid: incoming integer
@@ -4833,6 +4830,29 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+/**
+ * smack_lsmprop_to_secctx - return the smack label
+ * @prop: includes incoming Smack data
+ * @secdata: destination
+ * @seclen: how long it is
+ *
+ * Exists for audit code.
+ */
+static int smack_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata,
+				   u32 *seclen)
+{
+	struct smack_known *skp = prop->smack.skp;
+
+	/* scaffolding */
+	if (!skp && prop->scaffold.secid)
+		skp = smack_from_secid(prop->scaffold.secid);
+
+	if (secdata)
+		*secdata = skp->smk_known;
+	*seclen = strlen(skp->smk_known);
+	return 0;
+}
+
 /**
  * smack_secctx_to_secid - return the secid for a smack label
  * @secdata: smack label
@@ -5192,6 +5212,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
+	LSM_HOOK_INIT(lsmprop_to_secctx, smack_lsmprop_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
-- 
2.46.0

