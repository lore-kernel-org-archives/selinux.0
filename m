Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76630AACE
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820347; cv=none; b=Yup5h9pSEz2dmgCSpDqKkWkyjfAcQ7ORw+NqbQWcz8iWkT5DDf5KRYqEf3Er4J5NrdUjmoGCMJZ5x6H75WInFf2T8TAB7M0fIDZJnCTadyDFrEHYQCDOtzojWIbcz0tU1yAuc0chZul4LpOKiyFf4moOIH6IZoEGz1Gb8gWrXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820347; c=relaxed/simple;
	bh=wPGaNhfNEgBXg6eas8QRRx33yHcI5OAXc/Y1UpJE0T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK777XiSWwbBsajbVOMq5Y7MVuyS+/lK8QDc8xm12JG92odSrF+PxhYW5zr5ut00cMJB6E4GmGOlLSUhq5cFHEr/A+PnWOzTu5c5TgOsnqgVKLhqrMLfWTEmgeUAYBBIdnNJXfCADeXhru+4V4qbSaWTuR1aZRZm7xjRxInHSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cl5k9Qxy; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cl5k9Qxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758820343; bh=tblYsoVyzFLhhvWGaEm9B2IEdWQfucAi7Kk5TxDwdEA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cl5k9QxyPrd5x2i4u5PuTDJz4ijGtYZIR2ip7nQ8bTP1tvhqNJA5hJ3K1M2Gb4KpDCN3n7mCNBS/i39qi/5Nu22p2q0ZVsjOsX++KRVOyrIxRuwMkOoiyY2yrEB9PM3JSD1R/vCIyH3yizRrWQFJEfz+R5tywxst1TUXWRYn5x9Mzk3r0fAiMLJTMsfDcn30ep2+qneQ+xXikGXXa5bP4gC2mX2u6d9TP8+xMGVbmGzpRQ3sCaFtUAaGFHitobAtQmmRBpJVAT6TQ+8i3t0UFEcz3fFDD4bwxt1Z/cLDN61eBW4yelF+hP6uMKfMVIFImI/Qk/sqC97/KkF+6VP4EA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758820343; bh=Jix7sz7EcP5I//NpFpNQdEgrSRJzexgYxwLFAo82/IH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aj8mtBilNvQTrvRKEgYaC87m4BAuhKbnyXsJasnhVbC7a1HXrO8LRqK75L/rxk831tQpSFPj2Eo9Ue+9aqnEB6XZFzJo2LXZZyKc7yWiPG64M7HrHBdajQLIJ2PXjyyXJvhpDE3yCIh3sCtIjQJlOTDPGXoYr7Q0Cl4Zm119nXX5tTlCqb/VMoe6HHGt5QX4EaYs/CQQG8D9n7N73Eme2EZib+C84ODwpgOwn2AIA/rikJIZMosGtOazsZ3eFyMeIfjHDm4F2pNSNWL72NxXMaIsHpjD+OLzEMjvTjv2Oz8virKkn61NXkTU2RJ7s4L/0xBTdpiV206NNqzCLri7dA==
