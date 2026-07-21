Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09010F1
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599915; cv=none; b=Cnm76eu5J1tgq1/BOXxgD5+lYetgxOXQWcGgrfuxQHG3sMazfBInOAY0v8BffqDZVVb+McV9oxlT8ft/JyLBk/YC3F7VpoXzte3EiGEBWVVSPNCOLa9UVT+gcy7dsG+SgVult43Q4I0+rbkkDqtyF60t9MzqXK+uz0wuEuAp50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599915; c=relaxed/simple;
	bh=WxGhmFIHAwUV2RT2MM3EBcFHbJiVXIrlCpdhWfbQ0Tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TU085o/HeQ2Lzq9q1eCQndam3OTw7MfWfVZ2kGwsvJzOcNtxkriHNnWm2oKfxzLRUawtSZx/QsGujP/T/Ge4mK0NmuTD6h+qfhW6UdrHK7Cm5gA927Ffn9OsFWCJb5ZLyFCEAhsxZoaZOz3xvn4EzGajFiBtWd5wTbyBI7npJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkXEY2Ar; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkXEY2Ar"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacd6d37edso145981835ad.0
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 19:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784599913; x=1785204713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p+woLGICDA6D7e7XK/xnuvSZ08Ul7uyO4FdEkZHFPx8=;
        b=gkXEY2ArMe6CEpsXeMM6vkKJLkwVipOeMmvWcxFhjCr1qRvzwXISUl5IhCfDmmXg12
         gGEEu4rNNOWAC+vhHbJ6RBFaL0CavLe20vTaV0EVD6wN1tVXHk3P1vvPgGTUBePOzKsS
         37uXX0eqLsO2ykEscQLssfIpKk9CJnZyH4cXsybq3epJKE85GCzFV4tuyb5QB5KhxnJ0
         lKbwF8A+qHgGojsQZbrSjRPMgxaxcOgBLczY0eqybzgZRzapH1KqUkY7tGUdBaAml733
         vJuiffUPDCHDaqzCGJMF9rEH8/zFw896KgQvwUSdXLo5sXCX9sO9b8NQf/eBC5DpL7k/
         Hwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599913; x=1785204713;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+woLGICDA6D7e7XK/xnuvSZ08Ul7uyO4FdEkZHFPx8=;
        b=WjaaECrIQkkqeqCr6EprOAd5MmkuAvnzFvv2A47a3ZW+gvvWIlHML0oz4ktppEOcTy
         bRSdNcsKlceFfAI2/ynHZlfzuvCgw+pwRM/D1t+KFt5v6IkpPeq2nSff9z9wo+uY5NHk
         4AocYI62C3yU00aYEVQXhmLyrxlLPIbz8FoiNIbNiIuxSjQiVYHZX5PR7KYyudfZxCiL
         uG93ukkp9MPrPuGJRuyaPMJiStTspm18RhYly6gmlaIF28yrKHx5DGUypWGQbVsMoFow
         ab84biLyqqchPE+Cp/WApOomrgbViq27qym5wist0YscVsyMTrBfu8V/Pjsu8xoeSRBa
         nvfg==
X-Gm-Message-State: AOJu0YzC14GFWTv1Og9+PjOpdBatUad7exsEZP7x1+/Sm0+Ly/MG3O87
	lLHKgZR5xO6sgF3FX/vQaUU/u5X3+LgcfwVcwcRIu5nCq3N052jYq7pr6OxGnswPHflzhA7HvFt
	zfxlVyyyVQZPVtTv32DkSO2TOfGIH0TuMektKy7W7OSYkQr88zz+E3FI/gaCcGg0/Cu8vB726vl
	SV7/tNKRJ7jdf+A9L1c+tWvB2moakI7eOM
X-Received: from plcq19.prod.google.com ([2002:a17:902:e313:b0:2ce:6df9:bda5])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aaf:b0:2ca:c4a5:84bb
 with SMTP id d9443c01a7336-2cf349c97b5mr181381155ad.38.1784599912495; Mon, 20
 Jul 2026 19:11:52 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:11:27 +1000
