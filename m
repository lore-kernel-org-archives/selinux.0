Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939485678EC
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962421; cv=none; b=JZOCm8aZrlDFRYM3HUOUYLeBBg4+x+wSrtcLESX23iijUicvS4CHlZ1i4joObGE/NwSK9OVQ5EZZooUgYvvIyJocgSRFitJjlRFQUoZTCStPA142AOL0ZnKV7x3ZMTy2aY5Cy+cQQMbBs4Nofj492xh9AortCi0ElBYXyERUua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962421; c=relaxed/simple;
	bh=10Tqbsy3zVBsrj40CPMdaciFOnkXBKR4UEtNNJgsvAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaLoS/Xou614Ph0QuvfG9OQjpIb0CncJjlZ28eEBhAEMnRDh8XTXvisU4R9PCrZjeDOCu2nniEgS1nZ8yOH8XyfKS2/SwNhyTcIDJYGfNQfGwvzGJU3wv3Y8OnSF6uFKpNHURyXEzMkeGAAtBbLaTe/skr0/UJHhbRCGYsndmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRaKwGgr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRaKwGgr"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-871c8a36fe3so66040617b3.1
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788962418; x=1789567218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xTAc/GyzFLdr+77lwVn7KRXkUhtVNKP1Wg6+w0+XbJk=;
        b=iRaKwGgrZu3VYUR+cNgsJu6xmdvq9MuJYM1xzaC9jGX7weAi6PAxrgnRT+PKtvZaMn
         Gx7cp0l+KzFXdv9yq906Hbcbd+9oeLYTOsGq4JgRXaeaoG9FZSCJexdQdP+famIjIpFc
         FYOzCsi0YVMzfHX9TT6x7mtfhZM8I5xjiyL3av9l5q7GPHKM90HMCdgWN4uXJxyV2tK/
         o5eHDJ0UQq8rignbjhPJXReiNSi7u47EZvE/l8ost+k4OCUhl0ShPbDJ0dJoJu/fxQ/v
         Z6XBNAgyqi0wuE0bJT+EnUgRXQHTNCmIuP3oG8IKDi+SqkImzatSbT5+ls8xmMxx3qwK
         GWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788962418; x=1789567218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTAc/GyzFLdr+77lwVn7KRXkUhtVNKP1Wg6+w0+XbJk=;
        b=Pjf3tIruXts49Rg8IB0WUAyGjUmFsjSzxtJgLq7ngrTM+sY1VQbcYtVPTxTc+2eQMH
         JIKmpJYJi3pCEIqpEQ6OrU9OqqzL1AouPgGHa8IB/8oA11WdNSpnSUxXLOPsgzpUN0k+
         VvFta2/kSkEk1/81OnPvfjeDsUXUvheoBSZxc0hgYcjS9n2Nzo2dx4gttHHKvWkrrKTM
         Z+xld0YkzgRVKEe7QKRP8Fm/HYm/q0OPk8yBXfphec9tKENl0Pj9sXkU1+HqD0TQ+BB0
         KiSSFiGEQA8CjKxlTOfmJKlpOqOfX04bPaISKBPyWg0F3MM/t6BY0W1RmMtGQbW7+mbQ
         SEyw==
X-Gm-Message-State: AFuF++mmop1+L8A+ixf+5ZhD31/MLAth9skxOFdcFrQDHv3hKN1tt7eU
	5mOTkcccnfaiMmobzIAiZAMq+KDW4cUR3O9ZChECFUZfM+jk12bezw5JF7nGng==
