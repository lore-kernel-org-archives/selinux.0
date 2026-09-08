Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3939E6F8
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897829; cv=none; b=hmUswy1Fefo04EvBLX0B6lrR7vo5XnZpNlhLGPatt6tEq6CSPi/12k/HX/Ne9beSgHDncvTCTts2dGv7rLoH/WzlhsIWbrPvixLIcIlF6c/WnT9hzw0WS2CG9cGhu7mCO6PC40qeKaxYw/zyguXeIPnORML8NV+bT6gcRHyCacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897829; c=relaxed/simple;
	bh=Lm0Z7Y59DwqyvTspgKCc5GXLW5Ipg7RW2O1XedQ1kHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTguMGVDv3kQCt/T1CnpQlQKKuAhKlapZBP2x5bEChuCuKHG2cnf7XNyy4uGIC8VK3IeMIpp4YpiqVrrkE0M8XJvU5l+J/dbicmGzjkSi/60RfbEfKFdscdBLeWwZLVmD7Jgqu6kFAmnmkx3nHGlARFTA9KPP5yLu2sNNX7Vgao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4//Jwn6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4//Jwn6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91034716d1dso77207616d6.2
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788897827; x=1789502627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WPrYbjvI9pN1/dO2Vwx7JjBZPBvsK84US0dYZRVflqk=;
        b=h4//Jwn62n8UnToO2U4TrVkAn3dmdZsOfuQCiek+KTqupppJjbTam+TYaOFHLg2e4y
         ZldhesrY1r4sEUH/N7BDp1suOpWvcMeSu4E4DKoAk4EzBpqKrtvWhlfzILAbTRiGiYcW
         QUfslNhEbsZTn7djkWwb+HWdsuAjoKyqeoBv6tKr9GGsv1nrtiELzqRGaSme4N/3cTY/
         c5Wy0H08mO8C/SHwkK+t/LS/DaxyS4Lb0tNTEFam3MkIwZzRepsHfduhKvszrV2KlhyR
         9lGZbtNxcs5B08zPjAmE+3e/HsFL8jWQ0oR1OMA4RX8nX2f//BjljeUUKCCRyXzZYmGm
         sk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788897827; x=1789502627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WPrYbjvI9pN1/dO2Vwx7JjBZPBvsK84US0dYZRVflqk=;
        b=A3j6xdKiE4lZpGVcnEpbOpPMAm09i1AaIpSKQxCabFNBHtjqw4i3nOe5h1Ws4MKXPb
         8FR23LDtuInXl0FcnxCQaTOX4+3Z1iTlNwIdGwMpAWa8EcpevBcIm4hdcJHbhhhbdK3Y
         cFscTEie8YcdydPaOD48Tlg4zqt5Oe63mnlnq0a4+KHGthKWxuyUxmLCI7zmZ7lUNwGa
         RvMZIe3kRkUef4ZYwEwS10EDK0/QEr3zh37JzrWsHVPgsXUdVQNULfCeHzQRaxBO8hoP
         TL2OJ7iAeZYF25LHRylzeid33T0fHThCuSlt0rAdNlccCOfwMnNHXxPvQcV2syIkdRz7
         /PeA==
X-Gm-Message-State: AFuF++l6Sd93C4jeRj71rh/rhdW2o66eKx2rWTbCR2n43oul9crgGPQK
	T9hwQK8L3LWXsoTgxnclnO/VJCZ159ih4OFBZwAuGHxbl7x0dzgWp0AIq9sRsw==
X-Gm-Gg: AYBFou052lMPD41kiFfsgZ5QJwbqDusfCp0u0JivrU0mQX8FF7i6NwvB59nmx/9cEES
	BOVgllVAaZMyYy8L1S9oDbrYa12Twf6CluBQIsXyXifAqsqijQjhoNVmXJmyk2ORS6TvQE8UYO3
	50g6nA0Hjv9sXRBB2dexC+k2q/pE0VXgScAaMWNlvLunePpLmtPDkA4y2fpxkGE4h65T2+xRxOQ
	IVGXkzU8flOh7aa4/zGXN1r7BJzA+w4PVd5m7X1Blmat86t94pYoCKN28BOCF7sCSjiqiGI47xb
	nGsTUZkw+fZE+NPbNLWANSVNRjzg/bYvQQQfsb5kceaeaCs7geKTO9PGVeWwn0WpR+oYYapK/Py
	VVEoDIGMIaJ5kVp1620SFQwQ4Zn9mbmv7G2gGyS5vB0UyWJCCbMrqPjKh1kvn5GPod1J4A8MTnG
	9thlX9vdA0Bw0vF5sYroco8zq4/UHic4HBkN2DjiJscw8G4bwRKSppMDHFJF8i90NdpWdkGZLca
	F/jlHQDkkF6jMWV1cfxFYfgu2ZpnrPFtBmLIN7Z9WJU16aw8oFTbr4rtC2xI+Nk
X-Received: by 2002:a05:6214:20ca:b0:90e:98b2:f594 with SMTP id 6a1803df08f44-9103f01223emr381405766d6.17.1788897827322;
        Tue, 08 Sep 2026 13:03:47 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afe48sm124542456d6.43.2026.09.08.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:03:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] libsepol: only read/write the neveraudit map for SELinux policies
Date: Tue,  8 Sep 2026 16:03:31 -0400
Message-ID: <20260908200332.23630-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908200332.23630-1-stephen.smalley.work@gmail.com>
References: <20260908200332.23630-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The neveraudit type map added at POLICYDB_VERSION_NEVERAUDIT is a
SELinux-only feature, so fix the checking in policydb_read() and
policydb_write() to correctly check and handle the case where a
different target platform (e.g. Xen) is selected. While we are
here, replace the ebitmap_for_each_positive_bit() loop with
the ebitmap_is_empty() helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb.c |  3 ++-
 libsepol/src/write.c    | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index e243c3ca..bd52a107 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3954,7 +3954,8 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 	}
 
 	if (p->policyvers >= POLICYDB_VERSION_NEVERAUDIT &&
-	    p->policy_type == POLICY_KERN) {
+	    p->policy_type == POLICY_KERN &&
+	    p->target_platform == SEPOL_TARGET_SELINUX) {
 		if (ebitmap_read(&p->neveraudit_map, fp))
 			goto bad;
 	}
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 975b3ef2..e08fd7a7 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1938,17 +1938,18 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 		if (ebitmap_write(&p->permissive_map, fp) == -1)
 			return POLICYDB_ERROR;
 
-		if (p->policyvers < POLICYDB_VERSION_NEVERAUDIT) {
-			ebitmap_node_t *tnode;
-
-			ebitmap_for_each_positive_bit(&p->neveraudit_map, tnode,
-						      i) {
+		if (p->target_platform != SEPOL_TARGET_SELINUX) {
+			if (!ebitmap_is_empty(&p->neveraudit_map))
+				WARN(fp->handle,
+				     "Warning! Target platform %s does not "
+				     "support neveraudit types, but some were defined",
+				     policydb_target_strings[p->target_platform]);
+		} else if (p->policyvers < POLICYDB_VERSION_NEVERAUDIT) {
+			if (!ebitmap_is_empty(&p->neveraudit_map))
 				WARN(fp->handle,
 				     "Warning! Policy version %d cannot "
 				     "support neveraudit types, but some were defined",
 				     p->policyvers);
-				break;
-			}
 		} else if (ebitmap_write(&p->neveraudit_map, fp) == -1)
 			return POLICYDB_ERROR;
 	}
-- 
2.55.0