In-Reply-To: <20260721021127.1313453-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721021127.1313453-2-tweek@google.com>
Subject: [PATCH 2/2] libselinux: support multiple contexts for the file backend
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update the file labeling backend to support specifying multiple
SELABEL_OPT_PATH options in selabel_open().

All provided paths are stored in rec->spec_files and processed during
initialization. Derived files, such as substitutions (.subs, .subs_dist)
and auxiliary contexts (.homedirs, .local), continue to be based on the
first path (or default selinux_file_context_path()) when enabled.

Duplicate checking logic is refactored into a helper function
report_dups(). A duplicate with the same specification result is not
fatal anymore, but a warning is still logged.

Additionally, duplicate validation is moved after all files (including
.homedirs and .local) are loaded and sorted. For single file context setups=
,
the only difference in behavior is that duplicate validation now extends to
fc.homedirs and fc.local.

A similar multiple files setup has been used in Android for 9+ years.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libselinux/src/label_file.c | 216 ++++++++++++++++++++++--------------
 1 file changed, 132 insertions(+), 84 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index eb2e66da..902c9a25 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -104,9 +104,59 @@ void sort_spec_node(struct spec_node *node, struct spe=
c_node *parent)
 }
=20
 /*
- * Warn about duplicate specifications.
+ * Report a duplicate in the log.
+ *
+ * If the duplicate is considered fatal (i.e., if the specifications of bo=
th
+ * entries do not match), return -1 and set errno to EINVAL.
+ */
+static int report_dups(struct selabel_handle *rec, uint8_t inputno1,
+		       uint8_t inputno2, const char *ctx_raw1,
+		       const char *ctx_raw2, const char *match,
+		       const char *file_kind)
+{
+	if (inputno1 >=3D rec->spec_files_len)
+		inputno1 =3D 0;
+	if (inputno2 >=3D rec->spec_files_len)
+		inputno2 =3D 0;
+
+	const char *path1 =3D rec->spec_files[inputno1];
+	const char *path2 =3D rec->spec_files[inputno2];
+
+	if (strcmp(ctx_raw1, ctx_raw2) !=3D 0) {
+		if (inputno1 =3D=3D inputno2)
+			COMPAT_LOG(
+				SELINUX_ERROR,
+				"Multiple different specifications for %s %s in %s (%s and %s).\n",
+				file_kind, match, path1, ctx_raw1, ctx_raw2);
+		else
+			COMPAT_LOG(
+				SELINUX_ERROR,
+				"Multiple different specifications for %s %s in %s and %s (%s and %s).=
\n",
+				file_kind, match, path1, path2, ctx_raw1,
+				ctx_raw2);
+		errno =3D EINVAL;
+		return -1;
+
+	} else {
+		if (inputno1 =3D=3D inputno2)
+			COMPAT_LOG(
+				SELINUX_WARNING,
+				"Multiple same specifications for %s %s in %s.\n",
+				file_kind, match, path1);
+		else
+			COMPAT_LOG(
+				SELINUX_WARNING,
+				"Multiple same specifications for %s %s in %s and %s.\n",
+				file_kind, match, path1, path2);
+	}
+	return 0;
+}
+
+/*
+ * Find duplicate specifications.
  */
-static int nodups_spec_node(const struct spec_node *node, const char *path=
)
+static int nodups_spec_node(struct selabel_handle *rec,
+			    const struct spec_node *node)
 {
 	int rc =3D 0;
=20
@@ -126,24 +176,10 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
 			    node1->file_kind !=3D node2->file_kind)
 				continue;
