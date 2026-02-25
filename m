Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E73D7D8A
	for <selinux@vger.kernel.org>; Wed, 25 Feb 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047329; cv=none; b=WCY1u76pmZPh6DPcW7ySdPenOLBG2I6qc3KxwHwYQ/2SXbiuB8+v0xRlKlKQrCgBb2TU3dyhrR0XViZBHezLXCIqsGUGGT7z/IkvUB3KtJ5SohY8l7iSH3jOcNxoiAQ0M40Q3n4GP4nKsUCPdVwPmrxdkBokPpxLTMmkMwuik0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047329; c=relaxed/simple;
	bh=TwaMSNJglCc5N7dB1LZIcTLksKQqUKqUlFLv7rIULRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2jjROQQgNins9Vzg3siRJABikmhBLKHMNAAP+qLbB06P5d1DCSN9sM77Vu9m5KXFUaJwFqpoaC9bp+XDyS3BRhiQwhe/oLG6ZZIcz51agvbNUNIH7nyYuh6Xax6hCbho9aWlasAhoXA7yz321xp0+gVuxCkPoUhqMdF/eTU4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ahIVEN8R; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ahIVEN8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047321; bh=rLYr9JIDdLO/Rkgb8oxOUxPWOWlT1V5HAggXJ+SzLvc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ahIVEN8RZFC49cJLWZustfUP6zM3Bl2Yxq4Hwroc5YQe+YYLx+xZ+LWaJge1yFLTCKZngLtzGm8st7FAEXLwevpSGxQnCrqq6XSis2ivy8mPAdOBNZbpQ+535X3XqqQmnf99f072g+k7mq5Ic56/itTb/XnE6+/D5LRV8s3/KkR4jbJEUtOQteNAi7yPF3NSgGeLZYuYrOfYEwS39RdoPJ77+15A0Y7cCvleacn9pE1zn6bhkANoC3wjrXCu7JTCBXnjw9KKeTG5BSwCQs48D9J3EHESw3s9xi4bLaogWdsMPDiNS4e1L3xyY/SnqX9EmUTCtU5TdUcfGWyiEd+jgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047321; bh=8xVYQJm0U7d0LQfnUSZy/jUC0BRWJEYbFQRk6tr1VSy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Nq83VNNKK2ZkE1J1/jQIPexOZ9td17ePU2EzpPNayh0d0vcpxNx2m9GWdZsKXPox9dSlngPP9fgG+yVgv4Pibq/ZJS7IzEUnW0xdAw/ly1LNsWBD+S35I/ev0rpn71KfBpUNildkS/nBD8HmMsux1A+vy6ULbGRtHP8pmH2YpVGzqW7ZxbbGM66ftLZVLrm3V/p13wCOeaYfLpO2DizVhAwdWn5jVluh6f6Sf8FwIKiMJKG4+QDj7vZWAevpYiQUihRXIqOgxtKn2VtXX3y6oSJebprpQj0oRHgrXZPxPw29SFj0Hah1md3yBgd1qVEkHLopAU752A5sGJUDm7OZ/w==
