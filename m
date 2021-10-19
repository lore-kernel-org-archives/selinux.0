Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45376C43217
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3423E60FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhJSPDu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233196AbhJSPDq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLR2Leyry+xeRohsPAJ1nP6iahXc6L+3sR8YziyaFhI=;
        b=G2TvVRH5SqeKVLfZ/ahgcXCsHEXuPI/+5CAVy8IZQ558Ip9DACHF1rOcwE2vSEnQEMjILB
        HD0lyrfxchGGhgb3hwT7Xaxj4KPKDZFfmd91ktrOox6OHi53dXZT1kqqKeIJl4TE2Wx505
        mo00Aj9TmXEZDBsHlsWPS7P6X2RU6qE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-hjwHV75FNrqjiSXSpVZgJQ-1; Tue, 19 Oct 2021 11:01:32 -0400
X-MC-Unique: hjwHV75FNrqjiSXSpVZgJQ-1
Received: by mail-wm1-f72.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so2607025wmc.2
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLR2Leyry+xeRohsPAJ1nP6iahXc6L+3sR8YziyaFhI=;
        b=UJ2WqgdiUm2fTu1yUGLveCU1r2io29H1VDitwomQz16gs0KJStj0unElq7mKfhWU5p
         897jfFwcltyP2g1GxUiX8y5Tfj/O3VptdW7Wqea5fl5wnPSyDmDxBAiqvysKHQHZzfV5
         uZQZU85Ys+TofbC9S85ouxlSBBksTRh3q1837chLVj9dDV4rGl7yYsoxHfJ36zIbR9y5
         XpCtV7xz4MVirYNbBGz8+yjUzyZc1b0VY/dTePde5CO1OYPfBrM9CNO3T8d1r+3wSU1t
         csb2QD3fMMH45zUQdMP0/GGbwC1qskHazaK+zTrRuyQICjOZxPgwCOPNcVV94GLG7GM/
         3OiA==
X-Gm-Message-State: AOAM531DVOrJLVOtxHw8GrZKvNpsFtYWS61cD2Is7EgdlNHS0wTb0a//
        QhS1GiRJO7iz2SE9aZtSvR9GAY7cufQVp5Sh7iitxnHKCnmPTGm1P+KlBiz5aKhcIiJfAwgUqHB
        hK5nO8c9wqtyMKT6kJsEISsAJTGncwoC9aPZY5yLwcT+I7bsn9xKSwk+Evj9S3eiHUBQ82Q==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr6759345wmq.110.1634655690709;
        Tue, 19 Oct 2021 08:01:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5/6HAZhGXaEZyK9Xr0VgjX230SCoPP/9elmcPRpBIGmv6lIxPIuPTG/LP1qwP7l+lK8EBKA==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr6759259wmq.110.1634655690157;
        Tue, 19 Oct 2021 08:01:30 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r4sm19271630wrz.58.2021.10.19.08.01.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:01:29 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 7/7] setfiles/restorecon: support parallel relabeling
Date:   Tue, 19 Oct 2021 17:01:22 +0200
Message-Id: <20211019150122.459722-8-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019150122.459722-1-omosnace@redhat.com>
References: <20211019150122.459722-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the newly introduced selinux_restorecon_parallel(3) in
setfiles/restorecon and a -T option to both to allow enabling parallel
relabeling. The default behavior without specifying the -T option is to
use 1 thread; parallel relabeling must be requested explicitly by
passing -T 0 (which will use as many threads as there are available CPU
cores) or -T <N>, which will use <N> threads.

=== Benchmarks ===
As measured on a 32-core cloud VM with Fedora 34. Not a fully
representative environment, but still the scaling is quite good.

WITHOUT PATCHES:
$ time restorecon -rn /usr

real    0m21.689s
user    0m21.070s
sys     0m0.494s

WITH PATCHES:
$ time restorecon -rn /usr

real    0m23.940s
user    0m23.127s
sys     0m0.653s
$ time restorecon -rn -T 2 /usr

real    0m13.145s
user    0m25.306s
sys     0m0.695s
$ time restorecon -rn -T 4 /usr

real    0m7.559s
user    0m28.470s
sys     0m1.099s
$ time restorecon -rn -T 8 /usr

real    0m5.186s
user    0m37.450s
sys     0m2.094s
$ time restorecon -rn -T 16 /usr

real    0m3.831s
user    0m51.220s
sys     0m4.895s
$ time restorecon -rn -T 32 /usr

real    0m2.650s
user    1m5.136s
sys     0m6.614s

Note that the benchmarks were performed in read-only mode (-n), so the
labels were only read and looked up in the database, not written. When
fixing labels on a heavily mislabeled system, the scaling would likely
be event better, since a larger % of work could be done in parallel.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/setfiles/Makefile     |  2 +-
 policycoreutils/setfiles/restore.c    |  7 ++++---
 policycoreutils/setfiles/restore.h    |  2 +-
 policycoreutils/setfiles/restorecon.8 |  9 +++++++++
 policycoreutils/setfiles/setfiles.8   |  9 +++++++++
 policycoreutils/setfiles/setfiles.c   | 28 ++++++++++++++++-----------
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index 63d81850..d7670a8f 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
 CFLAGS ?= -g -Werror -Wall -W
-override LDLIBS += -lselinux -lsepol
+override LDLIBS += -lselinux -lsepol -lpthread
 
 ifeq ($(AUDITH), y)
 	override CFLAGS += -DUSE_AUDIT
diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 9d688c60..74d48bb3 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -72,7 +72,7 @@ void restore_finish(void)
 	}
 }
 
-int process_glob(char *name, struct restore_opts *opts)
+int process_glob(char *name, struct restore_opts *opts, size_t nthreads)
 {
 	glob_t globbuf;
 	size_t i = 0;
@@ -91,8 +91,9 @@ int process_glob(char *name, struct restore_opts *opts)
 			continue;
 		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
 			continue;
-		rc = selinux_restorecon(globbuf.gl_pathv[i],
-					opts->restorecon_flags);
+		rc = selinux_restorecon_parallel(globbuf.gl_pathv[i],
+						 opts->restorecon_flags,
+						 nthreads);
 		if (rc < 0)
 			errors = rc;
 	}
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index ac6ad680..bb35a1db 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -49,7 +49,7 @@ struct restore_opts {
 void restore_init(struct restore_opts *opts);
 void restore_finish(void);
 void add_exclude(const char *directory);
-int process_glob(char *name, struct restore_opts *opts);
+int process_glob(char *name, struct restore_opts *opts, size_t nthreads);
 extern char **exclude_list;
 
 #endif
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 668486f6..e07db2c8 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -33,6 +33,8 @@ restorecon \- restore file(s) default SELinux security contexts.
 .RB [ \-W ]
 .RB [ \-I | \-D ]
 .RB [ \-x ]
+.RB [ \-T
+.IR nthreads ]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -160,6 +162,13 @@ prevent
 .B restorecon
 from crossing file system boundaries.
 .TP
+.BI \-T \ nthreads
+use up to
+.I nthreads
+threads.  Specify 0 to create as many threads as there are available
+CPU cores; 1 to use only a single thread (default); or any positive
+number to use the given number of threads (if possible).
+.TP
 .SH "ARGUMENTS"
 .IR pathname \ ...
 The pathname for the file(s) to be relabeled.
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 4d28bc9a..15f939d1 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -19,6 +19,8 @@ setfiles \- set SELinux file security contexts.
 .RB [ \-W ]
 .RB [ \-F ]
 .RB [ \-I | \-D ]
+.RB [ \-T
+.IR nthreads ]
 .I spec_file
 .IR pathname \ ...
 
@@ -161,6 +163,13 @@ quote marks or backslashes.  The
 option of GNU
 .B find
 produces input suitable for this mode.
+.TP
+.BI \-T \ nthreads
+use up to
+.I nthreads
+threads.  Specify 0 to create as many threads as there are available
+CPU cores; 1 to use only a single thread (default); or any positive
+number to use the given number of threads (if possible).
 
 .SH "ARGUMENTS"
 .TP
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index f018d161..2313a21f 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -1,4 +1,5 @@
 #include "restore.h"
+#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <stdio_ext.h>
@@ -34,14 +35,14 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iIDFmnprRv0x] [-e excludedir] pathname...\n"
-			"usage:  %s [-iIDFmnprRv0x] [-e excludedir] -f filename\n",
+			"usage:  %s [-iIDFmnprRv0xT] [-e excludedir] pathname...\n"
+			"usage:  %s [-iIDFmnprRv0xT] [-e excludedir] -f filename\n",
 			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
-			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
-			"usage:  %s -s [-diIDlmnpqvFW] spec_file\n",
+			"usage:  %s [-diIDlmnpqvEFWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
+			"usage:  %s [-diIDlmnpqvEFWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
+			"usage:  %s -s [-diIDlmnpqvFWT] spec_file\n",
 			name, name, name);
 	}
 	exit(-1);
@@ -144,12 +145,12 @@ int main(int argc, char **argv)
 	int opt, i = 0;
 	const char *input_filename = NULL;
 	int use_input_file = 0;
-	char *buf = NULL;
-	size_t buf_len;
+	char *buf = NULL, *endptr;
+	size_t buf_len, nthreads = 1;
 	const char *base;
 	int errors = 0;
-	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0x";
-	const char *sopts = "c:de:f:hiIDlmno:pqr:svEFR:W0";
+	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0xT:";
+	const char *sopts = "c:de:f:hiIDlmno:pqr:svEFR:W0T:";
 	const char *opts;
 	union selinux_callback cb;
 
@@ -370,6 +371,11 @@ int main(int argc, char **argv)
 				usage(argv[0]);
                         }
                         break;
+		case 'T':
+			nthreads = strtoull(optarg, &endptr, 10);
+			if (*optarg == '\0' || *endptr != '\0')
+				usage(argv[0]);
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
@@ -448,13 +454,13 @@ int main(int argc, char **argv)
 			buf[len - 1] = 0;
 			if (!strcmp(buf, "/"))
 				r_opts.mass_relabel = SELINUX_RESTORECON_MASS_RELABEL;
-			errors |= process_glob(buf, &r_opts) < 0;
+			errors |= process_glob(buf, &r_opts, nthreads) < 0;
 		}
 		if (strcmp(input_filename, "-") != 0)
 			fclose(f);
 	} else {
 		for (i = optind; i < argc; i++)
-			errors |= process_glob(argv[i], &r_opts) < 0;
+			errors |= process_glob(argv[i], &r_opts, nthreads) < 0;
 	}
 
 	maybe_audit_mass_relabel(r_opts.mass_relabel, errors);
-- 
2.31.1

