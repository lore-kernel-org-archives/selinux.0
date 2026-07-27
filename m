Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A8373BF2
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116379; cv=none; b=BBcJ01SXJOu/EMZyd5ziWJj9qzErL8s8EsSSu9G0fpdWaOppWDwhicR97coaf1YpUji/qcaiO+rRyfdyvAXWtse2O/97dhHcU4jQQCCjjXYiYPnxQVLVfMMzM6azK7jOgBSrP6+TCynP5SLUtxFT8bMHRoeRYGuP/G8G/3DC90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116379; c=relaxed/simple;
	bh=9/7g2GgKmJ+QeX9nkIjiNVHR6lEUUxlMtb6lrzjiLaY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ewtySe6XTPlxgLOkcKOoWFlidAUipcPgshk2PRrK3CHrzf2rMi6ki5dBuWSCklNMRwdWYqw/wazdG6awgHJNUMpxEsAOfnkEhXgyWsUilO3RW+B60MrQs0nKJPicTCw00PUTDMUDoremBy8p7SDywdTSQbhg7RBms6H/JIeBeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyze8U2B; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyze8U2B"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2caf4173b1cso44445335ad.3
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785116375; x=1785721175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cWgN2JqG901TJAgPOUk8MA3SwkWSv3qMpfw10a+wZeE=;
        b=uyze8U2B/rrJJhpC/OwyE47HGXK966Q8MHzObSZIqdhI6GIMiw6WRZo+3p9Wqlh3Iy
         QYp7qOV2/4BlAa808tTD6K8vIBEefUMb5xu90QKt84u1QDkJLRBM/6I06FUa7cHv0gb/
         /Ap8jdbiePEYhqPeL2Hi126Fm4WyVTQnvVD5ERjXZOge7YnhRFSAH5gaHsv57b8bKOA4
         9QtiI6z7obElZKLnID2feycNwvSM5cjQubtI5f3Q9aMtpVenucrH4WhOS0gY9zVM6Nh5
         z55X3xucgYEHMY6hFllD9+eRtykCWmiInJfMg8/tk55yxqbtc81/pq/oLh55mAjoWt8U
         +afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785116375; x=1785721175;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWgN2JqG901TJAgPOUk8MA3SwkWSv3qMpfw10a+wZeE=;
        b=k9UDuLFO+R6yIHp4MAyD1zWqGH5f6qHJSh6UxmAo4G2cJ6didOnA0+deM+MnUG0Khv
         xn97m8oyzCEFSjAurR2uc4esoIykvBGV23hvY1SDM1ZCZxOM+LEPz4yjTtqQ4bSOFuXE
         k7TL+73L7XS6GYi6TvC5gQd2r/RHbOXyOquOhOJ6eG5vhOJXmZn6rT/ycV0x7FGcVG1U
         /m8wFfjUoiNE8GFKjArocRjw0T+lHdwQH/mYRJAXPM5VsgiGnCQN0NQesis4a7JoqA7V
         snrbC94yT/fh/Zo/knPirtTu711oYqlmOb74afEw6Z/2BtOZQyvkhWqSGoEbFL/HqRp4
         j4MA==
X-Gm-Message-State: AOJu0YyMtW/0Y4+uWQ3N3NnmlQWk+AOakh6nRg47uxmrFIR0NZWS/tZu
	TgBTo7Cv2Pk7dvq0vKah8zIKrlCCCrXfkjYp3V4BySFR5iuCN/C0OU/VjXPEW+pjcjfx1RJK88y
	wiYyTz62RF3CP0F+Ue6wDH0c9Poi30h66WFe6qydZX3v/kE89ukx6kjfP7hJsy/KPs3yiiEYLML
	YKgIZ3VyPOJbB5EBRIkMx+kUl2QUPwctHk
X-Received: from pldp19.prod.google.com ([2002:a17:902:ead3:b0:2cf:75c1:ab87])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fb0:b0:2c9:ceb9:865b
 with SMTP id d9443c01a7336-2cfde7cafeamr63239345ad.21.1785116374974; Sun, 26
 Jul 2026 18:39:34 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:39:28 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260727013929.2457799-1-tweek@google.com>
Subject: [PATCH v3 1/2] libselinux: support multiple spec_files
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update the existing backends to potentially allocate multiple
spec_files. This commit simply adds a level of indirection but does not
change any current behaviour. It will facilitate the gradual migration
of backends to multiple context files.

