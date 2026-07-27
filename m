Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332C3C4B68
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179886; cv=none; b=VFStWMgK6kt4pMYunCjTVEspE3SylcYi+23rL8LFqmHSHNqjPQ1orZGfxJ8ymmkpThHRHrmPXpcrxHd+HxZYqckzktKuZmRwuFnolCMSs7PdBvVOX/8UM8TmR434bUV4USURd77HyhXYFIjACtUMIuz/QmBzWGZeB+1QNQnpwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179886; c=relaxed/simple;
	bh=1/f5S90R+QukrKw/rfgIV8DQKVhJCiYxA5u8la4Zagc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCtlRHNTK1RfwWQ54hqairuvGpv4EUQK2KrBjGon7djyhEhve2P2ePV3G1qESdxHlQrse+A2cavJKOd/cUu5VYMZ7WXe5c8DknggpTWkSlcFSnARZklnSkXdDRYHTOeMpUT2jNihHKt8CnxT8wyvXJqFZntGwn6NI+uc4T03By4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDje7PrT; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDje7PrT"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-736eea06c3eso1139294137.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785179884; x=1785784684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+/Atf2Du2NIMxfPDvChfddHZqutWDJ/kTOszVUa4pg=;
        b=jDje7PrT77aMXoymJpdlLlihV7+oMlnk0X1y7FEDUh/qLN0mwnMqsQ4HNVJVI2ZZTE
         JGmc8HLaowVsAabLgfB/j8B8zkWUxKgLpy5jm2aHoGm8T09ubZGZXQoagIOwoSg6yZR8
         L8gMNRZuT4h0MetgxmjY40v70JN/Quw2U9/Kn7H18ZFORNPBSH7r9t4aBcQTcVMzS2PO
         lH4WR0XSTIu+LFM8yXxM2Q/aqyX5n/vnuLVxLeLfnlO/k0krN4SdEY63ywdOZ/INFAv4
         hOjmNAXezCEpCRUZZEx8C399orgNJkVm9nwKlQ5rPdg87NdqPNpbyZBZ2rwmjaiThyos
         ZJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785179884; x=1785784684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+/Atf2Du2NIMxfPDvChfddHZqutWDJ/kTOszVUa4pg=;
        b=TiUTFvC1coj8c2QHyxrCpM/g6eq8p93FBPd5lGSpta7yl9hTTz3XdOymdB2LH/KygH
         QRd3GzWUl1SWo7jxM36GTQ0KoPdockQSByFSiM+J0w5/UWTscGFDxmPQHz1z6vKw5PGe
         BgDzFxqerwmYESRiQDq6vYXGd6ZWn2J4c7oNJe2EEeMKf7ZGhPOtBRrF9xRS0399poWT
         U6pS2CvkADAPxKWzWoWAe7/Ng5XAnd0dv5+DFnP/hcF/Rq7/z+qeMYsXFDHT0TZotSs1
         95Q4cC1oKm9rc/vDuc5CKPBuk/e8LNieSOuKoPigpaOoWNYJKKPSEs3XO6twfdfIFL9M
         pVQw==
X-Gm-Message-State: AOJu0Yz85IL5r+l2Sc3MK9mgz9r1kGGdjLDKtS+F9fFT5Cw4NvvsGaoE
	w3glconDYZ16NtamuASyuFOYQwMhpZh3fMnfgDXoAxOW1JCuEWxQXqHILHAKqA==
X-Gm-Gg: AR+sD12tDfmsY3+5CbOf8/J4bgR5v+xHXvEQo8TiJARdxnvvlWpPWI999uSU9m5lvtN
	yyX+Qr7iCbj8Z5I7JRYhVCK6zkL+NW2JMyDfOZQYmu+x2aAGL0BxPKmY++1iAcb12AME2WJcII0
	BiJfZQDx1DfJ5mT5f4ZjHiynizAIapwGjE5Nx2/CxiaJTwtIKdGcyLpFdrD9IhAYRb1kgkJqPgE
	r/Y7a5ot/ZqKsuSqUxRk7TwLK9KK0MdmEH8rqALjaxks3qLXCcxQeilTxcNEqeimxG0P6OgZw3a
	wZShfS0zQqjtCC7umOIDIZoOC0JVcNheFqyY1Q42QCUs8rg+AuSY6CGlG8kh5J2Hyk9YjmFPsGc
	mQUOvqtj2eMze2OjtI6VLi+dKbudvFWE1PTmflDau7mQs41p4fFiemG8WzF23M3P1/NOSWw36ZC
	ESXYlNYtz3hzPM/FfvG5GL1dZH2aNWpTYkD2ebpXFPd9tRNK9Plfos1OlZ3WPPquo5dG/sx4qzd
	E2oFQ==
X-Received: by 2002:a05:6102:54a5:b0:6ef:db57:ed3f with SMTP id ada2fe7eead31-750411e3929mr4916796137.29.1785179884317;
        Mon, 27 Jul 2026 12:18:04 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c901f5sm6145111241.6.2026.07.27.12.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:18:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] checkpolicy/fuzz: ignore invalid policy versions for the Xen target
Date: Mon, 27 Jul 2026 15:17:48 -0400
Message-ID: <20260727191748.24108-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xen only supports specific policy versions (see policydb_compat[] in
libsepol/src/policydb.c); the fuzzer will always fail on the
policydb_write() call if given a version not listed in that array with
a .target_platform of SEPOL_TARGET_XEN.

Reported-by: oss-fuzz (issue 539336382)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 7db0d4c8..c58d10e9 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -159,7 +159,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	/*
 	 * Take the first byte whether to generate a SELinux or Xen policy,
 	 * the second byte whether to parse as MLS policy,
-	 * and the second byte as policy version.
+	 * and the third byte as policy version.
 	 */
 	if (size < 3)
 		return 0;
@@ -189,6 +189,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	if (policyvers < POLICYDB_VERSION_MIN ||
 	    policyvers > POLICYDB_VERSION_MAX)
 		return 0;
+	if (platform == SEPOL_TARGET_XEN &&
+	    policyvers != POLICYDB_VERSION_XEN_DEVICETREE &&
+	    policyvers != POLICYDB_VERSION_BOUNDARY)
+		return 0;
 	data += 3;
 	size -= 3;
 
-- 
2.55.0

