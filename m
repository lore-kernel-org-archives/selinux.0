Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9D43CEC8
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277787; cv=none; b=kfreBklDm1pRghsDl3+2HVT/3p7H+xOr8G+nvWPXcZLAETA2TIVYntUP1gDIrZaGTiyxEevBPw1IMllf87y8ZJBfIoDDDmmKLaDG0exeP/1rB4k2NhS0LYxdhPs++ToIDFYnginIN/PXnmbKNpS0hsqCn9MEAO+ApOo9dPG48Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277787; c=relaxed/simple;
	bh=QvvDs1Hgtuv9JeFmeavg/mudCCGGCu45vCK7q4ahlvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxe4l6QaTcXYYcw8vMh6a0d2zBaSQtLUe4HrJufjMGiVJswLDt1LJDtp+bLgWJubI1fIlCqout7X9ZntqUgyKNCo/ufQWYjSdHUcwfXwkBJIOwWc53QW1kMEYId6lUexMp4kARC9isyGbt86ULllxRmdonr4jvDOgukoZ0OEh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOh93Nnj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOh93Nnj"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-936c02e58dfso4423685a.3
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277784; x=1788882584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A52kVGmJzgD/27EbE5FQhHl+g2DDSdZxAnJQiajWHhU=;
        b=EOh93NnjJjQ3U/BaOmsiItt+tAdw6o7ywFClTA9kvgfM0aWHoxMfZLvfugPGSieCjP
         3KsJj4ba64uAO2SrS8MLg8RgYePTGcDqt9LiAXo6sC1PBbLZi/iwTuaXF5r+Q0pX3CUc
         kJb2T3r1vKjmzZhODgw8PRp/9NF0T2gcyI7cKHH8E0Xgfj9pasC/HEkV7LZ/KtovrfcP
         Py0hZVWSU6XjH4ADZ1M903lVyMyMzoBoQnoqUyW4b9nDy33PzLXjuiy2AGUZy1yNZ6s5
         aGlEjbF9gK7XxupxTSskTwwEhLxnc5NORdKiL2hBoS1/v9CFkI8Ldp3jW1niAuanMMl2
         jdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277784; x=1788882584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A52kVGmJzgD/27EbE5FQhHl+g2DDSdZxAnJQiajWHhU=;
        b=M1abAlU7lBy/7jIti4ohgPYJl31KCfHU9Rc/ZbQUua9W1yw3xit1FAHkVHF8oiPACW
         tLza0k/zjXhWdpgnVICmymclMQWSdkKm6aPaxf2a/O20WYxx1f4GJkyk4etmJWd9jONU
         SdQIcBtSDxW2lAyE8dgpAd/gETZ1RMf8V8HPyXxGOJThWdVJuiuiS2hRDimW3kj03kC7
         D+brQbBfl1/yCe/+sm90HUOb4rHV/9cZOaG/oL0MSNWC7+TNQpo2TQVo2bOGXUJDO9hV
         pyqm25aOw4GYuirDegqFZoegLQK9M+hwycqhN5YkdXb0GW0AT9YCPCypgf5iIPCS7QL8
         6nbg==
X-Gm-Message-State: AFuF++nHq+5fpa6Lu3J7jrcA6w7gaWrywzU1FFUYlYIzIipoqZW+eEgJ
	JQZcHnJ9ggOg+7ABguVeAG4OezjWM7d64Y05ndlJvBqaFM0UQFizsrq+TsLfBA==
X-Gm-Gg: AR+sD135sYVXCtzTdxTVeOFcoh7HxlPtwa94C2cHtgHPU7wK5TT2Ka13UqTJLaccuuf
	5FJ4E2T/NaqzcxfLoHKHNhp+RtPbcENa2NPKKwvrTTgQQO54m+GWObrroL8S79d24ziH353YafQ
	LbheK2yRQwBeWJIUOHY/OfKHcUXF61lj4U12q4vylNryRC0uOPCy5kKZOPjQsCxD4qhCcHd4gTe
	Njp6AOqa4XgHr/kYYBhrezDjuqMX3BSqkam0wL/s92O9qoSia+n50iGxwvgjURrwX4drA5KLFF8
	wogvkAtR4RPxTEyPsPjlTfr4ApBD7hsD3fu+RNVCenAqWLj4Uri6H80oKY7oEuSywYAYmJir8li
	/UgOjRpV0oE6B0X9bcSQAq6SPC49xrJZwSsWv7oI4Cix1fXRZczWwW3OG8fFga+OoghYal/jCcH
	iCbdRu5Zh8L4pY3f52aFOU46rKMBrz25TGYL8wSiZ8vlSQw+u5KHNar5s2jhH2F8QkW9H/YeYml
	pYl9Lpw5HrayoqyUxXaTFDqXX3TpBBEYbI6L/gi80BfZPLdlVLXb6HG9Jus2eKq
X-Received: by 2002:a05:620a:7103:b0:939:4890:98e1 with SMTP id af79cd13be357-9394890af20mr1207579585a.42.1788277784160;
        Tue, 01 Sep 2026 08:49:44 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173db029sm1047209785a.35.2026.09.01.08.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:49:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/4] libselinux: search for the binary policy across configuration roots
Date: Tue,  1 Sep 2026 11:43:06 -0400
Message-ID: <20260901154307.41844-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901154307.41844-2-stephen.smalley.work@gmail.com>
References: <20260901154307.41844-2-stephen.smalley.work@gmail.com>
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
index af1f9bfe..5d18e7a3 100644
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

