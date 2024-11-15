Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541571D14E9;
	Fri, 15 Nov 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677835; cv=none; b=kMUnn3ViUx4TsBw8YM7kTpaz3DoZecjuJm1IHmaazgvXlfEUuHmnMJ3niXfYEkTnQ/NQRFyzKkm3S1VC/Yoj1S5JO1chRGCVKt6mCH+89V+nyadvCGBntw2ahetMy0jnkR6UZpjcOGNC4ePut9L9GuEz+y3++LnGbbiDGSRb7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677835; c=relaxed/simple;
	bh=hkugTtgU5Xsxckl7bDYeFMcTVYVt5KrO8hLZ493UwrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=es+2UexzC11kFGFKHV3BA5CqJ6MOBX2J7FcvGUuhRKwYPYSMfi9u5mG9z0Fi5BvvDEp/S7PY4oTsp045YQpsgqeYCdHN0zz/1WPniQtwq7LEcOoevrXJceuuKktCJBcPBUUa+5/NnUr/u+zEk5/4PYwKc3Lpk/HJ6GxkT+s7lV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=P0HYG8BV; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="P0HYG8BV"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677832;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTSVMMRV6+fWEed7Vau5BzZl0GAMyD2UkRV2kOtriP4=;
	b=P0HYG8BVxY0lFCh2cgTZi5m1YlsBFy4y0OH7VlvaAwiZOm8civVZVLMOFrShyS8+R/XJTe
	6rFiu/7M9pKJBQh1EsKxKW5mMP6MN0gQ5gT4nt6+UOWGrxplzzr66Uy1AcFQbxGayDE1wZ
	/1ZrC/xJyAlwSUhF8/tPXwhnKqCxqAs290k5gtGFxnvMvTB/txX7VWS2CJKyUbdb7oknWP
	q68USQC0slsJSlcc4++m38vnITniXREBUQibMzesjWb4uKmXBAVUYgigdqT5M8gD+xqoas
	UOjdmOyBXAU9dd1dsVYrlRU2WZryL7tcemUU+NWuK0SlvYWFK/RGKJPwTAZNow==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Eric Suen <ericsu@linux.microsoft.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/22] selinux: introduce ebitmap_highest_set_bit()
Date: Fri, 15 Nov 2024 14:35:34 +0100
Message-ID: <20241115133619.114393-15-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Introduce an ebitmap function to calculate the highest set bit.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c | 27 +++++++++++++++++++++++++++
 security/selinux/ss/ebitmap.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index cd84357db2c4..74686b8a4c35 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -257,6 +257,33 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
 	return 1;
 }
 
+u32 ebitmap_highest_set_bit(const struct ebitmap *e)
+{
+	const struct ebitmap_node *n;
+	unsigned long unit;
+	u32 pos = 0;
+
+	n = e->node;
+	if (!n)
+		return 0;
+
+	while (n->next)
+		n = n->next;
+
+	for (unsigned int i = EBITMAP_UNIT_NUMS; i > 0; i--) {
+		unit = n->maps[i - 1];
+		if (unit == 0)
+			continue;
+
+		pos = (i - 1) * EBITMAP_UNIT_SIZE;
+		while (unit >>= 1)
+			pos++;
+		break;
+	}
+
+	return n->startbit + pos;
+}
+
 int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
 {
 	const struct ebitmap_node *n;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index e0150695566c..99a21d83a0b3 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -126,6 +126,7 @@ int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
 		const struct ebitmap *e2);
 int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
 		     u32 last_e2bit);
+u32 ebitmap_highest_set_bit(const struct ebitmap *e);
 int ebitmap_get_bit(const struct ebitmap *e, u32 bit);
 int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
-- 
2.45.2

