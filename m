Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FE253F30
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526641; cv=none; b=i1zkqC0IIUCV7laJQqBy7TaO4fQI3cIyQhuEGhgoCf1R/2ho6jNscNhISIqVoKi90mTrEBatypROxs0IgsuWxEoBZKbUKJenzBwNSkR5iome62hZSBf/JjIBS9J0D9MxEIvp06l316mwtgDSNBSTNCMqUFyaF1hzfORKyPbwnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526641; c=relaxed/simple;
	bh=kJ8f4ZD3u00ToRZgbsmnK0EdRqbXBfQMZThYhH17QzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoZN647NjsUoWbYX2/+t6bRcqJMsiVluFzb/KvPyLJ67BZEwFNR+ULugh6IPdBdzJxspnioQKjBw7lrb3GZe7EAicpXyQWcIyHFmXzwo68hoaXQGpikqwhZCEscvFGTLv/Bq+O+7pmRrluZ4v4njb8A7aU6bOGOmG2jwgzdmZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MpM/FBUP; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MpM/FBUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526638; bh=x4vyQeliurxK0jOyOlK67UgTequUsiEOBF40J/SQBGQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MpM/FBUPZc1eI9jgn364cJLsNZQ3L3UwmbYzGR1rju/0TpQ0t3JxWS/Bap175Ro0IcbywLVoC5J4xx89wzdXSYyrCezWik0lAvFVx4eWCg6k1JwnN/X0tiy6xmgs1oecoGaGPky/VhmMh/gYgI7DSCQmSdvgZ6kHfZL0CBQ2vfTuRQaGUGZHgbiScYFtlgbot1Bdgli9rjSw+zhC8VH3JaoYlm/TWW4Pj9S0DiFiyFtexVxhgB4cjKE2z/roTbm2g5w5fNPZc9HqumEzuaf3JyJa7lThzJSv52+32VYJGcUh33NpVcnh0tfAUfJvuNZEGiPK3YCy8S1b2Z6f+0aBIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526638; bh=GHzkwnY+Qn7rL1xvKp6I5Z6/smvvQDsMofbZqLSwmv5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qdD75DMXEbRigXZg+FMSXaF9XR+kxzHaDVwIsYj++0R+uG5ibhAyQ5I1Q/AcU1+mRFLFjpDCvhYdj0IMcerM/WHCYmW2Tpo0WQ898m09JrMgG52n6OtihZtux/e8YYQ/lwCeUDcoF4r6QYRslVszgKKkOEMIB1me+b4EWPk0F14ZIPTOE41hPZQv7I3U7G3i8N38nwQ4LGHNx6OLGSLCGgvEq0K4kDT11ozrNzzeI225SihJh6MG+BZpeKBFe1RtFaj+r2hU0b8wVKhbiN6RsoNHWEmOEVQ+reb0JI6Ke1+3N+tr8Am+rk/WMiITMOdh3/y7pBAkdKSfNgmSXOJZMA==
