Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC438735E
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851847; cv=none; b=PwVieantj/t9az4etGcotEqSTRFot9+1rx3miu1VYNGdb6761VAGHOwPMU/BI2JClnHpS374NK5kKuZ2WUZdvLovwuA/wU23TgBLcU+DJ+pj6fB8X9imbsuNMJ6hGS12Gg0xvPDh3gYZX+4QCAakR8M+HH4sicSoy9s2krSHPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851847; c=relaxed/simple;
	bh=b844Mva4zRHCxixfyWGtFYAaIGa4dLKXH1dDbT4u+Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIcksbh0lR2T3VK2Fnyd9yzKunE8gA4QpcA2H0n2+7LO5Dz3vvaSuErj9C/82KaferauCzdi4vZeP343biLMj9+rgbbmLbNqtCRwPGcv6v9FwxVq/YcKXaOP0XtaoNrxAIC5YMGOCP08RPo9O0OeblfQUTsQTP5Tpv5tUJRSPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICK9CwpU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICK9CwpU"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso31625156d6.3
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851844; x=1786456644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CgAP4TsC7EfD52a1ItNpPCLGyryOKpFkk0/VR67/Iw=;
        b=ICK9CwpUml9oPJbYaztNkj2HR/Houlon04Lc6RyHDwrSuyklTijW+j/OV7qUxXDAAA
         31BAK+vtwevUGE9oyTs9FIRuDgTcFrRtfyVAe3wV0uZI6/ZeF+wbDDHfR2Vm6CtbLSUm
         SVhHP+9mqs3bt9lwKgJl2psejArUu2VnWX2ahN75ukeR6BVuFxEbgnTnSFiemO/nNh83
         IXFBFzYwcxO/TiqxIHVruQZEN1ye9XoKRbIuN7u23b98HXr+D//lULjuHeaZ8XxhyDEE
         XIgi6YdJHc/vNwTEiwzNZOBOGBBW5y/OtTpg77UrdXIEg1OMLhHEvkgqw4c//eJ2aiYE
         ZLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851844; x=1786456644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CgAP4TsC7EfD52a1ItNpPCLGyryOKpFkk0/VR67/Iw=;
        b=ZE0VYHtxFLgAywIVqzh2Kvv/A+O7ouS75UR+LCq/xNN/GzcnFTL5rFzsht37xVQzIk
         0cgt9uDnmu1bcGo6VnP3GGHFJIxcvUXEFykhYjSj80tNTP7DRXiAUvz97jx5qbyP0/KL
         W/g6NRdPiaowj73rKK8DdPJiOrPULlR7wD7ARf2FqusgCWiA1TsyuOyallUux70iAI1q
         YBZqf0vEZvcLz334i/Zwo/YAp5Qkc1DLw1UNOrYFzBNWyLXzdQyNE99VpvgpaGw8mrHa
         cPYGZ89eJjzybJh8GSafYxCrRSgoteRaislqRU5V9SOR11YOl2T6q/VokCgKNKyKylvQ
         bChg==
X-Gm-Message-State: AOJu0YzgSOwnUMszRLJFL2heXuZAK/Fht1axfi7r6u8wjmxjgTj3FpPB
	pB+ZkcRLwCSlWmW5q69bNBI0rM3PzlE3Zb6xwHzmfxI8ZRoY0k1/S3AdvV+Mvw==
X-Gm-Gg: AR+sD12O9neJG2/J5oZJtTcUh+wX+LdxvRKxVzNPJR7lDqBIjbxP8iq21dR009Utmnn
	tAsftiZGa9jwM+InAbnR4UZFjuL7058HUDOZnwozPcoTK3IT22TqUDP5//JxRCtDKKK8H+U1Gtm
	dMpaEiwDp8WgUygsOHmgF/Dv6IpcrdNNGSwkKL0Jt4gacFVUdcMW0sKZA0sNRv3Ru0gsducdBSM
	T1ACp823l+hgt5rvEPVXE1llV0zeX8jUpRj/io5PiLQaQBTSWY7gG+bf7S8IHMBYqCmkXtmOvWb
	qmbV7atOdvOoZL2rIcVf4fdCvFOuzK+k8ls+0y8kTC76hOuxgAL5OMNQWfWYd7WAsxlG5gJe0AM
	TkUgG34h8MDrdvQywg3Thcx39CEDutLjozq/RcOP9MWR6CFiQqv6PUrc5cAw5jEIZpxxbxQmS4Y
	mI3DX7DJi2pCJKSql+KY+J8j3LimK0AnY39a2lVfTP/pCSR3pCgbEYik8kc13n06qNaORqK6QE2
	TeDfvzyWCo9MYyUSqV2/Ai2UxdUEbjW27Z2O1OfYqh18uPyVWSeJgKo2NNFs1qe
