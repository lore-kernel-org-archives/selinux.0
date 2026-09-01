Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417304854FD
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280536; cv=none; b=dqPlaDGrh9y3DmfHjV49JyEHKZNH4M3nBfgxGql5hlIIua1p7NsXkfT3l6WqkwhVyTsFwUpk5HL6gJVGX33UqFiHzvprfFdAJRTGRODr8Cfk7hRfR1+UkelgPPRrD9ushQpb4M9XMDroYzvzhNZ7WtGpRv5O/raK3fBMNkNrNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280536; c=relaxed/simple;
	bh=OiA3XeGgk7PWNDgsnAi++Ssej4r4Id4zoPOodrSZHdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEKCV0E8iGm0QXld0cbFqXIP/QEnYY1p8zGhHYcxefYQ7PKH/u/Zo+Qdfe5oGDeisiY3fZE1ie9GLWaRSioCkx+fx6bC3FLrw9jPwqgLXRTpDR0PTKVKj2MUcSvLoG42JlloMET4TmBBv+GECSA6CQlz7Vl3aRZpYxd5trVSx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijwEzXP8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijwEzXP8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52b6543169fso8327151cf.2
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280533; x=1788885333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HqQOhmFA2AUR+vVzFzrt6D1VabkqjMCpPIaypmAqyi0=;
        b=ijwEzXP88HW5LWGXRdFDljd5XBaMcBUa15tY0/K84x3NkSiXWS7uqTbWd6mVP98PTN
         JdHoNNBDM18KjkAWx23Wo/uhAVpOzlpX/5JYDaFJZnLKAjFcBscAarw6gyw5JrewX9OW
         Tpov19EkP2wOAQHO3L5JBJhD3pgoYUcRQP3UjwYsU8iw61FnVAf2OZ/NJBM2JyEgmGlc
         k+2vGXbALYIWkljuir7euMmkj8gRbULez8cAs/N3CJhHoOsbhMDpFG00cakLi2mAzG24
         c+ECoFTCWfGBUOEiztrfadUA4tqWzplV7e+dbuUzjos89DGYKBfmuP7UGV5QGCTNg7qt
         YYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280533; x=1788885333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HqQOhmFA2AUR+vVzFzrt6D1VabkqjMCpPIaypmAqyi0=;
        b=CNF+cPdLYaUgQUHQE7eNARuaCEbRaVTW9UANmuQyZjfKTT8CQxyIlOjXUZGm0HSaII
         rVFGDX+w38DQOVtJZjiEo869Ub/upmGCBEXY8u9q0rLgpktxIyD354eMra0MqDR6zMg7
         Lb9Ztf+q8IqelRy4+VDhh+ngYS9FIvUNnvTsepxwvnoQFgvK8WXQIrVAG5leTScFGigN
         bjdADlxGizASqe0HmSDq8pQwiiERy29uxLGW0cRhq168oUbOzm3RYrRMtMFqicUAbQA/
         xMvxf+qH6bCK0qeQNlq0co5sEL+gDMvx7QL2iG6pFGeOfqgJ1oGTxQg9c1wS/6yRI0pq
         JUOQ==
X-Gm-Message-State: AFuF++nH4MauJ7TPZFCFPiYTns1Vi+5Cf0xj5Fn1OE2IcQI556nUVb3K
	H45xP5GK4KZhkN28V5q9qHgxLTOdZpyI+wSHABfWb2Wv9NKfkMHUVQhvaRNFlQ==
X-Gm-Gg: AR+sD10ZihSti/EiM7OHC2hCFT5zTERBkHEEQHpF+PsmxMZ8zwxT1ze4kPw+ZWrGsUk
	fDGSYTP3MRAe50vc1jxl6tWfSX5ugyM997tGLvtp3+1NbrtVZeaH+eCu5hFGt6DTXnPYxIg9pHY
	7sX5P5dnsBRuGhD1mwpNR6jzz5TN0jX+G3iXbfI4WQhlXOb9akxvjkbw7PxPQMsUVw5iLiSuGmI
	3fh0oXfTxx1UmQLfw5sS+FgSTJ/jKlfEZXZ1C8jtMiCL302Sj3ixZpIJyo8216weBG8THVW5bg7
	UkRJfFERVkooSR6H0rGNlQW8evo3nL1S8rZbB+d0kuNP9TAAzMohHCsZmyfE5djs7UDVuxjtrzU
	JRA0E2SvFhWNPg2CMaxVM6SBHqIrJQjWZa+i/SfQYV6rsyKYuEFNdkKc1n/2PRDpy0j08s8X+Fh
	TL5WinKCi/e+pCywROOhIE64viwe1K4xrccdVCwgY9pyMfFjDMnr4tItrsApdYk6lprTZ7bkB3M
	dL/KyybC+v0bt1AIRsucGbxVwbvkAR+XOAdCDdSFDx5ytBZhmp3/p5FJ0C0x8sA
X-Received: by 2002:a05:622a:1b0e:b0:52d:4f43:d5b0 with SMTP id d75a77b69052e-52fb9640c97mr441770941cf.22.1788280532793;
        Tue, 01 Sep 2026 09:35:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce8769b76sm103461946d6.13.2026.09.01.09.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:35:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 4/4] libselinux: search file_contexts files across configuration roots
Date: Tue,  1 Sep 2026 12:35:13 -0400
Message-ID: <20260901163513.43186-5-stephen.smalley.work@gmail.com>
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
 libselinux/src/label_file.c       | 49 ++++++++++++++++++++++++++-----
 libselinux/src/selinux_config.c   | 31 +++++++++++++++++++
 libselinux/src/selinux_internal.h | 10 +++++++
 3 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index ce14e63d..54c43419 100644
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
@@ -1627,6 +1647,21 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
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
index ef03eea5..a4b5f463 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -595,3 +595,34 @@ int selinux_policy_open(const char *path, int flags)
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
+		if (sibling) {
+			snprintf(probe, sizeof(probe), "%s%s", out, sibling);
+			if (access(probe, F_OK) == 0)
+				return 0;
+		}
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
index d3b5cfee..4ce99413 100644
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

