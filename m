Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425725A322
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526645; cv=none; b=MwkYrMXnHgk5XqAgC9hH4jwx0cmAKbf7VlrfQxHYFW17STn7F32IkMSr+2LaPVRYrqvILdx/cpyLctoiBF1+SRloYCqkpkIRC2jhwMU+SDo8izFRwgb6V2stDwgcIQy95N7LZHaKylZm81r06xAMa6i9pe4nyf9Dy/KqGQuiJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526645; c=relaxed/simple;
	bh=PXNl/4U8SPxf6zMvJk8C55Fc9VC3ay7Kotmda9k1aiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlgOvfrAlTRggYLwOINjKySQIpH1vi8HYumq7zUvxoxp/lcTuGYda2bIz9kiedsWTRE7aBygNAfqQ91oMrpLHwAJJD0asqTFv8P+CubOQnmlr6e7xltTTdGqhK/bGZk4RiajmuXxnFetwo1O5O025VA2VG0WTTZw2cEvnu8oniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WavFRWZA; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WavFRWZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526642; bh=W/cTrlOevtxan2rTu6YSeU2owjx8zOs1+huUBxSxev0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WavFRWZAyL+1UxvSxNxOzCi53CfDmj4Bqwu0ZtYGNXsOggopcifDCuFVUMUHyXpg7L6uU41MQgnTZod7IjnbpakRcaLG+1U5ao8LlXGmuF5K40BOjn0y+LvV8oiTUVnlDbGRN1xw8VPzqbJLlK4rIU02c0QedwakH63sH2eCJQnFJgnKnCjf6mUl8SHXfW1Yrqcm7dVjZa/RcREk/T1f4sMIJbKSzN1xgt6D/jIFsxe5DvIut6Mh+484S2wxlc4KQKzOVizPZ/IHCHnYvb5zR5MT+//EyCm3OpOLXZFkTosvZRgh94hl35DpPX9o1RPL8xDyhX+llZ2RdL1Gz9r1Hg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526642; bh=siaMc1Pc1Y6p7sggT57dif6f4Luw/nMeR2jpnOfiNY2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Gkb3M8dyPWy2thVL7P8oI5F+y+vkpFGlQx459dKe2dt6ajJaIqWw4zWMYKXZIKhvBFy6mI18EdbUMgLvqjrHl3INGLHluXsC+F4aqWx7LC3KXAxpmAOJKLWVtaLnRC7ni4YNbZ5q/azzv+yUL01QygAUVdnK45E6u8DyLNuWkybhUSxo88Lqwt2ddWMNvvbcnk4M5hFNyOESjTZLQCkgtnmJLICYzU9eD0tfT9PaAGNgz1vvsmene55uCfpK1eayXDUKJRFUZqkML3u9vUtOwm6J8OiQQenXIsnOca9xkHQQA6ovg09u9EhFNwSh4yf1kXSMNBHfF+7LI9mUQUenuQ==
