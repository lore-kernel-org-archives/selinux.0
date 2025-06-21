Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F4254AFF
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526541; cv=none; b=QukJT57Kdl4H98br0ci2C7Ijp3w3yomJmbGUOkhDEBZNDe+3EXYvvhNuVYMWJ/WM3cCMIaH6rJsg12K4Asa2rA9XUyqVr3p3ZkANGVWouI6gBZOn29sGrknfUsLrao8ALjD0ySSzu5UwJG+joZezZwFeWuAOSiQf/IKTRaQStzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526541; c=relaxed/simple;
	bh=cXiQebxgLX00fT/tSH95ainL+DuArcuKLJT9NWIis24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLXx5EFGZ9v8y2ViX3SBewDtK0TpBG3G4TbECSF1NiMl0mLAl4LhGCzaPQiHLLJG4hLT4RYntOowb2DwPTXgHtSUoRpAO1D/wBJ0bAvPbBO8XYD0m1Oivt+EjYxW+s6KTQkKTXuggnDUB6S9NLEAyhg4N+2dDQopJijk7n4WkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Mx9YMRUr; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Mx9YMRUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526538; bh=rabLJkQuOMiYX35FNRjwZiFevYSDVzgMqoGPRpzLUwg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Mx9YMRUr9cv9oXwRTjvF2wllIhjBfqP3y0HtjSaaHzxIR1Qw5tYPOoeyZ41mGqc60pOKKCM8nwOQpOG01O5o0Clv1Q/y1O6DRVAE+jwsmhwT8r4kV0UEI0SHY5cfZxw+BnpXNSfDfOs5ZuqzQBk4UmBC80nYN9RWF1GuUP+8bkt4lnFMRkgG31tcydD541dPURku9FULWlHAiag/0WQYKV62rz0bQ192jWlrgwO20JJ8q28WB3WeSvoioU1sOGLul1dYRb1dlseicu/v4/UXVkiou7SXrKLB+iY16qosUfXb7VOOlsRaZ7iYx6M5XpvUMDsLYfzuzyMjt/0dEWPBQg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526538; bh=TPRHdfcg3c9hvB4bdbvELaIMfGbtH/TwK3fKgCCl3mr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e7Qf5MT6NMYV4TqQyiwrQ46/KQswsTFdev9J5f79CE+4CHeuCU4929lUFLEr2PRHGS2NdGfrc9uVo5yUBFcadAhQ2DJpyo9WgdbUQoa0NI/TzfM8Ks5CXvc23qKVyLVrLdAzwEgVO6cLoiqe+asX5LyGV1y9lMUdiDm30FLEyyXe5KDEI+TK0X8oI3+YZSzMeEh1daDifXwoPFz/9du3Xk+xXrCaxV9Jq/KKrl6OM9C2ZZHkaEBEm5M9fSstxdc1kLbWpk5SF4JDr3OJ1FualQU7UuD1pqC3WIZfJJdaKy8dXpVuikp5OZbkQv5mLErHMlD58FLYD2Dgk/fKABCN9A==