X-YMail-OSG: XH.05CgVM1kTU8EUkF.M.BkKsfy0LaeMMFhTabMkRAWzSx3NaDM7VwU4wzrrWOX
 jXEXrnmycVpB8MgygFQ0y_gG9RoUOy45dxOGe00CjuVT1X83B5v7JuuDLFztCZHMDrdLGb5zGe8O
 HI3oCiZkep24lLbAVZa7Z4bkAqC5NE88Vu4q_dcBpwl5WsyIm.OAcquGTK1dMbvizGTjQI04.s87
 aAJ7VmsmOSraDxHKeqz3If5c1HcoGXMp.V4KKVcvJPa.m94vsEIUxytuYJY6MMCsyGLf.GSeIR0J
 7MjvPz.Il.Jzec6SZlnZ4yeiMZWfPLueOAQcLzLNU3FoQ4ZIRV257wKRtiHuqky8dg8uEVxNWiUO
 cprFDwgX8yJxCh1x5UkPKAqz9fxwXhVq6Yb2XZRRs7PGowMjmJmbSWHn0bldNCkowtnBdpd5MsmW
 cJb7RMtc6hYWKhUIm7_iXVZ7jaZ_c8GS7sM2rCmnU_dx7aaAYBiVjHSbDvIc3avoq55QtoFdtVd3
 ZfYbiSCEjzeHyDY6g1HWALuVoCAf6ZxI54utbhBeQecLo7NYxLb1QQe.c2GWt53nh3o56.oGCXPa
 iPcFZw27zfkhzqdvYK9llBDjc3yNlGsfXkZRpQLZbkTGyMtWKjHrIrKh9Ug9kpkgj0Cy2pA5QTCd
 XHPzzJ2H9KTU0hpzbeVBRa7jIzZQkPQUqll6aoozV1PVJKrjuJliXBRAA75BPWv35c6zP1rlBHsG
 QiaicWRht7_9_qy3qyNBI_aSB3kjDqrB5AF_Y5m3dRwV5ryDoamBcO9IC6MQkcxDh9L2JyO5CkcJ
 G4LP0gu4E22KfMZIcTdVvI9PgVbVTh9bse_Rp3kjNxfV3iQ1MHca_RZh4Y9C5vVbx4ueyIZleoMX
 2AwpOSY.Q3Ad998IO9Rsjmm..FOf1tREIJExRvNZwgtTurWJEu4KKkx0tgDpLDugLG7R9k2PRTdP
 sRsx3zz6Afg.8hfQbIva04rm7t9JNy2TgBRkPxTUtkdlw_0MkkpG0fwY06.npxSXQmgf7jxDDEWw
 8PR0ENlcgRBplORQjDF8o5924Jdmc6wQOrpxsqN9v5cdR4C_bEdHpjJF1txTbXrGaD5G5LtNVzpU
 6UsEgrTKsltORpft8oieM9jeGwOP20P7mm2pQiYIPrlh2iC5eiX33Mw8SYiKGgIPVTpWQZGhvWQE
 Bla0oLWjX0QQidsjs1uQPmyUga1PdCeRTr7qVlT8pDqqgRiHX1U2up9M5kecco5kkPZjpET3SxrX
 QTdMNndBcCyrPiZCUGPXqQK2whvmThkNilYSDODIFZ6HLU9o_e1u6SN7JFa6r0PZOns.PgpvL3fa
 h0kgh8oiZfQQmCIupz0B3Tx0gFk3iKUqOKb5KKvQXsKI_70HVJ3M_mDhq43_tK3pf6taxUne8RrO
 SoMrxJfK.YCNRXKNJ.2cn819WYDMGbK4Mey6ez1KA6X0yYJ8XWmUF2Q9mBIkhULaa0gxdqGhUxRm
 oc2jHJ6SMLraNWvQGbm2vXzhj.ZnRJDh3rb0w5d9LZy7ievS6KJPFU9IZ.gRQLnZZucQH18zsduv
 hkp9FZFp6pFF8luvZP5TkmL2xgSz_wUNjEd.oe8_CR5U0N.tVXAHrDqLvYCplQ6KgFGqCRJ3z_Au
 izCaJw2QK68xcBnSchEtqoFEkswFJWNBg3ItCeTMBo51ubKAH7kErNWd6.Qt8CSUPu0IBLixezyP
 h_ZWoeY8O1nY20IadcxJ4ObmeHCORnrXUysQsoUHNr0dhxHpmkoOp8mPLtc.OlZvkOKwjTWpdorJ
 kfLswMiIbmsLGevcJKe5Ca5ffduj50JKCnhmXHx49VWm4UkdT1D_QkytbIAYPzipB1i8mtUW5Gg7
 xAq4mgrc8J4Z94BgpGRmhyYtdhSf3_Wd13ZESIdl80daS9JF_QBYoxw2fzA1b2ayu9vNXJuJFAdP
 CuZHZi3GeGHoKjsGE2S.8qvpEHFExDBd03GVrDkvbCSuwxrolo.8fduhKmPobIbFFMxAg_xmL1n6
 kyllN8wwkSspS72oQ3b3faqwqeMJsdiAHBGu531cegJZ7XL3RQ3eVhVRkdSMq2U37w6j.MjkFla1
 seFhe2tfliRlLw5FHFUy_S6El4DCf8pIFdN.YU96Q.NpqwK6e22tY.w_7hVPyjTMq3AO0amDcQFb
 GpkfMCvyaccHwQL2j2eVbkXj2HOfIcwTfeZbJeRQR6ybLCLSctp5oLsWjBFCqMfkRu08wReF0kVl
 U0Wt5PZzCNG34dQ55vicJm5tCJ8St5etv3ubsAQ7mJiERJY82flS3uCdI9GdBXVFBfLw2LzdOOIh
 H6F_PZ7JqRuCJmYfLNs9HNhA-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8f117207-dae8-4aa7-9653-1db26ab39f48
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Sep 2025 17:12:23 +0000
Received: by hermes--production-gq1-6f9f7cb74b-bmbkz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6f3ba4c112cabb90c4068fa90708916c;
          Thu, 25 Sep 2025 17:12:20 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 1/2] LSM: Add mount opts blob size tracking
Date: Thu, 25 Sep 2025 10:12:07 -0700
Message-ID: <20250925171208.5997-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925171208.5997-1-casey@schaufler-ca.com>
References: <20250925171208.5997-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mount option data to the blob size accounting in anticipation
of using a shared mnt_opts blob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 1 +
 security/security.c        | 2 ++
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 4 files changed, 5 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 090d1d3e19fe..0de143d7c094 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -116,6 +116,7 @@ struct lsm_blob_sizes {
 	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
 	int lbs_tun_dev;
 	int lbs_bdev;
+	int lbs_mnt_opts;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index ad163f06bf7a..8390410aec91 100644
--- a/security/security.c
+++ b/security/security.c
@@ -283,6 +283,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
 	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_set_blob_size(&needed->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 }
 
 /* Prepare LSM for initialization. */
@@ -480,6 +481,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
+	init_debug("mnt_opts blob size   = %d\n", blob_sizes.lbs_mnt_opts);
 
 	/*
 	 * Create any kmem_caches needed for blobs
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874bf7d..4bba9d119713 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7183,6 +7183,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
 	.lbs_ib = sizeof(struct ib_security_struct),
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fc340a6f0dde..1f236014e7d8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5030,6 +5030,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 };
 
 static const struct lsm_id smack_lsmid = {
-- 
2.51.0

