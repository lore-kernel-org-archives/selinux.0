Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975071AC885
	for <selinux@vger.kernel.org>; Mon, 14 Oct 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919007; cv=none; b=egFY8pZJh4TVPpK1KAgUDbs6fRK0HiquGsltl6oeU3sRHJqVc8tt3hUBmG8xdZPXwbeuHaKHKHM4Ve9JvFi/jvfz3vzpSfThXRuJkfkQnrcHA0M5l/S2kfqyfCTpEsYuj6e4PH5FechZk0zt2qXpssJ2zSWPypRj0FPpbI4YAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919007; c=relaxed/simple;
	bh=7/1FXUJwvlcxt6vdNjwfBmeConrT3KM7jGMe9A/9bmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNPNsGs77NNc/hAkPIGGtyrfQim6dpVyPGrb7m+HmCNj8YgFMUsTVX3SbCCJ5Wd23WSttq/ldav1t4dtnyVqsTPjDbImm5xsHmKeJd17gQa9o4J5EUEmZCZwzDD8p8QoWmZpiWk0dOtfWTTaEFO/XjGhLlxALx8GC8zxYjQxKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mBI2m+b+; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mBI2m+b+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918998; bh=TV4v7cqRw3JBLh3olvqrTMzRkPf7tP/c20WTH9ANVLw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mBI2m+b+1XzCVC8JvmT5LNXRm4BhUQPiA9ae4xwSifS0WE9aNHb7MrhpEkupo4k04L3gYvvF+8/rRXBmbs5SOoCnv3WTbMAr0EKQZAYh+R5UR+J5HKPOIG49PktmM9qodfrl7ZRgk2A1cJHE7T2l1eoJn1wik1DszIEBVP935pO88ktO6dGdMHsns5jYuR4KyCvggTa1Pfs0Kxj0oIGiKP3vUM6j0euyn4epnUGQwQwpVNB1zYyIzOyUnemFMYKy4OsewhfTQ+S83XPG9NYo9TRkPZvpsLZI+n0VUnP1kq9zgTuYE4WmiuP4sWBpt7gz/unYZF/9s+axUiBYhd/nwg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918998; bh=HThXJxfQ4/rBqT5pk7pZU0Wtkj5bnQfH6VJrVEhc6ZU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=l5jGpeMKlfiX74U6FxrYfE8KR6zt89o2N5T/yqoZGzsyybbk4i+IIlfE02oODZwyBAubCbyYusVmt8lVlgUYoszKcKzUZhTKcjkjRiKievvcLoLMlt0K5AR30NOVAfCFkvXBQfrfWAU7hd75XellNH0buhAXb5YHGLezd3UWkjFpA2jUIAdxqL5HHelGprfGv3/gdKuBEe/WhWv0sDSlPHCM3B+7ScOqlhqlthVlVZ6IPCWInk1OGv9Bq9ZvIwkF04b2ib+VVOqsFY5Rbd8X8J/JGF/Avco7IxqzrTlGbHQ388yarYOzx6pan1NOVqK2WH0E6se66fst6hdnnr0w5g==
