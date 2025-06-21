Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DF246335
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526451; cv=none; b=Y7+zkNv7E7HTmLmrqk9BR9aU9QHd73nPWCVyzVT8u0/C3Nmox7HrbZuhWYg83Q7Qs4gnbluY/erohr1Npj2PxK3zAqLdFNyg0NP+1P6/pnODLL7qWx0r6gSVV30d8pxYvC+PyBELqIeu2W9u0gz4Q6jlAAysKv2KwJDM6zjJJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526451; c=relaxed/simple;
	bh=aGOH+aAyANs+mfgpijgWGmqq9R5UIKA9AhxcYrw7YSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEKvY/r0PuFgRRn0KLywjWUyMO56PUKhfCSElQqCxEDaLhl46VuuJpA/U1f4HGfWxrh//gYTsz8COjtmq9++GsHIBpEOy0ixZ6c673W7eIahuV2BRm0wwSS4n6BJBsErDH0jZyUThXvTvVlCfrR/2+HA5FU8qMGzG0G/R4Q4DSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XFqs2s88; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XFqs2s88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526442; bh=28BsSsKBMb/CRoqFk+67h23muo0Ip5+8Af2Px0B+JrA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XFqs2s88nK22KFcbLKBsip5hLp0g6vIn2P0RICkblH7u+PKUxlEmKC4F9ry6HLnpOMeCopInzIew6mbZkp72ZBtxJVZUtIogmgrP+mib491slsTmdLiCV/ZZn9ychoamuDsmJ6dPfz2q73EloCdIvpgJGMOzfO5unqw2RnQ6taUtLKS0Ap41/MCHKZG8QNu8zN7w5YjlyOziCMTWpnHqOzf6Ys47F029EXPMh0hvweSwy0cemUkjiSqCTy1ec7OgSBCO7mTQDUvYp71FeLjDadhaTb5kn2OkFD58A50ywgO9+LCgpszczhvQS+29n1ypuFqaJiKmNu53IuxY29bQfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526442; bh=oJ9PYsGMMW0JYw7aHEo6Nq//kF6oA2q3BZ9qxW1ORKs=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qf9M/JrC/qmRwWipob4mzwLxRc8fTHQFIG2Dt2sjOmDNPIlmXXJj4UcyE0V3KPcYOezOi9T1eDa7gm5dXCeE5i7zqAN22hQThqqV7AgIb5FDvQ0CaVbcYPyqH8daf84cox32JgJi9cq1W0MLoNrcYU21Sf3lZQFiRqO4e0yMh/hKCYXjKsvVvQnKi9AWNgeYNzKiXWUW4JmYlb7Duri85xmsaqwijZPrM1Ts5tO2Pk6snvZI4CnLjQkECi5bzqdWsyFsDqzHwiEcPMqbnzmPEVNniTDp5H0y5qwLgNj3RLVZNyuSUThIvEb0Q0mmIr23pF5t2gy3ZdhhUDD1PC7ZVw==
