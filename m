Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C947B429
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577907; cv=none; b=aYM2kLyezf8LNug1zMUXuv0Pqw+7gYkcx4P8h/TTK5GNE08qjTyxEAJoHvEUjBV1WX+FwyrmaAKGdG1BXIYoFZWOv76U6O6uoOrtsnwXPGRsHU2cyygRRZR/D/9EtJsBFLcDYSqs+Oyhfky36IeuSXlYphJGmGHPn97XcdwYQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577907; c=relaxed/simple;
	bh=ALhsXcXQYrJA+BQ8cCn7QJq21Qfr6VlMEOPFn+FBolo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCaBApPlayLVGS/l8XkTdL0FP+SHwUPytsCp1vzX8jkuoW0lNkTS+XL31amVpNB6MqK6FhHVGaDXqpm54VbLnDWc26fqTh8JlIajjDLoTudK/bbV65WY7lyI0c8dpMAQBdXRFsSnAlpUEkz6P6UtAqOwkQkVIrSqO8Ajb1Gh2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJFXv/RK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJFXv/RK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9155183b42cso91300385a.0
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577905; x=1781182705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9DDPhdD0Mp+FGI2o1BuJ8xIDszFpQ1TNM/FCLF9tSo=;
        b=OJFXv/RKmfo0+Vl/ab6nI+PJIrJjUjkf1T91FDaWbBhTMnSV+ycBmvI9E87qosn2Sb
         UJwobKk2/QFzCpOK/0BZJzlAi96xogwXzA+bOxpHmM58OQKigp1TU222MYDMzF6+TqKr
         CzbIo/aXa3M01WWKt4i4rckJGBMbnGpk3Lkx0o/JLTcQXf51o69BBsIjwYizAIEhPwUL
         714fRrUjnVVO43unqbyr4eIjJUgybXtO++08zbwyCQ5x/aVEQeYxfBxePlvxanTsSUOr
         NkDEyaFkPKRtvtACHLUTtjDoruN2q8vgy5k1lHtpSwgqS0ntD4iozim25hnYZVnpprzH
         PAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577905; x=1781182705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9DDPhdD0Mp+FGI2o1BuJ8xIDszFpQ1TNM/FCLF9tSo=;
        b=PxiV0/xi5CljObrLPz6F4AahVfzC6gRWRtHVgsgcv/guAagpO5PGl7lLepHxmUM7GJ
         QX2N3QtIItyrTOAauU9YieXkDshtH7SUf88GH54aJK4L4BSsDFPpZcA+Hyk0zdwuFrTE
         HhHpB5cqmC6hWNmBa1C8D0an1KjUFEJBh6+Fh6Fie1FMgKfm6Sr5Arch4jvtTU/zwvPa
         6xwPFDn5TzX4qildhXeI9KsUc2QP1YoPKSJV5wxa5iBoMJa/PcHQFfsJsE3GPXtdBush
         TjNgKajIvc0QgpqSifbl3R7OGpxqLvZWQcxDAb3FYDuSExtOwC+G1MCbS3LmhXj4uIPY
         paRA==
X-Gm-Message-State: AOJu0YxKrCPx60/gxgkEusz2u7zuBQBl56/nZim9bdy/015+Rc3I5jLT
	nhNTibYxWYZ5REXYhQplEGjooXMaCBSTE68eb4iEx/XUXN45gQ9RjZbkS1NmIw==
X-Gm-Gg: Acq92OFrHLrVv+WGpzrmJIbbRmpAaoXBhUy0LIc7ig48Cu3wcp8/mzpw/vZfs5p5Cpn
	+cB85sTE0QPnBOIdStch031tbWbcB4VXvO6rhsGC5aYKIWfimVxa7vKz2edrDLJWyRs79d3AhST
	R7Nx0TkvmqsswRsPGaQqxZKgTrMD8to8fFfwxCmEY3SH4yW8UJQiCgez/RdCNWDaRAv6YqiwLVt
	qML4HTUeup6MlMvQdSaDj7LiMH1Q+uEPYW0x1l4KM9X6ecf4MTFHzZTpV9tQLAM0izmps2M2vla
	7Ldck2gCuJuQSo8BLIZZbFClnD016VorI2MzGR0ZdrpBvauaXa1KlW2IhfsdNdsqt9xNLDhrnR0
	2eY5B551Uh2haedjBMTy+Q4LsCwNn4w/yF+wxNDlA+RoysSHciT4XjhE1enI/5I78W6Bo82lt65
	tgdYczs3Anq7zgeXvqoHV4s8OXmh9Sh1aUdaJCJu2yAMIbY2dO5AmoryVPQlsOi1cFXELm+xYdC
	BY1EkOLgvWOJO2MvqATG6xBJSA9qdIcmNvEng==