=20
-			rc =3D -1;
-			errno =3D EINVAL;
-			if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) !=3D 0) {
-				COMPAT_LOG(
-					SELINUX_ERROR,
-					"%s: Multiple different specifications for %s %s  (%s and %s).\n",
-					path,
-					file_kind_to_string(node1->file_kind),
-					node1->literal_match, node1->lr.ctx_raw,
-					node2->lr.ctx_raw);
-			} else {
-				COMPAT_LOG(
-					SELINUX_ERROR,
-					"%s: Multiple same specifications for %s %s.\n",
-					path,
-					file_kind_to_string(node1->file_kind),
-					node1->literal_match);
-			}
+			rc =3D report_dups(rec, node1->inputno, node2->inputno,
+					 node1->lr.ctx_raw, node2->lr.ctx_raw,
+					 node1->literal_match,
+					 file_kind_to_string(node1->file_kind));
 		}
 	}
=20
@@ -168,28 +204,11 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
 				    node1->file_kind !=3D node2->file_kind)
 					continue;
=20
-				rc =3D -1;
-				errno =3D EINVAL;
-				if (strcmp(node1->lr.ctx_raw,
-					   node2->lr.ctx_raw) !=3D 0) {
-					COMPAT_LOG(
-						SELINUX_ERROR,
-						"%s: Multiple different specifications for %s %s  (%s and %s).\n",
-						path,
-						file_kind_to_string(
-							node1->file_kind),
-						node1->regex_str,
-						node1->lr.ctx_raw,
-						node2->lr.ctx_raw);
-				} else {
-					COMPAT_LOG(
-						SELINUX_ERROR,
-						"%s: Multiple same specifications for %s %s.\n",
-						path,
-						file_kind_to_string(
-							node1->file_kind),
-						node1->regex_str);
-				}
+				rc =3D report_dups(
+					rec, node1->inputno, node2->inputno,
+					node1->lr.ctx_raw, node2->lr.ctx_raw,
+					node1->regex_str,
+					file_kind_to_string(node1->file_kind));
 			}
 		}
 	}
@@ -197,7 +216,7 @@ static int nodups_spec_node(const struct spec_node *nod=
e, const char *path)
 	for (uint32_t i =3D 0; i < node->children_num; i++) {
 		int rc2;
=20
-		rc2 =3D nodups_spec_node(&node->children[i], path);
+		rc2 =3D nodups_spec_node(rec, &node->children[i]);
 		if (rc2)
 			rc =3D rc2;
 	}
