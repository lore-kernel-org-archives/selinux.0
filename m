Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014444B7151
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445932; cv=none; b=Ahppj0XBmEI/7Yz47CNEpBy9QWuBvTqORh+0yfBva1lFv8I/gFOCP9C2TItfi1WbGz/IPOC8qVwp+Wot9D5ljwBpPLnnQ1g4YkYeVZm8Vr/NZKZ3HENRtwhFQeAbOIseUSSkBmANznCykF4Pp5HAwenEnFujBEjPVtUlrConwlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445932; c=relaxed/simple;
	bh=ruo+objDGMJAJ2S4cbL1hm+bbGiHYC4biwTzS4Z07yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCJ4/Ar8ZFR+QniVBTsfHGEBNSVtA+MdlfpoNzAmQHZNLNGkyGq0hHpAlpBXjlUgH5DT5kAGrkiF2itQnc8xGr62O+KaujDuwqPoIrL3ijC2HF8rOmfeFuBYPRQ+igmvG3NyK//K7wyZBa9ONr/xtUNaGNlEcBYhpm5/CJZiP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3stDFBv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3stDFBv"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52fa9c055b5so15721511cf.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445915; x=1789050715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hge6+qZUvaCoRlu9kAJMLD6sjbfMzhCXOHq7DYYnyeo=;
        b=o3stDFBvXGVZTKMImSIyfY+QMdsqUe2zUKAbe9+Jaz3uoEyKpZQ3ufe7Ktm0DPOaA9
         FpmOUlrRX4uo3aitPSZGVG2eA9dN5dlvhjWPze0gE7dVHfSu2JDSlbZnwSn/WEZUzj7T
         ZWenBvE/Ye2VSlXCLq4C3jBIPzIA3wnyUc+NnUdcZfF8hggVjurBwO6mAUw+Gma0bof8
         AdNP4kOcrMzFfQVigaQUD4auJQKye7EUUlq9hnPZxm1gitPnpqDjkqB3XoIl5SDyHv61
         Al+fS2BoyLu9HZ86huCkVHp1tpFlTra6Scr3oSbffAV9Ik/QojTx7rhbndvzf9RWFhaH
         hYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445915; x=1789050715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hge6+qZUvaCoRlu9kAJMLD6sjbfMzhCXOHq7DYYnyeo=;
        b=SowYyO1KG02sWKmWgNNSk2AQa6Li0mhL/vazKqdTe7MBGweEaspvsnmOdNsKhpYy/4
         xj9bfnjR3JvSCgU8wOt7psKoAMx1QLt4emQ7O0rSqi/QeBhhBPzDxJwFGthIL+ckF5ku
         lnVv0ED8Do8zVJ1o7Y5uUsJA5XX8X6KLFp+yCFLPDxqCzZy+ug1O0N1OToRBPBo6/NYV
         o5exqONL/HyesEpMo641xRQe4rPFGZzfLk6ys5LT2c7qP89XeelAdBirvg6FR6K62CNZ
         s1ariZ8cQekMJU1aQ6/diXbO9xhw7Yd7Ligdt4z8nJvu8/ILmDzZY50BY4iyCHRzIjaL
         ZGsw==
X-Gm-Message-State: AFuF++nmIoON8OvARVhCgp39/8mreXUR1i/JbxvUo063lDYF/WyKSmXL
	HJHtLDq0m471gLr9j7kT7tCS282vHykdEdbX4ram1TOx/hRg6J8f0tIZBOmI7Q==
X-Gm-Gg: AYBFou3RFH5GnoUZkn/tUErvf+VpIpiUI/7S/ZUKC8LRhEIsPosLRhXV+wq/zYQT6vP
	PXsNOqob3wFeC0EJ5coJ06Qdt+7KzKYZ+L1zVqPHyt/s7LlBQ2tlWgUeOvlcW1uS1z10CnOz8r8
	Levd90yhmc8251fbkg2tl1FLdNKvygpfcn7bMLUeShAUDapzluWfxb+gnps92pHXydzFtXSB8qR
	zRaKrLA0mx3EOT7fGTPmY6jTUCOT+3bMx0q63BBaEHh3JePu1Jvo9E1vuCOWGrryqayPaoIAjKV
	mBW2GnnYu6RMw+L6EOaqp29BY42euPL7jWl+GiyyUtg96PWoUfKkReU+PohiJQ27dJJeS75HIOj
	mCDkOYPon3bLkNjUmrPADs4jcQ6Du1+Jvy+VBNrpBINPqlI6BeeJIuZX9pcnrHful5Aa/BaZs5V
	59goC1rbWx4gtRqTNqFsPLZ8n4uBBVTXVrp+oGqLqN2LjCMcFnnJUul9erZm0FeM1pXBT8aub5S
	V0DnudbaiTVheddSWVESnBr6SrN6DU3/oYbmdXUuTOmCbSjm1jEgleSFZwTTDwt
X-Received: by 2002:a05:622a:e31c:10b0:530:4c98:6301 with SMTP id d75a77b69052e-5304c9864d4mr13167401cf.2.1788445910648;
        Thu, 03 Sep 2026 07:31:50 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530330282bfsm43110841cf.11.2026.09.03.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 3/4] libselinux: fall back through configuration roots
Date: Thu,  3 Sep 2026 10:26:00 -0400
Message-ID: <20260903142600.19723-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
References: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
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

