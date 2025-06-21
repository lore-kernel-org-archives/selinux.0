Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B06254B1B
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526641; cv=none; b=e1SG9s3TgUG70SzDce4rZEReYrghouw57f0btxpLlwnZ0Z/5LajCYlRpzXEzxcm8v7GfULCi0jeDWNgvnZzhlNZOt6R8OXE3E0V224SfNXwwBgRGDEV+1JzHbvdPTuoFspGnI3b7uXMHuOoaqZ8unjjTE3UdvY6JSjNe+ZcdN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526641; c=relaxed/simple;
	bh=HWHyaWIb/BtpPN0SB7P8ktq3MZPQ3308NHR0pTMakjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX1n/UYE7BIUTVx2pTvLVOAieza0L6CICqbxuWIgbeKnEP/wDSeVAIK3WXTCh8/in+iQA1R04z/4ezbppAbYQQDJ+RiEOJBB/hpr7sVXLnuxLO7LYItNeOeSvueVWl42BiSLWtDaUkDPJVsX+quAAp4OpXvgyPRmsNds7Jqgs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bQ+bSYda; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bQ+bSYda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526638; bh=cJeLymkxKR6/Zy7QPMuI4QExf32iwM1KwA8MI/WeCFk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bQ+bSYda8V5GBT+VTeH2YY1lGgxhZEHR2yDS5kWuqx3RwpbMlU/ABPs9fLR0waS7EODe26dikGHrCE1kIERcycUgVp5LM9CkNJxLOHd7hjm7Mpfs9GeU4bS+fBzf+3eWXn7eQFF77dJDP4tMMfNCjvo3fL8yeqnwuO+xjT2ODfhXGLtNqmO53IIG1e30uvgb3t9yCM3WNtzyYgh8yZXZ8EUTv7cfvMk/BmeRtk5o6k/zYfa1+izZj76GL4XOEAmB9qfQB71a5AOrm6Do+WA7iWUZyTTA0bDqw0Zgu59d/1sQy5KcO+PJxEXTtWDRnDdlANLaFfoNqYzoTkUtrVcYew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526638; bh=LifPUm+5DjJKqlIFxJgZTwDJMmE4j9e3aQjOFTs3o7T=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GxJkFniZWEmAv47JLzv/ByA1qZkFrtb0z1r3P2n2sE/8LpPZlb8S7EdhnsHR7a7DsPGxhuc4McJSfggobQ904kKOi5R7oAaoLC7jSAEO8c7mWBW5geM7nWswPFElY2aJYNE2cboOMsX2zTIU7H6b1AyiiMCyT9D7C4pW3E6rUGrXdFpWS+HfatlkQhTbrwLaa9C6xhMurAc3UrKL8VfU5Kk7PO2BSAWVKgm0+HeziaL2hj50+LdgHQMQXrtnXrdUaEy3sTXUpd9iFqI+bTzhbFWXCG2MlxdxQJl0k39MwCdmtuYZu2N8svcPV/WPd+EINLHXdhOyqgRBtWSEq05A4Q==
