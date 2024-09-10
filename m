Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B071A7051
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994305; cv=none; b=R5qyGrGWkwGDqsLM228657D1BRf0hoJxWgbZpIbqPE0TAw+kRnso1KPG/x4uL/ZW3UjDKQsWEY5BQVSaO4n7RMas3+k91mkZSlc76fU42bhc+kYUKe472lPC7f6tidET4dPnLMe2u9qdF/kW8PjLXjyOxkmPjSp/qGu8mfFQ+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994305; c=relaxed/simple;
	bh=ejnAuWIHVexXxu18WYWJt5kKSKxQqOLzSBGyObEZr2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5WvWdir1HS2eALQkWBLZ08dXMbw4g9+UN8ZOcnJFubgsptrmISEWFaNN5nX1ilr/284meuJJDYebcCrtkTuIArc1FOZ6AiyK1HdmJ9HVSGemMmtt5HSH0I/jq4QAwbGaCSrivH01xVRlNrn1bynPpBxwSZPlZRDurarl+oN/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JDxciSjs; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JDxciSjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994303; bh=yetfcEk9Cj1mlws0zXp2G1FIRM0kq2ASdKolf6IS0Cg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JDxciSjslOmGjQ4xGeGRTskTd2PEUeDkR6N6/EUrnMOBYhWow39CTSAPQ8lpLyde6zfFG24I/sRNPGihwUbFnenZZs6xVnyc4G3F3GmzeS9+TzC0+0+Nf3wArV7Ea5bhjU2EKbrCvM25itIef8aPCw9RyAKRF7QcXljulRcdggF7+kKaWoS5TEiqE9/O3nY2kKWzBPt9dUO+x1z8H0XjE+7uq2zUSd83DiypLM9FoEQIO6sLRH4dyba0BxKLvbUSuD4mJEic3Js4Jng6UApYo6xgHy6IRMpQ6KfWd58hGFiL7GwUmxY6i7R0a2Ou7cHE9PIvmyj5d/NQqoWypFFyJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994303; bh=x5Lb3FsjiIllOQzK3cLM0XaG6/hXXV2IlE2zDal3lzk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=uQSisNVMR2O/YKv2L0RDkFl75Llfsu0If1pDyPCMUWK5IcZ/LM4iopgGgXHct8pYZeyPboA0C/16HTqaTpsyaSC4OQYm1jyWBqqYaz2f23wLpIKk7iRT3nrKvlsluW4w17bS+6qzK9gc4Ca1lTQy/Vly7IfSkn1xMd4nWqIeswCUzc4ELqON7qzzzjJULDLSFCSV7MSfAOnc36eGz122PKVaKuA0rH2a2LsElp4V4RsV4SIa/g9Jy/hKqx7MO3PyufbblaN1t+DkvCMqQ9/viuYg4IAgZO0dehMXFgeE22IcfNkPV99qmBGiOeYk/bWBtUau3FDgqMyCq1uNcis3YQ==
