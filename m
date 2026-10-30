Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388548;
	b=AgfxfrchT0jhq+Yr9pwbWRW2ypPROOuv+PF3UFQp1Dslx9ZCiaTdkxZ6GlwbPPJGKptc
	 XQGpXV+v1nbGXTaI6YOLn1MP7JuxeVasdEQL+Zxh5ZQGi2gRTb9c9UmIxF2UMHysWINGg
	 myH7E7UuPk3Dm9/AZAnTr2Cn9ErKe0D1KF6FsvBgui+YcYQ+3PV2S3q3LBN5so6EeVgsH
	 3fubb07L3HwZiTQR0ogvUeu9cDVKRH7rYivmDkJ0UBCW5szUc1QgA7jYQAi95LMATeN3z
	 tltYO8hwwobxqVxyNvpXK4c2L2kIViS6+JlvBamMLaJ8yj3kGreNxBqH/E1TSJsoGoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pV5RXkNGHjVKzlzIO7jBYNA2MYgGWIQkal3qXz1xVkE=;
	b=VzaZeC2U0Fdy+Ax5u57wC+ri4hN5vqjJwE07YIJiwF9Jl1Wzshi74kHhX38Y2sqoXKX8
	 kU6EFzIfhdu+bJsiEfuV5ixO7ZWnY7e/ASN38/UZ/ikZuVXyAD6t4I7MFFIiXAEyQCW5o
	 dbWW1MJn1K7qp5xNdg5ZoXWcV/Qm+FkJlFL/y6mBICfNkYf7IygdHDOC5f992C3Gfoj22
	 T0qsEY3LmJgSxTf6wtli3CLWTLF4XOypXWO6q6ip471hkqGZFS5wH8NEuHm5dp3A425SE
	 PFvb65J040wsoqHJk15LBThF7sE8YgNenwZSsSm0snvoR4DiQi+X4SSCrEM7sPY4AtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OzhJj06S;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054C606A324
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D054C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OzhJj06S
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53634b8328eso9576231cf.0
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388547; x=1793993347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pV5RXkNGHjVKzlzIO7jBYNA2MYgGWIQkal3qXz1xVkE=;
        b=OzhJj06SdwmcTn3VPIIIu8G6sxue/5NjdGM2T0bZVc2PXMQBSLEM87lcopYtA2mpvq
         +SzVjiFDLRd0e4Zt6y36LkE19e8rFIgRy5gpkd4qvMg2LedoNNiqpxmzDPGvI/+QpQZ5
         OfPuJA2XPqpjMaDYi499mOSngFminHbdUf63xu11cx5ugAWd/FpnhK+uZu2ydICZBhnF
         aiU/EPcEgoFRV+TwH5kM4XKEyVFgdmHw6NbYbJiEr/Yfz5wsgLU1O6kBB4zQcfAM0kSo
         ixRvIDJnspsQJc+HTFj5b09xzUrAIYJoYTLqo4MUCLN1pJNVwEKEvdLjUF4wFKE7gb3O
         YYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388547; x=1793993347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pV5RXkNGHjVKzlzIO7jBYNA2MYgGWIQkal3qXz1xVkE=;
        b=qWbI9w7R1fLZOMb5n6Q9Hqh5bDB5B9UyGuvqgVYu0pQ8Rj8DFw43a6l4THxfFO1TP1
         eLMHE427mUWe3+njg4CNixsNzhKndGm7NWdQYAaZwTXD/8ewGtbT/VJE5/a4vY8t+X7t
         SJ7W7VpOpNPvwtkaBb4gAvdg19DY9G5nvrjoMqI4KTyG6JRClrgRNemYaSWvth7MqjX6
         hmLI6hmYJWClPcuXoyBAqUMpwNKTlWTutGuodrAV1+y7ttjWSCxeKBN4f5QUu7MtpWZm
         5tYdUTdXLKPnb2AylZt1/NcRlWtIl74QO86bP6DYyR8MAA4IqtWiIc/9K0NsECcEHH+v
         B1Jw==
X-Gm-Message-State: AFq9FYK5xRyCVTm5P3wTiJ2ZX33u/T3XXLsAydu+Mc9lweG63WpwwalY
	aXcrxDwNtMQGxoFDu8SEYF6wNHqUESGsssSmWsuskaX1caDFSxfftHBi4s4AyGYW
