Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA02F0C79
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362522; cv=none; b=ZzShfQ7K99lYSMzNGUrLoQgkdWxOU8eR0PH1/vSb7Q3tJsKksw0w8mvd6poXN2qSlUsodNdR0UpQ4nav1hFHwU9PQHawIsnruzw5+7TEK+b7TqEJirhdHNkPZS8YK25NSoZmaPqeQOgbMviHAQT5xQET+zxcM0eR9x2kySYAniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362522; c=relaxed/simple;
	bh=IfyU0SLKhVx4/evH4GZoQneZPuk9OIpaNSSabTsfFxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD7Fc4de5ikFxrNqE7obzn6A1Z3eXd2JzZJBoMRQNgn3/GiGUCH36r40tuxrd0lVumQvnPt7gJsQ/RhxPexG7cdOEERlgYHhNANZu+09nrihpiV6YHiCzget/o75maTQ0cq02QXmLblAp3UO/+eGOsvclu+y50Bn+cdUdWfj2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZctXdS7V; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZctXdS7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362520; bh=fY+bnHMn1zvihdkur8/hjRqH2qCiWCld0D1nWQRQIQk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZctXdS7Vei2WaPC0PV5/VEPrq12NM0LRW5l//omX9peartivXWNxHd4w63ovoe8m6f81LV+7cq21xtT4OT+TdK64piK/Cl+wiX3Ujkel3978IscUG+sPjCGYlirnvN4hFpFDeXbb3o4G34zxVXsRHmLnx2wmWgLIV1A/RKKZskzlWRT2c9wKmL6xBG1qO/Kcplpv+H9ENfE1VAWt8L7asn2eFRfWYUoJ1gyjc1Kx6CdlF52BT0t+OaoHrFy8KM3DTeYmI276rCR1zRMuoH/46ZPGnHC3hXregfVbprawy2UmRFlwJE/PnCDeTdZUx5/b5poQZCCtGXGrOg/A6rTcFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362520; bh=LbayN2cdKXH4dOY63ex4uyZbhEOi7agd57tfRfnrm/U=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DmOlX6qBdnZm/Jqri/uSglaGlBB+JfCskAMK/KC3VHf9gPa+sr5oa3JuQSE6m2JjwG9TjoOMXjR9OGAFnFATX699o8ZTtECHNwQGjb9GeDc57IDH25Av7xXPTY0TJhe7+Lrp7W9wpaan0PVwoRnCnRB/zmvdiplcTq8BuMJrteB9hZkmPkY8gjLDHiBfekgXF6f+TJvtWev2Wc/1jfwVExRMnAsrAEOZirwKH7nYTCxiJE9rpl3MuAlBrkC/IpVq2KrGB3zzLt0r+5Gy7v40X6xQTt4DeCSQBky/yTBsViRbC0Q2MF/hd1Pm2C+3ECGaEbSQONzEZUm3q5c9UcHk/Q==
