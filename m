Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570D35C185
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843071; cv=none; b=FwkFI/4AQodz3n6uGahRkPzXzmyqr7Z3WMZQvE8SD9bJTGIX/MVRUnpx40K3HA0cNyeHIM42dVOsIr1WAh9jWqDPfQKV5YwdNlJ5HwIklga/HEL+jY5in2J8EG+CMrwYSCPifs0Uov2AXpZ0Lg/qu0rpEuC20M8GTOWFsBo3mZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843071; c=relaxed/simple;
	bh=/10a0KBA7PjHEOkK5r7wc2YEYd2yB4Rat5AwNddHnFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oopjF74qL2n1p3F6ySI1685fVZzhoPvYNDi1nWjnmbyvYv1s50MEpblP7TudYYYrAzrQeOfKvx2Dsgw83Ut1DH3t8uS4J6SoLFDCYqjGX8JHQRbHcVzmA7sxy2q20swcKr2JOds1LUSkPumxSKhqe5fWLUb5pbFxUgzotIfNERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtv3RGw6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtv3RGw6"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efef6533aaso489666d6.0
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787843068; x=1788447868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1E0F+bt40nimXtOruiLGgaWNtOaCQlNBdsb0ItosotY=;
        b=Qtv3RGw6EiXRXhRYooWqEdvx0JQTkvQgGdtwvRWWIDlXlSowvZzEtdg0L22gUnEGfa
         U8R94RPKRNdHjOR9S6THHvMIeCu+2XsYdCm7evbVFBrTKzwl7QBQq2u/x3equpbWy42F
         TM9e1N0Re4dOJdh9EzVEVycZjj7r4GmFPoorBla6eAHhQIbEZYIo7i0+GJQP2nA6CLGZ
         fNhMa0dHO2NhJ/ITNMX2yi0E4lI8buBKlL15wnk8G8V72akgsgIh637+XSLVj5KQu3Mp
         aseemzbU1iNwGlv6niarlt5CA0PYYMs7rccp+/J49EqZNvghso047vT9BDlStp4/XXQf
         u2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843068; x=1788447868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1E0F+bt40nimXtOruiLGgaWNtOaCQlNBdsb0ItosotY=;
        b=V2KQyfg5W6vjCfTpc/hOz3AGdPb3HTIVFOYcs7VPx5nTTmwq6pq1ctpUwBkKxHix1Y
         Gxkfkwln6WLmwydmXgoj5y/WAK7DDZp7PrnARjOxWt9itb2hz2Gj2dz+rZ+yWizFC/YY
         GpVi2UBNAoe2V1NZgRNLdZxM4CTZmsu7KMbA1UkfgVBlLNAwgvkhBvDbB7AJ6U/nP/4A
         XJRE3VJdQB5AALI7wd0sih9XKmjai9ktYXl0dyyB2wQwCKmOJDKUNMnzgDY/O6O1LXUg
         9jl4fLrh/nRwwygtB9dI+tg3VEXVU65/MOwOtxAewsZRtxIjewoHJ5yrBAFL7yhkjCrY
         i6xQ==
X-Gm-Message-State: AFuF++nclzmTATqf+UhS/zFg/Djat6ZXUaBNbQTfaA2qznv9EfIfkZy0
	rKx8G9q+Ha0LBy4ZoNjP4KSY0dFJv1xGtkuLjqIcrWINBnNMzv4HUcdKAXuTCQ==
X-Gm-Gg: AR+sD102YhNhmG4EpR/LhOqEevaWc4xddULzwMDTeMIZq/ZNkjVmqWUUDk05ZWxDtva
	AfIouuFDBb8jXPa8d9LEHSeMqMEVo7mJ8LyJdNMQmO41sJ8ILh4fVSunBA2wz7PIdO8z8LYqn6P
	JjSqpzZixlFyrZdcfSpws2n9QyrRXFBuHH9rMo7tscCLF4BAH69WjqOrHV/j3SrL5c/Y8vLgmVg
	gQG3LQU8+muGD29YBNVgs+18SHulJgd5AIy0tzk4hgZeWRD7o5rBvQOJ9ncEb3j1duf5CnufWkD
	c0uZWvjXWVSijpBOEdP+ngIG364MTptUdlrQ96NMxAPewcwPRHKSIeP662jnUuXaKNkjBi8yINJ
	w1kalWVSzcXF/ER/7VTFcWRwbWnR2wThWl/deOjlGBuLsYa6/KSW86Cwcj1d2Je+L9HcLdw5/4v
	a1i5gANdc+ZTOQNa/79xZ5Y+GO+uBYJWFt/8oxB+hv3ItS2SUQmnJZvn4MRPNHVPvpEpQ0olVOj
	Qj/gVVi+MAHrQIYv4beN3Dk9s4nd3OFTECrj20zgqiH3nRPKI3zk2fhBUL4g1MfeQ==
