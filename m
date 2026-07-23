Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5330FC03
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776277; cv=none; b=eONixrPbGUjP7qLlIT/GmXOTotkzKfog6+UI5lqZdJiFq2+XuS5gDlbHEMa0qD6iwQo8HY55CWjiQ7VgTnKWuly2A/qpPNylbbs/fwL0F1uqj2sXm0bPxDsIkEhZWsnorTHfSnQZdv/yYppPg6FsjtZaGdBBAAZuSRWn7+yq21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776277; c=relaxed/simple;
	bh=aig2VqJncEfAu4qjDTok71DehIYWA2zwIzlGmO4AG2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fey+iY8TZjZgGG4eHBPJyJ8U+9ngGuFIJc2hhsrG4CS1tbal13pj23oZgLgpRJBUEpUdYsS5Bc2I6qT3QK4w31NqRUW+g7LFF0XCE7numunh4Gyyi9+R9Wasb4pgUd0tYbfXZyPpCmldHBF+QnAN0r3/oJZFrOKvNXOyUEQIPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFn33Og2; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFn33Og2"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca124bf0189so139866a12.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784776275; x=1785381075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8pq9IYl64ebluSthhi6Bk+ngBUyTL1TYzmwLQ+6kqVQ=;
        b=NFn33Og2vmy/gx+BNV+2BOlTWKQhD4xFBsfUPXWyjEPPwfxLaBUsq2k8OVIOibs9SB
         TdHjmj9lsGc+2XfpB/R/NKgNL2s7AnFfkwKFV6FSFh/M+AfNJrh9yrOMbnGah9tF1eoU
         U2QtfNvXJssIz3G81t1JdWNAVDBn74jsJC8cKBvp5v9hWQSS5Z8H4KcQpQzg4wquoPJv
         3KVBgHglg20zrNxEghbAoBz4E11wsp1vehjxOqL8ff7fBzBIoC4GqXEeez59YqZRZDSM
         2CFGnKoJRvQ/vfG1qFsubrs6KxRcPe18rkbmCnLufw0e2JwdZ0xUjGBiazZRyXyPQT1t
         96Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784776275; x=1785381075;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8pq9IYl64ebluSthhi6Bk+ngBUyTL1TYzmwLQ+6kqVQ=;
        b=Jlb0vJ81CXjiE5pn2f7CDbE+u2pN5FngfbBCk3pFloh92OP/v+0Rl2sAJXQ+siP7rh
         VPGCtI/nh/H74dkGyJf7RsCA+/vHKlqJicsIRfjQ+4zdGY9zXtTbaPfYl3u3DzdG+gc7
         R7kjPABkkRcwXme+bpFtArSgn7wv3nsh3rmMVKPkZkxL6juAoB7Vhxe874yd4UKEtu/M
         ydw8YwE7YoMhu0rUOvo4dkVe906dc449LM6E2wxsSxoon7rBAiXyJMwbhFJT6Fe1ZpfZ
         ZjpNWMs+OKYHMvUP1jdys6bEXass+NhVWbi+t3b+XJQBjVdXVj+uyuS6MjNkZE4El9K7
         RpKg==
X-Gm-Message-State: AOJu0YyaZ9/z/SEivGEl9epSRP53ZfwPvrwIdmFN35d0BjkG+wxk3QhT
	ktmS+2/BSqA3a/n7yVkEGpgroXnVs8DLJOsnT/0g1h7kE6izi61EGTBF9Dtgj5hzCNz1TD8WScs
	wE8uwBMFDgYpY63Xn4wX42QlD8djYxum8QgzmFFEXZjgUJ2HtWFZXpVqW3dJCW6hMc+S/RN48lx
	O2TmAiq7GCf5ExZuOjR6rwLZ8jgUM5OKu3
X-Received: from pjuv10.prod.google.com ([2002:a17:90a:d58a:b0:384:e0b1:c3e])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4406:b0:37f:d265:18d2
 with SMTP id 98e67ed59e1d1-38ec83cd0bfmr718053a91.7.1784776274590; Wed, 22
 Jul 2026 20:11:14 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:11:02 +1000
In-Reply-To: <20260723031102.2718093-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723031102.2718093-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723031102.2718093-2-tweek@google.com>
Subject: [PATCH v2 2/2] libselinux: support multiple context files for the
 file backend
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, 
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

Duplicate checking is only performed within each context file. The current
behavior expects the ability for a later file to overwrite a previous
declaration (e.g., .local).

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
Changes since v1:
- Restore nodups_spec_node, ignore duplicates across files.
- Change num_paths type to uint8_t and check for overflow.
- Check for NULL before strdup any path.
- Use num_paths and num_paths+1 for homedirs and local.

 libselinux/src/label_file.c | 139 ++++++++++++++++++++++++------------
 1 file changed, 92 insertions(+), 47 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index d91e1462..02bd6f5d 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -106,7 +106,8 @@ void sort_spec_node(struct spec_node *node, struct spec=
_node *parent)
 /*
  * Warn about duplicate specifications.
  */
