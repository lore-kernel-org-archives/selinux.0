Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2437CD41
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116383; cv=none; b=NHupNiRVu1Yyx29h8zzOTXF2NXmMGcaOw0BuJxjdtm4ZO+5sxLkSLCZ3LxvyVQC40QesFmn0OyrUieliI6G3/I91JDzWMQDWipk2MX1lJIIRaOWHB9o1wYV69Q3niOjthmlKcvXPCOVdIVhGeduUkK3Ht8fPhjrygecYcXsNpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116383; c=relaxed/simple;
	bh=Pqx4h16w/U9C3/IcaovTaCPdq1xKEm+DqMSYeUyldp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=plm+/Rty1GMJv2a8fyk4cuosnsXbzaROkKZeq+8TMDvfS39QAkQDaO92J28Nh3Ie+mFwayaHkM1CPerJMAl/swKiwNK9gODeGqzItpcvTHr0Ha6Tzm7LwXzKkpK+LndHiSG7k/xqQZ8dvGjSHOObCwXgwHal/MIDVA/xQIg8qzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hFbH90Ll; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFbH90Ll"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848544a8496so2250271b3a.0
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 18:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785116379; x=1785721179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QubNY5w2dH+9tOIM8dQwsr/LooMhtKShCavbE49TTyQ=;
        b=hFbH90LlpVFYCuudLkLd85F7PrRHdZ2xM3vbJOC1OWbvZUh73RHr4DAo/63sETWm4L
         Jg6CnkU0Jcl2XtsI4Tzp8Fhb6uK2EV6rQ4oxi4+fJ012zOS24UPDbrCBdqoTRSBqxOxA
         q3paxVF+ugn5vMlREcPotM2H4dWLoZ7yJzMTD0PM/y1s/kxm4EPNyJuIXcxgduaRogZx
         1Q1549g61Jqbc/KW1qNQzj4AUTYdPF7Vvw8GV+al2uUdcvIJNE21CR4ac/ORGY76frq4
         EkQXcfifyCESr7sMt/669PfLmTpoRXndDvbzyAF8it8fTtgPoVdPKhRtLnksIJgHE4d4
         NeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785116379; x=1785721179;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QubNY5w2dH+9tOIM8dQwsr/LooMhtKShCavbE49TTyQ=;
        b=T78KOrcz8+ejGa9fji/SY2IwE3AKFBp0T9C2jy+nzbEB30+5Igf9rbulgpvz7GpuOY
         XL3385/5w+3rvFQiF8acfPVKLQ04fNu2T1sYagPTx+FG0AKVps06+EUtVG48nsdrw6Pj
         BKlOCim1Lcfke0UV552xyawpt7rUj0WI4tTNaSFYCbDiIS1ax8/tsgMI2fe8nCuR481J
         9g4qYqYAx9q1xNnmuXq71Yu0JI9qnyFu9FjYclDIbR+x7b5PdFsKPmT32egu++FfU+QF
         c4/M+h7oLJrGn2UfenLi8RXHcCK4BRdcfG6YPbDgh/dCIIjCMiygIiO5avmfl4I68Mq2
         4y+Q==
X-Gm-Message-State: AOJu0YzMfpfo9IAJ3/VvZw63nc6rKM2xig6ACEguvowKMgNdck5k22Qj
	a11BUsYg7eFYgL4H/nAcP9GJPXEUPdAGnSkFd0GPSyBtv3wFJeLSyjaf02msJB2AjU5MHCo1mNf
	ILBlQvRj2aywZX+/JLH3NlI/qg0v+nsSmwtfnJ0/dGeYDjqYW4HCB6xllLRUzTxbEC0hbQin5cu
	hHOJvvCmgPBoySP2//tSmmWDEmzRZDTTrI
X-Received: from pfld3.prod.google.com ([2002:a05:6a00:1983:b0:84e:4f2:22c])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:228b:b0:84c:1cd2:142e
 with SMTP id d2e1a72fcca58-84e59466c99mr5236057b3a.23.1785116378329; Sun, 26
 Jul 2026 18:39:38 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:39:29 +1000
In-Reply-To: <20260727013929.2457799-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727013929.2457799-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260727013929.2457799-2-tweek@google.com>
Subject: [PATCH v3 2/2] libselinux: support multiple context files for the
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
Changes since v2:
- Add optional paths (homedirs, local) to spec_files. Since these might
  be referenced, let's keep track of them as any other spec files.
  spec_files now contains the required files followed by the optional
  files.
- Strictly validate that, at most, 255 options are provided to init().
- Remove the intermediate `path` variable.
- Note: the 2rd argument of process_file is now always NULL. This can be
  cleaned in a follow up commit.

