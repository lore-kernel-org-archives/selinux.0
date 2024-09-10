Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBE01A7048
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993992; cv=none; b=G2iXLueAhGMWem3DWGPzE3JdBsjTbeOcfOyMBI8ujFR7N0Vz19ojtwSoLgKiIZI9IPw9DRNyNqAElCKX5q9bbUNqzhvB55Rsj3+6fOSZiGLC5CU74Hd+mpw4Y3Vbth6CcV+hKNSCFlkkgDyM4jKEoHTlN+mxXyslIR6lhw1HXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993992; c=relaxed/simple;
	bh=W8OMc9fA8HTKz0dHEFvJzgL10u/y0wf0V4o6lElOSA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QopyC/FT0eaykxyIK0g/wz4Q3CZzEHo1P6BDa7b7ktHgiY3DSirsOuj8nXDkGPQCz2xFKMWl9sFV3gd0MBhPp6I7RcSMolXL8oYfHiPQt/iOYrDCAnDCs+sq6/t4/dxrByvYkEc711akMBcD9+M1tD268ZjvqTCOyla9UgoKSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JVRnUfRe; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JVRnUfRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993989; bh=2pQtCQM2s12nVMZLCkPLb0og5s9GLCbFsCXEqZw75Vo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JVRnUfReQYQtOu1DAvndnBQIat3ySXmxjO1q0B5ATq+k/NzpNqmNxR3Qqbo0PWjPHRy4PPFiW4FMANZcvjq6OgIQe/K/rZXoWkldTRAw3dwK+JuLwuNKT53obNYHWU7zNg1IiYtvAA2oGA+sjHjmogxSswe8riWklHFhu6Pu3XzSjsYWWjwjODM0SUm6+ZSPIAcr55QIBuL5R0Hr4scmyCroMf5TEmJrg1wCngfce6wGg+K6oQOZB3tAqGaRYSPKe8mB9j4UZwPOTBpWjTOMRIxkpv8kWR2Y1fbu4ChZrn1SPhtUlI2+HqIVjRTZM68znTfN4WlqJJ+VQ0Hm9G7Ekg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993989; bh=YCyhaDyNxCf12Qtutsn37lGTWeBHNa89MxegxEWHeDA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Wq9kigslxWWQKHtZOnzNKPEbrdLl1tsjmzidgxT4d1t109raRmb4Aoz7xy6zx8pQXwkv979qHjMDRFATN6vubXjN47BjBP/1oB7s49Vj/olnB0M8M85YZ+n6N8c2dNOqHVnB4Bx56G4ksylmnJ4ZTb5U8HzYBsCf94A/4bd+JutpJLhwBkcXxetMUBX18Rvb2vrZedhc/q+eTm+52mdGWesihyh6VLyl4mQYBRFRAQP7gjyEcASKdaUjzMMZ8sqBYUXoF0egfLmgr2Nyol293FKSiENBqPpWBgh1Do2xVMi2zggcQsH0GDYMwQHsY18X30lSuKgnqWUpauMcqcVlHw==
