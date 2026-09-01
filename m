Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAD432BF5
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277787; cv=none; b=WlsSFoOZy/iOXhjbOAX6NNqSf4NoPUEB04MA5vWMuiKH9+/P9vwME+qI67wqhFf1r+6w0TBnMoK6EU51Ccl+tb1erjOebGCW721PV7TRkq8rCfFcKV7AQw5RSOPl4ssfdCb/7qQIZRfKRdpkouR63/sMEbh0R4LUuUhjLvvUJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277787; c=relaxed/simple;
	bh=EnU5DhaF9WYhUQQH6HdW7j1/G6AuYq7z/r80jaasqLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTOv2IaY/R4eGSKoXbFRavfPCBjxniEUTZlyfuT4xVRf4EWlmQHepcFvq2JR8l9gm7cKU9EV9ycByYHXb9NHYZlvxpUgyrygJgri7k3UkR2M5281C0ixeSXFlXHJ7G90FFhFMzMpkd1uioGMwU2yjaoMcNozA2twpZkn9YPy+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3l1gzpB; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3l1gzpB"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93900ed2925so6445885a.0
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277785; x=1788882585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZcVF6wO/3P1Dpz6T9ipVZ/e9+UhO/IFmYK/M4tbQB8=;
        b=m3l1gzpB7E/zDcflVSVySW0KIVtqAPY1yuJ0w7as7I1vinaIRih3mA3FpXTR1sXV9D
         sdvI8yxiZbwy1W3A9OVQQ9bLrbuQONaSlLI3jEsCDz54lcLp/EL0MPVpTTQSUUbTI6B2
         DkG7zK6P7i2qTABnmY+gKQELyBAEubNtfYBwq+b9qm1TowEpAC9GLB7Yq1KEj7xafaFQ
         S493yeFDRwPg25Fk0+jLNlCLjyUc2Dy0zgKwydN+sBTWsK9oQas+7hk0qFiwOqKiPnQ3
         jMbzjQMqolpO7mFgfjCBMBcRpQbFqwogVUJD6oim+kjIG/PliKvSP+gWgZ+feqWZx1M2
         WG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277785; x=1788882585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZcVF6wO/3P1Dpz6T9ipVZ/e9+UhO/IFmYK/M4tbQB8=;
        b=Z5JCGeRUo2kpUWQ8m+6CMHgBC/jmDq0uq+FckUlrfe7gUa226bkImbLbEZiVlhxMo3
         QLTAiNPJdeWgtMVBabXLL2H4ExOOyZi8HWfb18t7l03iHp9cpygfnSfBWzrG0Oas4jch
         37iDkhD84Di6V+6ICYxP/7RD/BKG92gOgr8WyA90i8AOiEGEap9+hD7KZMq3Vl3Qgm6d
         19SsAjLcRU0eaaTXimq6IGp8m8Sm4JDjVArk9xIjjnFTOMJ59HR1UAnDZGYisfQ0w2NG
         icPzB5kSF9MNna7VctWry/s3zD6oepgTQNbwJOUp2i0F4BmVmEGKcKc7WSBG3n4g0rig
         +Sig==
X-Gm-Message-State: AFuF++mnHzmIrbsdjdlRNFe1ODW1zqONPoBEkc1CSu+65ESggjnoIASI
	T1RCmpNNxN/EQclVlPXkfaa8ToB0V4VMvlGBTMl+a/AoQaW9axL+QDBHCVAtSw==
X-Gm-Gg: AR+sD13sBITIAHxALQOqAiFAsN9jAGr69LLcu/Zt0JxwrOCU0EjSWo7zDMUTGdkrwmz
	25Bo1sfXKB1tXoVcPfWWjHF9IPTvM16Hd4xQ/Swf6QE9eehXUa73zIxlI+mjRNOAJ8fmSXQD0Tu
	8E9MmUyZaBRzHw1HKxsssPp04FbAql/dS/jzXkyLy15EEaklLDx44o2ntmTS/3GMPjehxi04w8I
	wdnbwkd95BmJRJYVLoGlQIC0JGUC3rYCWqhV3TcuSexMjLf8jYBDQuAvae/0yk6ysp7t+Ab5U1B
	e4bbZWVTxXBmLXuvf5jzDNgJEOR6WPJ5cxiR6R3I2NHhDC+GN3Z7hs+KDX6G1WslOw+QYAPafXA
	qu/JKzZ1mpx5IV7d2bIIwawF1VjkeuiWaVgf1WquubpgzPVe1O0xDpP4N/uuVNugeesW3X6SLz0
	h11H4fR4ypa/JuxvXZzrUNQImsYOWRaZUBreSEY8KFjba8pcFR7Gr9cjmvV+eWAPz5poi/NtDBc
	fWTHuvE68koxAGEOBthREeb/W7gFr33X1LzL9I5POe+WwjTkQi5Vv7Vpvisrjsz
X-Received: by 2002:a05:620a:6e91:10b0:936:cd76:4d4b with SMTP id af79cd13be357-9394817e0acmr1001749485a.42.1788277784902;
        Tue, 01 Sep 2026 08:49:44 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173db029sm1047209785a.35.2026.09.01.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:49:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/4] libselinux: fall back through configuration roots
Date: Tue,  1 Sep 2026 11:43:07 -0400
Message-ID: <20260901154307.41844-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901154307.41844-2-stephen.smalley.work@gmail.com>
References: <20260901154307.41844-2-stephen.smalley.work@gmail.com>
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
 libselinux/src/booleans.c         | 2 +-
 libselinux/src/get_context_list.c | 6 +++---
 libselinux/src/get_default_type.c | 5 +++--
 libselinux/src/label_db.c         | 2 +-
 libselinux/src/label_media.c      | 2 +-
 libselinux/src/label_x.c          | 2 +-
 libselinux/src/matchmediacon.c    | 2 +-
 libselinux/src/seusers.c          | 4 ++--
 8 files changed, 13 insertions(+), 12 deletions(-)

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

