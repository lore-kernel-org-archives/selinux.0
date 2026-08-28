Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890A3DAAD2
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919540; cv=none; b=WqeZFOPhDZDm84R8bsLTsA9EpXdcmy3/cx9MT8eH8rgwgZPd+XLqYHqhe7fUbr32yIRp8Ic8RKO0LrSX+NgKCyi6VpILJ5HFGpthykv8+HUV2B+f2F7KQHWKOhfYKWF6XczSXtOnIGVg+J8fang/9mGHQsu0bBY/OoBZfbVndDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919540; c=relaxed/simple;
	bh=b5qIDG57xXtVdw7KmWeteHMvtY3CrlKGbjCEInfb+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZcM6fXWQtCz8VpA061ern3N2ub4IyYaFtlnGlc0W1ExwFnxyZVIMtKa1mbfRt32tAbfDp9k3ObdQW0yplUDf1VKj1qoj7jXZrKEql2FlBxzv+7bSB50uAG0qQx1tjuVEAsDtnxFEoMZBgc+5VPMajDJ+CusZYKSHoe1l4AInc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOtickE6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOtickE6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52b3934af3fso11151381cf.1
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919521; x=1788524321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14p9vKRdNyFtaj8W9Dl8TB0s0i9FTq1mFU3PN03DH7U=;
        b=eOtickE6nR2uEbx0Yqz3y7g0T/69EjKWatRgZ4SWa+7vBLsZKi9Qx0H8Yma7hMDmWI
         IB0X0SMK7lfr3HyB/IBN1segE1TuxoJmo6pe0h/8dlwzY9hWnRDE0yAzkG6YVXagkrgK
         G+rM+ELIgNLcc6Fg16BisK9jshVGoAy6XhSztAH7tUpD9tptZ76tSYWsj0HLthSXKCFZ
         4thzTFoqJljy29o6tXBl73hzd20FxhLiSFrjRQDRUJojZrN54896cznx7UEnFmD/4LIs
         YKe71zCgsY02ckmYmfMorMQvGPpmjQbQTqqtm41LGEPTFJq/ePyzgsWRt6nnbDhO/EhX
         Pe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919521; x=1788524321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14p9vKRdNyFtaj8W9Dl8TB0s0i9FTq1mFU3PN03DH7U=;
        b=NlbeH9nvBvIk2eGrnjbhYEBZuSuhAx8dj0r3mJg+FPbxnxFzs0yvYREckzTiTVPHWK
         wmrkDvHJzT3WeZs3X82YtRKCHjxwYARpvp8fqGaRc7ludlFCP0oaT5YEowp30w9BYrSF
         +EEmUKkCjVDiM1dZqlVZOzjF4Z4Smu//Rdt7z11/sA5I2oJswmw7dLrY+C5u4xNBT6Cs
         Bq3M4VSA+WKkDLZJEzcR3kXRF8feiiJ7X44z3z4nAia75jwDQsnnDTI5PKoowFzEP+A/
         YDFc5XwDHHrC6hI6aPtsif5s3mcFWPVLFW0Zw8VKyPLCmSFWm1uUOrB0WHq8U1shaLxz
         L+4g==
X-Gm-Message-State: AFuF++nyJHjpl6ExpuH+3nIDUN/HCCuEdW86R9+UKAWPT2029b4ODbhN
	kBKePduutO77PhoqXh6C3U92DsB9NsADYusyXdt+5+bV5jVV8dYUk2HRPFbHdA==
X-Gm-Gg: AR+sD13sg0GIbVSEYSknGH6q7DQbYBCjxMdzb36mU93ZWi5y24TxeN2e+BkVixzEb6m
	DHN+YW/lR6oLmX32sQA5YYPrFfVLBLiMdi/j0cD+Tsdn+rvCskvk4HM1EOfwlPuuzyJqD1knjm+
	9MxUUpO8N3aAm/VRembWP3P20Mz3N5YuaJBcSnipxppJ3QziaysB6r/9Jf7mzffSqoq4Iq/1AjP
	wWla4zXDnOjuqACvfFY+/29D6qel4IDXxusu8awxKHX/RPzpv9vsV8Lye50R+419NHbhIgZfVLO
	qKOieTMPK0etICSgvvGmqoqwwqcIsB34D9jWXyP05+qr8WvYEnp54wH1c1H2KURcsq3yvOyp0fq
	XrF83bWKbiAkUO+lF/gmBhLqmlu0zKy3W7mXmDVwOswIWO8TUQ/11hZArGQNfZyetKQz2QeHw9D
	SAxJL23dliMLi7S6Ly8iuXiQ4oa0r9jydEmw5Jf9jO6RisVmQSgzbnq0Rd8I4lZmrsq+PreZB9H
	d74rdH/e9rBV3Tg7VwNQjzzZzUg8AuCbkmi64sjUqcFSHViDheQ4LRAV4pbafvC
