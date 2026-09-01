Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A343D50C
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277788; cv=none; b=Mq7PKlCELhqjEStg1q6COwNpf8DcuHtsrkfcQwZvovz02wjmN4Qi2XdL4sjw8tgbB6xz26fJuZNjRoAbv5DKI2/bjBwitC2MxLa+fGFKud9opDoQvKah0wtTJKpkFXFTrNzjdLtofE1B5vKo6C7Sz0x/HvllsLL8k3n/5k5xCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277788; c=relaxed/simple;
	bh=lqG0SkGhP3eD5nzTzUS76aYWUwqokdXGAzSGgtxKIBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9p3KfcwtCD0GRLltReMtgeAiW76bVt4cetXDIBiRWxX4dQHLgw8aUcC7sjiKrNnNBiDnuXRfI33Y2nThffkCcjxrqfjY7hGJnxh5iBeenpKuZL6me5uPvXlLTPEcTk+f2JumI9D3hM2/aclCs9UuLanHLShNmYZVxKPVjVxEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jkqf+Ce+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkqf+Ce+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936dfd009d1so150698685a.1
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277786; x=1788882586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhU7UmF/R9+4ohjPL0lzoi3zi8L+O0TATjvMPuYDKNM=;
        b=Jkqf+Ce+YGjtwCQ4Je8a0SrZnis6i8KYJViTtyRzkmMpFfnAA1j5w+BMaYBGhwMqCu
         2LKme8hv5HHW+o4XldUyrsvq58fC4+IVVJBOEZS7bRp0l4DtBGqPbLFr+kzbYa3R7n1h
         YTlxL+fAerjdP7tjZlBK0arLQtd3f6IJ+lNenpmoEW9D3586OeL+8NmmRig+vr774Cf+
         VArYzYnFaC/mJuMsLvJZVU5IPclvUxvOWAHx7UqUqZDtmmh+zyzZ4kx3ZhWg9L5IykZD
         PgnT09AwOJ97OJMtdnT83U+p+ST7+pbJo/2PWIsx9ZWrIxA21ZKyDcqrTPNSyc0OcTUI
         ObBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277786; x=1788882586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WhU7UmF/R9+4ohjPL0lzoi3zi8L+O0TATjvMPuYDKNM=;
        b=AkQYbUULVs3fLsJmpVa6gAEKbp74CUSCbA8Jl19swDgeE0tZdUz2rR10Mri+fWAp63
         bYlkuDWh/RCI22VrcfoJz9hhGaNtoTXeYrRpGa+eokMNBlMY1GFtJkAC8mlXUkH+kYTK
         XHal1XHma5CclWnGktFVMFHYNxz4DuYiE13zXdgNFBcKaljT95KkDXEBYedAIBxuNIU4
         vyKyDwS/Gzv7ioBsiJYRF3GGpUM4dCZoXy1VqXRwdRxd0I0IWIe5jQ9WtEkN6QPM/PyT
         v4vDEeNrO7LT/u+NJfwW3762KlylYXvX6UCCvex5Y805Ns5SpT6FqGKS2vQd0Xh3emE7
         9wHg==
X-Gm-Message-State: AFuF++lHtLAnchwKurkBtP4eSRXJJI7H+tzfhxqauutdNMs0jF/MkAlv
	a5zSvg5a9vyN+sFXSj++eZOQNkvek5zwgxM1VoT9FUZKZdL1ZpMxYTu61QgrWg==