X-Gm-Gg: AYBFou3j6CONGSTUc+c2aKSQjKxLUyj+dT1GyimwiU28e9bOXQfpINrdRCubhuwwCxn
	86qsjNVN7RvFJrza5Sv3UCkc2Lc76e7oM7IgSqerbwZDnBJUiAHnVvfPfpEjPH9R8qU3sB89XNl
	KoqM7btyt+nvqR4iEJ98j7z1xSdWKSw+MbVBYsq03SGE4MEjiHya5s2lxZA0p0gHZrQCzY0GlSQ
	pWVYasJednAocegKwLpW5V52jlQ2IlmrrutsN6O4Rt1PKa+6m+Q54WqA7q4KoKwtVQbFqaxHRbF
	zgH4nz3sjEu4jBttIxIH7l3v4wSWX5HveGWoWLxQJaggBSP+m8Z+tFXwFobweNFo3ib/rSyEwv3
	vdd/jx9oiWNvvySEFRpBtTAeoX26gzIyUnQrF2ztoUts64lnhjB4PUo2Y81x7L6188Yl4NY+Yq4
	QqwiEBmQUTkXIRfKra555oTSp2nryMnfQ+WNC8Te5cSmHNPhv3nJNfr/hEMrNJg5/AtcBTk4E8a
	iaHcKUhXTDqh3zJHWhRD8aF9tRLVA0MKo0o5CKsnNegD4qTUPeDs9z/7o8byvaxbGgsp++2Hg0e
	auGibp1QhRLftgqJK5Y1p7ltmklulrh7fHxRh5XaUtdLlKzByP4Zxcp03oysPvWnoGOw/fJYGa1
	4s0fHbKaSIftnhe1pB3wQFsvxKlRXs9ts9dLz59eb3CnBUcALpJ2W7+ORvDTy4SC+bmsiaCVgPO
	4qAWKvjO2wK/ms/G4rOnmGgV4+fDU+eE7hG/TTjrtvuAj9OyaW3+w=
X-Received: by 2002:a05:622a:48e:b0:533:7a4c:d8ec with SMTP id d75a77b69052e-542b7916ac8mr56741271cf.43.1793388546649;
        Fri, 30 Oct 2026 12:29:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:06 -0700 (PDT)
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
Subject: [PATCH 06/11] libsemanage: preserve caches when serial lookup fails
Date: Fri, 30 Oct 2026 15:28:43 -0400
Message-ID: <20261030192849.151830-6-stephen.smalley.work@gmail.com>
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

The cache resync helpers treat a failed serial lookup as a cache miss.
The linked-list backends then reset their cache pointers without freeing
the old records, while the policydb backend can overwrite its old
policy. If a subsequent serial lookup succeeds, the operation reports
success after reloading the backing data and can silently discard
pending edits.

Return an error from both resync helpers and propagate it directly from
the file, join, active, and policydb cache methods before resetting or
dropping an existing cache. Keep actual serial-change invalidation and
attached-policy handling unchanged.

Add regression coverage for clean and dirty caches, transient and
persistent serial errors, cold-cache recovery, same-serial retries,
changed-serial reloads, allocation cleanup, and attached-policy
ownership across all four backends.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/database_activedb.c           |   6 +-
 libsemanage/src/database_file.c               |   6 +-
 libsemanage/src/database_join.c               |   6 +-
 libsemanage/src/database_llist.c              |   6 +-
 libsemanage/src/database_llist.h              |   1 +
 libsemanage/src/database_policydb.c           |  12 +-
 libsemanage/tests/.gitignore                  |   4 +
 libsemanage/tests/Makefile                    |  17 +-
 .../regression/test_cache_serial_error.c      | 365 ++++++++++++++++++
 9 files changed, 409 insertions(+), 14 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_cache_serial_error.c