X-YMail-OSG: 1zKKyBoVM1mRAMu7D_WQwraIGXQlroA7OXNTPIrI8gC5OOX1Fx8yecB5puzkCWK
 EX3MB7YBUbm7f_b6MPItSKxBDsEhjpyl7w7n4jNAmvuQANpArKNIjDmgkxJ34dALvAOL1uE0Eu.v
 Nn4oJa8QIK0sls85zY5qwt7gn_Dd7AvazkGUHVApntKlM4YjTcemQYAan61Ii1ybZYVjnZyb2uSt
 qjWiNiJsKnlzD5wmHdIBEjulPz8mrr6lhqYOt.12LeMa7wkNJNEuVwinRndmZRq3KzkSWLge4Cko
 LTLM5pT.Vdigdq2Pnhn3IHwAWhmOuCMkIxXroG9iC2Zgus2xzXbPkir6w9LOYESoCnotrWxLjq2C
 XrfRqDligaCKCBrx3LnQa81zfqM9ymSwOm8FTGIwogx6Qn7GkrojjOFExH2QQOWRyfWMsWHnZxNK
 C2awLfW9kcU3EAhgf6n1ihF_8tecyweeH0HyxRNU67BcvWuX.bpPC2QmBc_PnFH_vqPLdruFICYQ
 c3g3C8y9gZl60une26ltaaqjIbnqQjtR8F9tLRvhf20Vfjzw_LoO5L1W9VYEt1o6yUyIrs_zKKkn
 9lzZCy9zP.1iU9RUj7QZtfauFN3Q53qmYQeNXHveHdNuKECJ11BkyHQMyChQBnt_J3IXMWgiYznn
 9K2Kb5nt.ECXWAr1lSojvHWFyANeT6K.y8KwoB7UNe6w_H6lQoiBbEPaVsY8cdkI4GAPJQ.wLAt0
 VmQwXqimo1MNfO_LFlQBB4MhQxbVJ0D.izc9LGwyVg76wh2wLhQkmK289BQyVIfcuhI8TLxTj1nz
 TBQkJXosFuJ6NPcGD1mj4Kfmn7fm_i41o97TuXylm9rv7xJ5NQcqrf5OeO.PHDwTraTDeb5VKkzM
 uJug.eDgeSo5ChlfHs3KNH66ESlWYz4gnpKaZ6vHwgtVq15JejG6_1XKMxn9XVPrusKgZK7I4p9p
 xVn9cbJq_Qef8fOZvVd4bcWVRJ3BN0ssCQfx9k.puKSguDlUFlwR0fcy9HvnfF71Dfc6acthdO7S
 5IirFiNW9XyNO75.OtJqNKO0pseysTnjzk4QeNTBmc2a22ib4qA7duWGr6oq9LzJbESHiTQgOP5w
 o87UazfXxS_FQnO9cCtn29WeZ9q4qdo6WaA0uLtfKl1NUSk9QOJo_WyLTEZTACyibgG7tFXyvQPv
 _DQrqIwP9O23MhorTH7F39e2QksxoajHq0obuAzax4IBB6j4TrcsMt8MSBn.65R8uT1b3cT.m2pL
 jXVGR4FvZpwLysgKYrNeVIdssHl.215a14uQDKH4MmoU_oF.okR502KmYqyAc4qBfY8XjWDTKcTM
 h2oHbhraWtsnWLU2E3ohTGEie1w2EcZHdYUKQD1o4Zf_AKpAIrWbcPrrR5m6Ns2NuVaysQIHhjhT
 wHAKAWMgU8xCJ.EMsttzTWPkou8ccm6B5dJ7SGHyL7Nm3aMwH0P.EL5ESiaN8Bz2pFjYhnD0Ltly
 E_VeLT87IDos64NhxGbECORw1be2m7Dqr4NQh9ruZSv98bIILa5rtQekub5Po3IE6zN332w2.7tb
 gjeNcuw7oUuxdADSccTIaE0qcidnpz_wncmfEfOJDgUcr9ZnjcN3WtR_n4klPUgGTT5UV28UJ5g9
 caoj.jzfN9riU1hPktO1KcLMpTgMDnWXWCQ9jU8WJOsNQ8ilLV7dmDudVWfrWuo28BDO.9OFPcBz
 BPJn7cGes.tQqXO60Ujv0WMxojxgx7ds7GPGQtG0cwf.17_rUdWDDF1NYp8sdT2dC61aGN0jJaAL
 OHbRUjXjsvsh3A0FY.IDDVY6vxQdms2TpxRLKRmDIHyXzzgsG85wNuX6vHeIToUqVWwmRAMW3UkC
 dAE_88eiglgJXimCTMuepEyYHvNeo_AFgU_3csUGpmnFAbp3jtlCATJRxBZ_XwVm_DeJCpLXJjLI
 kEr5b2rlPR1N2OyCCRUb425Zvn3Kdr72OXDPvJiFIVuKF1.MKMfjmkaJlx9D4qLSgF6g.XBDfEGf
 RBOzGvearHp0A.T5Zek44z5giYPqXOYS6DQOakPc3Ol30.SToar4TNPEO3e91JvYvXxNHT6ecNpp
 .lSSaxXtnitWWMmSraC6cNezkLngxMHeq812ncDLleI4vz5GWtWsAGzjYsIveJSXrTDWeNbrd0Zz
 ZV3.tu2ZCoVMWnFg9VwrEZ1.lNR4QbFm.Kl6D8byUs6Phn6qM.nzpEMgZDNjMdAivsMeDBLzDZ.C
 l7SHGtDz5UoDlaJ3UFCLsV9PVzx8cJQb6UJ6Xmo5QC1xb9.nj4SolkssM9HEqXGxyhghhBbb6XTz
 EFXO48Mt8Vttj1BqBSxOjrKDiVluIBemomujU
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 39b451ff-64bb-4d8b-8d79-7e5430e9371a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:23:58 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5256f3ef263223dbc5f852ba156c094e;
          Sat, 21 Jun 2025 17:23:54 +0000 (UTC)
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
Subject: [RFC PATCH 14/15] Smack: Remove LSM_FLAG_EXCLUSIVE
Date: Sat, 21 Jun 2025 10:18:49 -0700
Message-ID: <20250621171851.5869-15-casey@schaufler-ca.com>
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

Smack no longer has any behaviors that require LSM_FLAG_EXCLUSIVE.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 650f2700160f..fa7a9b76f0a4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5339,7 +5339,7 @@ static int __init smack_initcall(void)
  */
 DEFINE_LSM(smack) = {
 	.id = &smack_lsmid,
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
 	.initcall_device = smack_initcall,
-- 
2.47.0

