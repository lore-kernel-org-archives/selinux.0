Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9252F9D82
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559301; cv=none; b=B0Mw6M5Ridmmllo7balaD9h3Ru1grjvqEN1ekYJ+XZiW5jsYmsL3DophUWFPNNn5o83PcE7hzRt7gMzqcriwnD0aA+bqRXTLs6TfxQvb9PcKerPtCsD0OEMoeW8D3bgvj1K+SC2zfzNIwg+1DqZtSnHvfPavcjifneG/Oh9Jrss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559301; c=relaxed/simple;
	bh=YPJsZEvS4tujIwfDN6sBLp9ri2cgprUFjH4TszEGKWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wxk82chgvZA7J7FXGHiBLnEEQ5sPd+jiLB6Xj2AyFEe/HT3LezYtglMkbmVYS1gOGJ8bOPlw99aGZR2qq5RDg7Zqs7BuIWov86lhC4BXwVLjTFSTeuw601OKj5+3/NKOrbWHnNVG92fzl5VjC5PD6Mt6HwUF23FjlWh7NDsZO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojL/wp9q; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojL/wp9q"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5c92c389so62576485a.3
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786559299; x=1787164099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t6oJHmE1Ro+vQbssucSchnTRrxQFhPTken8zXOiw0co=;
        b=ojL/wp9qV1eCYl8/+xtqfwJD1AahwFpKWoiRd5tvCf46SnNRWDbNqGMYn7oRjUC5z7
         dvVP8H8cuXzYcNJV4najrCPdmD4fXjY92b/hgoxjq6l3L2S+7zL80HEVWzmtw+i1tHJX
         GZ8yJEAIxAlFKs26ac/Ki8iSSdD8/5eO5z3dnYy0L2nGBvlTR4oUfzcpE9qB2yKRYqY3
         AWk/1xOrnkWUXL/zHzx1W7ygHZrCVxszR6kWadJ0WSyPafZ19Rp4Xx8Hf0zPqooBYRKH
         UbzJFsLy5zx2jOLuxB/0ISW7V1qDdL/cDPBHudH8yMLVpcmfRIO8C8kpPLUzx4TJZ64V
         dP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786559299; x=1787164099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6oJHmE1Ro+vQbssucSchnTRrxQFhPTken8zXOiw0co=;
        b=bvkksBc+ZcceuzFJVq/dhII0WmZJ1L8bEMGRkXSacKS95AKNGY7tnoj7avlsYnRGdE
         H4BaHfyyy37JUSCAv9nfpSB7CO6ZAb0VtBKE1WsK+xyq1p/DhGZRO2giftSx+4brsBYa
         FdKsQWNR1HK7WF31upT9t7X1AJAgoFiaqvaYlRjVqK8ojlL8ahVA+j5bm3x/l1jLnm1Z
         k15lrFtE7JvMpEgxkulyR47/AinJW8krZdjcsxHZhJXFZaz2wl/1IqTkHFfHNHswk7kt
         rome8QezZN0nAUtV6iBPNY+dPNwU3fKucZgeV/ZLQbA2OFl1NEYPu8Z97/fMLUKzA3bc
         ibzQ==
X-Gm-Message-State: AOJu0Yy217FikrGK1jtd1UZ2NpEJG3Tz/m2s27OpT+FSOU+5XrOH8xcw
	O77KPr5Eu3/oI4ygA1/XEFun1C/RC9gYU4KPREk7grzq23nAZT/k1MY9MhfLHA==
X-Gm-Gg: AR+sD11jY40Ugw7swBcF5gi4pRFR8w+qvOdjhTowk+Ay1O9bqcRyeo/jUOu6t/6sIWN
	nFDUnbSbMZsv5Fa8otAjZFXCF6+SOg7D155QmRhbTwR2KhBAIwz7k9AUfVYh8z70xGuf3sUcFSn
	zetewUM4K8fE4HGa0Hhj77hBYSrbgFM87h6W9Zt25/q8gHwBjExYNi4J93IaSxwXIl6vp4eEdeB
	5HiJvqQYJYb1DKTAXzYChYDxL91lrUslVC06rRJ+gjKQJbXmYC8nWZ8uz4rXjay+3M/2sJUgR0u
	Qn3mS+DHoe/PLyYlYZFoCyW4qeOHkoQK9A7mSz8jY6KixcpZjvFFQ9KZWlcJneJB9efWJ9Yoxjz
	+Ys0QDgBsYnA84m6unKTLqHlbrtiGaKq2D7CIQjrHMVb8uzl5FPkeoWMHWDCrAbWx3Q2xAMpeIo
	mfk6bZ26BEvdwYAaDCuxoFgAyADovNTMyBxyY5Hc5gLmYX6Bvr9K4XjBqUng34n0xNxTz6WJ2iQ
	jNz7DKOIvc=
X-Received: by 2002:a05:620a:6c0d:b0:92e:e376:cf97 with SMTP id af79cd13be357-936bfaf4a24mr8392185a.44.1786559298959;
        Wed, 12 Aug 2026 11:28:18 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5e2d2c9sm187235585a.20.2026.08.12.11.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:28:18 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Use spaceship comparison operator when comparing ibpkeys
Date: Wed, 12 Aug 2026 14:28:07 -0400
Message-ID: <20260812182807.7311-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparsion function for ibpkeys in kernel_to_common subtracts
the subnet_prefixes of the two ibpkeys which are unsigned 64-bit
values and stores the result in an int which might not be able
to contain the result.

Use the spaceship comparison operator to compare the subnet_prefxes
to avoid any issues.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 338dcef6..f338b588 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -585,7 +585,8 @@ static int ibpkey_data_cmp(const void *a, const void *b)
 	struct ocontext *const *aa = a;
 	struct ocontext *const *bb = b;
 
-	rc = (*aa)->u.ibpkey.subnet_prefix - (*bb)->u.ibpkey.subnet_prefix;
+	rc = spaceship_cmp((*aa)->u.ibpkey.subnet_prefix,
+			   (*bb)->u.ibpkey.subnet_prefix);
 	if (rc)
 		return rc;
 
-- 
2.55.0

