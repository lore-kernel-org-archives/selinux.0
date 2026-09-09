Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5215427E6
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960557; cv=none; b=FAeeq13tNUT8ay4CjeSXk9BHA+tiYrbCeQ5NyCJRzWnfu/L7u2QV5O9iArMwK6dvwGLqq4x938OejIv6Ya/Xe/mSsV9M9dfcGPl048ZdRj18z+awOb0zK3tu+UYTt46j3OI1wfawWVnW0SJt4mSZDsFOZVHCD3LjDk3Nj3b7kG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960557; c=relaxed/simple;
	bh=ZYwQns9CPqOpGHnDqt4WLAffj9c/rEc3LuRgh08uruY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWvXLQBIsnNfh+Lz9fO3b2H1hZnrxDlYGPBzLC/wHn4JOhYXtrzbn9d8wNfJMOWiKJdxa3mA0phIc/IJ6zPorxcHBXAQ50a0u/z3DNdQkkpb3WZYrBnBPu0KENL1Hha0ILHRc/FLadWS7/aE4tHKlLcj2AvnzEozSPwlQ0R8uIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYImH/v0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYImH/v0"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b76679c0f2so712625e87.1
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960553; x=1789565353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g6bXDwJKyuBIZqr6lEDNKLv0XxsOWvUxd04fImb1ALQ=;
        b=gYImH/v0ocem84InZ+UMXFfPIWEfVSt+y6Q67vgHgH4JPtl/AEcxm1U4UDLqeFFDSj
         Y8T5JuBY0hUEXRJswyB0BrFUdOOmTrwl5HeDyi9psrDjRlqDUIU8vNpWHiBOwPERVvQc
         35Pyho79KEXyTXqLHvgMjtwUvZOHqb8P4Y8y9MXePvG/WIbbSsQ3l12L6JBjQGXKUL/q
         hLf9icIG2aH6k8sxU/2+VWkxtQbOiXpsemz15tv9E6YGzD3zpavKfNGYaTYd86MiyRJH
         aZBv2S6kH/El0Iz9nb5glkAphb0iuTaPYqkiFbKPsGOyO+QvSXWF2gjubE8sbYOOI+jY
         KjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960553; x=1789565353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6bXDwJKyuBIZqr6lEDNKLv0XxsOWvUxd04fImb1ALQ=;
        b=FQ6EPFPqv3oUoswCbW7an8eSVHtVOKkZuIcg2xQctkOUB0gdg11aZ2kdzcF7Eh4zEY
         LfnICbYeO0WukqRwXcGoFGJmjXuuZb5kMg+48DM7IonK+YofuLxgagDBMC0E9dOdXcZ9
         M2sidHcFAjICyKWLZPN0+JSIte115BteBz1qY2ejWzYr+0Zae4/q7FhucADA2TsRxcuK
         t0sqDEzqZolfTvEy1nWmWbD2sk4+0n3ADTH+P2VrgZ/knLR31Mkq9P1aN1sCYMucMdX8
         Zmxg+HQgeRZWZso7bIen0ItoL9X2eWSnQwnAiZDkUwCntVZB95Q8llhzz7qr5k0N4Q9L
         SPQw==
X-Gm-Message-State: AFuF++mZFsZhvVRdG/qS7PvkLC/TbF1d8RWc017bDe2NBgoPnCapbYhi
	hEvNaXjFZAqYd9EPm9Zjw+aROXEectWGNX90alXKQyBQUrvvOfKhvad0er2t7A==
X-Gm-Gg: AYBFou17NPSKbv8rIOV4F5f2h731JY6fAEkhXnhaqhZVDepf2vn6vT2ZIaG+i4SgoJD
	cQR0E3ghEkQnVVbSj1DZpNHoc/51YZjOp4DJZp+Dqtz7LTV7bdF/X5uqG7d+thEaTZOJLCaETzV
	W0hV+7bdtXThO7344NTd38IB2chPHuWRyGOIC4m+CGffecrNqNxwAygP4Y+gOQnLID3fn4rsgoB
	pVwU7CyxeJevP9CjoUl4V82RslW9La24L1rybLso1Ln0UwWqyo+I8JonThRdzMRHrakcWHR/zIl
	/gkm/EHvRrmmH9LRbBfI1BLO7IHWAX22pa0v+uwF5joWl5T3qrLEFcvjponuefMNisZf5AeQB4j
	Fcxf9RBLB9aD6440qa4Q8dNfrEs2hi4UW44zA16b2PoF4UKjtHwKKf87Nc4e4eSWZoVxpWiBNUC
	ZTzL7vnZB/dXwEfG4W5Kx9qP3PNAsCcheoK1iN03Cpq4fD/xenJn74U1fI5iK9AabyOpxY6e6DM
	oGkQEPWgS4WwzlXDZldZwGDBkKmDXIU+YiEk/aqExy1abD/RmKf5hXZ2unq3Tz0/ozMPXUjZIA=
X-Received: by 2002:a05:6512:304d:b0:5b7:674f:caba with SMTP id 2adb3069b0e04-5b7674fcbe8mr809064e87.13.1788960552514;
        Wed, 09 Sep 2026 06:29:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b7e99b0125sm351185e87.61.2026.09.09.06.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:29:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libselinux: fall through on EACCES when searching configuration roots
Date: Wed,  9 Sep 2026 09:28:53 -0400
Message-ID: <20260909132855.29732-1-stephen.smalley.work@gmail.com>
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
 libselinux/src/load_policy.c      | 19 +++++++++++++---
 libselinux/src/selinux_config.c   | 36 ++++++++++++++++++++++++-------
 libselinux/src/selinux_internal.h |  9 +++++---
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index a64bde89..8992200c 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -137,18 +137,31 @@ search:
 	 * For each version, try each policy root in turn: an admin-supplied
 	 * /etc copy at version N shadows a vendor /usr/lib copy at the same
 	 * version, but a newer vendor policy still beats an older admin one.
+	 * EACCESS is treated as absent so an unreadable file in a writable
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
index a4b5f463..272e4473 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -90,6 +90,13 @@ static const uint16_t file_path_suffixes_idx[NEL] = {
 #undef L1
 #undef L2
 
+/*
+ * Open the SELinux configuration file, trying each confdir in turn.
+ * ENOENT and EACCESS fall through: an unreadable copy in a
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
+ * ENOENT and EACCESS fall through to the next configuration root.
+ * EACCES is treated the same as ENOENT so that a file the caller cannot
+ * read cannot mask a readable copy in a lower-priority root; any other
+ * error is returned against the root that produced it. If nothing was
+ * readable, errno is EACCESS if any root refused, otherwise ENOENT.
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

