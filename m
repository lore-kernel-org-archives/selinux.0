Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988374;
	b=lFvy8DJYYvNSJuNhBvAFSYepY31iP0K/3C3QwFCM/YjiBK97JhchLqvO/azaOKvgqsGa
	 biRlsKQj//1yDd2c82bm2iOQow2ioLJ/AY/SpDUiymTbfqpl7KHszYg8BDZGVUUQiX0qa
	 YcZAo7tS9KNyLCCxCy2poWJaWRV3fy5OrMrHBFTfoEBJklhXy+XhcGkTo2Tx3TOGhvkpC
	 8Af6jOhZWO1ohW3YJbIrNeFFvpCe8cQ7JIIrgPw51uhKjaDSlIFQIXgIhIsHxgNmmlnRO
	 GA4/1tt0ioUltXm3X29s854vOjDoDShFG7HkaZyg5Yl3pffiUTPGvhRyl4Nd/01vdOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xDz6hp9VqSwCRCaMQ/abeIYOvRBohCBECCa8zdGCUzM=;
	b=kgCPuzWq8jP1AkvanUcZ0sXrtyWIn1wrxZNEqYmlRzbJUWdfqFNEvO4JnSNBDIJ/dOF1
	 aUiLZzXnuQpbdj+6oacAHa8FjuG836Z2d+SOOdRJ/hVc+LPvXdaHV7WLjAj5OBuNEZ6NG
	 fNwbMag5hwnGW+Z5UNuEG6dIu8iIUKY6SEUtTfOFl4rMJ+Nqo+v5pX8sD+gbEX6gc24QG
	 e+q7pbe+2r0KcSqhlxIfnaMa6KluOTl2+Fexker2Kk6g9CfdqiDJwUDF+qowVgyvs9ovn
	 cGIr7uXXR+Oz7UhxcVB5TdLJVLTM3yMtM6WDznYPlUSaTXK4qfFnZmnq0wPcDvRU0bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbZ0EawL;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC84606A32C
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC84606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbZ0EawL
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53653e30353so11216501cf.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988373; x=1794593173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xDz6hp9VqSwCRCaMQ/abeIYOvRBohCBECCa8zdGCUzM=;
        b=gbZ0EawLTRzAYK+UfX8JWYzHanDUVEc6mIxxWtfy5fGeedKzWHmAZd0iN7r/hVDJD6
         Q9gki3KbOis5u93gf3eon3704kShGMb0AxkU9enlO7e7iRpkEv4XTbuLwLp42pyXk8Lp
         9muXdTGyT+x7Ygzd08QB4Rsyu1OqzFHEyfasgGXG3OTIft9Af3jVFefuLlp/7g+WUZYN
         B0ZeYNvh/PfmG9m98VDUXOoF99yTuQEEtcDrZYngMS/6Au9yMPclPqLMM+XHenbOkmny
         a++3FFhIxrtdPP943/Mg7tNZBhBKx16eEo6vp6/fUrMoze5EfjsoG05mlxdUorZxEixZ
         a5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988373; x=1794593173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDz6hp9VqSwCRCaMQ/abeIYOvRBohCBECCa8zdGCUzM=;
        b=K+cFGej5bSM0b/PHZsLASlGPZekVYnmU15x3B2vn9xbuDhqI91K4BZnm3eSEnZTzTO
         QA78Svh3CZ2hsPRyQeD4EdMsnI0cWEM66G7Fva4scXbOnHcAdQGKdPyy+IRqkrZH9wi6
         1/EV+uDEtG5dD9P9gQTmhmo7RwuxxQB27SQeqRuhl0El1dj8pQsgAlNhuEfZu9nwOmzY
         6MeOGCcsfFmPi7OXVS0MpOo63CQjXhSggJvDLAdCbhWkKcLwzRCG0e6TqEpnicYd4M+d
         CUDS5NPAEGWUfD4k+EnxcppDM9srLtiy2opgbZqZNtPqY73AsA/cLDZijCBKVYInX+Aw
         TBdA==