X-YMail-OSG: IWDPGnAVM1lWRUNQZCk2bf1RzWdc32XWZTKIiidnTEv71DHLxeCYV.OjDgSX0pr
 QT8nd17cvTeY6_XAVHxDKZz505daLZs48wX4a8usru0WB.TSasTv.Sb4SgNUUoaEOKn4hvaTjlnC
 GncHDbvdu9bPuSGknf9Tq21nMS7EQAagnEuwCDZYz51iVNryOb_ZS5eZOyayn5i8uypGFTe4k3hQ
 IkP4zO1kTHP09rZ3c_4xxb2nNrxtVw3xyJtZ4xHlQXea1SZzkL2_CdMiL2x.szgFZ44OKHPyBDYV
 sdGVfjVjyovapu4oKdfetr5tLV2Uk_8Y9gDSIhydtsvW2KaIdmylTnCFGmJqj7p1vbvSFSI2AYuk
 d9nJfdA8MYXstYdg_pF9BBq4JNvCs4OyLBTVQolmLct2Ts.r2PNmI8rYaQmw4kGXb0cA4oTF_1kC
 o.lPHdKlzn2NwjC88DQnn6pkUSbHel7ohom3Swkpeh1lTS6TirGlIXXMW0Mu7j9vp0GKsr3cx7pZ
 YYOazd1QvMgL62RvywhkHn1YcLnBFAjXx6EZ8UIIFaAD0gQr32J1bd9sW.iCgnBcIdlDT4HbEYBW
 GXQTSk1_jsW3NCPUP.rdWF41EZ7CCSvYxrDauepSweNLs2NNWKb.A6g9vv45NhapfEp8RHSysUgy
 p8taRsWnm2RKrxRPzi9M5qJWa.EBMrqalPSETiWKR6Hdz4tUWKrK7jeTtbgX4auIlaVtAUMvGFlT
 8Aha59fpj_EzZ.rlr9KFWGCUGw__m6Rp74dwuhK5EEJ7AB85Y6QXhn0CMBVdoqUQklTQrXKZzxwW
 1ut6uA2xmfQIHYfuJDH8DZF2D0UU22QluHybk0evv1_oKT8lSriZ7ZsjMldbYxyRbohun_Hq4a2i
 3D4O6AWJWsWdBSq6o4WhHXLtXScPm786shHJfMOGNmc08D8Um1_c7N1uebj46M7ad6VUU.CJL2td
 _tTADvImukczkyXQtjRzFoOWBbisAHoRcPWPctMdey0yzWz4sLCpEBUoPI32CGd0vND1f_OziKTs
 hbgQ5C_sV1vtsPixyEW174si_xvZj0aMsX8h46.Z_FIZyke.zwYp1XF56w3sIpZJh0zzXb1fdpqI
 .ZwjxRzB4lUqdX4lC1VQywqk94heJVqYfjM053cle.J6DKpT9YVBlOh36EVSP7qRGQi9Cj9NxE8p
 8lxb6kTAPy6iY0J31m1Lchnqyeu6IWd5WUwV2tiLcIqCbMxpgxSUMO2Evt5Mopm6nVjqbaqfLH3W
 wtNIFaNo4iIdPgNYyqA4etrb8gcBGInA0cYnB2hBKpbZTomFJVQrS9bPIGeQWERlJ5sKL6tKa1hL
 mAhjUFJnOAAMn7XMrudvN_4SqsmK3N4TdMQRMIMMdbymo_l9LxGWVWyF5OSMrBLQpRsXBzsoNy97
 jf6m.LlbE.9AUeK7VskgfOJ2XVJD3iz5WkiOOBisWwSivgBrXs6pHPBGs0Bk.O29kz0vokk0OtrL
 XvxeoljlLHKtsjaWl4NXdW4ALjpy8eZcPeiwcRQvPrtXN45VXRagbFXETNFY65h1cEUt4D8kL0xy
 6e.M3pQiX0EoepAjEb4kE0_eXF0rcy2dC05j0POLyF9tWiwl_0728X.kdFjMO3fmzJA23iP.CzZT
 wP7JoLjE_SEG0Iu7.hN2zPjiEEtdAoOgUgw4PANW.mPE9vyXwfDr1ilgmY2Aduttsj0.ckTLvDb2
 .uEUpXLXcD3UWt1fkgLfNmbdD63sMdADQvNwOxCCEwEHHi0Qxw8OWsqLjx9gosw5M.nM3N4PVhAT
 egMyDDq6tB_q9PNXoEOtPBe0oIMXi4OctYnUxChF5B6CzlhVJWhRBUAdRNabtJJNx4UKPpvUs2Mb
 DUJ1Odcnca6RSXb5Oy9hkpmbXQ7CqdNhQK42HYTYxYT.OH4prsT1H24oMtugVp1QSvwq0kLSAC_T
 8gKE.e698KtL6fniemQc4GsYCQ2m1sFc_NAxQw2DuZYwsFc6VerqVh884hdy0qSABLLWUJDLw30t
 YZ9IUVEmzW6iL89zdtR01yOwo8D1HQYpqx.oleZut5d_zVEFXVaoSBf_v.2QKLFTyeODAUwoBQgO
 jRtUkVPZ3lkdd.CUF0jV3ViPE9q7_nb32_.iia6F8ZusyBMcxOpjbR5oET2JwV78m5AfYf6fBFhz
 qjyF6v_eiO5sNG5HrIex1_kZo37EvlnpwmZkr9RVvT9uo88NN8TolnFO8WNSnzHQzY929ACmp7hq
 sr_0b6_c8dhobMyT5hSK5f40h84pTln77cV69QeP5TEjO5sZ8bl1ME9Rhy6asYmpf7vIMhWqZeFe
 H7maYBirO_4l6VPeBF5zkPA8m36KW7yP8B_KC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c9865e50-085c-43f5-ab63-822986864379
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:24:02 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5256f3ef263223dbc5f852ba156c094e;
          Sat, 21 Jun 2025 17:23:55 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [RFC PATCH 15/15] LSM: Remove exclusive LSM flag
Date: Sat, 21 Jun 2025 10:18:50 -0700
Message-ID: <20250621171851.5869-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250621171851.5869-1-casey@schaufler-ca.com>
References: <20250621171851.5869-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only SELinux specifies LSM_FLAG_EXCLUSIVE, so there is no point in
enforcing it. There is no expectation that new exclusive security
modules will be accepted, as the reasons for exclusivity have been
addressed. The LSM_FLAG_EXCLUSIVE flag and its enforcement can be
removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  1 -
 security/lsm_init.c       | 17 +----------------
 security/selinux/hooks.c  |  2 +-
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 06e840fd4b63..717541fcd653 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -149,7 +149,6 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
-#define LSM_FLAG_EXCLUSIVE	BIT(1)
 
 enum lsm_order {
 	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 784f8296966f..3d8f59104d8f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -28,7 +28,6 @@ static __initdata const char *lsm_order_cmdline;
 static __initdata const char *lsm_order_legacy;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *lsm_exclusive;
 static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 
 #define lsm_order_for_each(iter)					\
@@ -150,8 +149,7 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
  * @src: source of the addition
  *
  * Append @lsm to the enabled LSM array after ensuring that it hasn't been
- * explicitly disabled, is a duplicate entry, or would run afoul of the
- * LSM_FLAG_EXCLUSIVE logic.
+ * explicitly disabled or is a duplicate entry.
  */
 static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 {
@@ -173,19 +171,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		return;
 	}
 
-	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
-		if (lsm_exclusive) {
-			lsm_pr_dbg("skip exclusive LSM conflict %s:%s\n",
-				   src, lsm->id->name);
-			lsm_enabled_set(lsm, false);
-			return;
-		} else {
-			lsm_pr_dbg("select exclusive LSM %s:%s\n",
-				   src, lsm->id->name);
-			lsm_exclusive = lsm;
-		}
-	}
-
 	lsm_enabled_set(lsm, true);
 	lsm_order[lsm_count] = lsm;
 	lsm_idlist[lsm_count++] = lsm->id;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9578b63bbd2a..039d03be91f0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7675,7 +7675,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.id = &selinux_lsmid,
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
-- 
2.47.0

