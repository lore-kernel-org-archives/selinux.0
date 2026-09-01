Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E343E095
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278565; cv=none; b=gbMZ5cY7HOkLj0k/g66nFisMua+1LDzFv7mFjdEqW1OPWHNfiD6U1TUoW37Pb4L8fK2J8bDjkWSAv29+iO9fnkU2pS4K/kbxBnmthb1o0DtULKFzJ1nLQIdwuFZwjCefalgmba6m7km9yrEhQtDDIpotJEKJsMbFkZOBkEOuYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278565; c=relaxed/simple;
	bh=ruo+objDGMJAJ2S4cbL1hm+bbGiHYC4biwTzS4Z07yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IquIx1zX+a/77bDNvOz1DUaW8vNCOHbQjrBA6faKNNMcVWvU/gSPW6PQScqSD+Ve015tLcTkwvfiFXwkKS5cSZQcKCg8BTmvV0hxtcgHjewyjVBm8gFvzV5d7gSB3sXoo+n3S5lrb+bVRupZ7zCYMxqKm0lCuv7sft6WLWFVO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH/MzUek; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH/MzUek"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c08df8513so8112871cf.3
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788278563; x=1788883363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hge6+qZUvaCoRlu9kAJMLD6sjbfMzhCXOHq7DYYnyeo=;
        b=BH/MzUekSZ10brYyhSmZRVMA+mNesKYl51/BVOl+hTUMNogMVSOBDw/BuOCo+rrNR4
         b+EngzkEjAh0j41d9kkDaecCJE7GSpXtQ/uTBnhgkuNfDaa72/u+E+w1/v8qyN44Ot5Q
         Ppqlhzp5ghokL3PCTpgPOrRT4OPVbFAmCluHBXbu85ZRTnhVOyvM3LIGqVGEs9wUSwhx
         z0sgrQleJXvScP4T5fg51dSy91sWKRJ8U7hvsSkck/FpVMEmjketWiNwRTJyXZyZ1aRK
         SEGo+XmbyTODJ/P9vePx8HvHOocGotfz0jQ1cWD7EPnfFyhbrxo4IhRgg/HSy4XMMidT
         sQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278563; x=1788883363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hge6+qZUvaCoRlu9kAJMLD6sjbfMzhCXOHq7DYYnyeo=;
        b=JTjfXo6QZpMi4uZm7WvngyryLphZVmWyNJjpv4+iYGkJK5HHdC9Ve6aa83qWNmQITi
         Mf7ik4AX1U/9+2PH+OmuY/bNPLlr9PPH6qTJG+zcoUmfOjM8LF/uK7d1fd47BByYF7rg
         MfVm+A1gz7lYPRF77HwCzzuq5811orOWvxw0Mz76hVq909gejunhprf00Ojl9BDC/Ucf
         4VKW2i58rfyk4bbxfd2Ft50owR4fuaod5zHkqkObHiH6QSY0C70HWwhe/ZYheZvMY1hP
         VPcj7bUT1SVMo726FqhMySH3Zpjh2L4G+u2d97u3/K9B7VGqveD6XHJtjD44jom9UZLY
         Y31A==
X-Gm-Message-State: AFuF++k5QZTMHvpk/3A4D2GQQdgQAlrbgUgMrhljinblLv9djczWfU7q
	XJ39VrvOWyCwYRJIuvo8ciL/RSfhxhVed0CdbxfFgvgAV3dSirXRUx7kIjdIQQ==
X-Gm-Gg: AR+sD10JRD8krdGBpnfphI79HDm8jdoviOUZJaCuTI1av+WCL/lhI1sFoOz6JgSI/qf
	FaC/w/cYj9ZwPboekW19miKgLnwBqTJgjLvYfvF1v0jd74O59VVHhwHGqraDkwUjPYRFTB9ZMEU
	ddWd97XmV9DAacEjZvZ6iIpNHbDihGIcjxNQCPPVH6S4TyhbHkSgMKwFXfc675rvjTckR7DsIW9
	D13N9K9THgnPFUvGIqQz+53d8eAJrZ5i3ruhtod8W1sgkPm5FRlQW6VFuOlsF8nKgmi4ZNfgIth
	daPYzfTPBPB8/SS/WxqssPQVsFQAEqtZbHmOUBlZ4hcPfItrhyXvomYYYL06YE76SVDohtw2uf5
	ZWpLsv4MaYgLqI+ImtXAwqnffHaH78UI2PVAJyALITxOxS5ZBtQe+DZZH9entMqiSaS/snNH68R
	LlfZVEiyajGCvzSQ4yd+vrODZdcTsDgblUGKqWk2mtYQgQ8VHT49jz4su0jbNq/lqwKx/bEDfpP
	Kb9pKg0u2K8B6fznkZW6z84Dz/cSyFwgH09ndgd08/L/UBDeFlFLy9eaXR20Iw/
X-Received: by 2002:a05:622a:1cc3:b0:530:23cb:cac with SMTP id d75a77b69052e-53023cb0f9fmr114660761cf.6.1788278562211;
        Tue, 01 Sep 2026 09:02:42 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ff704a282sm78980701cf.18.2026.09.01.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:02:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/4] libselinux: fall back through configuration roots
Date: Tue,  1 Sep 2026 12:01:11 -0400
Message-ID: <20260901160111.42656-5-stephen.smalley.work@gmail.com>
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