X-Gm-Gg: AYBFou1Cqo0cjMyMaD9sbHwizMOkFNI5wxtYS36EpjV1inTM5r4g4W0nAx5wET9vgoR
	D3+bTMnB0ZJmVZcJNME9WK7MSpmHZb6HQX8IO0BAjjTbiHk554GlEmk+HdaAv7vD/ZxYgB6l9zY
	ttiVNUlwTcNypz4RmTNkJZxwd3qOQxN4bmhcGcf+LHxQJQxTNAY435FhVcvl39ZOFjae7r61Bum
	tYeSqMIMSJ+1GWsQCB/Z9nRNawkgQU1hs4Q+nNerM5bhC2E/ue7cwQlSqp1ItdS5sD6Bo7CsEV1
	wki3SCWrykF+17UvBBklZKQc/Pfd0ucRXdQyvRK6BQSi8nFRWcgBQ+0Jmjz14R89RUSx0hcaUcK
	emh04h0wATxbeJSo5rTbCkV4SG7bF+Huqit7DU8SbJR+9IqanJ8QzmtmPTg4K1V0HeASQ6TJCoV
	0jNVh/cF4Owi2zgMfzwOzGCB/aJ1Bv53qO76r11+NeDH8WR2/V6wPfauAq0xg4rw7U2l60P75hO
	bHztuccR7/Jv8f1tHnkCsY3zbmgvBnHgPoKldbfNXOydPkIBFaO3/3m2sdbXAAS6GOHHyUOIIs=
X-Received: by 2002:a05:690c:c:b0:873:5bb2:6c22 with SMTP id 00721157ae682-8735bb26d12mr105268407b3.41.1788962413243;
        Wed, 09 Sep 2026 07:00:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afe48sm143593906d6.43.2026.09.09.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:00:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] libselinux: fall through on EACCES when searching configuration roots
Date: Wed,  9 Sep 2026 09:59:17 -0400
Message-ID: <20260909135918.29943-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When searching the configuration roots for a given configuration file,
rather than failing immediately on EACCES, continue searching
lower-priority roots for the file and succeed if we find one that is
readable.

This prevents an unreadable file under /etc from hiding a readable one
under /usr/lib.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 removes the double S from EACCES in the comments.

 libselinux/src/load_policy.c      | 19 +++++++++++++---
 libselinux/src/selinux_config.c   | 36 ++++++++++++++++++++++++-------
 libselinux/src/selinux_internal.h |  9 +++++---
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index a64bde89..ab6743fa 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -137,18 +137,31 @@ search:
 	 * For each version, try each policy root in turn: an admin-supplied
 	 * /etc copy at version N shadows a vendor /usr/lib copy at the same
 	 * version, but a newer vendor policy still beats an older admin one.
+	 * EACCES is treated as absent so an unreadable file in a writable
+	 * root cannot block the search from reaching a readable vendor copy.
 	 */
 	fd = -1;