-static int nodups_spec_node(const struct spec_node *node, const char *path=
)
+static int nodups_spec_node(const struct selabel_handle *rec,
+			    const struct spec_node *node)
 {
 	int rc =3D 0;
=20
@@ -126,13 +127,16 @@ static int nodups_spec_node(const struct spec_node *n=
ode, const char *path)
 			    node1->file_kind !=3D node2->file_kind)
 				continue;
=20
+			if (node1->inputno !=3D node2->inputno)
+				continue;
+
 			rc =3D -1;
 			errno =3D EINVAL;
 			if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) !=3D 0) {
 				COMPAT_LOG(
 					SELINUX_ERROR,
 					"%s: Multiple different specifications for %s %s  (%s and %s).\n",
-					path,
+					rec->spec_files[node1->inputno],
 					file_kind_to_string(node1->file_kind),
 					node1->literal_match, node1->lr.ctx_raw,
 					node2->lr.ctx_raw);
@@ -140,7 +144,7 @@ static int nodups_spec_node(const struct spec_node *nod=
e, const char *path)
 				COMPAT_LOG(
 					SELINUX_ERROR,
 					"%s: Multiple same specifications for %s %s.\n",
-					path,
+					rec->spec_files[node1->inputno],
 					file_kind_to_string(node1->file_kind),
 					node1->literal_match);
 			}
@@ -168,6 +172,9 @@ static int nodups_spec_node(const struct spec_node *nod=
e, const char *path)
 				    node1->file_kind !=3D node2->file_kind)
 					continue;
=20
+				if (node1->inputno !=3D node2->inputno)
+					continue;
+
 				rc =3D -1;
 				errno =3D EINVAL;
 				if (strcmp(node1->lr.ctx_raw,
@@ -175,7 +182,7 @@ static int nodups_spec_node(const struct spec_node *nod=
e, const char *path)
 					COMPAT_LOG(
 						SELINUX_ERROR,
 						"%s: Multiple different specifications for %s %s  (%s and %s).\n",
-						path,
+						rec->spec_files[node1->inputno],
 						file_kind_to_string(
 							node1->file_kind),
 						node1->regex_str,
@@ -185,7 +192,7 @@ static int nodups_spec_node(const struct spec_node *nod=
e, const char *path)
 					COMPAT_LOG(
 						SELINUX_ERROR,
 						"%s: Multiple same specifications for %s %s.\n",
-						path,
+						rec->spec_files[node1->inputno],
 						file_kind_to_string(
 							node1->file_kind),
 						node1->regex_str);
@@ -197,7 +204,7 @@ static int nodups_spec_node(const struct spec_node *nod=
e, const char *path)
 	for (uint32_t i =3D 0; i < node->children_num; i++) {
 		int rc2;
=20
-		rc2 =3D nodups_spec_node(&node->children[i], path);
+		rc2 =3D nodups_spec_node(rec, &node->children[i]);
 		if (rc2)
 			rc =3D rc2;
 	}
@@ -1484,22 +1491,30 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
 		unsigned n)
 {
 	struct saved_data *data =3D rec->data;
-	const char *path =3D NULL;
+	uint8_t num_paths =3D 0, i;
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
+	for (i =3D 0; i < n; i++) {
+		switch (opts[i].type) {
 		case SELABEL_OPT_PATH:
-			path =3D opts[n].value;
+			if (opts[i].value) {
+				num_paths++;
+				if (num_paths =3D=3D UINT8_MAX) {
+					errno =3D EINVAL;
+					return -1;
+				}
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
@@ -1511,10 +1526,50 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
 		}
 	}
=20
+	/* If no paths were provided, we will use the default path or fail,
+	 * depending on the target. */
+	if (!path_provided) {
+#if !defined(BUILD_HOST) && !defined(ANDROID)
+		num_paths =3D 1;
+#else
+		selinux_log(SELINUX_ERROR,
+			    "No path given to file labeling backend\n");
+		errno =3D EINVAL;
+		return -1;
+#endif
+	}
+
+	/* If !baseonly, we reserve the last 2 indexes for homedirs and local.
+	 * Let's make sure we don't wrap */
+	if (!baseonly && num_paths > UINT8_MAX - 1) {
+		errno =3D EINVAL;
+		return -1;
+	}
+
+	/* Allocate the paths. */
+	paths =3D calloc(num_paths, sizeof(*paths));
+	if (paths =3D=3D NULL)
+		goto finish;
+
+	rec->spec_files =3D paths;
+	rec->spec_files_len =3D num_paths;
+
+	/* Copy all the paths given. */
+	if (path_provided) {
+		for (i =3D 0; i < n; i++) {
+			if (opts[i].type =3D=3D SELABEL_OPT_PATH && opts[i].value) {
+				*paths =3D strdup(opts[i].value);
+				if (*paths =3D=3D NULL)
+					goto finish;
+				paths++;
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
@@ -1526,66 +1581,56 @@ static int init(struct selabel_handle *rec, const s=
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
-	rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
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
+				      prefix, rec->digest, num_paths);
 		if (status && errno !=3D ENOENT)
 			goto finish;
=20
-		status =3D process_file(path, "local", rec, prefix, rec->digest,
-				      2);
+		status =3D process_file(rec->spec_files[0], "local", rec, prefix,
+				      rec->digest, num_paths + 1);
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