X-Received: by 2002:ad4:5f4a:0:b0:90c:c6fd:e8fd with SMTP id 6a1803df08f44-90cc7858b14mr198424046d6.2.1787843067500;
        Thu, 27 Aug 2026 08:04:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73e3c7fsm18668366d6.25.2026.08.27.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:04:26 -0700 (PDT)
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
Subject: [PATCH v2] FUZZING.md,{checkpolicy,libselinux}/fuzz: document selinux fuzzing
Date: Thu, 27 Aug 2026 11:01:39 -0400
Message-ID: <20260827150138.23835-2-stephen.smalley.work@gmail.com>
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
v2 renames FUZZ.md to FUZZING.md, folds the helpers for debugging
into the existing fuzzers, and updates the Makefiles to enable building
them more easily. NB Building the fuzzers this way does not build
with sanitizers enabled or link in the fuzzing framework; it is for
building them as standalone programs that can be run under a debugger
or valgrind easily.

 FUZZING.md                                    | 79 +++++++++++++++++++
 checkpolicy/.gitignore                        |  1 +
 checkpolicy/Makefile                          |  9 ++-
 checkpolicy/fuzz/checkpolicy-fuzzer.c         | 53 +++++++++++++
 libselinux/Makefile                           |  6 ++
 .../fuzz/selabel_file_compiled-fuzzer.c       | 41 ++++++++++
 libselinux/fuzz/selabel_file_text-fuzzer.c    | 75 ++++++++++++++++++
 libselinux/src/.gitignore                     |  2 +
 libselinux/src/Makefile                       | 16 +++-
 9 files changed, 280 insertions(+), 2 deletions(-)
 create mode 100644 FUZZING.md

diff --git a/FUZZING.md b/FUZZING.md
new file mode 100644
index 00000000..d7328ff7
--- /dev/null
+++ b/FUZZING.md
@@ -0,0 +1,79 @@
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
+with debugging, logging, and trivial main() function as follows:
+    make -C checkpolicy checkpolicy-fuzzer
+    make -C libselinux selabel_file_text-fuzzer selabel_file_compiled-fuzzer
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
diff --git a/checkpolicy/.gitignore b/checkpolicy/.gitignore
index 01a694d4..2aedc8a7 100644
--- a/checkpolicy/.gitignore
+++ b/checkpolicy/.gitignore
@@ -1,5 +1,6 @@
 checkmodule
 checkpolicy
+checkpolicy-fuzzer
 lex.yy.c
 y.tab.c
 y.tab.h
diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index e59ad63a..da255452 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -58,6 +58,13 @@ test: checkpolicy checkmodule
 # helper target for fuzzing
 checkobjects: $(CHECKOBJS)
 
+checkpolicy-fuzzer.o: fuzz/checkpolicy-fuzzer.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -g -I. -c -o $@ $^
+
+checkpolicy-fuzzer: CFLAGS = -g -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -DDEBUG -D_GNU_SOURCE
+checkpolicy-fuzzer: checkpolicy-fuzzer.o $(CHECKOBJS) $(LIBSEPOLA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
+
 install: all
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(MANDIR)/man8
@@ -76,5 +83,5 @@ relabel: install
 	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
 
 clean:
-	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
+	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) checkpolicy-fuzzer checkpolicy-fuzzer.o y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
 	$(MAKE) -C test clean
diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 401f24e3..3a3bb1c8 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -151,7 +151,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	FILE *devnull = NULL;
 	int mls, platform, policyvers;
 
+#ifndef DEBUG
 	sepol_debug(VERBOSE);
+#endif
 
 	/*
 	 * Take the first byte whether to generate a SELinux or Xen policy,
@@ -163,9 +165,15 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	switch (data[0]) {
 	case 'S':
 		platform = SEPOL_TARGET_SELINUX;
+#ifdef DEBUG
+		printf("target: SELinux\n");
+#endif
 		break;
 	case 'X':
 		platform = SEPOL_TARGET_XEN;
+#ifdef DEBUG
+		printf("target: Xen\n");
+#endif
 		break;
 	default:
 		return 0;
@@ -173,9 +181,15 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	switch (data[1]) {
 	case '0':
 		mls = 0;
+#ifdef DEBUG
+		printf("MLS-disabled\n");
+#endif
 		break;
 	case '1':
 		mls = 1;
+#ifdef DEBUG
+		printf("MLS-enabled\n");
+#endif
 		break;
 	default:
 		return 0;
@@ -190,6 +204,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	    policyvers != POLICYDB_VERSION_XEN_DEVICETREE &&
 	    policyvers != POLICYDB_VERSION_BOUNDARY)
 		return 0;
+#ifdef DEBUG
+	printf("policyvers=%d\n", policyvers);
+#endif
 	data += 3;
 	size -= 3;
 
@@ -286,3 +303,39 @@ exit:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEBUG
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
index aeede2b5..2f533e5f 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -55,6 +55,12 @@ all install relabel clean distclean:
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
 
+selabel_file_text-fuzzer:
+	$(MAKE) -C src $@
+
+selabel_file_compiled-fuzzer:
+	$(MAKE) -C src $@
+
 swigify: all
 	$(MAKE) -C src $@
 
diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
index 8466fed8..54d2f71b 100644
--- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
@@ -120,6 +120,11 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	/* S_IFSOCK has the highest integer value */
 	mode = (control & CTRL_MODE) ? S_IFSOCK : 0;
 
