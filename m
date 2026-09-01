Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56A484243
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280534; cv=none; b=cg9WRktpRIaoVuF6H7Z7OHeVq+uey4btLsu4CmS4Ap9vOR/fZMs/Ak2o9m+eYYF6PE2UtRuyBfWCUXzaW6niSADe2gWeiexOVbhe6DGlmPZp+Zg4M0AoLXJD0skjsHjsJ9c4qezZluYW+mXrlFcLeoBo3TTdLtUu2b9flW9dBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280534; c=relaxed/simple;
	bh=UxRT3sN+gL2Kus0WUhzbm2K3Ulm+i/bJ6jf/gAyHmu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKUWZ9uG/hVFs13WiZPfcBiEO9x8826TwlVLziSgHbB3wR23aycY18rBFda7MV6TCNyYlSC4PknZgeSWUeTRbnblufi4tGHjMEefFPVWXtc6Ep/XHT8ItgO7Ohnl0Zrs5zzlv0Valfj6ajyFUQUDLiwpue38yo69pm2JPTzOlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lriytshz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lriytshz"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cd4631090so137796d6.1
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280531; x=1788885331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKet388h6+qtlZ3+6vt8LY8xXRL75AmqocnzA8sL0p0=;
        b=LriytshzeNl8oa5OGjFWht36PktGVGiAqaQuLeQjPE6RaZs0tMOMpgStKZEC5kJRl5
         AYzDPN+SbQeNmsxJhfwk6rbT3QgT/2Mq9G1lnzCPvTxOVEcjUsdK4W76QPuNKk87KDN8
         Wa3ZxoVyj46GpmPG8+IHo7jbWFtwIBHPtW5PZiKVaTljWdE+AygmKGb7Ff0SmlqwDbFm
         tkXCAFM/dLjCC+SD4j0W6OiUrK3TJthmoRh5ei7c5erCvGW3TS6J+lnzbxqfWD7GT0zg
         2QxesYyZInJcw3hvfAROn6oFhXgRZfdnPMAq6VmEj9zj4Lsq+A/ZuPaanZF2wIP8BrhP
         tdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280531; x=1788885331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kKet388h6+qtlZ3+6vt8LY8xXRL75AmqocnzA8sL0p0=;
        b=JTCXl+wHITpPl4sgPrOxOd1NW3aTAd6JjOdU+1/bTaS/fJ1OMaIa6jwiu+H1r2WQ9g
         QJFMNW3de0yzHdYF6FhhZRVhkLwTd0ETwfREf+3wYSKhXorC12VjcXPnE/VNHnS5x3xb
         WswixSdEcQXU+viZkzEN57TJ3fYSe7a5BTgVRbXp0keRl1xSkUydOV6Vhcdpm2Lf+jXT
         3JBcSD8SwcEhCHY8hyWg8YCbgi3bD+XUAZT6hnPeG4Q8XcMxjmn2tWvKUmdX6QuzyHOW
         R6U0m5AwIcHmrQ+ZCkP1wJV3thdwMOeUciWM0Az3NP3dy0cGZPSJ35Y7kzSarhRdURjL
         k0sg==
X-Gm-Message-State: AFuF++mgXW9OsNo7sXq00v/Q+nznW6NyzTX+u4H4dO6M9WS+40HtEetN
	fTnHI7Cgy6K/Qpd9GCC2KANnUfl8ldFfW2bZxrFqNOuFwwXEmXFJUPSJ/dRW3A==
X-Gm-Gg: AYBFou31g/wcyQSzonSQjSeDpMdZlHpHAU8HnHxjF7FOYw6/hBH9FNz9WcXMj5jev1V
	14ayS01lLdzoMpbzfnLKy4a6uJk06vypwAt/v7MGdg0a1f3zZXuApWpkXluUQIh7qVlTCdtrCka
	59YdeGHCMlC1rFoYwNoZqmX2XAXxlbJL4XjWbzpsLJa43oRXOmsdplpEOnaR8Zh8lyLsh8CGMXw
	wWcq4zW1btirTDfNd8PPaOvngEB7xA0/rfLEDa98qjVwUr1K05J0sEN8XWsZaVWtJBn9ITpR4e1
	UgH58+SOIIjLjQOw352buxBmv0+zRukdm4S/4ycnJ4HwOVbkhvV4yncXWoXDxXTGhGfQ0T8jXi+
	gDuaXbCIIlPeJrdFqPLj8ZzHhBPcneoYtfwEb2gkNgkxGQX9F6fuaAWN3ntW2X5RILG6+EhyTP6
	lk9Lk8DgU66SQ/jhUlJ72uZfA0vA2PNFzD6O2AdYhk+xuuBSnTtNaJ5R79tRtKa3q1Vljl92yQ9
	IZ2k3HN4tPV82xV7W57c5tPX0KVZT7hHHEOmcXtD79dWSA5HnV5BFpSAPcGqLkVC2pxvkTi/0E=
X-Received: by 2002:a05:6214:8582:10b0:90e:98fd:48fa with SMTP id 6a1803df08f44-90e98fd4932mr49843456d6.11.1788280531453;
        Tue, 01 Sep 2026 09:35:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce8769b76sm103461946d6.13.2026.09.01.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:35:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 2/4] libselinux: search for the binary policy across configuration roots
Date: Tue,  1 Sep 2026 12:35:11 -0400
Message-ID: <20260901163513.43186-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901163513.43186-1-stephen.smalley.work@gmail.com>
References: <20260901163513.43186-1-stephen.smalley.work@gmail.com>
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
index 199f76e0..ef03eea5 100644
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

