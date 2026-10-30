Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388550;
	b=f0fYO4umi7wkSsEJhd/fTLHrOK6+0g4q9hAWlhzd+wH0rA35aJ+pa/wqRYN02Fyth0k9
	 Ov9F0/acmWA2RAvJAmRzuyAMNI2SKrSVHW8pHvMPmCoZtOjoiLBYSPh3B+k0ZRC+ePtoW
	 Tv+9EIqJtUW5l91aQk1Jzpyn3NyyaXmquETo7QOKDVYlmaeLA64WAFHOLmCnAzcktfwmO
	 sdKQ5P2/mGS6ST/p7A0wFm0v4BSBD2LDHXIvrkUkncfDZS7WbI7VMX4zviONvRrMDnjVG
	 FJOa3aXOu1elUGZKpKs8RmQIZLl8N0i4YGyDtrrltcNbhFV5cavoorJXXfBkwYLTIpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jexxeK2F9EtlT4PNIYsTLa/m6TNzsNBzRpOvbUgIopI=;
	b=nm1tluUnEJssrxLbtE0F6BWcRHmp8mMsN3bwE0GFENOZO1J96l7ScOupYimHtVMmzeI/
	 JhJKTaANLPFe0jT0W5bzNN4gBXzHV15/qwU/+S4jChITyLN/BxG1PmWvUtx3xiJzcj7NU
	 68tZOX2RnCqUDn2c5mB/fVD9hMDSRpgfsfDpj3ttagUFeLBj9Uhvc/NqfkLLIODJwBrml
	 ZapFMVCQ06ve0uCNUWL34CnmQiVqKKyjiWb8a76OpBOGZxkSDYzNrqRmHzqFWg5Xn9PZ1
	 Ndgy+wwOb+bs9kxZYc/PHUne9bn/Gd+QpHmsA8XWhglYbSsebAK66wt4pUwyaYD1lSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzM2SoAY;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D562606A31D
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D562606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzM2SoAY
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5364042eecfso14956701cf.2
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388549; x=1793993349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jexxeK2F9EtlT4PNIYsTLa/m6TNzsNBzRpOvbUgIopI=;
        b=qzM2SoAYOxIap1+K4UO1bTwPZzQw7yjQzIDocD94hLPy41CV8mn+sLRAdYJAWf6SsC
         jtAojYxNpD8ARt9jiF2eO5o6j5dOnsw3Akj80PsQ30NXgF14P1y8j7W8boo5OOnH7qc4
         F4InTPf3GFVGSHz2dV4GTTutHXhKjwmOy3M/7RjFp159VyQ3mCeGcMBYz56mwpLgw4g3
         E+1ja9qRdbIgjW7/QmYUV/+Ta932dzs7u8MwDY9+XhDKw9UadfV7Hfkc6Q27DzjAYQpZ
         8jFv14Yr7xCiGjtT/ggTkyzz7qHCIYilSy9231Ol/dSDWVhigDZDuC0LdIG+5l7ZFdpc
         xI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388549; x=1793993349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jexxeK2F9EtlT4PNIYsTLa/m6TNzsNBzRpOvbUgIopI=;
        b=donEnvv+cuY+UK53moP8/cbk3r8ZzrHOOZnDZCFi7ykaXhL7ve5aPj4PhQYI3INePU
         lSs/b5KpqWYDbz3ibwHeTnZKsLDoiTFuQBSOOTSY0bUDlxff/V/rctoPGH+PDmK1Vt/s
         GlPdC2dgHiuCcnDtqoqc1ch5KosooswQ8tHn9O5UjdsH16PorNtC+3xV2jtmYJPox/TJ
         1Lh9MRrPkWN3dvLHJzrc3rnLFvDLZSd+Hb0mofKenp4yate7TK7ofa9guftYGOdyAbVk
         xUBzcZVk8OUHoNCvyFZnXrT0glXuShGKOeSUx0oIjTsPEDEAnemljg829udaYEcXCtTE
         Kj/A==
X-Gm-Message-State: AFq9FYJIH8K+JRJsxKo0zgf4RwPublgMfUkprbwMXSzj59IIzOCWcQ5n
	d9kRujd3IGNUkNuVJwLme0M+oRYL5V5qoNJvcgKiT6IB5vPk5mSE50+GQL9zEdx0