X-YMail-OSG: O35Cu6EVM1lKIw0D1BGCwu_31sDyu83i8iV.OveaC74cLScGWpKpKlXZxJb1_lO
 j0gsJyTh4RO2C4LDccfWok4a5dF6ah5WH6ln5dW90fCEujWztEprPsgTE65snXSeypZ3aGQnG2qk
 1uYfGmsPXuv9A8QwxIUaH1NCztw9rP.laI5xx_8pGng8OUGkI_Ip182pV0fVl1FDh9CVBtWaEuM9
 NgFc1BdVrftM35VrZUzQ0cI8l73U_WsvJ7e86nUhhQxPNIGS0vjnViVERxk9nKWbQEplWK.ZqZk0
 4MparKNnMb1Vc2Fq_mBTy5C9NORywQp7RsPdcGl.6QWndWRZWEn3a7OK2JDgH5n6nLHfMwLi3V84
 RAFjXY0IkCp3MwnsYWV3.XQjpt4ASYb1g67XU.XyV5VnD3Cyup9N1Wjn1cenQe_Lb2xkVxkHBt8M
 YRKtgTuRmMy4YppPxiKnL_OBkkkcup8iBWoHn1aUhMJoBz0GIScDuKAI5ud7b88wdHM8Y03.cDEx
 .s3vbITmP4h1EZI7FNO_k1GAV02rdRMpgRLsoHX2JUAVUIUKII9yAbMhA4BxlU_BMrEA0z.DRVOv
 .JzdniWnFlCBDO2_WIVmBwv2oDNpCgRB6OgvwHSppNyHR0RzOSvoTksmtTzz0OA3jbXJn2R5tO4f
 sDNrY2fLMkHxJ_Rk2DRJ3DCyuKCPvsaKgNHwnXgagAfTbEGxBp.f9fGL1jCEA_f3PIL7aM2MKWBa
 WspJesXE0dCBKsx6E_kwsspuxqsRcPSjZP5cjHfGJa8Ig2vjbzHR1t7jGOW7uV8Ts7uk9hi1nltH
 ZVAO8Z50wp51Ek9JKFggzKYvI_G2YbmGM9jRMwvi7.iI8h9hXnKAkalgEp9DCKFUOmCVubZhzQX7
 7.x8udOrhxAqWOF1SMgkmmAFsGrXWyY1eMsZovASXQC39qCC3JA.i9qP_kRYw_MhzpapBe4twuoC
 yRGER7QMwhEe.1Es79d4g_e61oew9_kOoWJgT7bREb6Z6qGMujL6176SPFrn3F4QRRmf.MgAhM6E
 yPRK1Z4E1c.QPoyrgbkk6qWYCQrw.jYMpyX2.WCnd4qOlCJGEVsL7bBsvaJ0qlMD4d82YU3inutd
 33EsO5QhZ4TA8GqWfCJn2qvGCsdvC2mjmmntlrMj.DMPdpSVfn45dJ4rymfGFlB2Fr751BGQHusl
 _OApaHix5BAhlb52vdIV520gB7v0F8R.25epMa8.bCdNH5uB8DtMZMOz6oj8JmbF6HLmg_OdT8k6
 EzsinLAqJUstjY52Jv_jEQW8TRLhJOkOpUfPyB3rZL_pulQr5DWiA9W7W6Wypdr2N8OMClwu2x4W
 letDbQOy0UnYuRh4HTTdA3bqS3NNrTa1IAweAQSLAQXztvzjWWKOsNiEBYfLldUCaSdFoAdH.G0h
 2M9hm7azjnY.Y25NUnwHDZiFCKioRG_l3eJqstNLB92jbfd9tLn9HYD8cPdupn.qZNhGOd4B1jBG
 yoNct6m7xad4UIti.koF8q7Bm_Nd_W8yKdm_KtYssdR4OLh7AX.Bb1S6SvZHtnTMJWQOx6v6Nz3Q
 Q8qihuMrRDHzT.PJ3oLPvzsysBQ19xaY4GPwI4.zVrD1ks5bEHzhEdPEY1SWb1i998nKe64X4N.L
 VyRCZDXOijBto5NjdIUbt2vngcmtkwM5YB4ZO8P0GG1zfhlVIs1I1VAugvHOZeXmYxSyfpsc3H9G
 1Lj3KK.0INyFQ9vRy8Ta4jrTrytfJovfeRUZ6qZ0187h82CYnXEG18AhsahZCoHdRg7inmLkaow0
 Ej1nL8lssIUKuF9lzQvg_4CpZCcM8fGVSOa_0QPAoHPXWIum5BO3iHb0WMzX_bjLNtGMnf2TSk8a
 ZNuGsFgX36XS3cWsb_euIWV8doEfZH58YdtHuzUims0vZ2Kwda91Ywch9G.czLw__RnlQF8Ec05E
 J_8edDtEZafO72zxCpTYsLq.aF.OHlYDVFmEBrueXjPLUHnCyhNY0f8tQZMbOZq8wVsFguiHDgsw
 Bkbf4Vj67XTrUwX655wKEHXEblmAOKeGCu8.pRuMG.JZ3.Xxm4JMvIBwkg8IXNLAZiKQkkTWyZby
 8MDduHq4o_ZEQUMVmXq7PqSvUugPD3hGeYwyh2IvOlrGagIu8rrH54.E7gyGtQy79siA7qAskeqR
 .3w.Oes_iM5mLf9fagXtm9dvqp86muzWQHbhe.SHKwUrt6Gf.0oIxKI..hE2hu8OU6ZQd3qwvVJp
 KH6dwtQ4V.u_VfHYTjSX3iJtnm.ZxSXxPmHLg_t2d8DSaa_IiH3X9KsavgPj0SqhrRYn6_cIfztU
 Te1Apof3XL9i31nz0XUc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7061db02-d21b-44ab-9a88-fb207c9a5b5e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Feb 2026 19:22:01 +0000