-	errno = ENOENT;
-	for (; fd < 0 && errno == ENOENT && vers >= minvers; vers--) {
+	for (; fd < 0 && vers >= minvers; vers--) {
 		const char *const *roots = selinux_policy_roots();
 		for (; *roots; roots++) {
 			snprintf(path, sizeof(path), "%s/policy/policy.%d",
 				 *roots, vers);
 			fd = open(path, O_RDONLY | O_CLOEXEC);
-			if (fd >= 0 || errno != ENOENT)
+			if (fd >= 0)
 				break;
+			if (errno == ENOENT)
+				continue;
+			if (errno == EACCES) {
+				selinux_log(
+					SELINUX_WARNING,
+					"SELinux: Skipping unreadable policy file %s: %m\n",
+					path);
+				continue;
+			}
+			break;
 		}
+		if (fd < 0 && errno != ENOENT && errno != EACCES)
+			break;
 	}
 	if (fd < 0) {
 		selinux_log(
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index a4b5f463..297a33b0 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -90,6 +90,13 @@ static const uint16_t file_path_suffixes_idx[NEL] = {
 #undef L1
 #undef L2
 
+/*
+ * Open the SELinux configuration file, trying each confdir in turn.
+ * ENOENT and EACCES fall through: an unreadable copy in a
+ * higher-priority root must not mask a readable one in a
+ * lower-priority root. Any other error is reported against the
+ * location that produced it.
+ */
 static FILE *open_selinux_config(void)
 {
 	char path[PATH_MAX];
@@ -99,9 +106,10 @@ static FILE *open_selinux_config(void)
 	for (i = 0; selinux_confdirs[i]; i++) {
 		snprintf(path, sizeof(path), "%sconfig", selinux_confdirs[i]);
 		fp = fopen(path, "re");
-		if (fp || errno != ENOENT)
+		if (fp || (errno != ENOENT && errno != EACCES))
 			return fp;
 	}
+	errno = ENOENT;
 	return NULL;
 }
 
@@ -550,15 +558,24 @@ static int selinux_policy_remap(const char *path, const char *root, char *out,
 	return 0;
 }
 
+/*
+ * ENOENT and EACCES fall through to the next configuration root.
+ * EACCES is treated the same as ENOENT so that a file the caller cannot
+ * read cannot mask a readable copy in a lower-priority root; any other
+ * error is returned against the root that produced it. If nothing was
+ * readable, errno is EACCES if any root refused, otherwise ENOENT.
+ */
 FILE *selinux_policy_fopen(const char *path, const char *mode)
 {
 	char alt[PATH_MAX];
 	unsigned int i;
+	int refused = 0;
 	FILE *fp;
 
 	fp = fopen(path, mode);
-	if (fp || errno != ENOENT)
+	if (fp || (errno != ENOENT && errno != EACCES))
 		return fp;
+	refused |= (errno == EACCES);
 
 	__selinux_once(once, init_selinux_config);
 	for (i = 1; selinux_policyroots[i]; i++) {
@@ -566,10 +583,11 @@ FILE *selinux_policy_fopen(const char *path, const char *mode)
 					 sizeof(alt)))
 			break;
 		fp = fopen(alt, mode);
-		if (fp || errno != ENOENT)
+		if (fp || (errno != ENOENT && errno != EACCES))
 			return fp;
+		refused |= (errno == EACCES);
 	}
-	errno = ENOENT;
+	errno = refused ? EACCES : ENOENT;
 	return NULL;
 }
 
@@ -577,11 +595,12 @@ int selinux_policy_open(const char *path, int flags)
 {
 	char alt[PATH_MAX];
 	unsigned int i;
-	int fd;
+	int fd, refused = 0;
 
 	fd = open(path, flags);
-	if (fd >= 0 || errno != ENOENT)
+	if (fd >= 0 || (errno != ENOENT && errno != EACCES))
 		return fd;
+	refused |= (errno == EACCES);
 
 	__selinux_once(once, init_selinux_config);
 	for (i = 1; selinux_policyroots[i]; i++) {
@@ -589,10 +608,11 @@ int selinux_policy_open(const char *path, int flags)
 					 sizeof(alt)))
 			break;
 		fd = open(alt, flags);
-		if (fd >= 0 || errno != ENOENT)
+		if (fd >= 0 || (errno != ENOENT && errno != EACCES))
 			return fd;
+		refused |= (errno == EACCES);
 	}
-	errno = ENOENT;
+	errno = refused ? EACCES : ENOENT;
 	return -1;
 }
 
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 731826ad..718beb6e 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -117,7 +117,7 @@ const char *const *selinux_policy_roots(void);
 /*
  * Open @path (as returned by one of the selinux_*_path() accessors),
  * falling back through selinux_policy_roots() when the primary path
- * yields ENOENT. Internal-only.
+ * yields ENOENT or EACCES. Internal-only.
  */
 FILE *selinux_policy_fopen(const char *path, const char *mode);
 int selinux_policy_open(const char *path, int flags);
@@ -126,8 +126,11 @@ int selinux_policy_open(const char *path, int flags);
  * Resolve @path against the configuration-root list: write into @out
  * the first remapping under which @out (or @out concatenated with
  * @sibling, when the base file is optional but a sibling such as .bin
- * may exist alone is present. If no root has the file, @out receives
- * @path unchanged and -1 is returned with errno ENOENT. Internal only.
+ * may exist alone) is present. If no root has the file, @out receives
+ * @path unchanged and -1 is returned with errno ENOENT, or if a root
+ * contains the file but it is un-readable and there is no readable
+ * fallback, @out receives @path unchanged and -1 is returned with errno
+ * EACCES. Internal only.
  */
 int selinux_policy_resolve(const char *path, const char *sibling, char *out,
 			   size_t outlen);
-- 
2.55.0

