Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762221255A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229790; cv=none; b=otEuNwTPt5gt+DB33nQSKiY99HwsxmgotU/mjh8LVv3yLuUN7dxzRDd1GoWivJekdngDVNysKR/qIjFFeCzOTyk5la3oA1aNPnt5Drx+L5LoFxpc5xrNzv5Xj8K2LCBQGkO6eJfdY+pzWiVMXcvaz+RGt/jcw/bFPmtnoZhQ0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229790; c=relaxed/simple;
	bh=M01xmuDtRHcP9/QCC/vbMHLQbOoNoNBNMQ5EcqdLYew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxkDjCrsaItNNvvM4huj9ApUKxZP4CwZnR5dTEN/nNnd1cXd6SgjSYs9qJZJnGejhk6X1kDqmOQvWiday9xyuadcOhs7ibuQFXxUfsmnbgKcCdFX3x2X4s0yLPAZNape7XJQW0Xo7FDNjsanM5zGfzTI2DALdikOQDc2ImPVHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXFhzNZR; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXFhzNZR"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7296b265011so11266137.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229788; x=1782834588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFiHUcVYfvuD37J0VVJaZN18Nqe/KRuP2u8SU8S5h7I=;
        b=gXFhzNZRrTMoFqm5TDqFgtYG1ZVIpfUv04AqT0wjakXbTztcn63unr6PgH7qtVCs8m
         Vdjs4l6EpzUDUpyckRXirdMIQjdhyyd3YKXqIAko/nTHfqvDF3nH/pPIIxg0ntfd3lKm
         PY2njDOLwiuEqNS7D/IexfH0ArmOHvlFmi21uY8efoIgXE/FRdzr1UV5n8LTboIy+QwA
         U45zdemoFwKIpweuZ3NTYe5YmumzsTKmrPNqXDXNOUH3M0K+pnrIQOFuueur3xKr5MT7
         btJFue9mME8Sk7sbvpfcAhJ06V0uEv+9xkNgfkjDora33mAKJEE/mmHvijOl7eNiKo/h
         Dyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229788; x=1782834588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFiHUcVYfvuD37J0VVJaZN18Nqe/KRuP2u8SU8S5h7I=;
        b=ixO0/tGJZxTHdVfiBOIFyWOGsNvDTMzzPYOJLfkS9QTV8nw7Oqi1BQoKg/WKNXnLit
         tHl3XV1K8n/dtWB7MhRRnokIRsZWqRlPM1aGPzkD3THs5Jb0mBJoG806cEexQwW19MXM
         TreMPB/EVVKnhH+yZlgVZdtmlGk2iSm2nQyYJsyOdIvW+YDV2pN1uXth61wrDKGPrYRw
         2nSafQLEIDDVZf66GcuYWA/8zrG2NSs2wkV+LbjgCdzrblOSzeW7pn6pRgh8yxof9Jqj
         ZUdamx8UGcQv/90/S3YN17o/Zjsnv43iPgue31SaHuI8me8heo5Hc7Pmex/lS5hTT9nF
         XYaA==
X-Gm-Message-State: AOJu0Yzobf+ZvhaMMQsrVvVLZdDvu3qhRoVEBu/bmx1RUOgAj1ZFuJEM
	lT6UgTpy1SDUyqyvJA4KguLdmdrlC3jHG5DkAPqtwhwvurTleRWetzNwsC0H6g==
X-Gm-Gg: AfdE7ckJNlfyvCgvnnZm4QVHY7zi2Leg9W1Xvt2Ubt6p7+XWmVUxH5oc+p4tj4jdfZx
	jFAZ4DSNgY5UQCRjO6IJFBBsHj3i1A4ZPV6J3jAUVWxJGNICg6u6Y5UxLJ8217p4IyyRlPv7sdL
	4w9ulbXZ15IFnLzBqWmQ+q7f6KZWB/hOozdIy8VS96Y2MuZDt/rUT7abkjzC0u8p92aXbgW6fRF
	AZl1+2UUhVffQbiEegGapYnQeTrx+CeSyPltKu4UDZXDbSfsXrey8Elm0uBwFSPJRxphEUMVnP6
	12Dhc6vx+O+572YuPLTgsHNqjnLw1rwbcVJnrenXgouJoNth9LHuGNAsH+IsyUYxqnVSlfZ/FIS
	oQFK3oBfmh1DLOo5rWKP/TrZTmqvNfEw6kq3csGbjrX6O9LV7SJ05blwKAW8q3FFO/fxNaUsFRo
	ZQPkmItssAmStUnW9/x8yqDXT1NEQA+6JC+WE=
X-Received: by 2002:a05:6102:5348:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-72ff5977946mr1749513137.17.1782229788273;
        Tue, 23 Jun 2026 08:49:48 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm128197266d6.8.2026.06.23.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:47 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6 v4] libselinux: Add overflow checks
Date: Tue, 23 Jun 2026 11:49:32 -0400
Message-ID: <20260623154937.16913-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "*= 2" is a common idiom to grow an array or buffer, but it
is possible for this multiplication to overflow.

Use the __builtin_smul_overflow() function that will do the
multiplication while checking for overflow.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v4: No changes

 libselinux/src/matchpathcon.c | 6 +++++-
 libselinux/src/seusers.c      | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2623e5dc..80de61a0 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -117,7 +117,11 @@ static int add_array_elt(char *con)
 	char **tmp;
 	if (con_array_size) {
 		while (con_array_used >= con_array_size) {
-			con_array_size *= 2;
+			if (__builtin_smul_overflow(con_array_size, 2,
+						    &con_array_size)) {
+				free_array_elts();
+				return -1;
+			}
 			tmp = (char **)reallocarray(con_array, con_array_size,
 						    sizeof(char *));
 			if (!tmp) {
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index e4a844df..310b1e7c 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -114,9 +114,9 @@ static gid_t get_default_gid(const char *name)
 			break;
 
 		rc = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-		if (rc == ERANGE && rbuflen < LONG_MAX / 2) {
+		if (rc == ERANGE &&
+		    !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
 			free(rbuf);
-			rbuflen *= 2;
 			continue;
 		}
 		if (rc == 0 && pwent)
-- 
2.54.0