X-Gm-Message-State: APuU4Z+UgetBpxl1EDu/y22wFw/L1873edDCMr5P0Vpz1eDKJk3cEA0w
	sI5UR1hd1QvdjPoF7mER5JceLAhZ8SWI/rGIzLKxPPdU3KK4dIbL92R0cJChZKLK
X-Gm-Gg: AYBFou14nZ3Q4iz3+FfNaf8+0PDvt5nBq09G77a3VdpM2kP+KQT6k8FedZMcI0YSAsq
	7rKuJLaANGRpyXMh+mO2SuIVgYUMe8AFPbNOPZvTMTASLP5pFHHG5qRe93X6UFuJt3tO5gjwWw8
	1FJp8SARgnGmKMocpjY0SptEvMzoMpDyUjNMp5GklU2/ocse6KQLh6Kl1mGb1Wull+J76sch7OZ
	zDNdv0SIQXlD3pi6288AXC56Htrm/mByaChxZ4taguWj5KDMXXZYDXKapQYHm8IoWajxQyJ8O4B
	CE/eaM2wRqciv7Ibi3dmaaxFoB57jSr+Cy91LCsCNqTAs4HrOChJxZNpOelqYN5FNHhROWXrdBc
	UUfYlvO7/QubMnmL3nQ4RsfiaQMKeREv9qRNEv7Xu9J6YXACKTONfmXNdjvt9MxAHQbb/TyP6dt
	NKqdJ3BbW6MTab5ZW04R+i/WWp7/zdyJZQvwf141avg7UCg6BcXnQAjNpvh3bxUWGaL3zEy57G5
	YjDbXTV3eivcBiJc5kjE58MO5uCfLTD9yhGHmjDiLrAkAKr2QW6F3KlpJJNEzIDyi5TLCO7TxAR
	EKe+1wubaH+akbV/eAy516+Ke2J4ZyXgQKa5ftI0z9AboMceyzPTa81krWjy346mMjGNe1C/39z
	et43zdlVmSupcvGqgIoJQtyLrIVrvvscANktnSAD6SFt+qJ/8xofV3MYJRRhFWd7qriS88YGrVX
	4p4oNZH5VZ99PStl9X0xlehYcQFz+e8MTp6ZE3PrR6lDSDzxjQwoc=
X-Received: by 2002:a05:622a:c88:b0:531:164:fa73 with SMTP id d75a77b69052e-54e14369565mr50959931cf.32.1793988372653;
        Fri, 06 Nov 2026 10:06:12 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26259cf0sm25893461cf.15.2026.11.06.10.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:06:11 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/4] libsemanage: reject missing scalar configuration arguments
Date: Fri,  6 Nov 2026 13:05:53 -0500
Message-ID: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The configuration scanner returns a NULL ARG for empty and quoted-empty
values, as well as on token allocation failure. Scalar actions pass this
pointer to strcasecmp, strtol or strdup. In particular, the recently added
sort-local-fcontexts option crashes instead of rejecting an empty value.

Add a shared scalar argument production that rejects NULL before entering
these actions. Preserve empty external-program arguments, which have a
different contract. This also covers older scalar options with the same
problem.

Add 114 regression checks for scalar rejection, valid values, parser reuse,
empty external arguments and token allocation failure.

Fixes: ee7e4e1e4e97 ("libsemanage: optionally sort file_contexts.local by specificity")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/conf-parse.y                  |  54 ++++----
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |   9 +-
 .../tests/regression/test_config_empty.c      | 124 ++++++++++++++++++
 4 files changed, 164 insertions(+), 24 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_config_empty.c

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 1611f4a6..61b07310 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -69,6 +69,7 @@ static int parse_errors;
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
+%type <s> scalar_arg
 %type <d> verify_start_tok
 
 %%
@@ -106,7 +107,16 @@ single_opt:     module_store
         |       sort_local_fcontexts
         ;
 