X-YMail-OSG: FAsP6LcVM1n1fjlt588087qkrVLPc4BEyzb732vSi9fMnmKhZsKJLjTNnBEFcFc
 YpbqKCspsD1YpBR5WfyckR6bPLP2kLiT7KbU.G1aBZN.3m5kCU6enOXhCD7rX4ilPoWWozZ4pcBl
 kAPpibwXPepZfRhkVwUOo432juxuAMoKyrU7Citm6cVuggmd4YywYGPv1McyU_SClAPN9m.giq.k
 ZYOG0vbA0broseOJoEADz_OJFBcXgMnpH_05JmF9d9e3PiqI5uJshKvM_ntol6DYgrmNh5D4B.PN
 ODHjvGSKpTsOhQyEBNYZptB83H42LQySFHCrxURyTbzRGKiyTequ8FZ.vujlL9ikvwy2NryKBbZT
 C4dl8t0.ln_4JMK5efGPfHkyryGW2tu.hG1TiSxVmyuvYNOGsYNxdPQB0dQQaaVUaBEP4.UlHQoF
 7oJ.D.mNFqxid0A2XwNrhbaeezU8M6f8IPgZya5mhBqszxJyvR9hD8Wfz5IcqwAMSvaDPXZDcAT2
 JpanjMKhKwy3hEUNadREuD.O5e_Hn29O4QtteqPqhATJ0F9MnLxdrnZKkpKBE1BEi79REkKjdpk1
 g2hZjBkdbBl.acBjt0ZFp14JaXRvgA6DS.iIBNUqpDJJoERBvxs12ubPSBJcqdR.tMzLvccWWJ._
 snT0rn64rtcn3JGeD3NkWvF0Hdw9_nVzRHA5QwYjLwd3okKw.gbvBRTid1RaLyyDzW_mbXSNMF7W
 ufLSGoPy7dfrQIK6PiLDKVKR9.IZXcARYpHWswIOVr1WKp2D6peu0IzWl60_XrDAkjM14BCa5PNc
 5smmZ5Z5U9Gu0Uzf0LTTbmwbjExMlyl1PsSphBDrxM46yLvh7sSDF13.8Mdd4EO368.Nto5Z89td
 eJTdNRyaOQXa6ero2Tx9WvKF86UOso17IQKbms_moxPHX8RnP4pFv8EUz.n6URYkZkINHPPI_Upb
 RVccTxisxl_EZDcsuXAlxA9eZA5xuFl3cM0mIjSaVXTE30Cp34I_K4byAxvhdMjOmEkQLtdxaZFa
 fxTxqyF6Rqxh6DhrAAXR2fX_KdOei7viYH3ZIdgf7QxzapsBqoqziWoztbVnj5B9RQNdfAIXRwiM
 cRPk3IJPxZSQsC.quqaZUt10GafxsSFvBxiaF0XG45uFdd.h8Kke9BomAC5zCaBvOYuz0l1qDMG5
 MzMPL28cbaV3sJUjgrjWVu1X2fEuUJ_sSDc7U8P46AvIzNNu13YW7daKBe3mcB073Er7fheKNO8E
 XCfBpDqdRexmQf25FblsoE5kMcKuf.njmZq9MKd80myjCbKpRr5HinPT0TU3hY6B_F5RWhgjrYdC
 XfaFjd22IHhhaXlynjEnCmX_7tJLc.ukk.MFNu4yIIzd7PoesG4WD.IfTvYsHrM6fAa4axbh4vW.
 KWeg8VXAN8H4w8wfiRayw2prHPqIQ5ScGQcs9Kg6uWdxLdBR2FDnOAqntxfg1onP8AXycwKAHKI3
 QjS8ktUSQCiEblu.dLs3vvM_9fQ2G7COQMQpYwre3TkjI8cY3tnkGLeSoGqrohyJwkk5NgIOAMxx
 sh9jAOcTRj7nFfvvr_SXHPm.kKoQxnIpopyPqpBNjvDpRxIvf_G52sj5.64WuvrP96gH8rihd6QP
 dFkse37WtHOkuGA2sMi_wCJD6is4ksa88OoBqfYIbsgHUNWfpf18IG6L4Nt0TIxmRolH2haRTrIP
 i4.B.xv1E8SfciyOc9bWQamjnOkzcngqX9h7u4VU0q8GO4ywv3vT1hdO26BvEzo93H61COt3AMw5
 JRgtdyO6J2.NWo2aYOJXC7sIusHLDQtiUAbeTjlNUbUDiKwRc.NTN.AG5uX2.PxXet.h7EDBmpOC
 8zWroIiD1Zb3mCrTVFGv5rc1uRgdZbmXKog1RJLZ.vwWGqWpVn9zVpnKdSyPxAV2lvVUYRy9r4pf
 GGxkEiTJW_4_ItLESpLU.rHWSwcf9q63U5iW7IdbrcVYEADChCvekeK6iQKrCBiQjLLZ2lEYpgav
 378wRfifYB0p.eOMMBXypDhvZ3Ql4QCaiefM2gkMDqdbXTrJxqbq7h_Zrdy5hO7cZVk1tTdPkKUx
 rQf4r.XsDNRehVFI65DrlhwBWF3a9QDI4NmM4qA7C1s5SfYQxB50QTd.68fpNiIuNml44XEbcg2Q
 Cwo5H4xC3rX5HbQ_k.9SWrRAEoMzQttMcZs7FGvFlii58IFF6k3XNP46wdULh5xKkBLQcbq7U5HV
 GugAWOpuu_14N0gHFJgLLpHbXqhMCHmJE8ek4iyx9PglilFkFv68NFG8Lnc_H9gh3DWBHU0gptag
 CDXUYudVumpNiLewP.NnUgkPzUi3hTjOvfQp0
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7e13bc5d-c7f5-4308-9c96-df23430a8da5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:51:43 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0f4d83cf88f6912abe79246c392d6ed4;
          Tue, 10 Sep 2024 18:41:34 +0000 (UTC)
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
Subject: [PATCH v3 03/13] LSM: Add lsmprop_to_secctx hook
Date: Tue, 10 Sep 2024 11:41:15 -0700
Message-ID: <20240910184125.224651-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
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
index 0cc3c34f5bdf..f53323e52fe1 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -291,6 +291,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
 LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
 	 u32 *seclen)
+LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
+	 char **secdata, u32 *seclen)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
diff --git a/include/linux/security.h b/include/linux/security.h
index 736fb1f87bf4..1c3768c9cf30 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -520,6 +520,7 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1461,7 +1462,14 @@ static inline int security_ismaclabel(const char *name)
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
index 808060f9effb..ad2499bff591 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1532,6 +1532,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
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
index e06817ef4304..859b37e51796 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4192,6 +4192,27 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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
index 55c78c318ccd..a2da81d0d5f5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name)
 
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
@@ -7388,6 +7399,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	LSM_HOOK_INIT(lsmprop_to_secctx, selinux_lsmprop_to_secctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 7313c92d479b..a60a3e2635fd 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -49,7 +49,8 @@ void selinux_audit_rule_free(void *rule);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
+			     void *rule);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7868268032a3..1f478bb08779 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4787,7 +4787,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 				  void *vrule)
 {
-	struct smack_known *skp;
+	struct smack_known *skp = prop->smack.skp;
 	char *rule = vrule;
 
 	if (unlikely(!rule)) {
@@ -4799,10 +4799,8 @@ static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 		return 0;
 
 	/* scaffolding */
-	if (!prop->smack.skp && prop->scaffold.secid)
+	if (!skp && prop->scaffold.secid)
 		skp = smack_from_secid(prop->scaffold.secid);
-	else
-		skp = prop->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
@@ -4833,7 +4831,6 @@ static int smack_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
 }
 
-
 /**
  * smack_secid_to_secctx - return the smack label for a secid
  * @secid: incoming integer
@@ -4852,6 +4849,29 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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
@@ -5208,6 +5228,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
+	LSM_HOOK_INIT(lsmprop_to_secctx, smack_lsmprop_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
-- 
2.46.0