X-Received: by 2002:a05:622a:e14f:10b0:52f:e60e:70ca with SMTP id d75a77b69052e-52fe60e75b0mr13585471cf.29.1787919520204;
        Fri, 28 Aug 2026 05:18:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444e58fsm13929726d6.8.2026.08.28.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:18:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	nicolas.iooss@m4x.org,
	cgzones@googlemail.com,
	paul@paul-moore.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5] FUZZING.md,*/fuzz: document selinux fuzzing
Date: Fri, 28 Aug 2026 08:15:44 -0400
Message-ID: <20260828121543.32469-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the use of OSS-Fuzz and CIFuzz by the selinux userspace
project and provide some instructions and scaffolding for debugging
fuzzing failures.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v5 drops one more residual lingering cruft, gets rid of some trailing
empty lines, and updates the FUZZING.md build instructions to note
that one should always do a 'make clean all' first to clean any
prior builds (especially if scripts/oss-fuzz.sh was run to get
rid of the sanitizer artifacts) and build the base set of
components leveraged by the make fuzz target.

 FUZZING.md                                    | 85 +++++++++++++++++++
 checkpolicy/Makefile                          |  3 +
 checkpolicy/fuzz/.gitignore                   |  1 +
 checkpolicy/fuzz/Makefile                     | 38 +++++++++
 checkpolicy/fuzz/checkpolicy-fuzzer.c         | 53 ++++++++++++
 libselinux/Makefile                           |  3 +
 libselinux/fuzz/.gitignore                    |  2 +
 libselinux/fuzz/Makefile                      | 31 +++++++
 .../fuzz/selabel_file_compiled-fuzzer.c       | 47 ++++++++++
 libselinux/fuzz/selabel_file_text-fuzzer.c    | 81 ++++++++++++++++++
 libsepol/Makefile                             |  3 +
 libsepol/fuzz/.gitignore                      |  3 +
 libsepol/fuzz/Makefile                        | 24 ++++++
 libsepol/fuzz/binpolicy-fuzzer.c              | 39 +++++++++
 libsepol/fuzz/module-package-fuzzer.c         | 39 +++++++++
 libsepol/fuzz/secilc-fuzzer.c                 | 45 ++++++++++
 16 files changed, 497 insertions(+)
 create mode 100644 FUZZING.md
 create mode 100644 checkpolicy/fuzz/.gitignore
 create mode 100644 checkpolicy/fuzz/Makefile
 create mode 100644 libselinux/fuzz/.gitignore
 create mode 100644 libselinux/fuzz/Makefile
 create mode 100644 libsepol/fuzz/.gitignore
 create mode 100644 libsepol/fuzz/Makefile