diff --git a/libsemanage/src/database_activedb.c b/libsemanage/src/database_activedb.c
index 57ce4d85..a51db2cf 100644
--- a/libsemanage/src/database_activedb.c
+++ b/libsemanage/src/database_activedb.c
@@ -37,10 +37,12 @@ static int dbase_activedb_cache(semanage_handle_t *handle,
 	record_t **records = NULL;
 	unsigned int rcount = 0;
 	unsigned int i = 0;
+	int resync;
 
 	/* Already cached */
-	if (!dbase_llist_needs_resync(handle, &dbase->llist))
-		return STATUS_SUCCESS;
+	resync = dbase_llist_needs_resync(handle, &dbase->llist);
+	if (resync <= 0)
+		return resync;
 
 	/* Update cache serial */
 	dbase_llist_cache_init(&dbase->llist);
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index b57bbb2c..e67e0b02 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -46,6 +46,7 @@ static int dbase_file_cache(semanage_handle_t *handle, dbase_file_t *dbase)
 
 	record_t *process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
+	int resync;
 
 	parse_info_t *parse_info = NULL;
 	const char *fname = NULL;
@@ -57,8 +58,9 @@ static int dbase_file_cache(semanage_handle_t *handle, dbase_file_t *dbase)
 	dbase->cache_in_transaction = handle->is_in_transaction;
 
 	/* Already cached */
-	if (!dbase_llist_needs_resync(handle, &dbase->llist))
-		return STATUS_SUCCESS;
+	resync = dbase_llist_needs_resync(handle, &dbase->llist);
+	if (resync <= 0)
+		return resync;
 
 	/* Update cache serial */
 	dbase_llist_cache_init(&dbase->llist);
diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index d6ef6d62..2a25c330 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -51,6 +51,7 @@ static int dbase_join_cache(semanage_handle_t *handle, dbase_join_t *dbase)
 	record1_t **records1 = NULL;
 	record2_t **records2 = NULL;
 	unsigned int rcount1 = 0, rcount2 = 0, i = 0, j = 0;
+	int resync;
 
 	/* Synchronize child caches before mutating a join in a new transaction */
 	if (dbase->cache_in_transaction != handle->is_in_transaction)
@@ -58,8 +59,9 @@ static int dbase_join_cache(semanage_handle_t *handle, dbase_join_t *dbase)
 	dbase->cache_in_transaction = handle->is_in_transaction;
 
 	/* Already cached */
-	if (!dbase_llist_needs_resync(handle, &dbase->llist))
-		return STATUS_SUCCESS;
+	resync = dbase_llist_needs_resync(handle, &dbase->llist);
+	if (resync <= 0)
+		return resync;
 
 	/* Update cache serial */
 	dbase_llist_cache_init(&dbase->llist);
diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
index 209e8ec1..e703f01f 100644
--- a/libsemanage/src/database_llist.c
+++ b/libsemanage/src/database_llist.c
@@ -21,8 +21,10 @@ int dbase_llist_needs_resync(semanage_handle_t *handle, dbase_llist_t *dbase)
 		return 1;
 
 	cache_serial = handle->funcs->get_serial(handle);
-	if (cache_serial < 0)
-		return 1;
+	if (cache_serial < 0) {
+		ERR(handle, "could not check cache serial");
+		return STATUS_ERR;
+	}
 
 	if (cache_serial != dbase->cache_serial) {
 		dbase_llist_drop_cache(dbase);
diff --git a/libsemanage/src/database_llist.h b/libsemanage/src/database_llist.h
index 4c8b2a2f..9cf72417 100644
--- a/libsemanage/src/database_llist.h
+++ b/libsemanage/src/database_llist.h
@@ -52,6 +52,7 @@ extern int dbase_llist_cache_prepend(semanage_handle_t *handle,
 				     dbase_llist_t *dbase,
 				     const record_t *data);
 
+/* Return 1 for a cache miss, 0 for a hit, or -1 on serial lookup failure. */
 extern int dbase_llist_needs_resync(semanage_handle_t *handle,
 				    dbase_llist_t *dbase);
 
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index f65b475c..02c4a6cc 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -71,8 +71,10 @@ static int dbase_policydb_needs_resync(semanage_handle_t *handle,
 		return 1;
 
 	cache_serial = handle->funcs->get_serial(handle);
-	if (cache_serial < 0)
-		return 1;
+	if (cache_serial < 0) {
+		ERR(handle, "could not check cache serial");
+		return STATUS_ERR;
+	}
 
 	if (cache_serial != dbase->cache_serial) {
 		dbase_policydb_drop_cache(dbase);
@@ -89,13 +91,15 @@ static int dbase_policydb_cache(semanage_handle_t *handle,
 	sepol_policydb_t *policydb = NULL;
 	sepol_policy_file_t *pf = NULL;
 	const char *fname = NULL;
+	int resync;
 
 	/* Check if cache is needed */
 	if (dbase->attached)
 		return STATUS_SUCCESS;
 
-	if (!dbase_policydb_needs_resync(handle, dbase))
-		return STATUS_SUCCESS;
+	resync = dbase_policydb_needs_resync(handle, dbase);
+	if (resync <= 0)
+		return resync;
 
 	fname = dbase->path[handle->is_in_transaction];
 
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 1cf9527b..b7d39810 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -4,4 +4,8 @@ test-handle-lifecycle
 test-parse-read-error
 test-read-lock-error
 test-user-delete-error
+test-cache-serial-file
+test-cache-serial-join
+test-cache-serial-active
+test-cache-serial-policydb
 *.policy
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 60e48dce..2e4703ee 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -8,6 +8,7 @@ EXECUTABLE = libsemanage-tests
 USER_JOIN_TEST = test-user-join-transaction
 LIFECYCLE_TEST = test-handle-lifecycle
 ERROR_TESTS = test-read-lock-error test-user-delete-error test-parse-read-error
+SERIAL_TESTS = test-cache-serial-file test-cache-serial-join test-cache-serial-active test-cache-serial-policydb
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
 override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
@@ -15,7 +16,18 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS)
+all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS)
+
+test-cache-serial-file: SERIAL_BACKEND = FILE
+test-cache-serial-join: SERIAL_BACKEND = JOIN
+test-cache-serial-active: SERIAL_BACKEND = ACTIVE
+test-cache-serial-policydb: SERIAL_BACKEND = POLICYDB
+
+$(SERIAL_TESTS): regression/test_cache_serial_error.c ../src/database_llist.c \
+		../src/database_llist.h ../src/database_file.c \
+		../src/database_join.c ../src/database_activedb.c \
+		../src/database_policydb.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -DTEST_$(SERIAL_BACKEND) -o $@ $< ../src/database_llist.c -lsepol
 
 $(LIFECYCLE_TEST): regression/test_handle_lifecycle.c ../src/libsemanage.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
@@ -39,7 +51,7 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS)
 
 test: all
 	./$(EXECUTABLE)
@@ -48,3 +60,4 @@ test: all
 	./test-parse-read-error
 	./test-read-lock-error
 	./test-user-delete-error
+	@for test in $(SERIAL_TESTS); do ./$$test || exit 1; done
diff --git a/libsemanage/tests/regression/test_cache_serial_error.c b/libsemanage/tests/regression/test_cache_serial_error.c
new file mode 100644
index 00000000..a0bdccce
--- /dev/null
+++ b/libsemanage/tests/regression/test_cache_serial_error.c
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sepol/policydb.h>
+
+typedef int record_t;
+typedef int record_key_t;
+typedef int record1_t;
+typedef int record2_t;
+#define DBASE_RECORD_DEFINED
+#define DBASE_RECORD_JOIN_DEFINED
+
+static int loads;
+static int live_records;
+static int serial_calls;
+static int serial_error;
+static int serial_failures;
+static int current_serial = 7;
+
+#if defined(TEST_POLICYDB)
+static FILE *missing_file(const char *path, const char *mode)
+{
+	(void)path;
+	(void)mode;
+	loads++;
+	errno = ENOENT;
+	return NULL;
+}
+
+static void free_policy(sepol_policydb_t *policy)
+{
+	if (policy)
+		live_records--;
+	sepol_policydb_free(policy);
+}
+
+static int create_policy(sepol_policydb_t **policy)
+{
+	int rc = sepol_policydb_create(policy);
+
+	if (rc == 0)
+		live_records++;
+	return rc;
+}
+
+#define fopen missing_file
+#define sepol_policydb_create create_policy
+#define sepol_policydb_free free_policy
+#include "../../src/database_policydb.c"
+#undef fopen
+#undef sepol_policydb_create
+#undef sepol_policydb_free
+#elif defined(TEST_FILE)
+#include "../../src/database_file.c"
+#elif defined(TEST_JOIN)
+#include "../../src/database_join.c"
+#elif defined(TEST_ACTIVE)
+#include "../../src/database_activedb.c"
+#else
+#error "Select a database backend"
+#endif
+
+static int serial(semanage_handle_t *handle)
+{
+	(void)handle;
+	serial_calls++;
+	if (serial_error && serial_failures) {
+		if (serial_failures > 0)
+			serial_failures--;
+		errno = serial_error;
+		return -1;
+	}
+	return current_serial;
+}
+
+static void message(void *arg, semanage_handle_t *handle, const char *fmt, ...)
+{
+	(void)arg;
+	(void)handle;
+	(void)fmt;
+	/* Logging must not overwrite the serial lookup error. */
+	errno = EINVAL;
+}
+
+#if !defined(TEST_POLICYDB)
+static int create(semanage_handle_t *handle, int **record)
+{
+	(void)handle;
+	*record = malloc(sizeof(**record));
+	assert(*record);
+	live_records++;
+	return 0;
+}
+
+static int clone(semanage_handle_t *handle, const int *in, int **out)
+{
+	create(handle, out);
+	**out = *in;
+	return 0;
+}
+
+static void release(int *record)
+{
+	if (record)
+		live_records--;
+	free(record);
+}
+
+static const record_table_t records = {
+	.create = create,
+	.clone = clone,
+	.free = release,
+	.key_free = release,
+};
+#endif
+
+#if defined(TEST_FILE)
+static int parsed;
+
+unsigned int semanage_ro_root_count(void)
+{
+	return 0;
+}
+
+const char *semanage_path(enum semanage_store_defs store,
+			  enum semanage_sandbox_defs file)
+{
+	(void)store;
+	(void)file;
+	abort();
+}
+
+const char *semanage_path_read(enum semanage_store_defs store,
+			       enum semanage_sandbox_defs file)
+{
+	return semanage_path(store, file);
+}
+
+int parse_init(semanage_handle_t *handle, const char *name, void *arg,
+	       parse_info_t **info)
+{
+	(void)handle;
+	(void)name;
+	(void)arg;
+	*info = calloc(1, sizeof(**info));
+	assert(*info);
+	loads++;
+	parsed = 0;
+	return 0;
+}
+
+int parse_open(semanage_handle_t *handle, parse_info_t *info)
+{
+	(void)handle;
+	(void)info;
+	return 0;
+}
+
+void parse_close(parse_info_t *info)
+{
+	(void)info;
+}
+
+void parse_release(parse_info_t *info)
+{
+	free(info);
+}
+
+static int parse(semanage_handle_t *handle, parse_info_t *info, int *record)
+{
+	(void)handle;
+	(void)info;
+	if (parsed++)
+		return STATUS_NODATA;
+	*record = 10;
+	return 0;
+}
+#elif defined(TEST_JOIN) || defined(TEST_ACTIVE)
+static int read_list(semanage_handle_t *handle, int ***out, unsigned int *count)
+{
+	int value = 10;
+
+	*out = malloc(sizeof(**out));
+	assert(*out);
+	clone(handle, &value, &(*out)[0]);
+	*count = 1;
+	loads++;
+	return 0;
+}
+#endif
+
+#if defined(TEST_JOIN)
+static int child_cache(semanage_handle_t *handle, dbase_t *dbase)
+{
+	(void)handle;
+	(void)dbase;
+	return 0;
+}
+
+static int child_list(semanage_handle_t *handle, dbase_t *dbase, int ***out,
+		      unsigned int *count)
+{
+	if (dbase)
+		return read_list(handle, out, count);
+	*out = NULL;
+	*count = 0;
+	return 0;
+}
+
+static const record_table_t *child_records(dbase_t *dbase)
+{
+	(void)dbase;
+	return &records;
+}
+
+static int join(semanage_handle_t *handle, const int *first, const int *second,
+		int **out)
+{
+	assert(first && !second);
+	return clone(handle, first, out);
+}
+#endif
+
+static void run_case(int dirty, int error)
+{
+	struct semanage_policy_table funcs = { .get_serial = serial };
+	semanage_handle_t handle = {
+		.funcs = &funcs,
+		.is_in_transaction = 1,
+		.msg_callback = message,
+	};
+	int before, i;
+#if defined(TEST_POLICYDB)
+	dbase_policydb_t *db = NULL;
+	sepol_policydb_t *saved;
+
+	assert(dbase_policydb_init(&handle, "active", "tmp", NULL, NULL, &db) ==
+	       0);
+#define CACHE() dbase_policydb_cache(&handle, db)
+#define RELEASE() dbase_policydb_release(db)
+#define MODIFIED db->modified
+#define SERIAL db->cache_serial
+#elif defined(TEST_FILE)
+	record_file_table_t files = { .parse = parse };
+	dbase_file_t *db;
+
+	assert(dbase_file_init(&handle, "active", "tmp", &records, &files,
+			       &db) == 0);
+#define CACHE() dbase_file_cache(&handle, db)
+#define RELEASE() dbase_file_release(db)
+#elif defined(TEST_JOIN)
+	const dbase_table_t child_table = {
+		.cache = child_cache,
+		.list = child_list,
+		.get_rtable = child_records,
+	};
+	dbase_config_t first = { .dtable = &child_table };
+	dbase_config_t second = { .dtable = &child_table };
+	record_join_table_t joins = { .join = join };
+	dbase_join_t *db;
+
+	/* A non-NULL child supplies one record; the other supplies an empty list. */
+	first.dbase = (dbase_t *)&first;
+	assert(dbase_join_init(&handle, &records, &joins, &first, &second,
+			       &db) == 0);
+#define CACHE() dbase_join_cache(&handle, db)
+#define RELEASE() dbase_join_release(db)
+#elif defined(TEST_ACTIVE)
+	record_activedb_table_t active = { .read_list = read_list };
+	dbase_activedb_t *db;
+
+	assert(dbase_activedb_init(&handle, &records, &active, &db) == 0);
+#define CACHE() dbase_activedb_cache(&handle, db)
+#define RELEASE() dbase_activedb_release(db)
+#endif
+#if !defined(TEST_POLICYDB)
+	cache_entry_t *saved;
+#define MODIFIED db->llist.modified
+#define SERIAL db->llist.cache_serial
+#endif
+
+	assert(live_records == 0);
+	/* Failure during initial loading must leave an empty, retryable cache. */
+	serial_error = error;
+	serial_failures = 1;
+	assert(CACHE() == -1);
+	assert(live_records == 0 && SERIAL == -1 && MODIFIED == 0);
+	serial_error = 0;
+	assert(CACHE() == 0);
+	assert(live_records == 1);
+	MODIFIED = dirty;
+#if defined(TEST_POLICYDB)
+	saved = db->policydb;
+#else
+	saved = db->llist.cache;
+	*saved->data = dirty ? 20 : 10;
+#endif
+	before = loads;
+	serial_error = error;
+	for (i = 0; i < 2; i++) {
+		int calls = serial_calls;
+
+		/* One-shot failure first, then a failure that persists until reset. */
+		serial_failures = i ? -1 : 1;
+		assert(CACHE() == -1);
+		assert(errno == error);
+		assert(serial_calls == calls + 1);
+		assert(loads == before && live_records == 1);
+		assert(MODIFIED == dirty && SERIAL == current_serial);
+#if defined(TEST_POLICYDB)
+		assert(db->policydb == saved);
+#else
+		assert(db->llist.cache == saved);
+		assert(db->llist.cache_tail == saved &&
+		       db->llist.cache_sz == 1);
+		assert(*saved->data == (dirty ? 20 : 10));
+#endif
+	}
+	serial_error = 0;
+	assert(CACHE() == 0);
+	assert(loads == before && MODIFIED == dirty && live_records == 1);
+
+	/* A real serial change must still replace and release the old cache. */
+	current_serial++;
+	assert(CACHE() == 0);
+	assert(loads == before + 1 && MODIFIED == 0 && live_records == 1);
+	assert(SERIAL == current_serial);
+#if !defined(TEST_POLICYDB)
+	assert(*db->llist.cache->data == 10);
+#else
+	/* Attached policies belong to the caller and bypass serial lookups. */
+	assert(create_policy(&saved) == 0);
+	dbase_policydb_attach(db, saved);
+	assert(live_records == 1);
+	before = serial_calls;
+	serial_error = error;
+	serial_failures = -1;
+	assert(CACHE() == 0 && serial_calls == before);
+	assert(db->policydb == saved);
+	dbase_policydb_detach(db);
+#endif
+	RELEASE();
+#if defined(TEST_POLICYDB)
+	assert(live_records == 1);
+	free_policy(saved);
+#endif
+	assert(live_records == 0);
+	printf("dirty=%d errno=%d: preserved on error, retry and resync passed\n",
+	       dirty, error);
+}
+
+int main(void)
+{
+	const int errors[] = { EINTR, EIO, EMFILE };
+	size_t i;
+	int dirty;
+
+	for (dirty = 0; dirty <= 1; dirty++)
+		for (i = 0; i < sizeof(errors) / sizeof(errors[0]); i++)
+			run_case(dirty, errors[i]);
+	return 0;
+}
-- 
2.56.0