X-YMail-OSG: F39ozxAVM1msUKuhTxvq1a8AR3kYBUsn5t.Ed8k9yfIGylQGopdUedOtVbxxjxI
 iU6IssCN3Uk4xCQTuH0SXP4AO0d6jdkBvjGsHNs0nqdgy_nsKf27qFKJQ4cliIdJKqvAwHS94cWZ
 aTr0vg157v.XTzi8t1MdFjywq4B5Xj3YV8hu575nd003C4bHoK3ItCigZq1j6L3731zosXAlAfYB
 foreGxEa1q6cv4fPd.w1oXAUbnP5UN5bzK9B44YrKF.lZmIBVXcBrqSHPYADvOkzdJpgvcCzn80J
 hWspdkSyDsnlPJ3z1ivXSj3wwaqWhEBqsRvAke5FArQTAs9mrJEuxy6whs5AsZuNG0N2ZziSx.Vi
 TqZuyB4OStqFjFY4y8ssCEDpei_C0vpQ.zAq7z9_IS3VVK_u1LtTLyD76KX1G6Jp.Z9uYeyu_eXV
 PoeakUiifkvUlDwR_REnYTtVbg03D1NzvkEGQ1Ks_aC.5k6U5qh.hr9aRcmyB.xayA0Mr.fhekDS
 BTZTjVqZdpYaIv3An492atqxUS9i3B2F7JY0sNNkp_dPyHkwfoTaA.lSi.gbF2HR10UYgDcPTREB
 6VgiQqkaBo__km3y7z5Qdu9MljcdIzdGV501mkaBFsV4uMu_PWOcFSx0jebatC6Aqb0SWpFGXKgP
 Vo89._1xZAxW4TIkBL114O3MUPTWslM2lH6ml4iu3c6D8Rdl0HOlHQh49FNrPtJrWDD3_76F7SkS
 kNm7xj5bKS7hl14PA5JZ.NdrXOd8Dmr3kSY7FVK.vd90sVtiyC8.pge.apu4XY_.evm3T5Bokd5_
 WyR5WIlQg5CohhasoOdBhEf2.b2G2f7RX8.VgV8.OqySxgHIZBBB7F.tYQMcWJW24tQJLiCnrADp
 nWBmPflhrlsTy1jo52eFliuwnzYuJIZtutuhAv558BV1Na4JxVADAqZuaTl1OeS2oHoLETdFZLAa
 RhItsSoKgjwHhq8_Y_9xILR5_uDHCN7TSSQNet_Al94c5x_KlQ2vCmiYo4psh4De6vqSZ.5HJfxd
 0JDGKmw2Is2hMKo3YUKudVoJ4SDUNPODPZ_BN7O1HFkVD9o71O6U2l0QT.CjGTQWcGreRl3bHAxO
 98A8usk9Kd6mueypOHZaQ1x4u3_NuMFF080UzOTBzI_6ajMebyxmGhCD._.sQggrAQKKGcu4xEB8
 Gfe4_wa5_fLCws3AMjIXDnH3Y0naESh0JGpENwayUslA.AkcZ0mdQ5eteVePcHlV0Q8Rz3I9joX0
 Hy4eKLbKY7qD7KTprRC3.znpcedQn3kJGw9ncikncMco0TuoNBDqZYrSaG6uoIxyTxC836fuvHkk
 BlhrDIolXH73JWtBMFWEasMrancbkp_wEE.ip_0_.gka0tujn_Vq3MkfCJOtaGWHiLYsJh44ddWd
 vT63mAh.K4WI9gYby.QOPUeDTU3PjMjZCgB6dfyQ.bak5Yz1u.PTHefKH.tHDesGqVG.w3.087ak
 s4_JuUPloO8fzkmRWvfd1SzzLOH2zlubhI6blGH_0oFBZ63C9M0Ua8SExhFiPDEASae0h2Dl2l0B
 sGHG5fVBCO_274nUwqSKPVEfai7tv6C7h0n_62tRRymCqAxSC2qnvJAX.MSMuiXsraVmZM1eX7ki
 Vdh417kKe.RU7W9thINFdFwNn.Czgtg_hZU7C6EJJXP0OCGnqJAQjX156fzU_Mtf2HXU3aTnhCkk
 qunpWLGbSqljM65b1F.PxTHs1RXvy9HTnb4uGaROyHS1wJDlZ.12oP2ZY8Q2nxqS1WkZUCeJVvkC
 Ig3eAvzZlFruC_Uf5NQH6C1MAFRbJmKOxOZyiixEWVr0M01HbYGGtPibmZ9NrGuppl8EKTl1YZNr
 U1WtTG2IA0mS0YbjkHWs43cV7BTzCNf5Gl6oM1ralCXognDVmCrbX24LBWGkbrjAmzPOY.vWrEPz
 rkdjbnHXC5y6GWBaiPkLsiKasOCr.4L6I.SFB91u.ylQOvVq2xLWIW2nl.fAIDU5Fj3kPGiTftlS
 6fEW5iiuXDkCR2ysHBHZAwZQ930yiobZVhGp8Stwyd2BvTSnpgUG3CXbaPuT.61tfCe3rVTH.F4p
 rSghBABpKn_xDjQp4wG2C6KvtQ0BGfEQqmN4lfY56gXECn6pgJb5NIYVkoPo0vpBAx.5vyfliam.
 sqwgB6Tc_BQW.Yt3N5j2HNxnrCEGx5054LU8b.gpUJhln1hVVktrjYF2hxVTDCYScJLRu1sZfOjh
 cJ7Wvof4QAPD44mc5_Icf.OW8zkXovuZx3I_yRj9fvMStIsp7QycghEITcNgoZxoy2Ky31ggsKZB
 XzsGYnOKKoJZ5JT2hCYN_h7.S55d5C_yjZOlB
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3fe1b76a-764b-47f3-8958-efcc76b5a47c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:23:58 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5256f3ef263223dbc5f852ba156c094e;
          Sat, 21 Jun 2025 17:23:53 +0000 (UTC)
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
Subject: [RFC PATCH 13/15] LSM: restrict security_cred_getsecid() to a single LSM
Date: Sat, 21 Jun 2025 10:18:48 -0700
Message-ID: <20250621171851.5869-14-casey@schaufler-ca.com>
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

The LSM hook security_cred_getsecid() provides a single secid
that is only used by the binder driver. Provide the first value
available, and abandon any other hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index dd167a872248..409b1cb10d35 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2740,8 +2740,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
  */
 void security_cred_getsecid(const struct cred *c, u32 *secid)
 {
+	struct lsm_static_call *scall;
+
 	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
+	lsm_for_each_hook(scall, cred_getsecid) {
+		scall->hl->hook.cred_getsecid(c, secid);
+		break;
+	}
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-- 
2.47.0

