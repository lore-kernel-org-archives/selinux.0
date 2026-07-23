Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D030FC03
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776274; cv=none; b=qMCYjG3ypX6elUykjD/i7lvvmzu4NKpy5VNiyJ7y3x/F7k8pZ2TFExcwyeRqt9ByvtrgPqJR3E+DK7GwLZgUiWlOqJXPdMDVd8ZvMR3cyrS8x45D1NEV8+b6Mzfod0dfagxPwRwix9dyVvI3W+uyQ30t4D2OFY75J0dtV7H3gQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776274; c=relaxed/simple;
	bh=BXbtJkc2yt2e79LKHXbXGL7aDit449JIdtYFOwbTLoM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VPzA2cMWTFIPYCHC+DiAoGlGbk+/KZyCRiff1ZreGg6U+4HfxgGFCppkVjrrO+hwJBywpAlD+z0r/NRVdRRr/4z9Zu7tWOdEllz4kPZGZL3LWRwZrSns1fsPixim2DgqorDAIB5TJhs2FoQJLGFMB1Oid+zpBzNAHKDGmxWIIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ep5ueC5F; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ep5ueC5F"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso455980a12.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 20:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784776269; x=1785381069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iQduU2aTtoy7sogUO6qWneQkxfDqLYCoJjx0qL/9o8o=;
        b=Ep5ueC5FDaSmw0P69egamDilgRsiyDjPVKdObSDj92AmV2uiawTSH8JShAuWwtsRDx
         gplMMj4U2Xb+/OPM9X49mdsIeXi78gjE6YMD90fxgyrIYPAAnKGSaKJdoxm0sAV/xiPZ
         xPafcIucRTFn1L1bs1v1zzatWGpWvE6K5PbfM6cdBRp2nBTWGDvqgHlAcKIdkEpAvbiJ
         KxbV2wZRXNylWbcwHbNDIFSd8uvqBIg8y28ZHzHcjXwYvHWbZpfRjwK58H5mTHn1lnf9
         69whW1sZ9mZK2rhyyUGEbEz2aVn9Il3rnuG7UMcJ7HlOAcCH6I0WPbOUGyEcCnQHSdlB
         b0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784776269; x=1785381069;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iQduU2aTtoy7sogUO6qWneQkxfDqLYCoJjx0qL/9o8o=;
        b=k+o1ism/WW690yRbQyWvU9dhXIffS/VPUXuNWFeIsZRSlt8uM7GLT1a10Krg9+LaLA
         C1Ah+31e66Zvh33yvvhUIzarc1lLXY2YYYLWPZEMHWLlCKY2mT6o9pIZBEwLCeIgF6QN
         Ht5UjyuyDkL1/1dXy0BC0vkKkPN3h7KYh1iiYlMc9SJh8mAyurznsR2h7a4eoXg/5o/D
         jzGpxpo9oXFbTl6NaB5ObyeiLMlR7jpzE/iJCXlBPRfrZvSO+ZwiLH22iMXRQrdNleF0
         QOPHdrka9BE2VdyPRElLGtcnbCxEDkX0p98Tu5aBoZD0ENnOZHZ/NypotFm/aym8DmhX
         33EQ==
X-Gm-Message-State: AOJu0YwQs20IF1XkAJdpLWUwceMpq2l96Omzi5jivN0IbomyLFLE+Yjr
	ih7ma95vWmqRuUvRm7liQlvbW+bNK3qE9BZFDjNe4A9GfLLgTqpMzpP6q7uDzFCgTB3NA+Vq04E
	BmIDkSj1t8CVLb2cvD8mt5RquI2mz3peJ9MaNL/2R9OkIhIoYLYIWK+kX1ZzRqRbQiBQxmEgQ95
	QKSlDW2PQo33HPEFx3FwzjFgByhutxQY+r
X-Received: from pgbo20.prod.google.com ([2002:a63:5a14:0:b0:cb2:563f:d136])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3383:b0:3bf:983d:e9b4
 with SMTP id adf61e73a8af0-3c44b05d00dmr1394290637.33.1784776268452; Wed, 22
 Jul 2026 20:11:08 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:11:01 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723031102.2718093-1-tweek@google.com>
Subject: [PATCH v2 1/2] libselinux: support multiple spec_files
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
Changes since v1:
- Use sizeof(*rec->spec_files) instead of sizeof(path) as suggested by
  Stephen.

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

