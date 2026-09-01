Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA4481257
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280535; cv=none; b=BPdm7HOqlaRQw7+eya/HpJjW2Xh5Vzgo7A5bSimRtV6XQwxthWIr2tWAEcT7Hjq0fTX9LwJLBSpePSc9sbVrZHn1Roka/5xfMBy8C5ounAZAAheO89QeC4j/6Xp2qBfzmNKcJ/+9MxRHogN5iMT88jEALPMGJ/w7J5r19uMtD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280535; c=relaxed/simple;
	bh=ruo+objDGMJAJ2S4cbL1hm+bbGiHYC4biwTzS4Z07yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESeIGNGMEP2SegDvZBaezWHHYLIPpJcXB6xeCvO5joySQ0/IHE4/WccFqZ2mpSGyFqwoKPSDCvttX5m2SG0++X15uQj9zvNkkj5eRPSJA63AvZ11V5jeJH1KRLNLU+T+pfq6BlOIG7xSY0NLMPyXDAI4IY+YiuEoggnCDbfygCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHcknjZY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHcknjZY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90e970f710cso449556d6.3
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280532; x=1788885332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hge6+qZUvaCoRlu9kAJMLD6sjbfMzhCXOHq7DYYnyeo=;
        b=rHcknjZY0A95nxP8t6vu3KwGt5IHokSbjXoAUrPyACUOG21AsMyfk+dE9i9yMKuUh1
         09sDsC5221WZqMJR5JOLgUVZP/s4CB1ivOYsMfTTAdxEc1taR501zA/ffEsIQMHCIxaP
         EvEqOtfGo666sviW/XoZUIpR6t20xErLBV7f99BaD+YFfvAojzSJw9w67kTnITorKI4i
         7v0WjB5tvRAIFZqyZNhDUaQo3DFTQSWoBVyKVwPZa3WRnKgSRlkAxTqyBpUf1VvKy7x3
         7OVip322V/RXpo4oclOw6njwiDGiMkrFMoZQHw2irHho0fAw9jkHSZykJeYVmMq995RP
         b/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280532; x=1788885332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hge6+qZUvaCoRlu9kAJMLD6sjbfMzhCXOHq7DYYnyeo=;
        b=Ch+5xYftcE/WExhl837rAbQEkKbdQpMqLED5xULytq+Qlw+zxFniRRYdyL96VXD4BY
         G0nHM/YbuyziFZ8KDj2ES3ysvudHpMtmuhrjDV6U6Pe1H+LDL4qvtIWLGDvK5dLb0dmw
         1jMIv7xgNsFJHX4zAxXxeOw/YYl1WWSzsQuAtE6lQVgHFdYcmkYJy70wvwvfwySByM9y
         aiINv8MC09IWMdYx94x2cXN1hbZM4oHa7FOQKQtOnZvE/xwtESFOPKamZYxwAgZzNiA4
         VSh6YkftGFnUoXeKDOkJH+HoXWAjdmbNW9grhTTJhP43lX3LDRKwfKmhJzpg6swpAdF/
         QaJA==
X-Gm-Message-State: AFuF++nji5WnUSU6hNbWgiWuLB6PfV9w4WYjl4K9Aiwl1weWX0VOBaHw
	/pMMRNMZ4Dn9xZc4Z1NPh09DZFvV2dXme0Vpz/DKQ8PGlPujD8sZQmmawHTmrg==
