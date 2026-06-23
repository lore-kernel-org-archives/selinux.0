Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EEC38D3F9
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237006; cv=none; b=EF38DS5C98Bamm52k4rs6PdyPOzQ0m4l+wr2v0Sm4HYX49Ww0z5OSlYe5dkMvTOGptaVL6V98Akg4FosTmzvKvO7tfViT9gOa/umsveoMTyCjdrD2XqplPx7DI/SsyNI4SFqunvET68s3cNinLaWfH/NXoAg64k7lKUlaqbXkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237006; c=relaxed/simple;
	bh=4OUliM3Bka33xEGQZR9rd4TWi7IT71WIFyZAkCGVpk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nes3ynWky4JtvzNMOBYAt1riMFJhA0SHcQbq+0n/J0Eu1Xo4PISneg2HgU/y1JnSzv87i1Pv1EZUUNvQmnndWDFSBWg4JHzZOgK6SVIpiLpHJKt5VC2zrm2hPf28iyy6AKeSHL+6tOF48GsL5cxLhXVow4NgMskfJEG2Y2+SM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDaas3VY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDaas3VY"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8de91c353eeso2413176d6.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237004; x=1782841804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwhCOpYcCAMEeJ6dOBw/KTh6SU7h3zuPHjZSb8SIFPc=;
        b=FDaas3VY7Pz5h3OL8mNmUoj/UZsMyqwah7RO4R+dhq/E3GN+AUVagJWEhbrvMjvo0R
         9nDtIBWAbMvdzwgNQqBfo6LxETdjMVOw6yM4s8NgvLY840gdmmZ1A1PoUTbcvqIzaEwE
         jBDjLiatUrCUaOSFjtKB+zmjxrG30+Byj+oHJAOtV7iLHjdxkyVaR8TMGQROateHda8m
         lH6m0Gp6M6rdzYYZxBxgv3NP5U33aA/osUd5bgIvu0SpVuJDSxSCiGhKsPTRssiQ8tGP
         HQtmnN0Ku2QqLneSh7LmcRmD+Ku+9lz1HQys1o0IlwnVLQoL+SPFrZIZgTZISvHXaiyT
         C0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237004; x=1782841804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwhCOpYcCAMEeJ6dOBw/KTh6SU7h3zuPHjZSb8SIFPc=;
        b=Bdn6H7aqW9Q+XHr7E3A+mUv5soJ1W+ANpIVcfwkUCufX+HOugBngalw2Uiu6USbwwH
         OwKC9jPxLwmXgSuQSumZ/6vpy43Qree6x9BxF8MCTneLWfcREJ0OkEsXAhQOyGecGQEN
         +1/18RhKW9JEfGye3OFVNhJdIGydtkRs7XtJOxDPRODqSeBdK1sI/c2MwCNvWObnUPa9
         ORCWs+CtFsNBxDzZvB2WMb9dVAk3AYCVEl6uHDeKkj81piztBfD0mZ3OPQJqu3Re5Rst
         n4LcDzUC+jyxFLq8sVwgLzrhL3vSQ/yjwpzskjL2EscOsTUfV64E/akHCe9c9tyCX02q
         Xlew==
X-Gm-Message-State: AOJu0Yw4w+OcUAnEFqiGYaio5I3OPcxwxkbFR5qLSgmkHlOUGrq/jQOR
	20DdKhziG+4f9Mj2ljXMJoq8gPXtTlnpTgRGUvAzpIo8jbRBZ0N95s1Ixhid1Q==
X-Gm-Gg: AfdE7cmNCy7B9qW6U8EMXi/klpQiwTnkYIJruF/g4wx9h3RdQaEVhbDfpRPSqorkiGt
	oLf3IaG11gmrkSFbPLEHFuc1tgjAmU1HVJtclCEoxYBD3XoTUMAcetjvG81Yu44MiOIwS7DQeXA
	2kOV9a0BQYqFABYzqWcVY4FEm37OJ2o2cz3BRLn9IvAjwFA6K1JDdHDUvg4sT8I72jIlrJXx/LN
	xY/dcykvkMRZNs90miB/6pECYtxD65Vi08t7gxHEEbS+F3g7HaVBojCUa7gHbydX6D1gycU9Rza
	OeoOuWZgVv0kBIOgsre9MzDjLiRxEpAfqGN6iRQN0rNEP6kVWjU61oOoe4u5pd5Fhp+uTzyLqhl
	47dEbzaJ6q5VYWVhxRcC86v39QlDbEQ7uX6YguhS6w8118NqQL9ywM0073en5fxb6/iG6HFYRMu
	XKsFxFbRx5rGJRM05GJwPJyvxc4n56dgyERfw=
X-Received: by 2002:a05:6214:2525:b0:8df:843a:d947 with SMTP id 6a1803df08f44-8e52f9bc8d3mr1902796d6.25.1782237004328;
        Tue, 23 Jun 2026 10:50:04 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df826927cesm130109646d6.41.2026.06.23.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:03 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6 v5] libselinux: Add overflow checks
Date: Tue, 23 Jun 2026 13:49:46 -0400
Message-ID: <20260623174951.22074-1-jwcart2@gmail.com>
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
v5: No changes

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

