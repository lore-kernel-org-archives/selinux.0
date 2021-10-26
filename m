Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D4C433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2385C60F21
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhJZLzR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235590AbhJZLzQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLR2Leyry+xeRohsPAJ1nP6iahXc6L+3sR8YziyaFhI=;
        b=gzjuhE3GndSjlnLLzsz0lvfvi16s/VuSkOF3HBCnObgz5202YV4sRYD3ShapDnBLgu/gQ3
        elzGQxRb3ADKrz+14fzx41Enqer4q79WNUNEnAPCPhl9UzDX/a3u07sLbNeQJeiUdtZhCa
        +XEbfvW1xLjXF+1IL2I6QAJ+hZNmgE0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-oia9OqGTMJ-I5bCJdoIMLw-1; Tue, 26 Oct 2021 07:52:51 -0400
X-MC-Unique: oia9OqGTMJ-I5bCJdoIMLw-1
Received: by mail-ed1-f72.google.com with SMTP id s18-20020a056402521200b003dd5902f4f3so2364454edd.23
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLR2Leyry+xeRohsPAJ1nP6iahXc6L+3sR8YziyaFhI=;
        b=LjuY/OGqort+ac++2zycaoJwIsOIHoCj4B9mSMV5BJtiywFdSAzv8Yrjg8woAVry9t
         dI8yMyJMi9nA21CekL+BVmGi9eN94gJ90tJIkEtOXhdUHcvJqMdYakHCtZumgIBVxdAM
         XJ0uIg9wu5boamWNdYUyx2NzBpNS05dgZAQz84vo6iT2TJQj/ZMt8W4nZpRUxj9HwQyt
         TUCsT66ejtAUWvkgvMawAzkRa1HZ/1JmWIjopCmqNAfv/bubq3e9ZCJRHvQk+KDb/OB3
         0U+SvCg6kZBrRZyGs4dAJXQ7i6zKySzNcD1is4E38iQBF3MgZjdGvaKFuPZ+xgsZUC8d
         8+WA==
X-Gm-Message-State: AOAM5320MJ8voF1XMYA3YmFSbp2WgwzaeN56SnB63YoPoJ1eefNHDEAw
        XsjUpT6/n0JcmMQi3mr3WralwbSFjHDXIqDa4ASM7p1nzqO9OFLg50mAArcGHGOsyZq52yZdJLr
        3fJtwvSkwKb8ROVZnXB2WFwQRTje/+XBVy1JU7w/q8FkhFKWcq1NmYZPnqT3Ld4JYODHBuA==
X-Received: by 2002:a05:6402:27d2:: with SMTP id c18mr36046202ede.186.1635249170194;
        Tue, 26 Oct 2021 04:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz49rsOk3cF7aGpV40Ykle8b2IFO/dQcA3+CORHiiB/0WfPMlsqPLVgZFjB9w4hRAyQauHEwA==
X-Received: by 2002:a05:6402:27d2:: with SMTP id c18mr36046160ede.186.1635249169793;
        Tue, 26 Oct 2021 04:52:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 8/8] setfiles/restorecon: support parallel relabeling
Date:   Tue, 26 Oct 2021 13:52:39 +0200
Message-Id: <20211026115239.267449-9-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
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

