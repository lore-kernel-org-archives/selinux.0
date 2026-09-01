Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E143E087
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278568; cv=none; b=Wd2Ik9JF9IzQ8folXnD/XPeNb+uaYgFxtf/ngG4qF0PNChe0aelnDLNApMhBKL3b0s0/E7LDofQd0AW2yuJaawlqgbcr7AN+SGCUJfEjK2XJXtR/SGFJ97zwKzwhHz4h3ckKeszewrJP4s/dcOcWy4otY0oG9dTue52xY5IQ7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278568; c=relaxed/simple;
	bh=5boiI0/0abW6BmOa5TnlfwrPh4kitRJZDA5P2HDUdzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjjqGSGsyLFR1hNm/Lp5ce5VCu3finQpK17cEzlUDlNXzvZg3LGwhXyVheO09rjNzNveFlOGpNtv73ZyBqLQFmA7ZFEX6LBGaWwDe0O1iyOoyvY9GmkxVCYR2uqGelRzzQBSbSXJFEYlaeST/H1QCarm7maYUW4aYSz7dLudiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDI4fl5G; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDI4fl5G"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a449c57so51148931cf.1
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788278566; x=1788883366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mq+Adu+OdY+el9B3z1NnnEtulUcyGw5ybbyjvWAivx4=;
        b=VDI4fl5G3KFWk5ubu4/Z9WNjEe4hyQsdaIjsQPoami0SVjKxHwqkJ/5yMfLNU5EjA6
         TYRs1a/XzYqDTWFk29CUSgP9l6UhcL/nOaE5s0B8Tj8NKvhHB5fr9DxU/Jef6VZYKAjN
         QxF/Az910CwyNqyEdh2kBnfG8qFdaQk1sClEPA4e480WKBaMgSqjoQvG4e9W+ryrZm/r
         Smm0NkInuKzc1PrZCmPCtsHmeLWyr+V0owCiEgCR4QxwrmqayIocZtdRY9s+YKuJ58Qt
         6xGsGCbHZ7kCSQV21hYZqkX9rrJvdBuQ+AUnhktpk4Rv2LBy0udV40miB9Tbtz7XMG1t
         1e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278566; x=1788883366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mq+Adu+OdY+el9B3z1NnnEtulUcyGw5ybbyjvWAivx4=;
        b=X3gwRX0guXd+o20FfAlcf5T7u3w3Hjkz0UOwN8WdYlbX/MW1BZyHqFWNPct/PEOB9S
         0wtmOoReBm2vepuhp2HnlcfgFL5TUJfFQbNSQKPvuTvr6wmnyBNyCLOGBKH2b6zAcxh4
         J456r2uc0ZZqYlfmMbFJ4/W/FNXejee6Pbc63Tv/JQfpAXGAD9VxshJ+1VGdY/qsY5Ty
         YZ2JrQT8AspSuF9nPRCbFLzOSs2Bc0gBMW5PC5rr9L7++7KNobRBj0Sy28rZYGMF2ogd
         r1GRLmk5eSbkbFOZjLy5ZD58o/hD6TKDhz/YTJIbJ2raZrYK2+x2aqCl4aIOeAGNwNw6
         nuBw==
X-Gm-Message-State: AFuF++lvK53KsZn8u+wbUpNmQChlkEfzBCjZpXykEuwKbQr1VyXMNEms
	85eS9eMMwG6zV0lz2/ngZri5Wh+rGJ1Wh1wtg0jT4Qln90/eX+qQ0Z5PCtlWlQ==
X-Gm-Gg: AR+sD10u0ClmdUv2pPE3t+fJkrHJd7I9cEIDXxWsTZrIFW7mRqWr4ZmqYQ1C06DIwy8
	3y+s6ehCGrs84Mn0CA7049B2iCHaQMjf19GHkRLP69VZWrlUvDNzgMi2qAxQA4R8sdP48GzzfvI
	Wq5UQAuj5t+cNQjG69zP+74Jhfgvew1lat9oW3kCwxZ7WkxRGiO9qfeQZ4ULg49h7CfMPqb4/Hj
	1DJe7Yu7n1tsg/tgmYY/EbshYTqZdT5RHShplTm7Exvc1vbXjRQ28ao/9zcRaHR3TVtKnZcojcM
	V/UKqry8Fm+EgEz0lN9+pmoFsenyOw7xZa7DEWogqymkMLka8807Ve4pyfQHSO9fanXQGMBUj+5
	kmx/LTxCWxC2YKgDtg+eC3eHDtTzArjzEM6o7Z+JtVidAfs8gfThWwsTf0sjHHseaQHhG++Gh61
	q+k9f2wjI3RkKlwy0xn6Nu5RkX05iFUbRQXUqyuXGaqEGPPtNXJJccaE0mk0HTGvKIzc4dryp/9
	LBL89JGnGjdUaEoU+wem9WzSS6O1qGsSY9XnKEJqtJ4hbPQa5dcEx4xlXCVz1SkFLf/OgAqvZQ=
