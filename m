Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0B223707
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001014; cv=none; b=b5k1xO4edsCRKTREMPbMZKrwYA7lBeNeoDLRoLTYzaq4Xc2qFguVQqYlTvibThMEgrchWipmeAUOddSP2+DjH0OF/ANN6ytvTYkGzm//IP1QXaySJ8XNCpJQfgUTlGnzWIkW7L7cMzTOsBp+BhESZcD+fJmKQdTgL4N3nnKmhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001014; c=relaxed/simple;
	bh=wDeEfGnOGHU1LHvw86f/gX2CXFTW7TgkEtVW3PM8k/w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e7n3IoqXyu5JgzN/iR07YsoJhZidCkx5FPYaOpiYtSUT5PfyliepSFhIU6dXWUmqPqE+4cxirrqFqfK39jkychNqrNd0AMgfyLRUrmYirLiT9Ew6uZVhDnoUfSMZ2SDGaqGyNLOSzwmyKdiyqRHnDDhlEFMYOGLqHOTcChcHXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1JRloQG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1JRloQG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cccfa32670so55981505ad.2
        for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 20:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784001012; x=1784605812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nv6b7+avvrszo38f/ASpllmPRH9onyUZfNJpOPuZwLw=;
        b=B1JRloQGGQOf08IVQGNYDlL+eBZxUY6unpgRf7V4P1EDbulNgvaA8kmhQ3ESrYc6Jd
         kKpZGDJhWKf8dtxkoha1T0Sg4wpScT8z1P6PH330+z/o/lV+yaZHmzTNDsDUbyoJpLfd
         IyeKLs8Azx4N/x4WpvoqM1C/zeAZSZqWw0WIr4/4nTbHq6noxUBkJ5Z0hJKnyFExtlTA
         k94CVI6kY+FBN3V54TLFH84IW0l3tdw8mDvhlidN2Npn77i3tywAm1TRAA9oOz37v2EG
         ufTT79CtFYdPHaaf7LAS81yZ/31ApxPZXm6k/ivvJXzxmf2nINlY2Ooo2S1yzlrb2tRk
         OdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001012; x=1784605812;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nv6b7+avvrszo38f/ASpllmPRH9onyUZfNJpOPuZwLw=;
        b=C61tQPcDA1IX3Le/bzHghnbVRSrW8PzZB+ranlfntzbcdnmFd7BWkHELpJpYbuJWUz
         AVgMuzYGJAgtdNcv2AdbFrPBGoMGRbpzU6xvvO7zS3vPv4D/t7Mr+gNUFyIF2IKYoQmd
         2k5SEqkV2dbSuhgiHYUV0Wm7KfctSlEWWjaUS8hs/pIgdqjNPF/OduvQXVeUb/HeSi/k
         CwqkDcJwqd+iU29hxa4zt8GAPuNWXKdlZVtmK1CqXVlqTdY14zzWHPReUCAe5RrFF7Rj
         GRQXE7B3LUaga5R3sOeKOaW56N8xiOr7nhjp8vYARo/r6fH7a/2ZOdyllxxPQbXKg8Bi
         I/pA==
X-Gm-Message-State: AOJu0Yz11cEkLPZ+hw1IrbApKcpsZ9V6DsfJP4Mou43YtlvPsJv3IX9f
	EgcmfKGOK6Tiq8RMeDSbKxO6ZiXQZUuREYlUacjuWBQA0C6i9GbF8Hgm/zYdOO3ohiRv+/puS8i
	/6ZNYXjyYhnmqH+ykkG/tnpeLzvtBaGXB03gqXMLOpxqcMbmGIJVjpbLwuSW6/Xs8QbUCObKEsr
	XBVPMJDIAFPAyxp03muyuHjkHDRCXaAstU
X-Received: from dlg30.prod.google.com ([2002:a05:7022:79e:b0:138:62a:280c])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e0c:b0:38d:fad1:cf2a
 with SMTP id adf61e73a8af0-3c11062f6f4mr12560328637.13.1784001011145; Mon, 13
 Jul 2026 20:50:11 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:50:03 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714035003.1461542-1-tweek@google.com>
Subject: [PATCH] libselinux: use designated initializers for label initfuncs
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Previously, the initfuncs array relied on implicit positional ordering
to match backend context constants (e.g., SELABEL_CTX_FILE). If constants
were reordered or added, array indexing could become misaligned.

Use C99 designated initializers in initfuncs to explicitly bind each
initialization function to its corresponding context constant.

Additionally, define _SELABEL_CTX_NUM in include/selinux/label.h
to count total backends, and add a compile-time static_assert ensuring
initfuncs stays in sync with _SELABEL_CTX_NUM.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libselinux/include/selinux/label.h |  5 +++++
 libselinux/src/label.c             | 16 ++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinu=
x/label.h
index ce189a3a..0c20a4fc 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -37,6 +37,11 @@ struct selabel_handle;
 #define SELABEL_CTX_ANDROID_PROP 4
 /* Android service contexts */
 #define SELABEL_CTX_ANDROID_SERVICE 5
+/*
+ * Total number of context backends. When adding a new backend,
+ * please increase this value.
+ */
+#define _SELABEL_CTX_NUM	6
=20
 /*
  * Available options
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 2c510290..40fbd596 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -4,6 +4,7 @@
  * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
  */
=20
+#include <assert.h>
 #include <sys/types.h>
 #include <ctype.h>
 #include <errno.h>
@@ -46,14 +47,17 @@ typedef int (*selabel_initfunc)(struct selabel_handle *=
rec,
 				unsigned nopts);
=20
 static const selabel_initfunc initfuncs[] =3D {
-	&selabel_file_init,
-	CONFIG_MEDIA_BACKEND(selabel_media_init),
-	CONFIG_X_BACKEND(selabel_x_init),
-	CONFIG_DB_BACKEND(selabel_db_init),
-	CONFIG_ANDROID_BACKEND(selabel_property_init),
-	CONFIG_ANDROID_BACKEND(selabel_service_init),
+	[SELABEL_CTX_FILE] =3D &selabel_file_init,
+	[SELABEL_CTX_MEDIA] =3D CONFIG_MEDIA_BACKEND(selabel_media_init),
+	[SELABEL_CTX_X] =3D CONFIG_X_BACKEND(selabel_x_init),
+	[SELABEL_CTX_DB] =3D CONFIG_DB_BACKEND(selabel_db_init),
+	[SELABEL_CTX_ANDROID_PROP] =3D CONFIG_ANDROID_BACKEND(selabel_property_in=
it),
+	[SELABEL_CTX_ANDROID_SERVICE] =3D CONFIG_ANDROID_BACKEND(selabel_service_=
init),
 };
=20
+static_assert(ARRAY_SIZE(initfuncs) =3D=3D _SELABEL_CTX_NUM,
+		"initfuncs array size does not match _SELABEL_CTX_NUM");
+
 static inline struct selabel_digest *selabel_is_digest_set
 				    (const struct selinux_opt *opts,
 				    unsigned n)
--=20
2.55.0.795.g602f6c329a-goog