Changes since v1:
- Restore nodups_spec_node, ignore duplicates across files.
- Change num_paths type to uint8_t and check for overflow.
- Check for NULL before strdup any path.
- Use num_paths and num_paths+1 for homedirs and local.

 libselinux/src/label_file.c     | 154 ++++++++++++++++++++++----------
 libselinux/src/label_internal.h |   3 +-
 2 files changed, 107 insertions(+), 50 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index d91e1462..c955216b 100644
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
@@ -1480,26 +1487,37 @@ static char *selabel_sub_key(const struct saved_dat=
a *data, const char *key,
=20
 static void closef(struct selabel_handle *rec);
=20
+static const char *const opt_suffixes[] =3D { "homedirs", "local" };
+
 static int init(struct selabel_handle *rec, const struct selinux_opt *opts=
,
 		unsigned n)
 {
 	struct saved_data *data =3D rec->data;
-	const char *path =3D NULL;
+	uint8_t num_required_paths =3D 0, num_optional_paths =3D 0, i, j;
+	size_t total_paths;
 	const char *prefix =3D NULL;
-	int status =3D -1, baseonly =3D 0;
+	int status =3D -1;
+	bool baseonly =3D false, path_provided =3D false;
+
+	if (n > UINT8_MAX) {
+		errno =3D EINVAL;
+		return -1;
+	}
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
+				num_required_paths++;
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
@@ -1511,10 +1529,56 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
 		}
 	}
=20
+	/* If no paths were provided, we will use the default path or fail,
+	 * depending on the target. */
+	if (!path_provided) {
+#if !defined(BUILD_HOST) && !defined(ANDROID)
+		num_required_paths =3D 1;
+#else
+		selinux_log(SELINUX_ERROR,
+			    "No path given to file labeling backend\n");
+		errno =3D EINVAL;
+		return -1;
+#endif
+	}
+
+	if (!baseonly)
+		num_optional_paths =3D ARRAY_SIZE(opt_suffixes);
+
+	total_paths =3D num_required_paths + num_optional_paths;
+
+	/* Make sure total input files do not exceed the 256 indices supported
+	 * by uint8_t inputno */
+	if (total_paths > UINT8_MAX + 1) {
+		errno =3D EINVAL;
+		return -1;
+	}
+
+	/* Allocate the paths. */
+	rec->spec_files =3D calloc(total_paths, sizeof(*rec->spec_files));
+	if (rec->spec_files =3D=3D NULL)
+		goto finish;
+	rec->spec_files_len =3D total_paths;
+
+	/* Copy all the paths given. */
+	if (path_provided) {
+		for (i =3D 0, j =3D 0; i < n; i++) {
+			if (opts[i].type =3D=3D SELABEL_OPT_PATH && opts[i].value) {
+				rec->spec_files[j] =3D strdup(opts[i].value);
+				if (rec->spec_files[j] =3D=3D NULL)
+					goto finish;
+				j++;
+			}
+		}
+	}
+
 #if !defined(BUILD_HOST) && !defined(ANDROID)
 	char subs_file[PATH_MAX + 1];
 	/* Process local and distribution substitution files */
-	if (!path) {
+	if (!path_provided) {
+		rec->spec_files[0] =3D strdup(selinux_file_context_path());
+		if (rec->spec_files[0] =3D=3D NULL)
+			goto finish;
 		status =3D selabel_subs_init(
 			selinux_file_context_subs_dist_path(), rec->digest,
 			&data->dist_subs, &data->dist_subs_num,
@@ -1526,67 +1590,61 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
 					   &data->subs_num, &data->subs_alloc);
 		if (status)
 			goto finish;
-		path =3D selinux_file_context_path();
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
+	for (i =3D 0; i < num_optional_paths; i++) {
+		if (asprintf(&rec->spec_files[num_required_paths + i], "%s.%s",
+			     rec->spec_files[0], opt_suffixes[i]) < 0) {
+			rec->spec_files[num_required_paths + i] =3D NULL;
+			goto finish;
+		}
 	}
=20
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
+	 * Process each main input file.
 	 */
-	status =3D process_file(path, NULL, rec, prefix, rec->digest, 0);
-	if (status)
-		goto finish;
-
-	if (rec->validating) {
-		sort_specs(data);
-
-		status =3D nodups_spec_node(data->root, path);
+	for (i =3D 0; i < num_required_paths; i++) {
+		status =3D process_file(rec->spec_files[i], NULL, rec, prefix,
+				      rec->digest, i);
 		if (status)
 			goto finish;
 	}
=20
-	if (!baseonly) {
-		status =3D process_file(path, "homedirs", rec, prefix,
-				      rec->digest, 1);
+	/*
+	 * Process each optional input file.
+	 */
+	for (i =3D 0; i < num_optional_paths; i++) {
+		status =3D process_file(rec->spec_files[num_required_paths + i],
+				      NULL, rec, prefix, rec->digest,
+				      num_required_paths + i);
 		if (status && errno !=3D ENOENT)
 			goto finish;
+	}
=20
-		status =3D process_file(path, "local", rec, prefix, rec->digest,
-				      2);
-		if (status && errno !=3D ENOENT)
+	sort_specs(data);
+
+	if (rec->validating) {
+		status =3D nodups_spec_node(rec, data->root);
+		if (status)
 			goto finish;
 	}
=20
-	if (!rec->validating || !baseonly)
-		sort_specs(data);
-
 	digest_gen_hash(rec->digest);
=20
 	status =3D 0;
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_interna=
l.h
index d54053df..4279637e 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -96,8 +96,7 @@ struct selabel_handle {
 	void *data;
=20
 	/*
-	 * The spec files used. Note for file contexts the local and/or
-	 * homedirs could also have been used to resolve a context.
+	 * The specification files used.
 	 */
 	size_t spec_files_len;
 	char **spec_files;
--=20
2.55.0.229.g6434b31f56-goog