+#ifdef DEBUG
+	printf("partial=%s, find_all=%s, mode=%s\n", partial ? "true" : "false",
+	       find_all ? "true" : "false", mode ? "true" : "false");
+#endif
+
 	/*
 	 * Split the fuzzer input into up to four pieces: one to three compiled fcontext
 	 * definitions (to mimic file_contexts, file_contexts.homedirs and file_contexts.local,
@@ -186,8 +191,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		.data = &sdata,
 	};
 
+#ifndef DEBUG
 	selinux_set_callback(SELINUX_CB_LOG,
 			     (union selinux_callback){ .func_log = &null_log });
+#endif
 	/* validate to pre-compile regular expressions */
 	selinux_set_callback(
 		SELINUX_CB_VALIDATE,
@@ -298,3 +305,37 @@ cleanup:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEBUG
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
index db2b4cee..5472c4a0 100644
--- a/libselinux/fuzz/selabel_file_text-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
@@ -118,6 +118,11 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	/* S_IFSOCK has the highest integer value */
 	mode = (control & CTRL_MODE) ? S_IFSOCK : 0;
 
+#ifdef DEBUG
+	printf("partial=%s, find_all=%s, mode=%s\n", partial ? "true" : "false",
+	       find_all ? "true" : "false", mode ? "true" : "false");
+#endif
+
 	/*
 	 * Split the fuzzer input into two pieces: the textual fcontext definition and the lookup key
 	 */
@@ -141,6 +146,40 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	memcpy(key, sep + 4, key_len);
 	key[key_len] = '\0';
 
+#ifdef DEBUG
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
+	str = key;
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
@@ -150,8 +189,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		.data = &sdata,
 	};
 
+#ifndef DEBUG
 	selinux_set_callback(SELINUX_CB_LOG,
 			     (union selinux_callback){ .func_log = &null_log });
+#endif
 	/* validate to pre-compile regular expressions */
 	selinux_set_callback(
 		SELINUX_CB_VALIDATE,
@@ -223,3 +264,37 @@ cleanup:
 	/* Non-zero return values are reserved for future use. */
 	return 0;
 }
+
+#ifdef DEBUG
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
diff --git a/libselinux/src/.gitignore b/libselinux/src/.gitignore
index 5413ccf0..5b7258dd 100644
--- a/libselinux/src/.gitignore
+++ b/libselinux/src/.gitignore
@@ -3,3 +3,5 @@ selinuxswig_python_wrap.c
 selinuxswig_ruby_wrap.c
 selinux.egg-info/
 dist/
+selabel_file_text-fuzzer
+selabel_file_compiled-fuzzer
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9ecdbd4d..ed19e276 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -181,6 +181,20 @@ selinuxswig_python_exception.i: exception.sh ../include/selinux/selinux.h
 %.lo:  %.c policy.h
 	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
+selabel_file_text-fuzzer.o: ../fuzz/selabel_file_text-fuzzer.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -g -I. -c -o $@ $^
+
+selabel_file_text-fuzzer: CFLAGS = -g -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND $(PCRE_CFLAGS) -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -DDEBUG
+selabel_file_text-fuzzer: selabel_file_text-fuzzer.o $(LIBA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS)
+
+selabel_file_compiled-fuzzer.o: ../fuzz/selabel_file_compiled-fuzzer.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -g -I. -c -o $@ $^
+
+selabel_file_compiled-fuzzer: CFLAGS = -g -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND $(PCRE_CFLAGS) -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -DDEBUG
+selabel_file_compiled-fuzzer: selabel_file_text-fuzzer.o $(LIBA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS)
+
 $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 	$(SWIGRUBY) $<
 
@@ -215,7 +229,7 @@ clean-rubywrap:
 	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
 
 clean: clean-pywrap clean-rubywrap
-	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) *.o *.lo *~
+	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) selabel_file_text-fuzzer selabel_file_compiled-fuzzer *.o *.lo *~
 
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
-- 
2.55.0