X-Gm-Gg: AR+sD11p84oMz3fbZJ0yw0wh4NTDM+/ihcV5OVpw7V5ku23gay4qg8lRIcR6NJRSK00
	9Ere8jee2F/pJfHmq/nmwvbf6+lkCBN9ApPdOn1CwBCGDfRU31i30u31S9928e+aSVeaaMpN5IN
	ctgxVRfHHHTmcmnrHxDhFYLGpNQMDtYWt4AzHCfcqp1qZDK6QH/pB0GtNtzFLHllw1i4a2sxpvJ
	glUy8PtSMvdhag39rrAqzq1IUHe5y2Lop7QxoUDTPTs0Fr+hH2uObIvBFDHQIWbzYrMz8l4QKW4
	1taXJMgnCEsiI2P84kZOxHM3OY8/DhGncCLARfUicvnlsTtbeZgvXnGNyySs02DMqfWquiWrkHQ
	/JrHI5cKY57FrkzyOZDuKtBgCWM5WALzbV+Z2lYgGRqHWwE3J6UUkBuNxOTNS4VhDwuudiN95bW
	th4TbStN8jKSvZQdz6UeoIzW3UaXcifW2hp9ollkQOxlQifE6ED0O1y9lkJ9IAWtAD+ili+D4fu
	SvKzc4t7EQ0Yxh/Z6zk9yEFBsQmqsqvcif5YBkqoAJXyinM4XI5tm6x5jSU3AdtPg==
X-Received: by 2002:a05:620a:414d:b0:939:1476:9ce9 with SMTP id af79cd13be357-9394bcf8dbcmr788086785a.19.1788277785701;
        Tue, 01 Sep 2026 08:49:45 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173db029sm1047209785a.35.2026.09.01.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:49:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/4] libselinux: search file_contexts files across configuration roots
Date: Tue,  1 Sep 2026 11:43:08 -0400
Message-ID: <20260901154307.41844-6-stephen.smalley.work@gmail.com>
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

When no SELABEL_OPT_PATH is specified, resolve each of the
file_contexts inputs (base, .homedirs, .local, .subs, .subs_dist)
independently against the configuration-root list. On a stateless
system these have different owners and land in different roots:

    - .subs_dist ships with the policy package and is never rewritten by
    libsemanage, so it stays under the vendor root;
    - .subs and a hand-edited .local are admin config under /etc;
    - base, .homedirs, and a managed .local are regenerated by libsemanage
    into whatever root SEMANAGE_FINAL_SELINUX points at.

open_file() already pairs a text file with its .bin sibling by mtime
within one directory, so a compiled form under a lower-priority root
never shadows a newer text file under a higher one; passing ".bin" as
the sibling suffix to selinux_policy_resolve() lets a root that
carries only the compiled form still satisfy the search.