X-YMail-OSG: Eh8n8gIVM1k9N3KPs4TySABCYcvWEvOLX67P9EH3fK4H6fQA.pktdSmyrB0Sx.s
 rAHI29DRWMPpiBMg1MVFGBVksG4EfJ572QU22VsDljCIdKgvs6kWSdYHUrxkd8VEk.ceK1h51wk3
 TsKU3XuuCmNFHYWUOkgu_ePXCNGvAJgbzt6qakeNUSGt9SvF7aBe1FT5wPXFfAJ6yhMOSb9dLzwN
 ySLZyCIUvJD2WGw1KJUBhtuiv1VCrMADkcMhn9lt8EoKa_clLcWIIidxcnKFsvTUuJC0lOdImeMQ
 FnkZmW_id41C4AW6sy7D95tyESpTQY_bZqYM0WXlzKA6EenlGxHzIGctXc8T1SLVRezcTMP4aXyg
 .8jZrlX0l5kDe8XcrYTWV7RkU_ui95Y45ZCIyKCG5zjIy8GT_KZd0H2iK._ZlL3Iug1tRE6rUMr5
 rU8UzA2i4kOpgMnpq65fYLX_gLvgf3ZQP3rYcRpz68Nm3dQlrk.fAJ1URULbj.Bl95gVSOrozAry
 x.rZemwLhrEiyskNvF34OYmIa7ad9VD9_0SDG_bvIBrbpkZx.IPh4pfH8NdbVE6kd9.6px.w62tY
 5c.yBU3A.6mRukcVoCnwBWfXKG.XqXwFuVtsrX0sN.hdFl5tdgyY7pt2q3yIQjvTWkQulQaLNe3y
 uLnVCnzdGvsZXNUR2vYpl0PY8t8qB.Xf_3N_BQKtk.IRSzbTU.q3u7RSt5.GrZAQtvEeJobMOdS3
 XTPnKo8T9zpQezcMk5Tc.0ebMFihbLFy0K0DBHy_718ihqhQqTwulrk9x6E0YZy05P4osM_IDls1
 v6dix38ZSuzPe3oogLQBK.owgHsQh6ItC.Zj6r0Z8zd_e8xBfpztQS5TlVFiLP1DO5YgfIYqYLN6
 583ZEPSB0oXZ2uK_lgk_17xJryik5R.FxnMHWz96PHVGM49n_PpaVxB_CYO1lsF_5esuta0voFI6
 HYnswvtBDtyCmXI5two9y8rSTnn2EnoexvvyVNB7y0oEiVEKCPu73rEMbwE1ydzxLhYVvvUit.fg
 _z.MIZMbaynsJJWUEQcEdo9IKWgwGTqu8hRMQbWnLva1JqKApQcOXhLYJXjH19yO0f6sUxVZgPHb
 DT5Z8Es0cwZPVxUaBAtXxfrFC84nfZJCmO22kOpjPqzKAClFEOk9yiefEyKMLc5qDZdvwm_5Fvue
 _3SB_NIclr.LETW8G2v3KFghotZZe2HXv7qJUHiX_b6oXn0FCI.rrSmRaRm.ffMyW.QjeDpEDCGl
 1DGOLiaYeV1Pqbd6H9ScVRR9H_lhith2LCNKBOoi8GwJAnNlkfy.2SJosBBF7G_5GHWMCR3c9b.9
 XYDivXbEn7M1LpAGcIYe8HyFhy8jyTzb3_ppRWUCtjCw1CpgVTz7o9qaw_atgJcIgiFnA14q4W52
 bYDwWBE17T6Ky667F_fvE1b7n664_GjnvDQgV7UAtEcEq5RelcTlOLKe6Yrzy4FoosT5MKtFankk
 3RyGxfh.fuA69h.RDrJTuCptI4koFzDAHC1WFarEBoEnHSmLrDQrPLmqUZRx70UOqNfwxwjNXr6o
 LJ9ij93Eh8iqfpj_H2G87OID3XzXFZDecMViqNL1B8KsyWg9Wsuz4TKMxbwQdNCsZbJNmMvGLU07
 E44U4yU3ONgeh9zyU828Ljj1ZOnSx9nsqtAvWeEsoiaS461vLHNYw74nRZhZzkqeUowlnjMSOIg0
 9gwcDB5QuBXQwWexppnUTxoh5MbN0r9paIjAFsBcWpWESG8ZB0Y7iV4t0_VfqEgslStVd1qmiEuH
 Bj0JDysG5BMok6MJlz6okp6gwzHiUTTtbmIbPy34znhyFdvZIY.xCUzsbZ2ju.fDLwi4r8C7EPfs
 RSw0rhKTaDlfO5ZVPmioqyE.Dqrm21K82ruRGJRbPD_PUf2B2ve_wwuq1153NxmEH2ZxgfbqsEF1
 kx.bidhCZFdQt_XRG65qgQ6hcbSvdzTvLh.TyXuD5iPir.KGqgG1hyuYpgVko8HDVwxl5Xwq.kh8
 cx_XJ1M6EzDP8nO99yVOkUnZ3K8XHmUmWIsZQo05a4bltz3Px77QKBHSJpZLEXE0CgYk46xIOaOR
 pIzNZ9v.Ziyj3jbAot_NeqEOVVFXXaMmce7gcRbTBL.GGlqE0vNnJwkNx8dKv82QMBFOACjv7F9T
 QfBfcrVeZgL6IOfZ0DmFgmRNtz19i3fTyM5PVHzoHvewC7ztrf2AvPw37KyWhbUG8xoCyvtTXKXa
 .h1lyswBKXPjYcXxF5I8zDqTCWdb16RXJfUhhlnPbdo7rHt_69aQXa5AxhULsPg._ikDmdWdVf1f
 .3CePD4EnuXLOSHzX7M_PAdGj3Fs-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ad2a0721-8dc7-4b24-ad2d-9848e8b27c9e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 16:42:00 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12cf07a2fbb9800c7a9ea9632f3a0835;
          Sat, 16 Aug 2025 16:41:58 +0000 (UTC)
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
Subject: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
Date: Sat, 16 Aug 2025 09:41:39 -0700
Message-ID: <20250816164140.6045-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816164140.6045-1-casey@schaufler-ca.com>
References: <20250816164140.6045-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two indentation errors in audit_log_exit().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/auditsc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 322d4e27f28e..84173d234d4a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1780,15 +1780,16 @@ static void audit_log_exit(void)
 						  axs->target_sessionid[i],
 						  &axs->target_ref[i],
 						  axs->target_comm[i]))
-				call_panic = 1;
+			call_panic = 1;
 	}
 
 	if (context->target_pid &&
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  &context->target_ref, context->target_comm))
-			call_panic = 1;
+				  &context->target_ref,
+				  context->target_comm))
+		call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
-- 
2.50.1