X-Gm-Gg: AYBFou0bbeMnq3078mgA/1bMcK9TGhwRfPrNLnHs5XEd6zpaQdS+3jUCqACcJyCmqHW
	H0Rqc0bd0bOG/SgAczKKpcBGRXz/Md/Mhaq1X2rmWq5A/6AV+Li4S5IRmuxQkKIWZYfJWnJzePa
	f2qdkbj7w043hQMgfUXulZ965rYnrSVs7zlbdYm4iIceCL031c65VCLd1jiiBFjJjjhUWkhCGfK
	gQJTEQNqD0xQHH/LXT/BFeeT+hdpUyd+bPjC/TBpew/GBd8z0A0V0g1cWBMCTGZ25akogKVB0fr
	rNWUTK/mrMIFmYTVA79/v8Um9/xXxzo2LWRB/Czspp7IYk85HSOSAf+RD4Hcpub/GENq6ssMvfz
	2CWgkV4EftvORphfLRKDPDSH1BKLO8wIadtg5RpSA4Te9DJ3+TZoMqgroaz0lBs4A0B6Dp51BjF
	M/gnT4ifjbRxusAORHrjFrtpTn9rZF+kGIvl3lcm4lJVWsdfoehv/b61aFHRC4sDLrFrwrvabU8
	BvZA8e3UqjjQW2Op0FNHlytVgy0yhDhCFiFF1XkJuaC6AXjChlSMPXG3uQXvJxci28G+n4Xl6Ea
	ZAzPjSP0gFdhCQ9rmgBeEUwAT4rrKr0gq0tvEf6mH078jyYbtmcEGIJLshUy9BBfh7Om6YTg+uT
	G46b39REpJ+1r5b4KyECpi1qSnFTBt/8bu5tWVOZd81r8BQgE7gM83Ob5Rrh1+6Vn10v47d8Bsj
	lKJEyo/1iXhjHQ2+ZuaE8mTWqcZ81hLPRUFmuUORZoe4NsStm9OJ0=
X-Received: by 2002:a05:622a:a12:b0:535:1e4f:4ed2 with SMTP id d75a77b69052e-542b3b78ae9mr54134421cf.11.1793388549343;
        Fri, 30 Oct 2026 12:29:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:09 -0700 (PDT)
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
Subject: [PATCH 10/11] libsemanage: free subnet strings during local ibpkey validation
Date: Fri, 30 Oct 2026 15:28:47 -0400
Message-ID: <20261030192849.151830-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
References: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
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

The local ibpkey validator allocates subnet-prefix strings in its
outer and inner loops but never frees them. Even validation of one
record leaks a string, and repeated checks accumulate allocations.

Mirror the ibendport validator: initialize both pointers, free each
before reuse, and release both on successful and failed exits. Reset
the pointers before calls which can fail without assigning an output.

Add tests for empty and single lists, adjacent ranges, distinct subnet
prefixes, overlap rejection and failures at each string allocation.
Use actual records and subnet conversion with fixture database listing.
The tests pass with ASan, UBSan and LeakSanitizer.

Fixes: 6a7a5aafe52a ("semanage: Update semanage to allow runtime labeling of Infiniband Pkeys")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/ibpkeys_local.c            | 12 ++-
 libsemanage/tests/Makefile                 |  7 +-
 libsemanage/tests/README                   |  5 ++
 libsemanage/tests/ibpkey-validation/run.sh | 17 ++++
 libsemanage/tests/ibpkey-validation/test.c | 96 ++++++++++++++++++++++
 5 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 libsemanage/tests/ibpkey-validation/run.sh
 create mode 100644 libsemanage/tests/ibpkey-validation/test.c

diff --git a/libsemanage/src/ibpkeys_local.c b/libsemanage/src/ibpkeys_local.c
index 65cb37a2..82f28f01 100644
--- a/libsemanage/src/ibpkeys_local.c
+++ b/libsemanage/src/ibpkeys_local.c
@@ -83,8 +83,8 @@ int semanage_ibpkey_validate_local(semanage_handle_t *handle)
 	unsigned int i = 0, j = 0;
 	uint64_t subnet_prefix;
 	uint64_t subnet_prefix2;