The SELABEL_OPT_PATH case keeps the existing behavior: everything is
looked up relative to the caller-supplied path.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c       | 50 ++++++++++++++++++++++++++-----
 libselinux/src/selinux_config.c   | 30 +++++++++++++++++++
 libselinux/src/selinux_internal.h | 10 +++++++
 3 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index ce14e63d..2624c343 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1594,17 +1594,37 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	char subs_file[PATH_MAX + 1];
 	/* Process local and distribution substitution files */
 	if (!path_provided) {
-		rec->spec_files[0] = strdup(selinux_file_context_path());
+		char resolved[PATH_MAX + 1];
+
+		/*
+		 * Each file_contexts input is resolved independently
+		 * against the configuration-root list. The .local and
+		 * .subs files are admin config. The .homedirs file is
+		 * generated locally and .subs_dist ships with the policy
+		 * package and is not reinstalled by libsemanage, so on a
+		 * stateless system they will not share a directory with the
+		 * base file. Text/.bin pairing stays per-directory in
+		 * open_file(), so a lower-priority compiled form never
+		 * shadows a higher-priority text file.
+		 */
+		selinux_policy_resolve(selinux_file_context_path(), ".bin",
+				       resolved, sizeof(resolved));
+		rec->spec_files[0] = strdup(resolved);
 		if (rec->spec_files[0] == NULL)
 			goto finish;
-		status = selabel_subs_init(
-			selinux_file_context_subs_dist_path(), rec->digest,
-			&data->dist_subs, &data->dist_subs_num,
-			&data->dist_subs_alloc);
+
+		selinux_policy_resolve(selinux_file_context_subs_dist_path(),
+				       NULL, subs_file, sizeof(subs_file));
+		status = selabel_subs_init(subs_file, rec->digest,
+					   &data->dist_subs,
+					   &data->dist_subs_num,
+					   &data->dist_subs_alloc);
 		if (status)
 			goto finish;
-		status = selabel_subs_init(selinux_file_context_subs_path(),
-					   rec->digest, &data->subs,
+
+		selinux_policy_resolve(selinux_file_context_subs_path(), NULL,
+				       subs_file, sizeof(subs_file));
+		status = selabel_subs_init(subs_file, rec->digest, &data->subs,
 					   &data->subs_num, &data->subs_alloc);
 		if (status)
 			goto finish;
@@ -1617,6 +1637,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 					   &data->dist_subs_alloc);
 		if (status)
 			goto finish;
+
 		snprintf(subs_file, sizeof(subs_file), "%s.subs",
 			 rec->spec_files[0]);
 		status = selabel_subs_init(subs_file, rec->digest, &data->subs,
@@ -1627,6 +1648,21 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 #endif
 
 	for (i = 0; i < num_optional_paths; i++) {
+#if !defined(BUILD_HOST) && !defined(ANDROID)
+		if (!path_provided) {
+			char opt_path[PATH_MAX + 1], resolved[PATH_MAX + 1];
+
+			snprintf(opt_path, sizeof(opt_path), "%s.%s",
+				 selinux_file_context_path(), opt_suffixes[i]);
+			selinux_policy_resolve(opt_path, ".bin", resolved,
+					       sizeof(resolved));
+			rec->spec_files[num_required_paths + i] =
+				strdup(resolved);
+			if (rec->spec_files[num_required_paths + i] == NULL)
+				goto finish;
+			continue;
+		}
+#endif
 		if (asprintf(&rec->spec_files[num_required_paths + i], "%s.%s",
 			     rec->spec_files[0], opt_suffixes[i]) < 0) {
 			rec->spec_files[num_required_paths + i] = NULL;
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 5d18e7a3..2f648f13 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -595,3 +595,33 @@ int selinux_policy_open(const char *path, int flags)
 	errno = ENOENT;
 	return -1;
 }
+
+int selinux_policy_resolve(const char *path, const char *sibling, char *out,
+			   size_t outlen)
+{
+	char probe[PATH_MAX];
+	unsigned int i;
+
+	__selinux_once(once, init_selinux_config);
+
+	if (strlcpy(out, path, outlen) >= outlen)
+		goto noent;
+	for (i = 0;; i++) {
+		if (access(out, F_OK) == 0)
+			return 0;
+		if (sibling)
+			snprintf(probe, sizeof(probe), "%s%s", out, sibling);
+		if (access(probe, F_OK) == 0)
+			return 0;
+		if (!selinux_policyroots[i + 1] ||
+		    selinux_policy_remap(path, selinux_policyroots[i + 1], out,
+					 outlen))
+			break;
+	}
+
+	/* Nothing found: leave primary path in @out for diagnostics. */
+	strlcpy(out, path, outlen);
+noent:
+	errno = ENOENT;
+	return -1;
+}
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index ed77cf34..3d553f9d 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -122,6 +122,16 @@ const char *const *selinux_policy_roots(void);
 FILE *selinux_policy_fopen(const char *path, const char *mode);
 int selinux_policy_open(const char *path, int flags);
 
+/*
+ * Resolve @path against the configuration-root list: write into @out
+ * the first remapping under which @out (or @out concatenated with
+ * @sibling, when the base file is optional but a sibling such as .bin
+ * may exist alone is present. If no root has the file, @out receives
+ * @path unchanged and -1 is returned with errno ENOENT. Internal only.
+ */
+int selinux_policy_resolve(const char *path, const char *sibling, char *out,
+			   size_t outlen);
+
 extern int has_selinux_config;
 
 #ifndef HAVE_STRLCPY
-- 
2.55.0

