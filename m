Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C7C433C1
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D97B6188B
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCWRJP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230050AbhCWRIn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Mar 2021 13:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616519322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsOY1N9DVLuUMCekvDNDqyoYEic1JhxmkoreO8nLHX0=;
        b=XGQ9pRnd7py35vwy9gU47u9KUt6F/f43zhnpcoZZDIyq4VQXaQDqzKpZ71ESIlQkOlX0Q7
        UzCLLbEfPh2BWKp0xHTRa96YDud8aCyjpY/UaLG7J1Xo6QnHPFq4ppp+ySh8SIbwSAK/xm
        ZR5jqbwzifDb1N1prRT8hlvbf0dGLTA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-Gzk33Vc6P0mSUUahf_C8aQ-1; Tue, 23 Mar 2021 13:08:40 -0400
X-MC-Unique: Gzk33Vc6P0mSUUahf_C8aQ-1
Received: by mail-ej1-f70.google.com with SMTP id e7so1360448ejx.5
        for <selinux@vger.kernel.org>; Tue, 23 Mar 2021 10:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsOY1N9DVLuUMCekvDNDqyoYEic1JhxmkoreO8nLHX0=;
        b=Byw17IqbnnOAMkRQq/IF/c6m+mEekXPquil78RLHBTRL/O5Qf/I++8fW7i7tJ7Cxil
         MZ8xMuWtgqI9Nu9t/86lct0CgOor0nZTp28LMTxZAYWZHIn7VUnALp5r85vnUZcWRnoN
         gUAvOUs00lfF87BEZq4N9QYKdOcvGlc3juOj6GdvV9MiLYAEvmhHT8vE/kGfFQPrxKhq
         JBioLBz2ubR2n1Q7jap1LvAWJOojlzUkS2dpEIguMjaICaabtViAECnHumH1OcE1avSP
         FFEEtxA1AHV9CSW9EFrzXr0Nr/gCA6Uu25E/RsoR6ct0ISQLSV4HmU1u0p+KnHvNgWyl
         jsJA==
X-Gm-Message-State: AOAM531Ao3chnjoBCFpgse6RJ3eLd6+tEeWaAKE3a+KABszOZrroSLiA
        ca2CLW0NwaTXVqTuxB7VSaUVTDc9/ZzlD0VQh3p2XT7k09DjZb5KyDejxe63h7nZ/n45nYeXITY
        Z8+Wco8IRKu8RAwDCNzbHjlOgwVEjt8qJ4JWJyEqrIsSifChY0ha8Vdu6/MFwJhz5Nbbp9w==
X-Received: by 2002:a05:6402:1103:: with SMTP id u3mr5423031edv.205.1616519318604;
        Tue, 23 Mar 2021 10:08:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK7fS5ZZcWmSFE+SY0WZbpcdZMSF9nK5k1dO2OuLPqNIbwSkm/JfWXtOv8liaCaylS4JBtGw==
X-Received: by 2002:a05:6402:1103:: with SMTP id u3mr5423000edv.205.1616519318309;
        Tue, 23 Mar 2021 10:08:38 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k9sm13337948edn.68.2021.03.23.10.08.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:08:37 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 6/6] setfiles/restorecon: support parallel relabeling
Date:   Tue, 23 Mar 2021 18:08:30 +0100
Message-Id: <20210323170830.182553-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323170830.182553-1-omosnace@redhat.com>
References: <20210323170830.182553-1-omosnace@redhat.com>
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
$ time restorecon -rn /usr/src

real    0m23,580s
user    0m22,681s
sys     0m0,707s

WITH PATCHES:
$ time restorecon -rn -T 1 /usr/src

real    0m23,493s
user    0m22,637s
sys     0m0,668s
$ time restorecon -rn -T 2 /usr/src

real    0m13,438s
user    0m25,536s
sys     0m0,946s
$ time restorecon -rn -T 8 /usr/src

real    0m5,476s
user    0m38,440s
sys     0m3,016s
$ time restorecon -rn -T 16 /usr/src

real    0m3,868s
user    0m51,292s
sys     0m5,289s
$ time restorecon -rn -T 32 /usr/src

real    0m2,817s
user    1m0,317s
sys     0m6,157s

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
index a3bbbe11..82de8f2a 100644
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
2.30.2