@@ -1484,22 +1503,27 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
 		unsigned n)
 {
 	struct saved_data *data =3D rec->data;
-	const char *path =3D NULL;
+	size_t num_paths =3D 0, i;
+	char **paths =3D NULL;
 	const char *prefix =3D NULL;
-	int status =3D -1, baseonly =3D 0;
+	int status =3D -1;
+	bool baseonly =3D false, path_provided =3D false;
=20
 	/* Process arguments */
-	while (n) {
-		n--;
-		switch (opts[n].type) {
+	i =3D n;
+	while (i--) {
+		switch (opts[i].type) {
 		case SELABEL_OPT_PATH:
-			path =3D opts[n].value;
+			if (opts[i].value) {
+				num_paths++;
+				path_provided =3D true;
+			}
 			break;
 		case SELABEL_OPT_SUBSET:
-			prefix =3D opts[n].value;
+			prefix =3D opts[i].value;
 			break;
 		case SELABEL_OPT_BASEONLY:
-			baseonly =3D !!opts[n].value;
+			baseonly =3D !!opts[i].value;
 			break;
 		case SELABEL_OPT_UNUSED:
 		case SELABEL_OPT_VALIDATE:
@@ -1511,10 +1535,44 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
 		}
 	}
=20
+	/* If no paths were provided, we will use the default path or fail, depen=
ding on the target. */
+	if (!path_provided) {
+#if !defined(BUILD_HOST) && !defined(ANDROID)
+		num_paths =3D 1;
+#else
+		selinux_log(SELINUX_ERROR,
+			    "No path given to file labeling backend\n");
+		goto finish;
+#endif
+	}
+
+	/* Allocate the paths */
+	paths =3D calloc(num_paths, sizeof(*paths));
+	if (paths =3D=3D NULL) {
+		goto finish;
+	}
+	rec->spec_files =3D paths;
+	rec->spec_files_len =3D num_paths;
+
+	if (path_provided) {
+		for (i =3D 0; i < n; i++) {
+			switch (opts[i].type) {
+			case SELABEL_OPT_PATH:
+				*paths =3D strdup(opts[i].value);
+				if (*paths =3D=3D NULL)
+					goto finish;
+				paths++;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
 #if !defined(BUILD_HOST) && !defined(ANDROID)
 	char subs_file[PATH_MAX + 1];
 	/* Process local and distribution substitution files */
-	if (!path) {
+	if (!path_provided) {
 		status =3D selabel_subs_init(
 			selinux_file_context_subs_dist_path(), rec->digest,
 			&data->dist_subs, &data->dist_subs_num,
@@ -1526,66 +1584,56 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
 					   &data->subs_num, &data->subs_alloc);
 		if (status)
 			goto finish;
-		path =3D selinux_file_context_path();
+		rec->spec_files[0] =3D strdup(selinux_file_context_path());
+		if (rec->spec_files[0] =3D=3D NULL)
+			goto finish;
 	} else {
-		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
+		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist",
+			 rec->spec_files[0]);
 		status =3D selabel_subs_init(subs_file, rec->digest,
 					   &data->dist_subs,
 					   &data->dist_subs_num,
 					   &data->dist_subs_alloc);
 		if (status)
 			goto finish;
-		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
+		snprintf(subs_file, sizeof(subs_file), "%s.subs",
+			 rec->spec_files[0]);
 		status =3D selabel_subs_init(subs_file, rec->digest, &data->subs,
 					   &data->subs_num, &data->subs_alloc);
 		if (status)
 			goto finish;
 	}
-
 #endif
=20
-	if (!path) {
-		errno =3D EINVAL;
-		goto finish;
-	}
-
-	rec->spec_files =3D calloc(1, sizeof(path));
-	if (!rec->spec_files)
-		goto finish;
-	rec->spec_files[0] =3D strdup(path);
-	if (!rec->spec_files[0])
-		goto finish;
-	rec->spec_files_len =3D 1;
-
 	/*
-	 * The do detailed validation of the input and fill the spec array
+	 * Process each input file.
 	 */
-	status =3D process_file(path, NULL, rec, prefix, rec->digest, 0);
-	if (status)
-		goto finish;
-
-	if (rec->validating) {
-		sort_specs(data);
-
-		status =3D nodups_spec_node(data->root, path);
+	for (i =3D 0; i < num_paths; i++) {
+		status =3D process_file(rec->spec_files[i], NULL, rec, prefix,
+				      rec->digest, i);
 		if (status)
 			goto finish;
 	}
=20
 	if (!baseonly) {
-		status =3D process_file(path, "homedirs", rec, prefix,
-				      rec->digest, 1);
+		status =3D process_file(rec->spec_files[0], "homedirs", rec,
+				      prefix, rec->digest, num_paths + 1);
 		if (status && errno !=3D ENOENT)
 			goto finish;
=20
-		status =3D process_file(path, "local", rec, prefix, rec->digest,
-				      2);
+		status =3D process_file(rec->spec_files[0], "local", rec, prefix,
+				      rec->digest, num_paths + 2);
 		if (status && errno !=3D ENOENT)
 			goto finish;
 	}
=20
-	if (!rec->validating || !baseonly)
-		sort_specs(data);
+	sort_specs(data);
+
+	if (rec->validating) {
+		status =3D nodups_spec_node(rec, data->root);
+		if (status)
+			goto finish;
+	}
=20
 	digest_gen_hash(rec->digest);
=20
--=20
2.55.0.229.g6434b31f56-goog

