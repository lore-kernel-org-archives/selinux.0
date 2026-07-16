Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888442CAEE
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214869; cv=none; b=sc3Ydzl9WDjh+95wDbpYHRZ2RM4B6BTAZPIsYrxpVrf3T9PvReGMZHi/Q61/7LdvbASsXTtos7DoMr7UM1T6VmBoh42VFv74xX9IAXAgJaM+AXxBDdGDkamExlK3aKfUxLHORJaLRmOZ3h7H2rxfVVA6a7OLeRcx2jg7fMMzRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214869; c=relaxed/simple;
	bh=FoYeZOYZcyvBsz0mki7dmJlBVs0paaA9D+h6nWjb8TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7Kezot+nqIev79fZBnFo4EFj9KNNawv+r6RDYkcO2NStOFp+7rm0ScAh0hgrIG3qmtqeDMj3VhgNF9cp2h2ZMQhH+0yYBQFwUmfmCX4AT7SShG85cgLhKygpg3eFKoj4p1Ba9X4/xjlawteb+M0OUk8I6UPjTXMcxpoQSvnobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrKCeVWp; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrKCeVWp"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9305a2121a1so307307385a.2
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784214865; x=1784819665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kjgpp3I3Holkw/80uv2+r/jenNRo4JdoOzad81f+vqk=;
        b=IrKCeVWpDCxVz3cq6EVYfEmQYDVfav2uNJrpAVX413NRqtgETQ+y/OTpwt+wzu744N
         vVS2YHTqYO3NNjRHY/2g+t6aXEq0gkd/rIH74UIxZMPsdZ/sRgsL8V/WG0CTZxEHBPLJ
         qJdotZ32hG58IJna1ezrCjSKL2RhNijQpdP7zHDvnXLsH8nxrV6MV/tptTsHEEfKm6l3
         WmN9RZFc2jPyG0rMg/GAZEOUn6tTKWqO0WUKxvS/tDTX0HYVWTa4zCan+N+VoQ5iZihI
         /w6qqpmVXhA82jZBTBEpGu4uPG72DZRNs8p5EKSQC2clKRPWUytoPd9yU4h6Qi+RWq2K
         SSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784214865; x=1784819665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kjgpp3I3Holkw/80uv2+r/jenNRo4JdoOzad81f+vqk=;
        b=gfHid9O/PYlBuUuWLMKYz+6BLSbz6x22Y55nsMcwEVyJueB1cJM9kDz6Vpd+5D5s4/
         gskHGrIIz0Dt5poxTppmDxS2U/namQUZVHlbJ0m0SnqHVw3FzNEBV1nnqZ3mcoTDqhSB
         nOuFss4JjXZ3Gidg4Pk4GR32Kbtno2E8iSjW8/QhaOAoVk64B+aK4VZHespHJfrAIpm+
         lYxAJBbB8TOz7syRyMI+aPLErDN0zLMhVjii4qbkNk1+3TCvVDidoCuRR2SKxyaSpbNN
         lKfPL4OqSdo39XhH8clWujgvQt1x/Bm0kyhY2WE6UyFr/LhknVv1lOXGqk6BHH24tOK3
         nQFA==
X-Gm-Message-State: AOJu0YwiTHpXnaMu0B/imKbPljlyJ6T6pAIyeMAPVh5WVbtgIjuiKIRh
	y6bzq+BWdsDCCklgnvHBs7exUI0zKXO3Qo9rw40Z8ly5HpR+8IB8l+SCBVRuFw==
X-Gm-Gg: AfdE7ckXzBnGmfXbjPWuHJ4JnYKAM+sNyVVwGPM4FLmsXP9MsoUPupVZTAYMMMdstaF
	ueclujfDT2eoska5hNjQIwq1G0JzkhoNEq9b50NyONWvaSW2ehF840VYWeXGU9lIPwmvsXUz3e6
	Ed6Mtv+bYbwfbSjGyKMRtMXVV9E4Sm4RikpJ8VVfW1FWHCuJL0m+g0cQ39vvT7lt45p1/WJLfD0
	n95WQvYay1u6jJqwNcV1BQ3FMKhZIAi90wMQtDJF/0vI5pjLWcEXNffvX/9xBXSy9KkBmX4QveI
	aNchXBcjG06w+fRBWL/eiaLolkFaDbXmv9yKZRx7fcZCFWS6U+YBe/UE8c2S4vGqJaTKr0cd8pZ
	bRd3jcI32H9ylIdd8yI1lozQ3+Uo8AyeYBW0WlQcAB6nDZBMv0aV6y2iZYQWm1kshuka5Ufs41u
	pMB/yDJSk3sNHyUAr8iPUq2Jjl6yvkiDaAQWfdlxRqaU/9pMNhHwoG40CVgBdQnm4JMBLaXBoU5
	R7Wfd0gDqedEtHC
X-Received: by 2002:a05:620a:2413:20b0:930:9658:b2e9 with SMTP id af79cd13be357-9309658b9bemr613760085a.23.1784214864742;
        Thu, 16 Jul 2026 08:14:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d2d68bsm2015509285a.33.2026.07.16.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:14:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: fix inverted alias skip check in compute_trans_from_raw()
Date: Thu, 16 Jul 2026 11:14:05 -0400
Message-ID: <20260716151405.9158-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ebitmap_cmp() returns 1 when the bitmaps are equal. The
skip-if-alias-of-last-bc test incorrectly was comparing to 0 as if it
followed strcmp() semantics. Fix the comparison.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index e79aa3d5..8ed1aa95 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -1623,8 +1623,7 @@ static char *compute_trans_from_raw(const char *level, domain_t *domain)
 		if (l->sens == bc->level->sens) {
 			/* skip if alias of last bc */
 			if (last && last->level->sens == bc->level->sens &&
-			    ebitmap_cmp(&last->level->cat, &bc->level->cat) ==
-				    0)
+			    ebitmap_cmp(&last->level->cat, &bc->level->cat))
 				continue;
 
 			/* compute bits not consumed by base classification */
-- 
2.55.0