Received: by hermes--production-gq1-6dfcf9f8b-5skm9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 34de27226d18fbed2fa1781e81910440;
          Wed, 25 Feb 2026 19:21:58 +0000 (UTC)
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
	selinux@vger.kernel.org
Subject: [RFC PATCH 2/3] LSM: Enforce exclusive hooks
Date: Wed, 25 Feb 2026 11:21:42 -0800
Message-ID: <20260225192143.14448-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225192143.14448-1-casey@schaufler-ca.com>
References: <20260225192143.14448-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an LSM hook is marked as exclusive via LSM_FLAG_EXCLUSIVE
in lsm_hook_defs.h it will not be added to the set of hooks to
be executed if an different LSM has already registered an
exclusive hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  2 ++
 security/lsm_init.c      | 66 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..e3c137a1b30a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2404,4 +2404,6 @@ static inline void security_initramfs_populated(void)
 }
 #endif /* CONFIG_SECURITY */
 
+extern u64 lsm_exclusive_hooks;
+
 #endif /* ! __LINUX_SECURITY_H */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 05bd52e6b1f2..dc3c84387a7e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -356,6 +356,70 @@ static int __init lsm_static_call_init(struct security_hook_list *hl)
 	return -ENOSPC;
 }
 
+/*
+ * Hooks that are restricted to use by a single security module.
+ *
+ * Secmark hooks have not been converted from secids to lsm_props
+ * due to space limitations in packet headers.
+ *
+ * Conversions from a secid to a secctx are restricted to the
+ * single security module. All cases where there may be multiple
+ * modules providing the input data have been converted to use
+ * a lsm_prop instead of a secid.
+ */
+struct lsm_exclusive {
+	struct lsm_static_call *name;
+	char *namestr;
+	u32 flags;
+};
+
+static __initdata struct lsm_exclusive lsm_exclusive_set[] = {
+#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...)	\
+	{ .name = static_calls_table.NAME, .flags = FLAGS, .namestr = "" #NAME "" , },
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+};
+u64 lsm_exclusive_hooks;
+EXPORT_SYMBOL(lsm_exclusive_hooks);
+
+/**
+ * lsm_exclusive_hook_denial - Check if exclusive hook is in use
+ * @hook: the hook to check
+ *
+ * Check if the hook in question is restricted to a single using LSM,
+ * and if the LSM providing single LSM hooks is defined.
+ *
+ * Returns true if the hook is exclusive and they are already provided,
+ * false otherwise.
+ */
+static bool __init lsm_exclusive_hook_denial(struct security_hook_list *hook)
+{
+	int i;
+
+	if (lsm_exclusive_hooks == hook->lsmid->id)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(lsm_exclusive_set); i++) {
+		if (!(lsm_exclusive_set[i].flags & LSM_FLAG_EXCLUSIVE))
+			continue;
+		if (hook->scalls == lsm_exclusive_set[i].name) {
+			if (lsm_exclusive_hooks) {
+				if (lsm_debug)
+					lsm_pr("%s denied for %s.\n",
+						lsm_exclusive_set[i].namestr,
+						hook->lsmid->name);
+				return true;
+			}
+			if (lsm_debug)
+				lsm_pr("Exclusive hooks limited to %s.\n",
+					hook->lsmid->name);
+			lsm_exclusive_hooks = hook->lsmid->id;
+			break;
+		}
+	}
+	return false;
+}
+
 /**
  * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
  * @hooks: LSM hooks to add
@@ -371,6 +435,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
+		if (lsm_exclusive_hook_denial(&hooks[i]))
+			continue;
 		if (lsm_static_call_init(&hooks[i]))
 			panic("exhausted LSM callback slots with LSM %s\n",
 			      lsmid->name);
-- 
2.52.0