-module_store:   MODULE_STORE '=' ARG {
+scalar_arg: ARG {
+                        if ($1 == NULL) {
+                                yyerror("missing option value or out of memory");
+                                YYABORT;
+                        }
+                        $$ = $1;
+                }
+        ;
+
+module_store:   MODULE_STORE '=' scalar_arg {
                         if (parse_module_store($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -116,7 +126,7 @@ module_store:   MODULE_STORE '=' ARG {
 
         ;
 
-store_root:     STORE_ROOT '=' ARG  {
+store_root:     STORE_ROOT '=' scalar_arg  {
                         if (parse_store_root_path($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -125,7 +135,7 @@ store_root:     STORE_ROOT '=' ARG  {
                 }
         ;
 
-ro_store_root:  RO_STORE_ROOT '=' ARG  {
+ro_store_root:  RO_STORE_ROOT '=' scalar_arg  {
                         if (parse_ro_store_root_paths($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -134,7 +144,7 @@ ro_store_root:  RO_STORE_ROOT '=' ARG  {
                 }
         ;
 
-compiler_dir:       COMPILER_DIR '=' ARG  {
+compiler_dir:       COMPILER_DIR '=' scalar_arg  {
                         if (parse_compiler_path($3) != 0) {
                                 parse_errors++;
                                 YYABORT;
@@ -143,7 +153,7 @@ compiler_dir:       COMPILER_DIR '=' ARG  {
                 }
         ;
 
-ignore_module_cache:	IGNORE_MODULE_CACHE '=' ARG  {
+ignore_module_cache:	IGNORE_MODULE_CACHE '=' scalar_arg  {
 							if (strcasecmp($3, "true") == 0)
 								current_conf->ignore_module_cache = true;
 							else if (strcasecmp($3, "false") == 0)
@@ -155,7 +165,7 @@ ignore_module_cache:	IGNORE_MODULE_CACHE '=' ARG  {
 						}
         ;
 
-version:        VERSION '=' ARG  {
+version:        VERSION '=' scalar_arg  {
                         char *endptr;
                         long value;
                         errno = 0;
@@ -168,7 +178,7 @@ version:        VERSION '=' ARG  {
                 }
         ;
 
-target_platform: TARGET_PLATFORM '=' ARG  {
+target_platform: TARGET_PLATFORM '=' scalar_arg  {
                         if (strcasecmp($3, "selinux") == 0)
                                 current_conf->target_platform = SEPOL_TARGET_SELINUX;
                         else if (strcasecmp($3, "xen") == 0)
@@ -180,7 +190,7 @@ target_platform: TARGET_PLATFORM '=' ARG  {
                 }
         ;
 
-expand_check:   EXPAND_CHECK '=' ARG  {
+expand_check:   EXPAND_CHECK '=' scalar_arg  {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->expand_check = true;
 			else if (strcmp($3, "1") == 0)
@@ -196,7 +206,7 @@ expand_check:   EXPAND_CHECK '=' ARG  {
                 }
         ;
 
-file_mode:   FILE_MODE '=' ARG  {
+file_mode:   FILE_MODE '=' scalar_arg  {
                         char *endptr;
                         long value;
                         errno = 0;
@@ -209,7 +219,7 @@ file_mode:   FILE_MODE '=' ARG  {
                 }
         ;
 
-save_previous:    SAVE_PREVIOUS '=' ARG {
+save_previous:    SAVE_PREVIOUS '=' scalar_arg {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->save_previous = true;
 			else if (strcasecmp($3, "false") == 0)
@@ -222,7 +232,7 @@ save_previous:    SAVE_PREVIOUS '=' ARG {
         ;
 
 
-save_linked:    SAVE_LINKED '=' ARG {
+save_linked:    SAVE_LINKED '=' scalar_arg {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->save_linked = true;
 			else if (strcasecmp($3, "false") == 0)
@@ -234,7 +244,7 @@ save_linked:    SAVE_LINKED '=' ARG {
                 }
         ;
 
-disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
+disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->disable_genhomedircon = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -245,7 +255,7 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
 	free($3);
  }
 
-usepasswd: USEPASSWD '=' ARG {
+usepasswd: USEPASSWD '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->usepasswd = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -256,12 +266,12 @@ usepasswd: USEPASSWD '=' ARG {
 	free($3);
  }
 
-ignoredirs: IGNOREDIRS '=' ARG {
+ignoredirs: IGNOREDIRS '=' scalar_arg {
 	current_conf->ignoredirs = strdup($3);
 	free($3);
  }
 
-handle_unknown: HANDLE_UNKNOWN '=' ARG {
+handle_unknown: HANDLE_UNKNOWN '=' scalar_arg {
 	if (strcasecmp($3, "deny") == 0) {
 		current_conf->handle_unknown = SEPOL_DENY_UNKNOWN;
 	} else if (strcasecmp($3, "reject") == 0) {
@@ -274,7 +284,7 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
 	free($3);
  }
 
-bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
+bzip_blocksize:  BZIP_BLOCKSIZE '=' scalar_arg {
 	char *endptr;
 	long value;
 	errno = 0;
@@ -286,7 +296,7 @@ bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
 	free($3);
 }
 
-bzip_small:  BZIP_SMALL '=' ARG {
+bzip_small:  BZIP_SMALL '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->bzip_small = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -297,7 +307,7 @@ bzip_small:  BZIP_SMALL '=' ARG {
 	free($3);
 }
 
-remove_hll:  REMOVE_HLL'=' ARG {
+remove_hll:  REMOVE_HLL'=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->remove_hll = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -308,7 +318,7 @@ remove_hll:  REMOVE_HLL'=' ARG {
 	free($3);
 }
 
-relabel_store:  RELABEL_STORE'=' ARG {
+relabel_store:  RELABEL_STORE'=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->relabel_store = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -319,7 +329,7 @@ relabel_store:  RELABEL_STORE'=' ARG {
 	free($3);
 }
 
-optimize_policy:  OPTIMIZE_POLICY '=' ARG {
+optimize_policy:  OPTIMIZE_POLICY '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->optimize_policy = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -330,7 +340,7 @@ optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 	free($3);
 }
 
-multiple_decls:  MULTIPLE_DECLS '=' ARG {
+multiple_decls:  MULTIPLE_DECLS '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->multiple_decls = false;
 	} else if (strcasecmp($3, "true") == 0) {
@@ -341,7 +351,7 @@ multiple_decls:  MULTIPLE_DECLS '=' ARG {
 	free($3);
 }
 
-sort_local_fcontexts: SORT_LOCAL_FCONTEXTS '=' ARG {
+sort_local_fcontexts: SORT_LOCAL_FCONTEXTS '=' scalar_arg {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->sort_local_fcontexts = false;
 	} else if (strcasecmp($3, "true") == 0) {
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 8a2a866a..47f2f45d 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,2 +1,3 @@
 libsemanage-tests
 *.policy
+/test-config-empty
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 241ff17a..2162a5e3 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -12,7 +12,7 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES)
+all: $(EXECUTABLE) $(POLICIES) test-config-empty
 
 $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
@@ -21,8 +21,13 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) test-config-empty
 
 test: all
 	./$(EXECUTABLE)
+	./test-config-empty
+
+
+test-config-empty: regression/test_config_empty.c ../src/libsemanage.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=strdup $(LDLIBS)
 
diff --git a/libsemanage/tests/regression/test_config_empty.c b/libsemanage/tests/regression/test_config_empty.c
new file mode 100644
index 00000000..9936f37d
--- /dev/null
+++ b/libsemanage/tests/regression/test_config_empty.c
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sepol/policydb.h>
+#include "semanage_conf.h"
+
+static bool fail_token;
+static unsigned failures;
+
+char *__real_strdup(const char *s);
+char *__wrap_strdup(const char *s);
+
+char *__wrap_strdup(const char *s)
+{
+	if (fail_token && !strcmp(s, "true")) {
+		failures++;
+		errno = ENOMEM;
+		return NULL;
+	}
+	return __real_strdup(s);
+}
+
+static semanage_conf_t *parse(const char *text)
+{
+	char path[] = "/tmp/semanage-config-XXXXXX";
+	int fd = mkstemp(path);
+	assert(fd >= 0);
+	FILE *fp = fdopen(fd, "w");
+	assert(fp);
+	assert(fputs(text, fp) >= 0);
+	assert(fclose(fp) == 0);
+	semanage_conf_t *conf = semanage_conf_parse(path);
+	assert(unlink(path) == 0);
+	return conf;
+}
+
+int main(void)
+{
+	const char *keys[] = { "module-store",	      "store-root",
+			       "ro-store-root",	      "compiler-directory",
+			       "ignore-module-cache", "policy-version",
+			       "target-platform",     "expand-check",
+			       "file-mode",	      "save-previous",
+			       "save-linked",	      "disable-genhomedircon",
+			       "usepasswd",	      "ignoredirs",
+			       "handle-unknown",      "bzip-blocksize",
+			       "bzip-small",	      "remove-hll",
+			       "relabel_store",	      "optimize-policy",
+			       "multiple-decls",      "sort-local-fcontexts" };
+	const char *values[] = { "", "\"\"" };
+	char version[32];
+	snprintf(version, sizeof(version), "%d", sepol_policy_kern_vers_max());
+	const char *valid[] = { "direct",
+				"/var/lib/selinux",
+				"/usr/lib/selinux",
+				"/usr/libexec/selinux/hll",
+				"true",
+				version,
+				"selinux",
+				"true",
+				"0644",
+				"true",
+				"true",
+				"true",
+				"true",
+				"/home",
+				"deny",
+				"9",
+				"true",
+				"true",
+				"true",
+				"true",
+				"true",
+				"true" };
+	assert(sizeof(valid) / sizeof(valid[0]) ==
+	       sizeof(keys) / sizeof(keys[0]));
+	unsigned cases = 0;
+	for (size_t i = 0; i < sizeof(keys) / sizeof(keys[0]); i++) {
+		for (size_t j = 0; j < sizeof(values) / sizeof(values[0]);
+		     j++) {
+			char text[256];
+			snprintf(text, sizeof(text), "%s = %s\n", keys[i],
+				 values[j]);
+			assert(parse(text) == NULL);
+			semanage_conf_t *conf =
+				parse("sort-local-fcontexts = true\n");
+			assert(conf && conf->sort_local_fcontexts);
+			semanage_conf_destroy(conf);
+			cases += 2;
+		}
+		char text[256];
+		snprintf(text, sizeof(text), "%s = %s\n", keys[i], valid[i]);
+		semanage_conf_t *conf = parse(text);
+		assert(conf);
+		semanage_conf_destroy(conf);
+		cases++;
+	}
+	for (size_t j = 0; j < sizeof(values) / sizeof(values[0]); j++) {
+		char text[256];
+		snprintf(text, sizeof(text),
+			 "[load_policy]\npath = /bin/true\nargs = %s\n[end]\n",
+			 values[j]);
+		semanage_conf_t *conf = parse(text);
+		assert(conf && conf->load_policy &&
+		       conf->load_policy->args == NULL);
+		semanage_conf_destroy(conf);
+		cases++;
+	}
+	fail_token = true;
+	assert(parse("sort-local-fcontexts = true\n") == NULL);
+	assert(failures == 1);
+	fail_token = false;
+	semanage_conf_t *conf = parse("sort-local-fcontexts = false\n");
+	assert(conf && !conf->sort_local_fcontexts);
+	semanage_conf_destroy(conf);
+	printf("Configuration scalar arguments: %u cases passed.\n", cases + 2);
+	return 0;
+}
-- 
2.56.0

