Received: from sonic314-22.consmr.mail.bf2.yahoo.com (sonic314-22.consmr.mail.bf2.yahoo.com [74.6.132.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5E1FBF4C
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718635; cv=none; b=LiVQtd7QTAudzP0E2nwu75Uqzqfvv5RujeZ/HVgoaCQ89OeDT8eP5krze9mdeUjr4grFZW3M9uiPq1gkZOaJXngA6kKRGL51yIfT3tSZk8UdbZO2V/YgER1yXSHR4RbepZUPZXr7MuyRE9Wog7Q2sx5JYIYs7i0HZW+3H52Th60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718635; c=relaxed/simple;
	bh=xI5Udp7+iPy8mZha0q7CIj13Ny/nmKfB0rckcmSATx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8VD0y44SZfMooeWnDsVrehgTtD/V4KA3VSwo0/sD3ho4dv+3pDoa0o34zHYnspzzyNkDMCEhadq4PixcNGojGcUAgY0ltJ9sKy/YA781r4N7PMS90X1tZAnwVOKrzydmQsvoJws4uxu0SkgKTj2gxeWUMrhDmwQBAHLQNUxP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fr7uK6et; arc=none smtp.client-ip=74.6.132.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fr7uK6et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718632; bh=UnQ0rI2w33MXrRKYOUPZC8/87Ao4K9IiWmtcpAV7+bI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fr7uK6et/YAx+qyUKA6eygkZedeebOOL6bKeY2Sndbhjumpk95padF92MsLEvYfv+nczDAThs9IgoCyts0C/lItVJdCsbgh0ZbWjm1EfxUqANMtLtSgZQ7bqaH5+qCw3CR4/Z1yDXpdL2oqJxVMKGYdjBA1U0lyapksb4gmyLquy0SLXNez5aLue1+ymRq2/WJnr5gtKAdMkgB8D2pGREqaant+MBP1BBiSwwuYuzH4eFakhIZQ/SDYL3FbTuGtCYd7K1cG8G4OuOOhm6aM0frYO9OVPD8k+o0As3wD5rVI2mKCPExhmjQ7ln6nRu2f1bn6smUQ2VmNzib9KqpZ9eA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718632; bh=BtzF3sJGDcYWa7OTjtwH1ZCDRrlzg+6XoLpnavP8yrW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qqHEoFeRaQO+PRJ6aEUO/jCkTdizp4xQEI4RwOQdCl3oSoPEiiyjC8Edx2xmY+jFz+duZtL/2CtbvsWZq6lbvQgk7cadQdWzlaMMW4HA3T9VPZi4Y84hxKhiC/y9e5JUexpIQa719PjYg3kdblSr1VFHHlg0sPKowy1wdVKdJS+0xC/gzi7P/DWUL8eYvBB7zpwtOfS74BQS3L3YgHx5qeu1oXwBwtYcKBNCymJ1QwBhbrAckrgbOAUpG5TKFj5FRh3roH54QM2Eio/oVyjufg/0pwevatHW0vcWadSdGdyuALJ1eSImYeHs0maf4Q0dN2uWzREj3pHXRRC2FVUzFw==
X-YMail-OSG: DYTnJWUVM1nuMpFoEsfs9VW7mCAzIzNOUfaT6wet0nBcvqIzpI6zQpBsEkyLSHS
 LBSZkPUVNZQwH4PCdqwqey6eZ5Ha6btUjGs9CRUMj4e_ii3qur.dcLLuC_h9L0B6VFUUUR42OdY5
 J4aUpkOL_2J9mb6oQxEgFyGXoXNd5LOFdDQj3arTOxWoczEq0TZWX2CmU9UewVLYr2ep1mxsdCi2
 Q8kd_7d507eAd3UgzH.2d7vuijBjvX9E098.4IpGhCxlHIO5jVe9.0LZeJ2tOFqRo9_UqR.ncj58
 he0bIhV6QnBLv5RKxYWhrtT98ECFCG0zkovfxpNBPRYBNBW2UCefRKNKyuzrxVPsWejYckzv_FeG
 Z8oX53z7lqdXomVUMNOtnYI.njw_WIdSb5UIzuFnV9zGba9iSzZ5E97RvdmykNbYeBkaH8P.O8wI
 pM0QPQ8IOq_YfboQqohCNBB1Q_W9sxChWMSOavo_UGBf4VeuO8jFAgN5pCKL0bdVmOJL7q5BNYjf
 XzENkJj9BOvF9bsd6Lb0AKbu3rwdKwC58Cn6ZUzxGpIoYbwrSSmpFafaFzDZHdV2tofohqaAfEaj
 N8NzaQoHo_2YYvcJ6mpVN5VKpCm7LBN72Ypq65tCm_vTC_DvFfnQpFew32XpcKGSptiFRIPSXlKA
 MiQfNU8N43SVvgd7U8UVoZsuVDRMRUqtko10f6PdP_LfrQJEYbpLPL012YqJM45ZJmNmyrLDyseO
 OspWQcvxDsAPMwsM1o85WKzAREPUolCEILYJy279n7u0xy5Xo6DwE3UVRnkrC2Rz8RHQ9H4zQ0er
 enJ5xXKWW2I1qhJN2rY7WNKJGeHti04gFKta7D2fqLwhqxbdlLSBMt.RqVRaNNLznJ6j8XzAPxDo
 S1GUGdFe58E4NjsdtyX_cDx0qIgsBcl29FZ0U_yTvWDAH0FM.fmjA4CdiLTrSejFAERe7ftTRl5I
 3hZIh46uURW1Uvde99rgjzQl2WRInYZELT1lZVZQTvsxHSesHTsUSLm6KLCgvocbRJ1T8.0CzVO6
 A1_pSod3p3w2DJF.ag_RObL3Qt4RnK_.WZdZhoB3m2TZ3PX_vL4cTISPuRKotVZJgFA5vrjAOXsc
 ERIcvkxBTp7ZxgGICdyUDigX4RlbtThOKztYEKJY.TsnJEe5at4HNqGDWtoMIBQfqZ.WRzK55Yk0
 YeWXAktwTg63mO5vZyIrEQjyZPQLM18wkxJVsDsh7NBbooUirke6H45PYFed9LtYwcWD6txMbEGd
 IK8BUDtNjDFRHwusbq78INyOQaceCguh_OX7V5AnRzR.Dg0B6EhX.xOo2E1RNHjqkhm0r556HE52
 5B1R.og1bGGbYkhtXznVrloql.qL5aZyUYdCUNzMqXXTiu9qDBIX5hss9de4wXULR9lGfUZ.CAJV
 hBi6TedEiaC2zEHw4HhBjCerAntGTANOxuIdLOOCJV89MlvbUq1kYzTAsuUm4XlShB.h0yWcXbCa
 IsMnFeIm._9wS7h32vzdpPbuIOrQjQdquYfGyD6K_tZ4Wj0UGsvA9sirU8ZX1cwWQuTqPThxpkp1
 eKKvs5nyRlVf2CVy5fELFd5LHlBxfb8WzlUPlkvg.vLUuUmw1b92teD649Gvrpd5XVD61mjBAyIl
 LHyZzqU2Jz2fJvpo.VndfSwbTrR44bRcMBJRm9WSwwJyGi9i2LBRaDiVha0q1xp5Z_pSBAR7VLC.
 spG8YU2uj2wzXa97AeZ7T5SGHI2CAblS8zhwie3cSngh1gLr7hJ.ulnZEmLlr_fCy0u2f_6BcjmM
 bQw00GFMwBqpq_QJA_Y7Wzc_Kccku9fIYeCIkchxWvRkkRNG_YQVVst9u6qQdzAEuNlgKqq0gpYA
 x2VTVFg_MQkbUSvTFPRJtVAx.bbQZAraCwdTue3Nbhx0q0HjlCwXR._edJ75RNojyJx_Kz9bT.Uv
 rEZbPRBwssicwFQHxg2IIuQiR80wEQapNiXbslI9ylCtAZ9CI9Yf3pRLmfMjqNiTfqFQDgYkphBt
 iOOWRegwp5RvJYdQdwNE.Wzm9vV3i8FPJMAYE3bsJCOYIOVhpFyDmkNyfh1JtOFAed9S_xM9xNGB
 rqN99HBamaTkHjyD5RDRreqoQUumCKLOo9ZN31pJ1gbqZmZni0Rm0loLHfKAjsVM8TmxR_bmfrBj
 j2lcliA4ECttSVgnVFsiWuKCsf9v23Xmd9fLocOxrDaZfv0hox0inNmtrwxhcZ0KWWxnxkXh4x14
 bqRDOEcd4ujewUfd1G9qMixyGYYHohAl1onzTTIA6Pjm2_cjU0VXkZqZQtv9.j5myKezWRzOJGkf
 lXKH8pJX5ziTsN.V.Zkv4gScJdQ4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0349e8d1-6b76-498c-9fd1-a59c85c93dce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 23 Oct 2024 21:23:52 +0000
Received: by hermes--production-gq1-5dd4b47f46-pfhh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d261940d1cdfc655543cc442dda3a810;
          Wed, 23 Oct 2024 21:23:44 +0000 (UTC)
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
Subject: [PATCH v3 5/5] LSM: secctx provider check on release
Date: Wed, 23 Oct 2024 14:21:58 -0700
Message-ID: <20241023212158.18718-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023212158.18718-1-casey@schaufler-ca.com>
References: <20241023212158.18718-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that the LSM releasing the secctx is the LSM that
allocated it. This was not necessary when only one LSM could
create a secctx, but once there can be more than one it is.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/secid.c | 13 +++++--------
 security/selinux/hooks.c  | 13 +++++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 5d92fc3ab8b4..854613e58e34 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -122,14 +122,11 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 void apparmor_release_secctx(struct lsm_context *cp)
 {
-	/*
-	 * stacking scaffolding:
-	 * When it is possible for more than one LSM to provide a
-	 * release hook, do this check:
-	 * if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF)
-	 */
-
-	kfree(cp->context);
+	if (cp->id == LSM_ID_APPARMOR) {
+		kfree(cp->context);
+		cp->context = NULL;
+		cp->id = LSM_ID_UNDEF;
+	}
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79776a5e651d..996e765b6823 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6640,14 +6640,11 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static void selinux_release_secctx(struct lsm_context *cp)
 {
-	/*
-	 * stacking scaffolding:
-	 * When it is possible for more than one LSM to provide a
-	 * release hook, do this check:
-	 * if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
-	 */
-
-	kfree(cp->context);
+	if (cp->id == LSM_ID_SELINUX) {
+		kfree(cp->context);
+		cp->context = NULL;
+		cp->id = LSM_ID_UNDEF;
+	}
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
-- 
2.46.0