X-Received: by 2002:a05:620a:2728:b0:915:4ca0:1199 with SMTP id af79cd13be357-9159aec007fmr489952185a.13.1780577904826;
        Thu, 04 Jun 2026 05:58:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d3a0esm585789085a.40.2026.06.04.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:58:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] restorecond: Use new SELINUX_RESTORECON_SKIP_MULTILINK flag
Date: Thu,  4 Jun 2026 08:58:05 -0400
Message-ID: <20260604125806.255648-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604125806.255648-1-stephen.smalley.work@gmail.com>
References: <20260604125806.255648-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly defined SELINUX_RESTORECON_SKIP_MULTILINK flag
for selinux_restorecon() to prevent mislabeling files with
multiple hard links. Unlike the previous approach, this
is race-free and covers all selinux_restorecon() calls made
by restorecond.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/Makefile      | 4 ++--
 restorecond/restore.c     | 3 ++-
 restorecond/restore.h     | 1 +
 restorecond/restorecond.c | 3 ++-
 restorecond/watch.c       | 4 ----
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 51eb7608..5e0bd2ec 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -18,8 +18,8 @@ GIO_CFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags gio-2.0)
 GIO_LIBS = $(shell $(PKG_CONFIG) --libs gio-2.0)
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I../../libselinux/include $(GIO_CFLAGS)
-override LDFLAGS+= -L../../libselinux/src
+override CFLAGS += -I../libselinux/include $(GIO_CFLAGS)
+override LDFLAGS+= -L../libselinux/src
 override LDLIBS += -lselinux $(GIO_LIBS)
 
 all: restorecond
diff --git a/restorecond/restore.c b/restorecond/restore.c
index 0ecfc42f..23c2c98e 100644
--- a/restorecond/restore.c
+++ b/restorecond/restore.c
@@ -34,7 +34,8 @@ void restore_init(struct restore_opts *opts)
 		opts->set_specctx | opts->add_assoc | opts->ignore_digest |
 		opts->recurse | opts->userealpath | opts->xdev |
 		opts->abort_on_error | opts->syslog_changes |
-		opts->log_matches | opts->ignore_noent | opts->ignore_mounts;
+		opts->log_matches | opts->ignore_noent | opts->ignore_mounts |
+		opts->skip_multilink;
 
 	/* Use setfiles, restorecon and restorecond own handles */
 	selinux_restorecon_set_sehandle(opts->hnd);
diff --git a/restorecond/restore.h b/restorecond/restore.h
index 97fbdf4d..d7935e06 100644
--- a/restorecond/restore.h
+++ b/restorecond/restore.h
@@ -40,6 +40,7 @@ struct restore_opts {
 	unsigned int log_matches;
 	unsigned int ignore_noent;
 	unsigned int ignore_mounts;
+	unsigned int skip_multilink;
 	/* restorecon_flags holds | of above for restore_init() */
 	unsigned int restorecon_flags;
 	char *rootpath;
diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 90d73087..421b992c 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -154,10 +154,11 @@ int main(int argc, char **argv)
 
 	watch_file = server_watch_file;
 
-	/* Set all options to zero/NULL except for ignore_noent & digest. */
+	/* Set all options to zero/NULL except for ignore_noent, digest, and skip_multilink. */
 	memset(&r_opts, 0, sizeof(r_opts));
 	r_opts.ignore_noent = SELINUX_RESTORECON_IGNORE_NOENTRY;
 	r_opts.ignore_digest = SELINUX_RESTORECON_IGNORE_DIGEST;
+	r_opts.skip_multilink = SELINUX_RESTORECON_SKIP_MULTILINK;
 
 	/* As r_opts.selabel_opt_digest = NULL, no digest will be requested. */
 	restore_init(&r_opts);
diff --git a/restorecond/watch.c b/restorecond/watch.c
index 333f0af0..44094fd4 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -192,7 +192,6 @@ void watch_list_add(int fd, const char *path)
 	if (glob(path, GLOB_TILDE | GLOB_PERIOD | GLOB_ALTDIRFUNC, NULL,
 		 &globbuf) >= 0) {
 		for (i = 0; i < globbuf.gl_pathc; i++) {
-			struct stat sb;
 			const char *p = globbuf.gl_pathv[i];
 
 			len = strlen(p) - 2;
@@ -200,9 +199,6 @@ void watch_list_add(int fd, const char *path)
 				continue;
 			if (len > 0 && strcmp(&p[len], "/..") == 0)
 				continue;
-			if (lstat(p, &sb) == 0 && S_ISREG(sb.st_mode) &&
-			    sb.st_nlink > 1)
-				continue;
 			selinux_restorecon(p, r_opts.restorecon_flags);
 		}
 		globfree(&globbuf);
-- 
2.54.0

