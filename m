Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2830216D
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311774; cv=none; b=OHlcyz54h3Tu8OCiDkYcmHMFxG9Z07w4ypacyOjaJceirw5XWO+48Dr/nnuM1XBR48+ITQ0b1iZeUJCjSrS/FKyGoceaeZTMMIvxuOzi5EBEoYEy8YB9fZe6azeGs8+w+t8SpFb9xmDCGhgYN0MZuKy0KKGQaDW14fQUYq0jnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311774; c=relaxed/simple;
	bh=aafQW9wI6J5Bjn0nCgHKdb8Y7y3PkmgrfT4UXkB0QkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHjsxU5ERV+IMF/VCi2rSbhVSTTFVtr3gt4spLz5obhpLQvq+cVUU4KlMBPDL9l+oka5KsTrIv6qwySTabbGWmlYv01XGGHyhGyT35DP4HF7toCQtjwf/VQu+B5wJPumoMH9bAjCqOft2wmizUqAUdTIrOl5FCuEQPL9M95bWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcuvv2Rw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcuvv2Rw"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5176fc0cc72so10588731cf.1
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311771; x=1782916571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIUeQ/O8KkdHnuHkp6yP2zBOcdzvxrdXaIOX7j/ioZg=;
        b=pcuvv2Rwg9ijIyP/tYtNvajwb1K8BepqgrpemBh8ioiCkNmUkhWH/kztUDklVb6RPS
         8P18RvU/P0Wa34bRkWXlCxMqnRrQUwnEgOzAWmaA5p9t35inHIOFZmjmUGJNANhuLFH4
         Pu+ysDZ2YKU/yYKXVcyrpHFA4pzy8+9Qh0iOJ9vZdmgbABZpCjW55qSZczK9xVK+Z7Xb
         0dUxRI/OJc9t7SUth8XeU6Xk+1Jop+7QF161/Nf5ZekdqY806ZjqWUy0ypddUJWYUSP1
         oNnUDOnVQ9HWY1TQtRK1HAq+XOnRT6AY0YIKt4tZuFrKilz71mB5Jx9jblfcEHfQVQXS
         82QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311771; x=1782916571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIUeQ/O8KkdHnuHkp6yP2zBOcdzvxrdXaIOX7j/ioZg=;
        b=pxjFqqfoXLpGU1N8+pqj/L+2VUBVBG+QQgjV9VEEZPxH+PVhEqi0QRugZmD184eiy3
         2U2MhNQsz2qHUif5nUl5gHMWbQlZrrCn2tS4vOLlIStdAKZTNwPQqmBxbbsjG5M7Hpfh
         XMgJ6M1beaXTP1JcRU5Qcn3vnFUeFVcmmTXh/kfReE7+JRyLxyWVqGJI4qYTUzqGpqKk
         SolIeVCJqU1lSB3g30s4PPPdxoTAzQKzbYLuGzpyjiqaGrCkSRTjzEVkUdIrAAUpDwRq
         /nE1vmtgEd5ApxW4RRRMdt6ZCxTWqyHhYfz9wUu34F8CRpVocZSjJfjtKF15vnbfv9v6
         b0AA==
X-Gm-Message-State: AOJu0YyRLq/SufFbtMKoXEDTRqe7+LY/HPZ12ySEwlSDcd8jQFvIbDza
	TU7MCmWMC+ux83/y/PtiEp63SVhOicPOg6R9CUpL1pIblwouUqrFsrUUCYaRYw==
X-Gm-Gg: AfdE7cnH2i02XXgknpYlFj5BAzoz3EY0hqkqxFWSjHlEikvfdrYqXMmeZ5x8FosTq22
	KAHUSihQhWDoCPBcE5CeqZpWnfTw+8SJIfgbubQGJIf+YaaXMxzgakjYSbGBBbgaucOCYAfo5T3
	RJqfYNN3335uSoIw45HAjEcAfTGqpyhCLVKaHgWj813EZmgxqOeDgzHFC3dRDRWa4PRP6+mtl7c
	Mbv3veAZM5ZNRaAEYLE7/DjYQBgrCa5+ufwfpWZd1MSt/mXzNZKrE0z74qZ4inUdsqK87SO0ipV
	iZhEXc8T5KwD7sSMUYDzeadmHqU7UsAZAiDTKi+cY8koMh6NFR/lWFVbFUANw/r3TnA+/ceBBnE
	JVAjq7luhphyVhBAIvgDJ1tGgCTiXnvjgOPyX4UZDWNScYwO8r+IIUjUqNA8gA09bP4Vq3xL1yp
	XJFoRuSHyBltYMGWSenvVHh0pPx+zqXs3umnw=
X-Received: by 2002:ac8:5d01:0:b0:517:9e9b:162b with SMTP id d75a77b69052e-51a61afac74mr52673871cf.7.1782311770825;
        Wed, 24 Jun 2026 07:36:10 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51afc29csm48721611cf.27.2026.06.24.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:36:09 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6 v6] libselinux: Add overflow checks
Date: Wed, 24 Jun 2026 10:35:55 -0400
Message-ID: <20260624143600.11282-1-jwcart2@gmail.com>
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
v6: No changes

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