X-YMail-OSG: _HJuy2AVM1k14Uw3UABYidswokWmfNEAS1ytmRt2BfMnYMIX6qpizcvLO.TKgQE
 UjPRmtipwjEZ2R5FLcvK43XoOTBDxsyyg0jLdMZC1iDQFOmuqUUb5NEG5ZdCZW_5xhEK756FCiBg
 oQ5Urb4UQsFTxpVEknf6D.TCOxda1OPXkkMcTWq1zR0SblAV0yVWoooTXSnNtJxNdoM6qzIoO_VN
 Dg4vf16lIWOaksj13bu9oYvK44GpIN3cY1z0IPiEV7Ace3jKIcod5dIc433HdxxyOngRv9eTq8_d
 z62hFW.jDRfG3RIpcDMfZPKnvn3qH73OjYbXJT3zJVpcm2fLo_SVqWyc7Q4K2YZC1XXTyXpaYW9f
 w1WtxdQH12sO2TEf0rIdwz4eUFTJX0nQW1zCEf_IlY3ysETKkD3J2K8AnyWFgG8ANSJEZ6Tyb1PX
 DdExZZBBrGa0zk8pGAqjwiR5WIswbgnw_P.kJWnL5n97KOGlxNtp7avDxoEOsgwxHTqTLhqXnOzf
 PFYdYCMjKUtDfbW6iEd.nEPpRJ26pxkpORG9Qmol0VrFDkw7pCCReckqXAqESrzXqq8CGippXsUG
 9eiax0mKnsFHmkp0rGlUwktCYD2xPTN4I0_24SRCMHINA_5MsHHriDyEJvJsnbHANI.sHMbP_z51
 AWy6.VNOQmf8hOzQ6lCQGdteACZdLaQuX.s_BROV7vzr3CovpjYu24ZlgWBxRlVTpk0D1AG6YeuK
 uG3yymS5vv.TwL5asa8FdvIGKN3Sj7WcyPCS9CeZcjSnfqDXVQ4VYyykRyMeZMOgGCuob9CGOzlt
 ctX23Dxyw71oXZ9PvoB3RyJ3cUmCgU8XKG25Tpx_7Ge7uXy4xRJ005tgfsGsvnBfLiKyEp8eC0eV
 ozJnob_Lft.jd0kRZKpc8epp9oRetjOIX46MXxEes3KtJNuYaOSeq0aD4TaHew2YVt0uPvyNX2lN
 nlMHCI2cqQzuFGzFsgIQQZ.EMpI.FsFzK0fBLclT.9rkZfOe3HTbZ71W.qdDQUTf.FwhR61u3x7.
 RKZGrTwCePLeFvlrZElkHijIQnsFjTqquaOxnqIxibsw5tS3OwG_xlhvGAhubQ3PvhhJ0hhUu27m
 40ywYwCAZmJuvydyqgoJjShxpG2Rs1e_076J3DZkYMCXOZ19FoYzd1uO.SCwq1iqHTAirq2_nu3j
 SOacJ5OOBeH16wsfCPsyK0MNoVyq9Jc2imKK9QlFUms_4OJlGQn3GT9qhVOv5kN.9_spXPbeNypV
 WJ5O0aGp9Rcy1J0AXKuUWsG.qV3VMPPfVTaqau2ggufsXW4ZHe2IKtAthrnY09isA13uGXVbl_VD
 FOLGTXgzrFBcH4H1slk9sn1zE48t.TWkGwAb49g.01Mrufrfj64CTwUXMhIh0YFSwyJof5Wfebot
 9Hm5n2k21SompOy2iz_ncnUMdPn3J3azRyoa7Guup7.uFr8CLTiqjwz8u1K2ia9FZApgxOCbIygo
 iI5qV0DAHrN6l0TRP.2zACMzHl3a5tA7bK.F00Z4gtP2g5eVfFqGtdinYQ6fWasCsABunwzcZq6m
 RtP3hPoP107UjR5n68ttHSp5MUoDl7vSms3vDwPth7AnHWR5h0G4SKildOyhWXMit4jJexvTQUpc
 yxSI6CWOroLTn82CJZCD86lk1URPmr4w3oO1rJ4eoF7wMcDxEd_rFdkYtK09o48iUmtiEU1j.iyE
 hDXLXuIEX1Lw0yMKYfP27c4u0E35iZvjMIW6RPy4ZAJ8qMLxW2RSsXBub.QSVj1m9skb53E8c8Q7
 3bZSOe.HtB9QKDuYBEUa3cHxtiWylFeu4QwxgLyFyd0gWiNB_br2guO4iXyBIAG0u70qcmMG7jm2
 0mzUKIcjXNk4m4ujGAJ_X0zy0Q.REIA1aNsSGYhUtaHAABuvdBStSs76gY.YRF4oXsY8U6wiNyzH
 KWvTNsTG248b7jWEWyWsA_JxrqOIWPVljSVDCuyRbwnE_ikWHpG7bxV3S0XObj9iyzg7kIvBCtJy
 VXoNT0WqaJbNiqH5da3J4XImCtMq0htu2_GdZIjkUYrpKP7rZ6B_3wY69m1i1xjvwfPQQwvIOMmc
 WGhoLu_Xt_Tmi55g36Ogtc4hMcT9Fj9r6g2i.j1rlGX_fbJ7LTT9161tkpnyhOdlNTFKSd0xq756
 qmwKcipn5G2zi.48wQZOYuWwnyMAJOrNqSrh3FZnjAN8lNSyAZ1zQvu_V4DZJjXxcu.dFE__wD3J
 9swQUXF7FTk9G88hqAZyjLVu6L8NeaX198.7K0I9BdjeYwd0sbVM974HnhHs5HnW4EzMEzH8a8dm
 N4I7CRRZaD0_Bcg3y9BBAf.KJ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 295b33d7-51bf-4ad8-9a32-de7877d31889
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:22:18 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be755b04d481595739dfcf42be1b4c68;
          Sat, 21 Jun 2025 17:22:13 +0000 (UTC)
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
Subject: [RFC PATCH 08/15] AppArmor: Remove the exclusive flag
Date: Sat, 21 Jun 2025 10:18:43 -0700
Message-ID: <20250621171851.5869-9-casey@schaufler-ca.com>
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

With the preceeding audit changes AppArmor no longer needs
to be treated as an "exclusive" security module. Remove the
flag that indicates it is exclusive.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 255d2e40386f..ac38864d9bce 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2278,7 +2278,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.id = &apparmor_lsmid,
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.47.0

