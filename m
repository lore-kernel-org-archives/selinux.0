Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A933C1A
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754585; cv=none; b=Uu+JA9kFXyKYeQYmLPU2Jjd8pjcvCkpANYcIRuH0DBIgJBNgiz/KEIge5TiQ0sWJ0e/QPhVG2EFiHF/7hfHJGFDxhQUsw0ZWYSvfkHqFYaT+uySAMIx/Y3oJ5f8jFs3KXUtYsUfgq6+A1y9OeNIEeknqjrYVj3mmu6bUXPSRVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754585; c=relaxed/simple;
	bh=4QAL1BhenX5qWuuKI5EMCFAh72bfZWTvtilG1necCQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0wD0fzHAbXbeKbfLNrxk2JD6MHbVxwflUhO/NG4FbWRBU56Q819uGjxBCx5Q+9V2lLV9jpInH8jWHEpNYbjh0Pzqqt1xlugMnWqq8VqysV7mck2+NOeiQssetsKimVijIDqbtjWpIzfQAP8vm1SRJvfCXl9hbY439FK5Blvo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY9flfKC; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY9flfKC"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52f9fc510e1so732411cf.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787754583; x=1788359383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNDxFn3zoTTv6SDn7qwzNqf2tIFjlG8PJno7NEZdJHI=;
        b=WY9flfKCsiSKm5HQUJuzB3MqFOvwb/DS30XEkPzxc8qX1e7h/lXffnlNylVrXHOhio
         tXOL5O+AKdDzKhrhJ2x2pyLLNmZP6GCesfQea29/1O13MzdWBuOHBOK3KsBgY2F9Na0Q
         CT30kUaBt7RUi/QPeAerCf5mLBdM8ffLeSZdVya3pTh+A8iHSw8HPxRvIE67DydMBO5j
         LSogVKY5G5D9+EgcyrOFC4rTs+yhNHnv1q/VDZcWma+0C7fff7Lm+xS+TIxzZFcEyNd0
         yboKuoBTwN7MNHNPbQHcNoL1SChTt6xNMehjMEOqisT5d5J6dV1BFULYYe6Q9KjKzrtq
         rziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754583; x=1788359383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNDxFn3zoTTv6SDn7qwzNqf2tIFjlG8PJno7NEZdJHI=;
        b=BeTI8wSRKxrKwLHy76BpK+OWyL8tZgqeSETVEQ+rx3Vz0lu2eWrZbivK03+Ias104F
         3+dM+f0CNFL1YoHEqXKC3Py25m7N4f7E8JxaX47sP6PBV2OTrNNJJ6mly/ij/9P+ZtbA
         CEIDz0GJWhcIgM0pGvsAEHdpIVyKI+IUX/GPZAJtjhCpkjTS1YI6u/FFSmouYo7QYk54
         kXUYwdh3P7mOLMj1LBQ53ntMf2nvk9C4ZQfDYkDYpUyFmuiYLTTMps6L4jePgt9ffJzc
         NX4De9xI8uNxcNvZbff9vQmvp//6jowi3rrRmvr2RsmY9JBbK4wfQpTy0UiPrJEdmaL2
         Gvdg==
X-Gm-Message-State: AFuF++nTssTwpFW5N/8O9bfkd1SaFljlopKiwVB3ACvMrYXiyR36EXqQ
	p9IOT5m2vjYFMDhZ7i79rNozxHVSJZqcDFMyvJ1gOAOCMNHK7FT/xrfuSdp5aQ==
X-Gm-Gg: AR+sD12/EYq+sANdaXIRmbQGKPKp3TMulT7OF8mIalbczRPTHCyIXj830UkMyaI2eep
	iAxk5jgqdeVNuEf9ysAA6uyAh5c2Np3nWG00sOMARgn4hXIYFyucvnHJ+U+xKEdaCtReBUdSMAJ
	3gw1Lb5OPMEGHa8hJvyQqk4twr6tM+HUxP477/Wtu2wHTcSYW8I9D4ISpiHmt7d3SGl3+dRwjcF
	aZgJQuXD3QjPv9OEYhC1oVdkD7gQgmsqSidEMyEmZ2GuYS7/RxI+iTx+gnhH/6H0UQIWbRNHMdZ
	057uDJYbezFlchHNZkN12cpEOX/DQ9sgKY6BKn5172Ik2hMCtG1xh3hrPKmazNoYwIcKz+eTKW9
	oIeHg4T8yTHiNLTAf7Wgzfe4eDEFrPkO3cRFn/97jflawCMNX+cFPGsOhun7Z012r4zvysstDuv
	hpohfQyV4gOqWCRUrL76sJ6C88ybYnOWJLXYxpRY1WaoqHGBai/54o/LJVqzKgoqJDc3wq/bRis
	xEBaneXdlHXUpFdKiPBvi9bNfLpMxo/q1GGDcfZEc4NHF0jcuMun1PgpvD79N/ZUWxXNy6Zl6Q=
X-Received: by 2002:a05:622a:5916:b0:51c:4f35:81b8 with SMTP id d75a77b69052e-52e41ae4f6fmr74404771cf.7.1787754583184;
        Wed, 26 Aug 2026 07:29:43 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e425704a4sm17721581cf.6.2026.08.26.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:29:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: semanage_list_sort: handle a NULL *l correctly
Date: Wed, 26 Aug 2026 10:29:27 -0400
Message-ID: <20260826142928.3091-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No existing caller passes semanage_list_sort() a NULL *l but
we might as well check for future-proofing.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/utilities.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 678e1443..43851f8b 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -167,7 +167,7 @@ int semanage_list_sort(semanage_list_t **l)
 	size_t count = 0;
 	size_t i = 0;
 
-	if (!l || !(*l)->next)
+	if (!l || !*l || !(*l)->next)
 		return 0;
 
 	for (temp = *l; temp; temp = temp->next)
-- 
2.55.0

