Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124010F1
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599909; cv=none; b=sdgArSGCITqloGOSp9FVStMoLbM+ZHVeThOrWRg4bgZY+oMErM+6P+YFGZo0W5zV+JtUrwm1WC9WtfCyshTQS+TAFGW5G0Kdio7CXBBfO4tNuhPZok8XNnmH9InxY7QznokVWoqoxpTOALarng8WKmt8737IVuckSfa+DWWJVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599909; c=relaxed/simple;
	bh=CaWe4iuriv3+pU6n9cnkArsTaquxm8mAC+8QZEZUUM4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ciIpKbcqeZH6th8WDeIlzBsAHomehgYrRlyYBUaN48pqY64Cj+7wEWIe1HKr49lOslF4QIhMANtWurpPoMUS8Xu1MfKT8QM30OWOMXPoiLRir3BUC5LxUatVwE7a+WALaRE48jVADp6ox8Pi/grUtJXzfIPLSlQvV5EU7G1zGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlnhaYpf; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlnhaYpf"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso7939807a91.2
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784599906; x=1785204706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yf2r7RbieGJv9UTOKmipPScNngck1ABYrHmm6ujmWn4=;
        b=PlnhaYpfnKVN/4PrAUVQLJv7+5jYotNOD3835AtstlC0h+a2dm23c8sGms6H38at3V
         ISiosUMV7dnKM8WJcDyQ9iGWsu9o6tclIADQYe4OgoCqez5pISVHoUtjeSDTMaZHW7Cg
         TfbkBoLeOIxz+KreQzbu5HL6q5/7e+BB/J1w1LUIZFOWBaL4uVIk3vBJ2d95ebvh2Jz2
         dpLHh883UPcGw0Oh00ZjSFFXScMpkmd7f0wTT8sBLWra5u1EUv99KmhT2SM27w2xUlIO
         +ky9Gsk/SqinMo1ApsqWy6tezX2uQGISwebZtXfGR28PQCyHKOAnCPxk1S0ozQk7vx3X
         zjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599906; x=1785204706;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yf2r7RbieGJv9UTOKmipPScNngck1ABYrHmm6ujmWn4=;
        b=ktujf2PZEv3I9oAq9R+7MGsRUhMESP+0eYSqM5w9G+JnlDjawWZTDwV6XbyXkBcIu+
         +zg3Nqg7DoiqWhIYs/QRHUGDHfk+qUnujgwI3RJHnTDkZdG2Hi8wbUKzd32ZbA09o4w9
         J/Hc3uPU191irnmti45WhZoSmX/2CiXpTF6EC/O4eY++Y+WYL3gwUhuT9VgAj+CRykG5
         h72MN3VKRg/BcWxFNAdciP7bqLnjhqArz3qeg3uvIn+T9V3BJo7vDVrIlluws5sSgnH6
         +W5/t3LHusu0QoqU9aWHYq8j6UEz57pSFCFZrfEtMfvop7qqVBPI/NXA6tbzTif4MK89
         QNjw==
X-Gm-Message-State: AOJu0YxkbHHOAhAlAJxzVGzUTPpX4w8oycfaErhoBzPb9JItq1rgWVAf
	CcuMLORB4qAv1ie1CIMJlZuKFzjo+FQAaQw1YtXdiaGW8haHzms5eSofqLLw2M9QmKyuNnKtiK9
	mUSZ7gWt8vGL/+lCcX6kD42+5jmDZGowzaPOMHieSMUdkWMzplGlh+5pyuiQ9Q19fWWlH6BZDui
	HREeMs8HzLKbe0C/pmtYrSjMswiQjmo2WC
X-Received: from dlzz33.prod.google.com ([2002:a05:7022:4a1:b0:137:f9fd:ecf0])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:586f:b0:38e:6b76:f0a4
 with SMTP id 98e67ed59e1d1-38e6b76f1bcmr10395199a91.2.1784599906100; Mon, 20
 Jul 2026 19:11:46 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:11:26 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721021127.1313453-1-tweek@google.com>
Subject: [PATCH 1/2] libselinux: support multiple spec_files
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
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
index bafa9328..59a291e8 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -302,12 +302,19 @@ static catalog_t *db_init(const struct selinux_opt *o=
pts, unsigned nopts,
 		errno =3D EINVAL;
 		return NULL;
 	}
-	rec->spec_file =3D strdup(path);
-	if (!rec->spec_file) {
+	rec->spec_files =3D calloc(1, sizeof(path));
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
index 0c0499eb..eb2e66da 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1549,9 +1549,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
 		goto finish;
 	}
=20
-	rec->spec_file =3D strdup(path);
-	if (!rec->spec_file)
+	rec->spec_files =3D calloc(1, sizeof(path));
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
index 957fcfd3..35f3cc16 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -109,7 +109,13 @@ static int init(struct selabel_handle *rec, const stru=
ct selinux_opt *opts,
 		errno =3D EINVAL;
 		goto finish;
 	}
-	rec->spec_file =3D strdup(path);
+	rec->spec_files =3D calloc(1, sizeof(path));
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
index 0c525bfc..33a64a6a 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -139,7 +139,13 @@ static int init(struct selabel_handle *rec, const stru=
ct selinux_opt *opts,
 		errno =3D EINVAL;
 		goto finish;
 	}
-	rec->spec_file =3D strdup(path);
+	rec->spec_files =3D calloc(1, sizeof(path));
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

