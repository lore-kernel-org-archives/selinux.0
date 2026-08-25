Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791922D785
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686887; cv=none; b=B7+n2vnx6ISZ1VPlcJaE5crEr5Cug2k7UoE+eb1oMuQHnNpX1YLh2vchTIRv+k/oHiulfjZ/W3MJfV6UDciTDWSQguhQMyHTFS1hFWNCQ1ZK3maU7YYsVoiwGkhgV0Xw3NtNcPkZKZe3II7ieGvvrU+RH5PKcVeOm2XLWiBLd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686887; c=relaxed/simple;
	bh=5mZcgbkRVb70AyQ5nT/llUazDvXRYPAojajcciFIyIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzllEfNmymy/9TphR/+dq6e5xHe/QjBwsl/IUrOqGqOdDNd65UTnaXh38ORzRiWVZIfajfZ63PgWgJO2uqEuoWDQx1scsnbl2lziEz7nSIEkhFt2ym2gF0cHLyrpFAJj6FLhfLFT3jfoXHhNIq0ny5IAe/uEwyC2TMM20I5IjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4XPyZvO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4XPyZvO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90cc0e4c51aso1868686d6.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787686885; x=1788291685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mxLPUqZGyyGIkijuO5SQTYpVBCik//NuhDX0HuAXQcs=;
        b=I4XPyZvO9gTOKjc8BJraU09ZTOzthlDiqi+G8bwJ2TTQ1mCvP38hOM8UyGAd8cWS5G
         IOK9kdx79AVOUU8Pg3wjDLspCNLSNMPO3Q6h0T694r81PeEN+tT3/HDxxYYbMveQ/drX
         nvx2hEm2wwflWFjgKeP8b9HgaLskC7AQuJR1vJFEsKfIcKpLvHK/h/vnjXU0h1B5PC3k
         NnbC6aj9GL1oh1UGW77M8/4hqZnw7QtpD0UxTmnOXx1lTpPKKwScPodiBl4tucnxn4l+
         EuYeV4BfTJpKmzunUbYPChxljJJ55s0mdeidDrc4nJPvCgpV77to/TbeuuglDAwNlHAI
         4OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787686885; x=1788291685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mxLPUqZGyyGIkijuO5SQTYpVBCik//NuhDX0HuAXQcs=;
        b=k7HMgyETbbgToJK3Y6WezGdxh4qyh56yvpdmHX/SnPqTd7WoWePV6b6YicGhXqHbSr
         /Ch7KXr2QmnNfL+RZdx3tJKsgdng4pWYjQui8ptZuIEPMI+orJpkE1I5BSc2F+gjABcf
         yEaIFfhVDcpVQH9MVnZsmSJRm7d6RAgFZbZQKGAKGvUrG6hSIDDwod4x6sIH/K7FxU44
         d/eorg27+9xei20EuaU0WlQhZeKVAOdbqneaq3CcYaugI1O4V4a6AuwdLrdbye3923Ca
         P6p4kxpZ5/KDOtza7S4XmS7IzY6iy5OD92vAAE2M14g2VXJc3m1RgJcKdXvsJyLCfIS/
         NC7g==
X-Gm-Message-State: AFuF++nS3ErNE9PE+DJDnpr59pBEmkHQyYZEuHl1M4L9ARE4Mwdt1VIm
	pXC9R0WU091QG/u2+SsHgMmryPHn7Uddv5WGWxN77LJIvSk9+Y1tpVfGXGcxqQ==
X-Gm-Gg: AR+sD11+cAa6i0wBnjcz0eY2yjGhNu8ci0jUsEuQiGp6bplXQ9CCY7HSoVeWocdVcUq
	t3R94da5YhBfo1pR87kN6BhMyLt7D1axRiEfx4Wmq08O+3xZLwEI6A6MuMgl66LUl3pg10CdJHt
	LpGH7D2B5QRSfwvw/i/Ta7x6ddRVTfE5WNybMaMguRI3zdlD2w3BkoWpzlPE2XZV5B4s7QefhHJ
	VH/kAGxso1iKcaqXnLgWiZ+9mcoslOgx5ATOTsESiPmoHb4k6sSyYUWTT/htAjAfMMOVQLxXUms
	YVfs0jCYcgnOhbqW/uYrec+iCAacYVEu+iYh7exfvDOJ7E/3ilPuCklMAXX8Dt1kTWrHH8K3b8B
	fdsIjZ7auveaJOmQ7tfewa1aqVR/RTYwLBLt+afEmQrOO/Eo8oWEYB74vnmtokLPMAzMh0UpzDX
	trmzkMwpU5nzIiHe6G+ChgEKOOrQyO+GZj48q+Dki//U7+2TxPmxQ8GNIuYRFw3mrQTuLi1bMX0
	6aGud4kfTs=
X-Received: by 2002:a05:6214:da6:b0:90c:c6fd:e8fe with SMTP id 6a1803df08f44-90cc7a70f44mr9927556d6.30.1787686884954;
        Tue, 25 Aug 2026 12:41:24 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc63e42d6sm6815846d6.12.2026.08.25.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:41:24 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Move the PERMISSION_MASK macro to private.h
Date: Tue, 25 Aug 2026 15:41:10 -0400
Message-ID: <20260825194111.75602-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the PERMISSION_MASK macro from policydb_validate.c to
private.h so that it can be used in other places.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 3 ---
 libsepol/src/private.h           | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 7d9ae3fd..99d27f88 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -18,9 +18,6 @@
  * Check that at least one permission bit is valid.
  * Older compilers might set invalid bits for the wildcard permission.
  */
-#define PERMISSION_MASK(nprim)                          \
-	((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : \
-				       ((UINT32_C(1) << (nprim)) - 1))
 #define NO_VALID_PERMS(av, nprim) (!((av) & PERMISSION_MASK(nprim)))
 
 typedef struct validate {
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 6fc5fa2d..7f7344a8 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -45,6 +45,10 @@
 
 #define MAX_ALIAS_REPEATS 32
 
+#define PERMISSION_MASK(nprim)                          \
+	((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : \
+				       ((UINT32_C(1) << (nprim)) - 1))
+
 static inline int exceeds_available_bytes(const struct policy_file *fp,
 					  size_t x, size_t req_elem_size)
 {
-- 
2.55.0