diff --git a/FUZZING.md b/FUZZING.md
new file mode 100644
index 00000000..1f0ebbfb
--- /dev/null
+++ b/FUZZING.md
@@ -0,0 +1,85 @@
+Fuzzing of the SELinux userspace
+================================
+
+OSS-Fuzz
+--------
+
+Portions of the SELinux userspace are regularly fuzzed by OSS-Fuzz based
+on the configuration at:
+https://github.com/google/oss-fuzz/blob/master/projects/selinux/project.yaml
+
+The fuzzers can be found under the fuzz subdirectories of various
+directories within the selinux repository, and can be built using the
+./scripts/oss-fuzz.sh script. OSS-Fuzz itself uses this script to
+build the fuzzers.
+
+See
+https://issues.oss-fuzz.com/issues?q=project:selinux
+for public OSS-Fuzz selinux issues. OSS-Fuzz automatically makes
+issues public once they are verified to be fixed or after a 90 day
+disclosure window. Issues are initially created private and
+sent via email to those listed in the configuration above.
+
+Not all issues will be fixed by the upstream SELinux project, e.g.
+small memory leaks on error paths for checkpolicy are not viewed as
+worth fixing since checkpolicy will exit shortly thereafter, and OSS
+Fuzz will create issues if it encounters a timeout during fuzzing even
+though the fuzzer would have completed if given more time.
+
+Items categorized as a vulnerability by OSS-Fuzz will not always be
+treated as security issues by the upstream SELinux project; in
+particular, issues that depend on attacker-controlled policy are not
+considered to be security issues and will just be handled as regular
+bugs. See
+[SECURITY.md](https://github.com/SELinuxProject/selinux/blob/main/SECURITY.md)
+for more information on the SELinux userspace security vulnerability
+handling process.
+
+CIFuzz
+------
+
+The selinux GitHub CI Actions include a CIFuzz workflow based on the
+configuration at:
+https://github.com/SELinuxProject/selinux/blob/main/.github/workflows/cifuzz.yml
+
+This action is invoked for pushes and pull requests targeting the main
+branch of the SELinuxProject/selinux repository to help detect
+regressions on new commits.
+
+The status of CIFuzz workflow runs can be viewed at:
+https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml
+as well as in the check status for each push or pull request and
+displayed in the banner at the top of the
+[README.md](https://github.com/SELinuxProject/selinux/blob/main/README.md)
+file.
+
+Debugging Fuzzing Failures
+--------------------------
+
+OSS-Fuzz provides a detailed report and, when possible, a reproducer
+testcase. If the cause cannot be determined from the report, the
+reproducer testcase can be downloaded locally, the fuzzer can be built
+using ./scripts/oss-fuzz.sh, and the fuzzer can be manually run on the
+reproducer testcase input.
+
+The fuzzers are built without debugging information and with verbose
+logging disabled when built using oss-fuzz.sh. You can recompile them
+with debugging, logging, and a trivial main() function as follows:
+
+    make clean all
+    make -C libsepol fuzz
+    make -C checkpolicy fuzz
+    make -C libselinux fuzz
+
+These build into the fuzz/ directories and do not touch any object
+files or archives used by the normal build.
+
+In some cases, it may be helpful to run one of the selinux userspace
+programs on the fuzzer input directly, potentially under gdb or
+valgrind, to better understand the issue and whether it is applicable
+to any production tool. This can be done when the fuzzer input is
+accepted directly as input to one of the selinux userspace programs,
+such as a CIL policy file to secilc or a binary policy file to
+checkpolicy -b. In other cases you may need to split the fuzzer input
+into its parts and only feed one portion to a program like checkpolicy
+or selabel_lookup.
diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index e59ad63a..b5a32e41 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -58,6 +58,9 @@ test: checkpolicy checkmodule
 # helper target for fuzzing
 checkobjects: $(CHECKOBJS)
 
+fuzz: all
+	$(MAKE) -C fuzz
+
 install: all
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(MANDIR)/man8
diff --git a/checkpolicy/fuzz/.gitignore b/checkpolicy/fuzz/.gitignore
new file mode 100644
index 00000000..f9ba626f
--- /dev/null
+++ b/checkpolicy/fuzz/.gitignore
@@ -0,0 +1 @@
+checkpolicy-fuzzer
diff --git a/checkpolicy/fuzz/Makefile b/checkpolicy/fuzz/Makefile
new file mode 100644
index 00000000..a7f619d0
--- /dev/null
+++ b/checkpolicy/fuzz/Makefile
@@ -0,0 +1,38 @@
+# Build the checkpolicy fuzzer as a standalone debug binary.
+# oss-fuzz.sh handles the sanitizer/libFuzzer build; this Makefile
+# only produces a plain binary suitable for gdb/valgrind on a single
+# reproducer input.
+
+CHECKPOLICY := ..
+LIBSEPOLA ?= ../../libsepol/src/libsepol.a
+CFLAGS ?= -g -O0 -Wall
+override CFLAGS += -I$(CHECKPOLICY) -I../../libsepol/include -D_GNU_SOURCE \
+	-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -DDEFINEMAIN -DVERBOSE=1
+
+# Parser objects - same set as $(CHECKOBJS) in ../Makefile, built
+# locally with the fuzzing defines so module_compiler_reset() and the
+# lexer's non-exit error paths are compiled in.
+CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
+	    policy_define.o
+
+vpath %.c $(CHECKPOLICY)
+
+all: checkpolicy-fuzzer
+
+checkpolicy-fuzzer: checkpolicy-fuzzer.o $(CHECKOBJS) $(LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^
+
+# Ensure the generated parser/lexer sources exist in the parent dir.
+$(CHECKPOLICY)/y.tab.c $(CHECKPOLICY)/y.tab.h $(CHECKPOLICY)/lex.yy.c:
+	$(MAKE) -C $(CHECKPOLICY) $(@F)
+
+y.tab.o: $(CHECKPOLICY)/y.tab.c $(CHECKPOLICY)/y.tab.h
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
+
+lex.yy.o: $(CHECKPOLICY)/lex.yy.c $(CHECKPOLICY)/y.tab.h
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
+
+clean:
+	rm -f checkpolicy-fuzzer *.o
+
+.PHONY: all clean
diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 401f24e3..a7e245c4 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -33,7 +33,9 @@ extern int yylex_destroy(void);
 jmp_buf fuzzing_pre_parse_stack_state;
 
 // Set to 1 for verbose libsepol logging
+#ifndef VERBOSE
 #define VERBOSE 0
+#endif
 
 static ssize_t full_write(int fd, const void *buf, size_t count)
 {
@@ -163,9 +165,15 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	switch (data[0]) {
 	case 'S':
 		platform = SEPOL_TARGET_SELINUX;
+#if VERBOSE
+		printf("target: SELinux\n");
+#endif
 		break;
 	case 'X':
 		platform = SEPOL_TARGET_XEN;
+#if VERBOSE
+		printf("target: Xen\n");
+#endif
 		break;
 	default:
 		return 0;
@@ -173,9 +181,15 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	switch (data[1]) {
 	case '0':
 		mls = 0;
+#if VERBOSE
+		printf("MLS-disabled\n");
+#endif
 		break;
 	case '1':
 		mls = 1;
+#if VERBOSE
+		printf("MLS-enabled\n");
+#endif
 		break;
 	default:
 		return 0;
@@ -190,6 +204,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	    policyvers != POLICYDB_VERSION_XEN_DEVICETREE &&
 	    policyvers != POLICYDB_VERSION_BOUNDARY)
 		return 0;
+#if VERBOSE
+	printf("policyvers=%d\n", policyvers);
+#endif
 	data += 3;
 	size -= 3;
 
@@ -286,3 +303,39 @@ exit:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEFINEMAIN
+#include <sys/stat.h>
+
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s fuzzer-input-file\n", argv[0]);
+		exit(1);
+	}
+
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
+#endif
diff --git a/libselinux/Makefile b/libselinux/Makefile
index aeede2b5..2ba414d1 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -55,6 +55,9 @@ all install relabel clean distclean:
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
 
+fuzz: all
+	$(MAKE) -C fuzz
+
 swigify: all
 	$(MAKE) -C src $@
 
diff --git a/libselinux/fuzz/.gitignore b/libselinux/fuzz/.gitignore
new file mode 100644
index 00000000..d3bf28ca
--- /dev/null
+++ b/libselinux/fuzz/.gitignore
@@ -0,0 +1,2 @@
+selabel_file_text-fuzzer
+selabel_file_compiled-fuzzer
diff --git a/libselinux/fuzz/Makefile b/libselinux/fuzz/Makefile
new file mode 100644
index 00000000..5410c487
--- /dev/null
+++ b/libselinux/fuzz/Makefile
@@ -0,0 +1,31 @@
+# Build the libselinux fuzzers as standalone debug binaries.
+# oss-fuzz.sh handles the sanitizer/libFuzzer build; this Makefile
+# only produces plain binaries suitable for gdb/valgrind on a single
+# reproducer input.
+TARGETS := selabel_file_text-fuzzer selabel_file_compiled-fuzzer
+
+LIBSELINUXA := ../src/libselinux.a
+
+PCRE_CFLAGS ?= -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8
+PCRE_LDLIBS ?= -lpcre2-8
+
+CFLAGS ?= -g -O0 -Wall
+override CFLAGS += -I../include -I../src -D_GNU_SOURCE -DNO_ANDROID_BACKEND \
+	$(PCRE_CFLAGS) -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION \
+	-DDEFINEMAIN -DVERBOSE=1
+
+all: $(TARGETS)
+
+# Only label_file.o changes behavior under
+# FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION. Compile a private copy
+# of it here and link the rest from the normally-built ../src/libselinux.a.
+label_file.o: ../src/label_file.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
+
+$(TARGETS): %: %.o label_file.o $(LIBSELINUXA)
+	$(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS)
+
+clean:
+	rm -f $(TARGETS) *.o
+
+.PHONY: all clean
diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
index 8466fed8..ea9c10c6 100644
--- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
@@ -15,12 +15,18 @@ extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 #define CTRL_FIND_ALL (1U << 1)
 #define CTRL_MODE (1U << 2)
 
+#ifndef VERBOSE
+#define VERBOSE 0
+#endif
+
+#if !VERBOSE
 __attribute__((format(printf, 2, 3))) static int
 null_log(int type __attribute__((unused)),
 	 const char *fmt __attribute__((unused)), ...)
 {
 	return 0;
 }
+#endif
 
 static int validate_context(char **ctxp)
 {
@@ -120,6 +126,11 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	/* S_IFSOCK has the highest integer value */
 	mode = (control & CTRL_MODE) ? S_IFSOCK : 0;
 
+#if VERBOSE
+	printf("partial=%s, find_all=%s, mode=%s\n", partial ? "true" : "false",
+	       find_all ? "true" : "false", mode ? "true" : "false");
+#endif
+
 	/*
 	 * Split the fuzzer input into up to four pieces: one to three compiled fcontext
 	 * definitions (to mimic file_contexts, file_contexts.homedirs and file_contexts.local,
@@ -186,8 +197,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		.data = &sdata,
 	};
 
+#if !VERBOSE
 	selinux_set_callback(SELINUX_CB_LOG,
 			     (union selinux_callback){ .func_log = &null_log });
+#endif
 	/* validate to pre-compile regular expressions */
 	selinux_set_callback(
 		SELINUX_CB_VALIDATE,
@@ -298,3 +311,37 @@ cleanup:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEFINEMAIN
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s fuzzer-input-file\n", argv[0]);
+		exit(1);
+	}
+
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
+#endif
diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fuzz/selabel_file_text-fuzzer.c
index db2b4cee..3c86b37e 100644
--- a/libselinux/fuzz/selabel_file_text-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
@@ -15,12 +15,18 @@ extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 #define CTRL_FIND_ALL (1U << 1)
 #define CTRL_MODE (1U << 2)
 
+#ifndef VERBOSE
+#define VERBOSE 0
+#endif
+
+#if !VERBOSE
 __attribute__((format(printf, 2, 3))) static int
 null_log(int type __attribute__((unused)),
 	 const char *fmt __attribute__((unused)), ...)
 {
 	return 0;
 }
+#endif
 
 static int validate_context(char **ctxp)
 {
@@ -118,6 +124,11 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	/* S_IFSOCK has the highest integer value */
 	mode = (control & CTRL_MODE) ? S_IFSOCK : 0;
 
+#if VERBOSE
+	printf("partial=%s, find_all=%s, mode=%s\n", partial ? "true" : "false",
+	       find_all ? "true" : "false", mode ? "true" : "false");
+#endif
+
 	/*
 	 * Split the fuzzer input into two pieces: the textual fcontext definition and the lookup key
 	 */
@@ -141,6 +152,40 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	memcpy(key, sep + 4, key_len);
 	key[key_len] = '\0';
 
+#if VERBOSE
+	printf("fcontext_data_len=%zu fcontext=", fcontext_data_len);
+	unsigned char *str = fcontext_data;
+	unsigned char *end = str + fcontext_data_len;
+	while (str < end) {
+		unsigned char c = *str;
+		if (isspace(c)) {
+			printf("\\s");
+		} else if (isprint(c)) {
+			putchar(c);
+		} else {
+			printf("\\x%02x", c);
+		}
+		str++;
+	}
+	printf("\n");
+
+	printf("len=%zu key=", key_len);
+	str = (unsigned char *)key;
+	end = str + key_len;
+	while (str < end) {
+		unsigned char c = *str;
+		if (isspace(c)) {
+			printf("\\s");
+		} else if (isprint(c)) {
+			putchar(c);
+		} else {
+			printf("\\x%02x", c);
+		}
+		str++;
+	}
+	printf("\n");
+#endif
+
 	/*
 	 * Mock selabel handle
 	 */
@@ -150,8 +195,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		.data = &sdata,
 	};
 
+#if !VERBOSE
 	selinux_set_callback(SELINUX_CB_LOG,
 			     (union selinux_callback){ .func_log = &null_log });
+#endif
 	/* validate to pre-compile regular expressions */
 	selinux_set_callback(
 		SELINUX_CB_VALIDATE,
@@ -223,3 +270,37 @@ cleanup:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEFINEMAIN
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s fuzzer-input-file\n", argv[0]);
+		exit(1);
+	}
+
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
+#endif
diff --git a/libsepol/Makefile b/libsepol/Makefile
index 223edcec..efa10d57 100644
--- a/libsepol/Makefile
+++ b/libsepol/Makefile
@@ -6,6 +6,9 @@ all:
 	$(MAKE) -C src 
 	$(MAKE) -C utils
 
+fuzz: all
+	$(MAKE) -C fuzz
+
 install: 
 	$(MAKE) -C include install
 	$(MAKE) -C src install
diff --git a/libsepol/fuzz/.gitignore b/libsepol/fuzz/.gitignore
new file mode 100644
index 00000000..88310076
--- /dev/null
+++ b/libsepol/fuzz/.gitignore
@@ -0,0 +1,3 @@
+binpolicy-fuzzer
+secilc-fuzzer
+module-package-fuzzer
diff --git a/libsepol/fuzz/Makefile b/libsepol/fuzz/Makefile
new file mode 100644
index 00000000..4c8820ae
--- /dev/null
+++ b/libsepol/fuzz/Makefile
@@ -0,0 +1,24 @@
+# Build the libsepol fuzzers as standalone debug binaries.
+# oss-fuzz.sh handles the sanitizer/libFuzzer build; this Makefile
+# only produces plain binaries suitable for gdb/valgrind on a single
+# reproducer input.
+TARGETS := binpolicy-fuzzer secilc-fuzzer module-package-fuzzer
+
+# Nothing in libsepol itself is conditional on
+# FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION so the normally-built
+# ../src/libsepol.a can be used as-is.
+LIBSEPOLA := ../src/libsepol.a
+
+CFLAGS ?= -g -O0 -Wall
+override CFLAGS += -I../include -I../cil/include -D_GNU_SOURCE \
+	-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -DDEFINEMAIN -DVERBOSE=1
+
+all: $(TARGETS)
+
+$(TARGETS): %: %.o $(LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^
+
+clean:
+	rm -f $(TARGETS) *.o
+
+.PHONY: all clean
diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index f2379175..c75d0106 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -12,7 +12,9 @@ extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
 extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
 // set to 1 to enable more verbose libsepol logging
+#ifndef VERBOSE
 #define VERBOSE 0
+#endif
 
 static int write_binary_policy(policydb_t *p, FILE *outfp)
 {
@@ -117,3 +119,40 @@ exit:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEFINEMAIN
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s fuzzer-input-file\n", argv[0]);
+		exit(1);
+	}
+
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
+#endif
diff --git a/libsepol/fuzz/module-package-fuzzer.c b/libsepol/fuzz/module-package-fuzzer.c
index 2516970b..bce9155b 100644
--- a/libsepol/fuzz/module-package-fuzzer.c
+++ b/libsepol/fuzz/module-package-fuzzer.c
@@ -5,7 +5,9 @@
 extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
 // set to 1 to enable more verbose libsepol logging
+#ifndef VERBOSE
 #define VERBOSE 0
+#endif
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
@@ -45,3 +47,40 @@ exit:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEFINEMAIN
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s fuzzer-input-file\n", argv[0]);
+		exit(1);
+	}
+
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
+#endif
diff --git a/libsepol/fuzz/secilc-fuzzer.c b/libsepol/fuzz/secilc-fuzzer.c
index 57a39f46..e75ed9d3 100644
--- a/libsepol/fuzz/secilc-fuzzer.c
+++ b/libsepol/fuzz/secilc-fuzzer.c
@@ -8,11 +8,17 @@
 #include <sepol/cil/cil.h>
 #include <sepol/policydb.h>
 
+#ifndef VERBOSE
+#define VERBOSE 0
+#endif
+
+#if !VERBOSE
 static void log_handler(__attribute__((unused)) int lvl,
 			__attribute__((unused)) const char *msg)
 {
 	/* be quiet */
 }
+#endif
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
@@ -31,7 +37,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	sepol_policydb_t *pdb = NULL;
 
 	cil_set_log_level(log_level);
+#if !VERBOSE
 	cil_set_log_handler(log_handler);
+#endif
 
 	cil_db_init(&db);
 	cil_set_disable_dontaudit(db, disable_dontaudit);
@@ -75,3 +83,40 @@ exit:
 	sepol_policy_file_free(pf);
 	return 0;
 }
+
+#ifdef DEFINEMAIN
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s fuzzer-input-file\n", argv[0]);
+		exit(1);
+	}
+
+	FILE *fp = fopen(argv[1], "rb");
+	if (!fp) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	struct stat sb;
+	int rc;
+
+	rc = fstat(fileno(fp), &sb);
+	if (rc < 0) {
+		perror("fstat");
+		exit(1);
+	}
+
+	void *address = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE, fileno(fp), 0);
+	if (address == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	return LLVMFuzzerTestOneInput(address, sb.st_size);
+}
+#endif
-- 
2.55.0