X-Gm-Gg: AR+sD13xK5l63e84NhFx975dXIWaUroAgK55lW1lyzIXKOawsBb1CTatEaEyVnj1VRS
	J2N4CtNmysrsWreXLYV6NEKP4RMZ05b2HpoWygwNutmVW6j8ywcaARtGwMkQukWDq8FYs1yVQ6z
	YcFNEWnFTF0HdAieDMyyuH2sg1NP5mFQGq2M2UbdHC+mOpYUb2meN8d6hyMOwWhjC6B3NI8giTt
	vzTlY7yTsyE0t/FpbKGgHSAT1WYWFxMrZnR//0E15riRDdNT2F+9K8UUK0SL6xr0f/UlMUW4S4h
	eOIRtSJ0y39DwGrDBudDI2rs/gzMkMi891umozT0+8W6rrZZBtkmsoUwlkcIDRPd9oUDZth1fbT
	Up/W4YN1cQSWRJzIbFXigUdlksitByt7EbVmINfOSer3kulKDThcFIPeljvvJXSjSmooB+ZPKOF
	Nx3wQc0nPSLGao9bohomaLVy2I7JkwwLhC6Bza0Es9W7HoWxcGKVOYFi21B3pBwKenHEmRHaMkv
	cJWu5ge9nggTvAMEHFb2XaIj+w6lwW8iGP1DTq+2IG9ndRX7VZV0JCcF26D8ZYZ4IElYDWzzlI=
X-Received: by 2002:a05:6214:4b0a:b0:90e:98fe:5e3e with SMTP id 6a1803df08f44-90e98fe605cmr71768066d6.19.1788280532157;
        Tue, 01 Sep 2026 09:35:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce8769b76sm103461946d6.13.2026.09.01.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:35:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 3/4] libselinux: fall back through configuration roots
Date: Tue,  1 Sep 2026 12:35:12 -0400
Message-ID: <20260901163513.43186-4-stephen.smalley.work@gmail.com>
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

Convert the internal readers of selinux_*_path() accessors from
fopen() to selinux_policy_fopen() so that a missing file in
/etc/selinux/<type> is retried under the other configuration roots.

selinux_policy_fopen() only remaps a path that starts with
selinux_policy_root() so a caller-supplied path via SELABEL_OPT_PATH
in the media/x/db backends still open the requested path.

The label_file backend does its own text/.bin selection in open_file()
and cannot go through selinux_policy_fopen(); it is handled in a
following patch.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/booleans.c                        | 2 +-
 libselinux/src/get_context_list.c                | 6 +++---
 libselinux/src/get_default_type.c                | 5 +++--
 libselinux/src/is_customizable_type.c            | 2 +-
 libselinux/src/label_db.c                        | 2 +-
 libselinux/src/label_media.c                     | 2 +-
 libselinux/src/label_x.c                         | 2 +-
 libselinux/src/matchmediacon.c                   | 2 +-
 libselinux/src/selinux_check_securetty_context.c | 2 +-
 libselinux/src/seusers.c                         | 4 ++--
 10 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index 9ec46ed1..ea9d2057 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -103,7 +103,7 @@ char *selinux_boolean_sub(const char *name)
 	if (!name)
 		return NULL;
 
-	cfg = fopen(selinux_booleans_subs_path(), "re");
+	cfg = selinux_policy_fopen(selinux_booleans_subs_path(), "re");
 	if (!cfg)
 		goto out;
 
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 39d169dd..289ef89e 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -297,7 +297,7 @@ static int get_failsafe_context(const char *user, char **newcon)
 	size_t plen, nlen;
 	int rc;
 
-	fp = fopen(selinux_failsafe_context_path(), "re");
+	fp = selinux_policy_fopen(selinux_failsafe_context_path(), "re");
 	if (!fp)
 		return -1;
 
@@ -422,7 +422,7 @@ int get_ordered_context_list(const char *user, const char *fromcon,
 	if (!fname)
 		goto failsafe;
 	snprintf(fname, fname_len, "%s%s", user_contexts_path, user);
-	fp = fopen(fname, "re");
+	fp = selinux_policy_fopen(fname, "re");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		rc = get_context_user(fp, con, user, &reachable, &nreachable);
@@ -437,7 +437,7 @@ int get_ordered_context_list(const char *user, const char *fromcon,
 		}
 	}
 	free(fname);
