Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF35415B6E
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278568; cv=none; b=uFUSj8WvRvMDHrwrra8PdBZ1itj0a8SdxyU1wd0C4oAUpksuAzWD1JawW0OlB84uiHfJ/4InBOszI/zcFR4zdmxIQuJp0QT3odciPC2aZtnEf6p/zfNhNknbZcAKAVJ/EiubjkevyD0ZAXI2uR0+6KhT0IwQMF5C6+ipLDxaFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278568; c=relaxed/simple;
	bh=6xo980fiZti1MW5qsrBQIEm2QtHYtpBNPMgUbiLaApI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pykHSBIiFI+PrysAmwQHcZvAVM50f70sytef9Xz7ARws3Dl0WZx842xntlj+0Mp5e5v40in6zIm1+OsRr9mquFOAf2UcwU3dAOWnzwQ7sP7zzJwd/msz99U86Umx9f+4w77oSl3R0nN1YxtCqCG5Rd/8tb8Y3IWarQecmfJbeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1c51beb; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1c51beb"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5302b692c8eso6206981cf.2
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788278566; x=1788883366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9uvaSRYkXsXS7uX31ipyCK5P0UyQtwhcd5xzgf4sI8=;
        b=m1c51bebfX6E8Mk1tLVJa4CZq2b6JRvOWl+tlBxKrBz3BGvPJP4pn+dAOyjSIUr4Bi
         0h1mjC/PYtwdcu93BYlR1efMv12EZIZoRP21/538Ehb2/jVjrwNqk9wua6nTAD1rqWG4
         U8EgEqqp2SFujgGfJUL6fzEfzYYcOVvY5tSVbFK9TXHvCnoxFcYA9Z00keXL++oBbX1O
         idba4RPkqKfNXXUCtMm3BTo0pMBEtGU/5PnJf4BAct48qMRmmrcO/OxrNP6gH8z/BPI6
         XQQUY3TVGsgb42QDTE7lKpwsMtQee1BLOwj6PNOXazh2GDVNkaLE0oOQX4P/Ahz89KK8
         rUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278566; x=1788883366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9uvaSRYkXsXS7uX31ipyCK5P0UyQtwhcd5xzgf4sI8=;
        b=dYVSEb6a1+p9vy+YjsTWayVbd4v/U6ka0FVlb9aXBqCR3iuvQf+xxyMJWrONbX/5cA
         FmLnI1BSDKHxxSPC7z4vXnjQJY/fKZf8GTxXxeVMwGgjYbqho7bdvn58qaP5CrPXagSr
         5KXJ4FtfAArPiFlQ6ud2FlYMBqgC1F3HD8B/BItnPRDsID5nrCSvktm6+eDZIumfYMZL
         9jE9Quubjc/5FB4wm2fz75NG+SlxkgLR4ih5f1zBG4PFqgEen1Hp/A6np0uM+G7wkbIm
         jyBCPLhlTZBOz+5ksRBc0dfBiWlk3jxV2I52KJsbisI1KWeJftKyuta6wtOhUguFHAg8
         ydNw==
X-Gm-Message-State: AFuF++kGEoMW5xDSeZ8NluZ4yJILkHSCTGoa8M1OYCcHDrgySTbI2GyE
	T+/QJWU1Nx9Y+aEcfUTV95m+ADyKToozjk28XguKGzTKG2H0xNQhIHivymtQ4w==
X-Gm-Gg: AR+sD11OGzfGUU1Co89tVL9QuEz0a/dLGC01V4qAb/eqM/e53lzshVeaEt8RXn9FH0p
	Sw0dXsya8TvdNp+yKlS/vYiPEb/Ba3+CJp3ZVb7vS05dErwGf7B1RJ0B3Z2P9MLxOqbtBRkiIns
	QFkwhDSKi3bgQaY5yCQflq7Jiv8eOmal0Gn8iv1nPaoHtIBWx3YjMPE9UEr5rU8zxwXtLPFMPzO
	db4fhSVHAdJOw0M/TbBehR0qlv9uToOvSMC5raN+2KuMi3WyTgQtJt3ufWCUOXF/qcqsWlCQSzD
	P756rNkbykS9KZCatqnVLWEk/NJE1o5eUxq84aiQalpua5qyLHveqp421UG+d5T6iQ6aLzCWsif
	y3ldfivM1Yi6bzCyTbQjM+U0vevyP/MbKpbK5/CjRMAXnc4swlNHG6H1/dLMCP/151FTcSLF3gR
	pcCSAYmhqsl/jqkhVDVBkc32C9STHSfYJcRvR2fhaGDUm8n9/Ow7dTezzvIjEkg1lUn5GgvnLP+
	mz9oCYDt+sdFOOLyWhwYn2sgQGtm5vsy6IQ8Pp58cLSiDbKPPx3L9dH1BBSQ+fsCA==
X-Received: by 2002:a05:622a:1f16:b0:52e:467e:e9e5 with SMTP id d75a77b69052e-52fb96e682bmr465165091cf.40.1788278565249;
        Tue, 01 Sep 2026 09:02:45 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ff704a282sm78980701cf.18.2026.09.01.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:02:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 4/4] libselinux: search file_contexts files across configuration roots
Date: Tue,  1 Sep 2026 12:01:12 -0400
Message-ID: <20260901160111.42656-6-stephen.smalley.work@gmail.com>
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
 libselinux/src/selinux_config.c   | 31 +++++++++++++++++++
 libselinux/src/selinux_internal.h | 10 +++++++
 3 files changed, 84 insertions(+), 7 deletions(-)

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
index b9dfec12..09b43fc5 100644
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
index e54d660f..66123472 100644
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