X-Received: by 2002:a05:6214:c44:b0:8f1:1bf9:5119 with SMTP id 6a1803df08f44-9084957bcc5mr285482876d6.8.1785851844223;
        Tue, 04 Aug 2026 06:57:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800cb9basm1604076d6.45.2026.08.04.06.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:57:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	jhladky@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Jiri Vozar <jvozar@redhat.com>
Subject: [PATCH] selinux: check level category sets once at load time
Date: Tue,  4 Aug 2026 09:57:00 -0400
Message-ID: <20260804135700.3713-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Jiri Vozar, commit 7edea6e8c8e8 ("selinux: beef up
isvalid checks") introduces a new loop in mls_level_isvalid() that
causes ~89-94% throughput regression in System V IPC message queue
operations (msgsnd/msgrcv).

Move the expensive part of the ebitmap checking to policy load time
instead as the reporter suggested.

Reported-by: Jiri Vozar <jvozar@redhat.com>
Link: https://lore.kernel.org/selinux/CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com/
Fixes: 7edea6e8c8e8 ("selinux: beef up isvalid checks")
Suggested-by: Jiri Vozar <jvozar@redhat.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/mls.c      | 24 +++++++-----------------
 security/selinux/ss/policydb.c | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 3cd36e2015fa..40c62600650e 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -160,9 +160,6 @@ bool mls_level_isvalid(const struct policydb *p, const struct mls_level *l)
 {
 	const char *name;
 	const struct level_datum *levdatum;
-	struct ebitmap_node *node;
-	u32 bit;
-	int rc;
 
 	if (!l->sens || l->sens > p->p_levels.nprim)
 		return false;
@@ -176,21 +173,14 @@ bool mls_level_isvalid(const struct policydb *p, const struct mls_level *l)
 		return false;
 
 	/*
-	 * Validate that all bits set in l->cat are also be set in
-	 * levdatum->level->cat and no bit in l->cat is larger than
-	 * p->p_cats.nprim.
+	 * l is valid iff every bit in l->cat is set in levdatum->level.cat
+	 * and no bit in l->cat is larger than p->p_cats.nprim.
+	 * policydb_index() has already verified that every bit set in
+	 * levdatum->level.cat names a defined category, so containment is
+	 * sufficient here.
 	 */
-	rc = ebitmap_contains(&levdatum->level.cat, &l->cat,
-			      p->p_cats.nprim);
-	if (!rc)
-		return false;
-
-	ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
-		if (!sym_name(p, SYM_CATS, bit))
-			return false;
-	}
-
-	return true;
+	return ebitmap_contains(&levdatum->level.cat, &l->cat,
+				p->p_cats.nprim);
 }
 
 bool mls_range_isvalid(const struct policydb *p, const struct mls_range *r)
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f141f007d96d..b75c977c6673 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -670,6 +670,23 @@ static int cat_index(void *key, void *datum, void *datap)
 	return 0;
 }
 
+static int sens_cat_index_check(void *key, void *datum, void *datap)
+{
+	struct policydb *p = datap;
+	struct level_datum *levdatum = datum;
+	struct ebitmap_node *node;
+	u32 bit;
+
+	ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
+		if (bit >= p->p_cats.nprim || !sym_name(p, SYM_CATS, bit)) {
+			pr_err("SELinux: sensitivity %s allows undefined category %u\n",
+				(const char *)key, bit + 1);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /* clang-format off */
 static int (*const index_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 	common_index,
@@ -793,6 +810,12 @@ static int policydb_index(struct policydb *p)
 		}
 	}
 
+	if (p->mls_enabled) {
+		rc = hashtab_map(&p->p_levels.table, sens_cat_index_check, p);
+		if (rc)
+			goto out;
+	}
+
 	rc = 0;
 out:
 	return rc;
-- 
2.55.0