-	fp = fopen(selinux_default_context_path(), "re");
+	fp = selinux_policy_fopen(selinux_default_context_path(), "re");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		rc = get_context_user(fp, con, user, &reachable, &nreachable);
diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index 2f8e4781..cd101030 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -2,8 +2,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
-#include "get_default_type_internal.h"
 #include <errno.h>
+#include "get_default_type_internal.h"
+#include "selinux_internal.h"
 
 static int find_default_type(FILE *fp, const char *role, char **type);
 
@@ -11,7 +12,7 @@ int get_default_type(const char *role, char **type)
 {
 	FILE *fp = NULL;
 
-	fp = fopen(selinux_default_type_path(), "re");
+	fp = selinux_policy_fopen(selinux_default_type_path(), "re");
 	if (!fp)
 		return -1;
 
diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index 124ee38c..b39539bd 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -19,7 +19,7 @@ static void customizable_init(void)
 	unsigned int ctr = 0, i;
 	char **list = NULL;
 
-	fp = fopen(selinux_customizable_types_path(), "re");
+	fp = selinux_policy_fopen(selinux_customizable_types_path(), "re");
 	if (!fp)
 		return;
 
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index bf18bb3d..8b339296 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -287,7 +287,7 @@ static catalog_t *db_init(const struct selinux_opt *opts, unsigned nopts,
 	if (!path)
 		path = selinux_sepgsql_context_path();
 
-	if ((filp = fopen(path, "re")) == NULL) {
+	if ((filp = selinux_policy_fopen(path, "re")) == NULL) {
 		free(catalog);
 		return NULL;
 	}
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index f315abc3..9ac90562 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -99,7 +99,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	/* Open the specification file. */
 	if (!path)
 		path = selinux_media_context_path();
-	if ((fp = fopen(path, "re")) == NULL)
+	if ((fp = selinux_policy_fopen(path, "re")) == NULL)
 		return -1;
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index b528a019..8028097a 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -129,7 +129,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	/* Open the specification file. */
 	if (!path)
 		path = selinux_x_context_path();
-	if ((fp = fopen(path, "re")) == NULL)
+	if ((fp = selinux_policy_fopen(path, "re")) == NULL)
 		return -1;
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index 2bc0932e..6ef3a217 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -18,7 +18,7 @@ int matchmediacon(const char *media, char **con)
 	char *ptr, *ptr2 = NULL;
 	int found = 0;
 	char current_line[PATH_MAX];
-	if ((infile = fopen(path, "re")) == NULL)
+	if ((infile = selinux_policy_fopen(path, "re")) == NULL)
 		return -1;
 	while (!feof_unlocked(infile)) {
 		if (!fgets_unlocked(current_line, sizeof(current_line),
diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinux/src/selinux_check_securetty_context.c
index 9cc69ce6..b9fb9a4a 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -8,7 +8,7 @@
 
 int selinux_check_securetty_context(const char *tty_context)
 {
-	FILE *fp = fopen(selinux_securetty_types_path(), "re");
+	FILE *fp = selinux_policy_fopen(selinux_securetty_types_path(), "re");
 	if (!fp)
 		return -1;
 
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index 0099b6eb..ea542392 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -201,7 +201,7 @@ int getseuserbyname(const char *name, char **r_seuser, char **r_level)
 
 	gid_t gid = get_default_gid(name);
 
-	cfg = fopen(selinux_usersconf_path(), "re");
+	cfg = selinux_policy_fopen(selinux_usersconf_path(), "re");
 	if (!cfg)
 		goto nomatch;
 
@@ -296,7 +296,7 @@ int getseuser(const char *username, const char *service, char **r_seuser,
 	if (asprintf(&path, "%s/logins/%s", selinux_policy_root(), username) <
 	    0)
 		goto err;
-	fp = fopen(path, "re");
+	fp = selinux_policy_fopen(path, "re");
 	free(path);
 	if (fp == NULL)
 		goto err;
-- 
2.55.0