X-YMail-OSG: mQnTyMUVM1ny4VG6i3ZHvC2r6y3lUuLuQrO_.uspqViuS3MW7AimDhwoc.TILEE
 nqPMywQ..yC3K68tHOrHLNpwb7n0vTBi8iNQeKogC6EKw7BhLiXqzoYbpq0ma4X8hd0lQnPH_19q
 lnddTHCRkKC4WvsO7QlkASDa8Erjp7MaoaT7lZ9j6O.RgzY8L4bRclx9LTvlsBKgX5V3OaQxb3Vs
 klw3B9KV3GWxC.1vmN.IgtYOfjVgjtXemT7XLWHqARbnjOqped6yUg4kftuRJKIsrppzZBsoXC40
 1uqgGaZJqXzJ1uSPDSJwKzdPiEMbujmeju6OmrTPFa6wxOanQlFKqY7zEFNUg0_PjR6ZO8qIz8IU
 e88Yb4NOSLEvH11oRo7XSKImA6teF7SNH0c4F0PSdwmDH_8enuLV7e28ylgzSwRiyraNRSuYoLZ1
 RI5jX1u0J.mou4I8vsFKynixMifym_d21MviEq00shnze2BhZtSFgi0ywQbfYwBFbDLbtHTIVAjF
 njBTqZC2CNUL7uXD4ruDnWDCbi1WUk0MKJ_e5wUlgDwUbUIhZMPkM6p9a8JbKIZTKayzSyS4oXJA
 JxYwEjf6sgkie1NZBg8XeZJ8I7xJyWMfxpnyUNhQaMLDFRDE2Q3IiqkUtT.CYfzZuTma_A1JXCb2
 3SjdoRSiDAvYRqdmEnzIfpxGh6gMYYfKevtZDBopiuaWP.K3jjcLFoImVszr.UfheaFGmp5hI9DO
 5vs.3SVaIdYDlWe_XbZ8.GqtDKi3_X0vPuShlTeQ2PSWXH9yupZMhl5.CB2Pi1Pyq.smDTpa46.g
 HGFwwHSZdLU0YPYfeS9QTyGnYZDBu.ebrvb_978dTKwzggmxiNHsotoDczTWqNrFIIAecWaDz15Q
 3v0i4.HGaRK8BxZi2EeD2t6wXB4_cmTcgfeeRgyrw1xyLHCMmslPWZga1i4S1is3xtgbyngzq5mr
 _zmQEElBAgMm0YbZILdLv5sK1o7U6H.tUEfXIpIZJcITi20Tgb.jW3nib9WCj25YBQxowQZwoEMC
 NxDXhr3P3OzYozTza0kIulYASgMJQsvgFFqg_oDvZWdYucpm0W8TL38VHTu9vJhK0K.uB6it4Nfd
 WH4ZiAJRpmmWg4015drrcPZVHNbfGgv3.WWNq0Hzla5FUqv5BiASQ4KstuHdJ9mv2H6Fudjrvg_W
 d6Kt9VsXK5NKOSrZcq7IsayD2vlMH1q9XnCfPujxC80zCxOWU2lN1CtcjFXFlILf93aA9XSkuCXz
 Bv0cUBhcFbp0GJxwVvRDSKqtl5TOPq4mOR3sKCZPyqPJNHiOltokGQnkV8TouWSf8Q2xmWFRn9R2
 1T5cU79t97AjhHBucIS4UPai1tc5_jrXB0bZzwu_elxqr3ONNajmX2VlATldM6sFwJJmLUedPfqG
 JHkgTsLPBgGRbjFy8a4cw5uQiseJcSCpcGMXjYx1iFYiIlFaLbgbw8DwrZxHjbhSF536W7eiO40V
 n3wNwoNVQrUySVmw67zo2AgKvtn9PMgZHd6gJfQx2KjYIDw66l.ju4ycDG.hpiaBvR6xdL5JnwMf
 gwVKzrQLr8utYgFZr37_mrDEeM4FM3q5KpwiCp2P6PYqpU14mNNZZ8QxP5CLFGopR0G2yMHdw5CS
 GIOyovNKNJSxjj0_LE6JU0wOWw__nOsrdum99LpDIlmTXBj4LJkjwPQiJ0oy.EAw25VeqR59.0J9
 qYqO2ucf4VOtUSmoLBaPcPEO4w2rBSK_IwwmlV.h1izBo2X951xlR0KmJhgPvNXFUwS8qNaWDRVp
 jzhEyYsA11eBBb5OUm0MBQqJDhRWBNYVXm1BSVgEgz51s3LvrwfLMCIVQ3OldnKxmJBNVUcIgtez
 Z9GMxs7YC4G6zQN6icYyD8xknUPxcPzO91NI8q6VicKtWckaK2PC3Cfu3qRC1dR0dl7xYbzNSRS0
 R.h.4hC4eNiDkBOzrWsmQemIpHpKMwMi87yJN.8M.c5xBAF7kF1d9FgDkEmL6bBT_ycCaNmd76c6
 fq9JUA1MICytma7Nq6IX6sM6upNP7iDCkY4HV9eSZswra459HD0.LT.tAQ7NUAxHO_8y0zvQDYvQ
 kOOGIxB0BD5FGMBSsnPNr483OxCBmaRFRV7BDcsLB4f9b4hf.0I8p_3vJy3R3YfBfyTFddbGULDf
 sC6iN9O8pW4wMBQ6.sLRssvcmUetPWnacp5Y6O4WLuTN7T2mfjt796_Cyh4pLFYbKu9uUPHmZ7e1
 CjVM8o0Df.BjgRnh_iVknwp0KWN50_cjNW7OtReQRM44BwiFI14x7ksfVZ0b735hwh7593JAc8Aq
 ljdSCobU3TgfjDrfrF0imWf4lBmlUjc45mw9XKQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 33ed5c9e-1488-459d-863f-83f24f420e6d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Oct 2024 15:16:38 +0000
Received: by hermes--production-gq1-5d95dc458-4hqnr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8dd3ed09a3dd7dbd0509b276d789cdef;
          Mon, 14 Oct 2024 15:16:36 +0000 (UTC)
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
Subject: [PATCH v2 5/6] LSM: secctx provider check on release
Date: Mon, 14 Oct 2024 08:14:49 -0700
Message-ID: <20241014151450.73674-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014151450.73674-1-casey@schaufler-ca.com>
References: <20241014151450.73674-1-casey@schaufler-ca.com>
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
 security/apparmor/secid.c | 10 ++--------
 security/selinux/hooks.c  | 10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 5d92fc3ab8b4..974f802cbe5a 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -122,14 +122,8 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
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
+	if (cp->id == LSM_ID_APPARMOR)
+		kfree(cp->context);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79776a5e651d..b9286c2c5efe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6640,14 +6640,8 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
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
+	if (cp->id == LSM_ID_SELINUX)
+		kfree(cp->context);
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
-- 
2.46.0