-	char *subnet_prefix_str;
-	char *subnet_prefix_str2;
+	char *subnet_prefix_str = NULL;
+	char *subnet_prefix_str2 = NULL;
 	int low, high;
 	int low2, high2;
 
@@ -98,6 +98,8 @@ int semanage_ibpkey_validate_local(semanage_handle_t *handle)
 
 	/* Test each ibpkey for overlap */
 	while (i < nibpkeys) {
+		free(subnet_prefix_str);
+		subnet_prefix_str = NULL;
 		if (STATUS_SUCCESS !=
 		    semanage_ibpkey_get_subnet_prefix(handle, ibpkeys[i],
 						      &subnet_prefix_str)) {
@@ -118,6 +120,8 @@ int semanage_ibpkey_validate_local(semanage_handle_t *handle)
 				goto next;
 			j++;
 
+			free(subnet_prefix_str2);
+			subnet_prefix_str2 = NULL;
 			if (STATUS_SUCCESS !=
 			    semanage_ibpkey_get_subnet_prefix(
 				    handle, ibpkeys[j], &subnet_prefix_str2)) {
@@ -152,6 +156,8 @@ next:
 		j = i;
 	}
 
+	free(subnet_prefix_str);
+	free(subnet_prefix_str2);
 	for (i = 0; i < nibpkeys; i++)
 		semanage_ibpkey_free(ibpkeys[i]);
 	free(ibpkeys);
@@ -161,6 +167,8 @@ err:
 	ERR(handle, "could not complete ibpkeys validity check");
 
 invalid:
+	free(subnet_prefix_str);
+	free(subnet_prefix_str2);
 	for (i = 0; i < nibpkeys; i++)
 		semanage_ibpkey_free(ibpkeys[i]);
 	free(ibpkeys);
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 662bbaee..8800fb73 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -61,7 +61,7 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 clean distclean:
 	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST) $(RESTART_TEST)
 
-test: all
+test: all test-ibpkey-validation
 	./$(EXECUTABLE)
 	./$(USER_JOIN_TEST)
 	./$(LIFECYCLE_TEST)
@@ -71,3 +71,8 @@ test: all
 	@for test in $(SERIAL_TESTS); do ./$$test || exit 1; done
 	./$(ROLLBACK_TEST)
 	./$(RESTART_TEST)
+
+test-ibpkey-validation:
+	sh ibpkey-validation/run.sh
+
+.PHONY: test-ibpkey-validation
diff --git a/libsemanage/tests/README b/libsemanage/tests/README
index 4430c6a8..00e7032c 100644
--- a/libsemanage/tests/README
+++ b/libsemanage/tests/README
@@ -13,6 +13,11 @@ When the system setfiles does not support the policy version of this tree,
 set SEMANAGE_TEST_SETFILES to the absolute path of a matching setfiles binary.
 SEMANAGE_TEST_VERBOSE=1 enables library diagnostics for troubleshooting.
 
+`make test-ibpkey-validation` checks overlap validation and subnet-string
+cleanup for empty/single/multiple records, different prefixes, overlap,
+and allocation failures. Records and subnet conversion use real source;
+database listing is a fixture. Tracked allocations must all be freed.
+
 The semanage_access_check test in the semanage_store suite simulates a
 read-only filesystem by using DAC permissions. Consequently, these tests
 will fail if run as root, as root can override DAC permissions.
diff --git a/libsemanage/tests/ibpkey-validation/run.sh b/libsemanage/tests/ibpkey-validation/run.sh
new file mode 100644
index 00000000..fc50649e
--- /dev/null
+++ b/libsemanage/tests/ibpkey-validation/run.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+set -eu
+cd "$(dirname "$0")/../../.."
+out=$(mktemp -d)
+trap 'rm -rf "$out"' EXIT HUP INT TERM
+${CC:-cc} ${CFLAGS:--O1 -g -Wall -Wextra -Werror} \
+    -DHAVE_REALLOCARRAY -fno-semantic-interposition \
+    -ffunction-sections -fdata-sections -Ilibsemanage/include \
+    -Ilibsemanage/src -Ilibsepol/include \
+    libsemanage/tests/ibpkey-validation/test.c \
+    libsemanage/src/ibpkeys_local.c libsemanage/src/ibpkey_record.c \
+    libsepol/src/ibpkey_record.c libsepol/src/context_record.c \
+    libsepol/src/debug.c ${LDFLAGS:-} -Wl,--gc-sections \
+    -Wl,--wrap=malloc -Wl,--wrap=free -o "$out/test"
+for scenario in empty single adjacent different overlap fail0 fail1 fail2 fail3 fail4; do
+    "$out/test" "$scenario"
+done
diff --git a/libsemanage/tests/ibpkey-validation/test.c b/libsemanage/tests/ibpkey-validation/test.c
new file mode 100644
index 00000000..14ccbe60
--- /dev/null
+++ b/libsemanage/tests/ibpkey-validation/test.c
@@ -0,0 +1,96 @@
+/* Verify cleanup around actual subnet-string allocations. */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sepol/debug.h>
+#include "ibpkey_internal.h"
+
+static const char *scenario;
+static int fail_after = -1;
+static int strings;
+static int tracking;
+static void *allocations[16];
+void *__real_malloc(size_t size);
+void *__wrap_malloc(size_t size);
+void __real_free(void *ptr);
+void __wrap_free(void *ptr);
+
+void __wrap_free(void *ptr)
+{
+	for (size_t i = 0; i < sizeof(allocations) / sizeof(allocations[0]);
+	     i++)
+		if (allocations[i] == ptr)
+			allocations[i] = NULL;
+	__real_free(ptr);
+}
+
+void *__wrap_malloc(size_t size)
+{
+	/* Only enable failure after fixture construction. */
+	if (fail_after >= 0 && strings++ == fail_after) {
+		fail_after = -1;
+		errno = ENOMEM;
+		return NULL;
+	}
+	void *ptr = __real_malloc(size);
+	if (tracking && ptr) {
+		for (size_t i = 0;
+		     i < sizeof(allocations) / sizeof(allocations[0]); i++) {
+			if (!allocations[i]) {
+				allocations[i] = ptr;
+				return ptr;
+			}
+		}
+		abort();
+	}
+	return ptr;
+}
+
+int dbase_list(semanage_handle_t *handle, dbase_config_t *config,
+	       record_t ***records, unsigned int *count)
+{
+	(void)config;
+	semanage_ibpkey_t **items;
+	*count = !strcmp(scenario, "empty")  ? 0 :
+		 !strcmp(scenario, "single") ? 1 :
+					       3;
+	items = calloc(*count, sizeof(*items));
+	assert(items || !*count);
+	for (unsigned int i = 0; i < *count; i++) {
+		assert(semanage_ibpkey_create(handle, &items[i]) == 0);
+		semanage_ibpkey_set_subnet_prefix_bytes(
+			items[i], !strcmp(scenario, "different") ? i + 1 : 1);
+		semanage_ibpkey_set_range(items[i], i * 5 + 1, i * 5 + 5);
+	}
+	if (!strcmp(scenario, "overlap"))
+		semanage_ibpkey_set_range(items[1], 5, 15);
+	*records = (record_t **)items;
+	tracking = 1;
+	if (!strncmp(scenario, "fail", 4)) {
+		fail_after = atoi(scenario + 4);
+		strings = 0;
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	semanage_handle_t handle = { 0 };
+	assert(argc == 2);
+	sepol_debug(0);
+	scenario = argv[1];
+	int rc = semanage_ibpkey_validate_local(&handle);
+	int failure = !strcmp(scenario, "overlap") ||
+		      !strncmp(scenario, "fail", 4);
+	assert(rc == (failure ? -1 : 0));
+	if (!strncmp(scenario, "fail", 4))
+		assert(fail_after == -1);
+	for (size_t i = 0; i < sizeof(allocations) / sizeof(allocations[0]);
+	     i++)
+		assert(allocations[i] == NULL);
+	printf("%s: validation result=%d\n", scenario, rc);
+	return 0;
+}
-- 
2.56.0