X-YMail-OSG: A7OECvcVM1l7ys5ey4fo3Wip2mB0SnfUGWVtdNkzO9hGiilPU7racTZ1V7OfaHI
 qBEkZyLn.wxNxVvO4mmgzGvEQeVHo504AEMmwt_8Z83v1p2B38UzJC4tyvN_odppeNKLj7VILhFK
 CAAzWb9n1jvjBVYwOgYhHCM.F2.6wx3XeacLccGgQRGd7CSyuBh.8IjZUTf9Oy5p6P7B.Ox3KGbe
 OhwSBBmTmvBdFQcpUHPCEUQqb0jSfvdQ3NhH4b7Io3HUmW1XkH5E6pm8JvsrxzqsdD27Vzheq5Lt
 NNm.pWK3r20PWX13VEX.4aFPNIhyN6z3Z42ZPoktEUe7IG78lamDElyQ75pYuRyGuOYPv9VmXrLb
 4reiZQfm6mYETDGI0dPW7zdY2NTxuxz_GTbgLrvDrVc0JhfWgXQc7d1akwO7Xnq6npAY4cba7gbL
 kwbUFnZ5yjqRK_D7kUMiUeRLzHlYIPoaEO86T3Tr8QawumhhmmbKkLPce3cix59fMlDdmvjlsQ9Z
 6VMhQEW0WjQephdr9PuC6OkVsE4X.Z9i3WKzqZ7soT6GDVpAEXNDZsUBLdk1oxU1IeEthfApsOh.
 8TwmRc.BuMq2wkO2iqylDG0QYWGnKkTfz7vBr0Y94uaNH1q7.zrIDQzahuUtFqvcXR85ijRhuGIh
 3cf_Tzs6pfHcXVhRrL3YtCB2aYY28XAZfGSpjuyQCP7T62WebGSLFok54LOTu_4hGm6hPaNRhypm
 F_WNswqJJKLgGU.D8IxmSpUdufUqYA4KAzD2qXLqIasRI6RcFpwsIfZtJWEtrlqry7wasVURuOr.
 JZGX6HhNZeVE4B48KDVg9WWbjlHt4SqkQWts4d5LY2cACUJQVh3DxVJ7fSfJe2KCuYMvm0Whmlcp
 GOI7KaWnntzMpxhAhRKi6ElyP9nH8T.z4LnkKZhhYx05Hlov7K57Ys3FAyYAMmz_zeV_GQ5Z7oO5
 uCPk_UjSLQ3gc_mlapuNRd.ttsqsKu6gpC3qx7pH2rtxBO9WRDgXoclF1ZF1V9zZn.G2B3UnB3LT
 IOny.fe1wxS7_._n3ML1l6JRKscttHojk3zGweYq8ThL_6Zs3JuEYZYVzYowgVOC6nTUZPJp.vv6
 5ZbnQ.a34tM2dTlOBwe6k_ZzoSnZZfoiOwF1CwbyhKf_NseOH_RvMaA6SsQbMlG79cscEw4mSlGA
 YCa_2BmGrOJ0DHCC5r7BmoQqy8fpCRPn0CZnlCPbdooA__uCXFIXRGJ3QgS9Q9N8wSnYy.o0w.Da
 A55qC_DSB1vHjPBqHJqr_je2CvbAGc2DjxL8AyMg0zOZvS94UAcwA.C1a8dv5WLhjwq_vQ5DuUj9
 luGOZZku93Vg_0Ue7zwgi9ICLdgboT2aqku5bPK8QPkJITuMxJnBaESPQbHYu.I5jZH3IxwfMs4j
 mple5ga1Dav.PROk7K8.Lx6XLbxmipMgsBRJze33NYkVjEZA9yE9GP3fFxPR8AWMFrffCT1FUKv1
 THAI_pJtWekttpXA16OoxE0ko.PaAhb5LHOBJxajMoiC9WMXBUELzgGXCD8.zYm2NPKwqq_N94rb
 OsBMasRCZGYsZU2EPm0CoA2fMBPfGBiHE3V9NNOCf1oheFwKX3MvgEV5CPXOk1T38f8S17cQVoC.
 WdfPunECSa7QRSDCmD9VBdmkBWmO5uyr5lHEW2ryTsGF5Z91r0dmBHqJyUaqd6Jdh8ITEqP.Qm3Z
 7TnvEFbCdWp9T40g_sNeZaV_4_WmCsvpXR.hKHQj27A3DRlLmgt0lsSmBdAnoOYCY6BcsJI7BhpC
 CIwvHKAYHTfU1VtGHTywO7rtJqsMxvxSFxdutFpYzenHpupwaEWwRiYKkah9nKTbMyGJpoP7Pc7i
 V6v40WnvWOq84hRhw2K_WUARDfom0pRe1fyfSHzR7x1MjEi9opOzykxjd_K5zhAFROyIcRXDsuiC
 5hhNEzLVcBiYCwe3TTUQs0zlWPaj9hWt6UiwryOwGeHsj7yRKJlGZC2G5Hmh_QozIJ0lo02mz2Zq
 wrUZASTxplXy8kCvRTAPrlHrmc3vVVJ9Rkx0NaYN8XOSJD3j1er_k4fTuayo46TrBtCMxtIdk7B1
 ICILsQSjRYSMPFLXuXumQ0R7WMRxgKSqVFj.j5NiRfMICmeEJxSw71lo49oMY4nLZc640CJmcxQ3
 wzvHl5paMLEnBNbLKD_0WCs8JH4hOdpmlFs_GZV1CVmUm9OHM.pA7mmzfrjOzt4mD7b7QekULlJl
 HYCQ2bXenU_PObd7rW1anDPlgA6fEIdu4ZxfqGWMsqElTDMmhawaveFwxRtUP1ObA9K4bvgZRxDf
 yk.BkSDNQlUdRRKkhp7lsD9_y2PwxV8f.l_7co5pusfaPW2E-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ca65378f-48c5-481e-9bac-d2b9d7e6188b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:46:29 +0000
Received: by hermes--production-gq1-5d95dc458-rx7kt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2439121b4758407954183c0b5224f0f9;
          Tue, 10 Sep 2024 18:46:26 +0000 (UTC)
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
Subject: [PATCH v3 12/13] Use lsm_prop for audit data
Date: Tue, 10 Sep 2024 11:41:24 -0700
Message-ID: <20240910184125.224651-13-casey@schaufler-ca.com>
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

Replace the secid in the netlbl_audit structure with an lsm_prop.
Remove scaffolding that was required when the value was a secid.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h            | 2 +-
 net/netlabel/netlabel_unlabeled.c | 5 +----
 net/netlabel/netlabel_user.c      | 7 +++----
 net/netlabel/netlabel_user.h      | 6 +-----
 security/smack/smackfs.c          | 4 +---
 5 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 654bc777d2a7..37f5a290f040 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -97,7 +97,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct lsm_prop prop;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 5925f48a3ade..1bc2d0890a9f 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,14 +1534,11 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
-	struct lsm_prop prop;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getlsmprop_subj(&prop);
-	/* scaffolding */
-	audit_info.secid = prop.scaffold.secid;
+	security_current_getlsmprop_subj(&audit_info.prop);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 3ed4fea2a2de..81635a13987b 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,10 +98,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	if (lsmprop_is_set(&audit_info->prop) &&
+	    security_lsmprop_to_secctx(&audit_info->prop, &secctx,
+				       &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 39f4f6df5f51..d4c434956212 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,11 +32,7 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	struct lsm_prop prop;
-
-	security_current_getlsmprop_subj(&prop);
-	/* scaffolding */
-	audit_info->secid = prop.scaffold.secid;
+	security_current_getlsmprop_subj(&audit_info->prop);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..96e7cfc45e21 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -182,11 +182,9 @@ static inline void smack_catset_bit(unsigned int cat, char *catsetp)
  */
 static void smk_netlabel_audit_set(struct netlbl_audit *nap)
 {
-	struct smack_known *skp = smk_of_current();
-
 	nap->loginuid = audit_get_loginuid(current);
 	nap->sessionid = audit_get_sessionid(current);
-	nap->secid = skp->smk_secid;
+	nap->prop.smack.skp = smk_of_current();
 }
 
 /*
-- 
2.46.0