X-Received: by 2002:a05:622a:4d8f:b0:52e:3f51:b791 with SMTP id d75a77b69052e-53021b0b8c1mr125242891cf.5.1788278561026;
        Tue, 01 Sep 2026 09:02:41 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ff704a282sm78980701cf.18.2026.09.01.09.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:02:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/4] libselinux: search for the binary policy across configuration roots
Date: Tue,  1 Sep 2026 12:01:10 -0400
Message-ID: <20260901160111.42656-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901160111.42656-2-stephen.smalley.work@gmail.com>
References: <20260901160111.42656-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinux_mkload_policy() and selinux_current_policy_path() now try each
configuration root at a given policy version before falling back to an
older version. An admin-supplied /etc/selinux/<type>/policy/policy.N
therefore shadows a vendor /usr/lib copy at the same version, but a
newer vendor policy is still preferred over an older admin one - the
same behavior a single-root system already has when the running kernel
supports a higher version than the on-disk policy.

The load_policy loop now records the actual path opened so that later
diagnostics name the file that was used, not the /etc path it was
searched under.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/load_policy.c    | 24 ++++++++++++++++--------
 libselinux/src/selinux_config.c | 25 +++++++++++++------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index a6ec4a59..a64bde89 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -133,14 +133,22 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 
 	vers = maxvers;
 search:
-	snprintf(path, sizeof(path), "%s.%d", selinux_binary_policy_path(),
-		 vers);
-	fd = open(path, O_RDONLY | O_CLOEXEC);
-	while (fd < 0 && errno == ENOENT && --vers >= minvers) {
-		/* Check prior versions to see if old policy is available */
-		snprintf(path, sizeof(path), "%s.%d",
-			 selinux_binary_policy_path(), vers);
-		fd = open(path, O_RDONLY | O_CLOEXEC);
+	/*
+	 * For each version, try each policy root in turn: an admin-supplied
+	 * /etc copy at version N shadows a vendor /usr/lib copy at the same
+	 * version, but a newer vendor policy still beats an older admin one.
+	 */
+	fd = -1;
+	errno = ENOENT;
+	for (; fd < 0 && errno == ENOENT && vers >= minvers; vers--) {
+		const char *const *roots = selinux_policy_roots();
+		for (; *roots; roots++) {
+			snprintf(path, sizeof(path), "%s/policy/policy.%d",
+				 *roots, vers);
+			fd = open(path, O_RDONLY | O_CLOEXEC);
+			if (fd >= 0 || errno != ENOENT)
+				break;
+		}
 	}
 	if (fd < 0) {
 		selinux_log(
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 0a9bed93..b9dfec12 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -368,8 +368,8 @@ const char *selinux_binary_policy_path(void)
 
 const char *selinux_current_policy_path(void)
 {
-	int rc = 0;
-	int vers = 0;
+	int vers;
+	unsigned int i;
 	static char policy_path[PATH_MAX];
 
 	if (selinux_mnt) {
@@ -379,16 +379,17 @@ const char *selinux_current_policy_path(void)
 			return policy_path;
 		}
 	}
-	vers = security_policyvers();
-	do {
-		/* Check prior versions to see if old policy is available */
-		snprintf(policy_path, sizeof(policy_path), "%s.%d",
-			 selinux_binary_policy_path(), vers);
-	} while ((rc = access(policy_path, F_OK)) && --vers > 0);
-
-	if (rc)
-		return NULL;
-	return policy_path;
+	__selinux_once(once, init_selinux_config);
+	for (vers = security_policyvers(); vers > 0; vers--) {
+		for (i = 0; selinux_policyroots[i]; i++) {
+			snprintf(policy_path, sizeof(policy_path),
+				 "%s/policy/policy.%d", selinux_policyroots[i],
+				 vers);
+			if (access(policy_path, F_OK) == 0)
+				return policy_path;
+		}
+	}
+	return NULL;
 }
 
 const char *selinux_file_context_path(void)
-- 
2.55.0

