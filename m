Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A903A7820
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348740; cv=none; b=N5hJAQfub3+pruwA127m9/usBB3Sp6KxjOL5h9qX3bfrpxKfS2Fyygu3MJjxjQ9HbxHPUfcpdiUF+dKaVdgiKU2gIL121M27ySV+Y6BB6fXtYWmQn9+BN0nybN/bsKR4Qb5M2niw7X1OoFHSd0HTVepPVaihuhjKz7di8ghJcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348740; c=relaxed/simple;
	bh=QWjEv+lQRGreQW7pmyM/nGj4sj9WWmzAMkpx0C9xpw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqSGrJ+bGGDlS/G9RvTNQxfBOgge2p7ugp0WXyx1OVeoGIt6O8H+rQ7sYACbghtpAch1lQKbovWUnxfZ8ls1e9y87oicRKiMQTR+Zde4MUVCHxd68yvsvoOc8TWrw0LjVwL66TrFhANTF+UT/45xw1hpLV0Kp6NZa0l3EIpUEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLqtGzuj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLqtGzuj"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c5382806fso20904311cf.2
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348738; x=1783953538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vCSNG7bnEqspM6QMfflXk+5f6L972pJBfcCPe0sOnRI=;
        b=KLqtGzujx1ys9KU3TfX7f1vVGKDq4B1m6bxxlV+d00E1T541JuzbpqB9cC73D9TNJF
         oqAXawUp5GAcVWIEpceZJ63cHmndujZ9ji+1E/sqo9UP+xuf+OuYjtL5AOY/ZWROHpIW
         FdKkiHwrcVD/o6H+MT+dxmpZmu+hpBVpOthr7zWrR5/lYKPtJOR8YPPSfkkmH4rP1E8v
         5ASxtNXsFGsC+F4uOG3Ja5v1v4Z9QBAn2yVLqs+qIsepvi41f+LmS0kngGwa/ei79MNu
         MRpTtsFwCnQjjQYsS5shiV7e6SMK1Wf2qDPgeA4TJ/msD2kdDgscy/J2fXTrQry2z4Dd
         l8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348738; x=1783953538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vCSNG7bnEqspM6QMfflXk+5f6L972pJBfcCPe0sOnRI=;
        b=IsG7XvNgKEv4ERO/GP2sRIKw0MGR+N9xjowgQ9rLBS1LPS0khRa973S0U0Z6nDHW8W
         LE8QFlgkpamGJyy7qjJX6/NIc73HF6FeD1p5xXG5MyLcdoiEtG1NKmS8nqeZoyDEG6H1
         ngxuKtIgX+Q/cHTz3wsvG0yvFxSIkFI9YRVaPdeQ/BUl3oH3qqnB3MmX1eOUw+fzG6X6
         76y/y8sHFKy07YrK4cFODqMI7KrOHpnKyYXDXBBfw3I8ju1VJbZgKFdGnBmOd0Aqh3th
         S3IF37i2pwcwKuWjiyDm0aC5w5s9gUOYnw7vNSBmHFpnTtIEdbYVn+LhPjdrjyxovgrb
         JZVQ==
X-Gm-Message-State: AOJu0Yz5YJKZ8pcRYoaxcm3u+MlgOlMSd7EpADRsLT1U49Ga2v1yz50p
	ofUXjYNZhvI9+I86PkZWQvhEqfMI2cyKFUJa8zhi0jmyAJcc862/WEjDvpMrOA==
X-Gm-Gg: AfdE7clbBD9Hiheuvr8dgXoXQ+yQv+rN3tZWhz4go9nqlFHKY6I1bT4DMcwGFHdsLJ2
	EvGlLpFmtNAd9HfeUoY4a9qrFMOcKMl/gVlv5upneGNWGT7vd8YzMWGNExyVvIv5JPj0LPeTlXJ
	1GBY5IGf5f3sQS2GmtIwCYtG5C8Ssv0Pu55sqQog0DtqsEguJjC+oKeoDfTRPUBHrW1hEucF0J+
	0ZGRtxqJJt/bwNDf+DSwc31f5TbLT2UqR1KrxTyNmGVPEVQldce3CLCW1F7ffM5jeq7/dhGJMdn
	bEb50pkXVsf4vgH5QTl+ZYeGvMe5Q8p/Wi8Tzr1/iHFUKvZal051a/MFn4kXyXVO9KZpTkCTwzQ
	wVH1RSmDkIX1Cbfm9ru26QNLvH2sRqqCD5eyHanMY/Xuy/OmPzFBo50vcO0QF6Z1TQzKzp3UlC3
	LYZ7sfPjeG6CPzaqr657VinUT7k+M8YxcAY5Y=
X-Received: by 2002:a05:622a:2c7:b0:51c:257c:8166 with SMTP id d75a77b69052e-51c7487fd1fmr9086981cf.33.1783348738257;
        Mon, 06 Jul 2026 07:38:58 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm89839431cf.7.2026.07.06.07.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:57 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6 v7] libselinux: Add overflow checks
Date: Mon,  6 Jul 2026 10:38:39 -0400
Message-ID: <20260706143844.25956-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
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
v7: No changes

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
2.55.0