In selabel_fini(), compat_validate() is updated to use the first
spec_file only, for legacy validation error reporting. selabel_open() is
already performing context validation if requested against individual
file paths (see insert_spec).

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
No changes since v2

 libselinux/src/label.c          | 10 ++++++++--
 libselinux/src/label_db.c       | 11 +++++++++--
 libselinux/src/label_file.c     |  8 ++++++--
 libselinux/src/label_internal.h |  5 +++--
 libselinux/src/label_media.c    |  8 +++++++-
 libselinux/src/label_x.c        |  8 +++++++-
 6 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 991b9769..4a97d3bc 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -162,7 +162,7 @@ static int selabel_fini(const struct selabel_handle *re=
c,
 	char *ctx_trans;
 	int rc;
=20
-	if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
+	if (compat_validate(rec, lr, rec->spec_files[0], lr->lineno))
 		return -1;
=20
 	if (!translating)
@@ -398,11 +398,17 @@ int selabel_digest(struct selabel_handle *rec, unsign=
ed char **digest,
=20
 void selabel_close(struct selabel_handle *rec)
 {
+	size_t i;
+
 	if (rec->digest)
 		selabel_digest_fini(rec->digest);
 	if (rec->func_close)
 		rec->func_close(rec);
-	free(rec->spec_file);
+	if (rec->spec_files) {
+		for (i =3D 0; i < rec->spec_files_len; i++)
+			free(rec->spec_files[i]);
+		free(rec->spec_files);
+	}
 	free(rec);
 }
=20
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index bafa9328..53731470 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -302,12 +302,19 @@ static catalog_t *db_init(const struct selinux_opt *o=
pts, unsigned nopts,
 		errno =3D EINVAL;
 		return NULL;
 	}
-	rec->spec_file =3D strdup(path);
-	if (!rec->spec_file) {
+	rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
+	if (!rec->spec_files) {
 		free(catalog);
 		fclose(filp);
 		return NULL;
 	}
+	rec->spec_files[0] =3D strdup(path);
+	if (!rec->spec_files[0]) {
+		free(catalog);
+		fclose(filp);
+		return NULL;
+	}
+	rec->spec_files_len =3D 1;
=20
 	/*
 	 * Parse for each lines
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0c0499eb..d91e1462 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1549,9 +1549,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
 		goto finish;
 	}
=20
-	rec->spec_file =3D strdup(path);
-	if (!rec->spec_file)
+	rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
+	if (!rec->spec_files)
 		goto finish;
+	rec->spec_files[0] =3D strdup(path);
+	if (!rec->spec_files[0])
+		goto finish;
+	rec->spec_files_len =3D 1;
=20
 	/*
 	 * The do detailed validation of the input and fill the spec array
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_interna=
l.h
index 4ff39d96..d54053df 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -96,10 +96,11 @@ struct selabel_handle {
 	void *data;
=20
 	/*
-	 * The main spec file used. Note for file contexts the local and/or
+	 * The spec files used. Note for file contexts the local and/or
 	 * homedirs could also have been used to resolve a context.
 	 */
-	char *spec_file;
+	size_t spec_files_len;
+	char **spec_files;
=20
 	/* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
 	struct selabel_digest *digest;
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 957fcfd3..f315abc3 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -109,7 +109,13 @@ static int init(struct selabel_handle *rec, const stru=
ct selinux_opt *opts,
 		errno =3D EINVAL;
 		goto finish;
 	}
-	rec->spec_file =3D strdup(path);
+	rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
+	if (!rec->spec_files)
+		goto finish;
+	rec->spec_files[0] =3D strdup(path);
+	if (!rec->spec_files[0])
+		goto finish;
+	rec->spec_files_len =3D 1;
=20
 	/*=20
 	 * Perform two passes over the specification file.
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 0c525bfc..b528a019 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -139,7 +139,13 @@ static int init(struct selabel_handle *rec, const stru=
ct selinux_opt *opts,
 		errno =3D EINVAL;
 		goto finish;
 	}
-	rec->spec_file =3D strdup(path);
+	rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
+	if (!rec->spec_files)
+		goto finish;
+	rec->spec_files[0] =3D strdup(path);
+	if (!rec->spec_files[0])
+		goto finish;
+	rec->spec_files_len =3D 1;
=20
 	/*=20
 	 * Perform two passes over the specification file.
--=20
2.55.0.229.g6434b31f56-goog