X-YMail-OSG: xMaNaS0VM1nwKa67gwCV7oVs6MyB.OSqshu.Zs3nP_ZX4AAUG0ACyo2Q_JRRtby
 YWcEQyA9vs8Ml6O0MgA.heIISR.M.H0RHn.HDok1PICV0h.s0zbPBlroTdUI_AY22Ijr2VHLni_g
 3yJT0q3r5W1GoXG9zDO83hnlLVftrFuP.Q2EYWfBPnHPpyngvNjZBsqc04GEAOKrtN0ZbzHEH.UN
 1NYaoPbg0uX59Qrlk5p7LyqNn_I1CrlQYbmEY_wfk7ocTIzuI3szAcKOIVVlT7jF67zttw0QZXs1
 svB4.VijSFJCc.DbxKrCv2DwQ2S7mz69SdF3eLAaktV2tONObgb_PI_2entpfA6C2v85p8AXPhBo
 VnIbSuVFoMeYwcwi_CHoZf1Yj21U0rM6ArdplIZEgwaMv1hUvyYrkUwd9L6tvCLaoDyd3glmm3bG
 STh0dMUPMVh_MxJVvVm932R9kAbST.7HkpxOIbz85IpKin7ZO4aunWAphRD26ozNguhK.Wf2ghnA
 Hhmx0lo7oxzPlFB1CvYQqH1Kbakn9o9KsX36Pv0qBsoBwYI4VWTx5BSUMn58.QZDzd4Q2B7u0A_O
 H.XT8JSF3HEPChRXFOpvNlKKRs4ZhAuYR.7FFe8XIyESvrK0Ylvsj1yhFkUjGiPXtgmO.ijwnT4s
 vvrllM8tbO8Cenl.UWh33Ij040PdhfnJVhBthNVKDmYpODXXItB0c8D.w7IKQesAmwKzvVW1gEnY
 CAenHwJKr_cGstpqOuClg3uKNasv6LbXfkb9MV52bEyKyHXEWGyo2RV.8EB35cN_20T_dGaNRZpw
 zT5zt7.0y8MwOnbzqCR_6aTL.ekVHUqhyPgxdHMo.rAZmIK3i_R0bXsxi9fwgcxepkpuIg.XEcjW
 pcWpWV8wo0idbb1faiDdgxtCTlFcQVUc393u68Xsn3RObvZxPbIqZWq2CVXnTXgp_a0SNVw4bDKF
 zhnGdcfuhI0lDinTMvwr_nBgUth8RBsRzjV.Jf4lWXtlty2PfEWPNQO5EStXFrxHhPRMQ29bJxW_
 1U7wuQVMrzMYKvC7LLCGggGnHACbBsuvaAUQVrfa7RC5yC1vD4PSzzXTIzTbuopU0WNkSgcDEKbx
 lt9m8qDMqlJe47u.q9TmiKNRahpOHYQoo_83VgUorG8UVVN.hUxfiGnbnp41nTCiw.ZYYcnF1KrZ
 0izHNlSLeloNLb1P1Xc9OVm5J_4z6cRUQqNbB6_1NSD0AP1p3UaKJuBtaDH_emJFmhEMzEceaPPh
 VdlJMMiqgS6j2vhUg7u2SxRhywwf5vvowvGjkD17vSdYabHCBU_ADOPJ.ahA8.7citjt4fJXBR.Y
 2Jy11J2WD2OdnBtL4ztjsPrQF.IPQ8gfbcD40MwreKFDtLN6Etisr1WlyopdWr4mm3uzrkBber.Z
 kM3jVxrfvXl5_YOr0Tn4RKWjfDzkXP0QM8D22P55_ytVU0K7W2ZUsCMYLZ2wI.FzWPv6nJDu6Om.
 3jBGFFruFerR5a0eNvSyYh9pc_rWXGsFMGxkYKvCfxUUiKns1aj1_f0gYNgg3DM3XQC1V6OzKq3S
 37n.hdJwet5UBgC9T90MOLe5u43PzVvximzjrITa52Yjf.LEvve_ZvWsKclN4ZV0dOwYQQlAO8mG
 U1.cVOcldnmPhF1b5LsDX3Z6EDuLVbje48v0OLqdQDhY7dQyu8xBTmOba4ZiMZV.CjxAJ7mI5m3N
 pbVvTXoGPAfcn36siGjQPmNnvDxYM4uAZU4.hsYCT7gu.OLC8WaLnQdwxEAFARDYwClJuwFUVW2Y
 3QZ8w0bpCVnjlOsRTs5KW4Wg.tOWGc2FMvpDwC0pgEg6IkOuJkrGvCgIne35QQso58k514SZK1od
 agx7ynqU_Zo9GiDd7jhzolgrlJVFwfCG21402gyYtviVesSM2dq5VdFwI3ZsfzlvdZsencEcn03B
 JmdHeyRvELjrtzksY9ziYMcucOUp2yCb3kWiszOCzO0pIwYq8heTGz1EKLJk913iMjisOn.rNeYY
 qGpZwVLwLKYz5WE07XfvI_z1bLoU0dEUmX7a._eRZhf_F_D94v6iv_40uDOlMCkDc8seZATOkvLj
 KbYNZ7kvxYlteH9ezGxLQtiliQpnNXDMNsN7I4K8OGBWa2y_UZhJsamf.33hCBNz2pHhkk4UNClT
 WmPfwZZxGmJqW_x7XAsbfmCYs4NI8FwzSkSe0P0_q.l2HDQNIZPr4AcbXVuyyurIkStLEcq0AHaP
 zwJJdPIrrUa2oChIZHXLfBVcAMp2fWqmVJf9nWlpLtP4SFi4DzEYleutqBfI7vbeMOu_RwI805.g
 JRJiwnl5mQteVZPPhalF5vaLrkKk-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 11436d48-2019-47aa-a971-74adf09de465
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:20:42 +0000
Received: by hermes--production-gq1-74d64bb7d7-cmxx8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 311260ab82870132bd75579510690963;
          Sat, 21 Jun 2025 17:20:38 +0000 (UTC)
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
Subject: [RFC PATCH 07/15] Audit: Call only the first of the audit rule hooks
Date: Sat, 21 Jun 2025 10:18:42 -0700
Message-ID: <20250621171851.5869-8-casey@schaufler-ca.com>
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

The audit system is not (yet) capable for distinguishing
between audit rules specified for multiple security modules.
Call only the first registered of the audit rule hooks.
The order of registration, which can be specified with the
lsm= boot parameter, is hence an important consideration.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 2286285f8aea..93d4ac39fe9f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5056,7 +5056,13 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			     gfp_t gfp)
 {
-	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule, gfp);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, audit_rule_init) {
+		return scall->hl->hook.audit_rule_init(field, op, rulestr,
+						       lsmrule, gfp);
+	}
+	return LSM_RET_DEFAULT(audit_rule_init);
 }
 
 /**
@@ -5070,7 +5076,12 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
  */
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return call_int_hook(audit_rule_known, krule);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, audit_rule_known) {
+		return scall->hl->hook.audit_rule_known(krule);
+	}
+	return LSM_RET_DEFAULT(audit_rule_known);
 }
 
 /**
@@ -5082,7 +5093,12 @@ int security_audit_rule_known(struct audit_krule *krule)
  */
 void security_audit_rule_free(void *lsmrule)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, audit_rule_free) {
+		scall->hl->hook.audit_rule_free(lsmrule);
+		return;
+	}
 }
 
 /**
@@ -5101,7 +5117,13 @@ void security_audit_rule_free(void *lsmrule)
 int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, prop, field, op, lsmrule);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, audit_rule_match) {
+		return scall->hl->hook.audit_rule_match(prop, field, op,
+							lsmrule);
+	}
+	return LSM_RET_DEFAULT(audit_rule_match);
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.47.0

