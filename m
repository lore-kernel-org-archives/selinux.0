Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988375;
	b=BufyRVglKkJQWtaw/WIVnvKnCnp5RJ+/bGnS94yS8laIbtRwwMfVY8XGy2UPlPTJg4/p
	 wYtUa/23jsDGeu4RSp26CGXQvsZkjotXaqvcgRmpx7KhBEy0R6Dor+Ub24uqQEPCWjs+o
	 4bDe+wOqOkwpqjOABKnkyi/Z0R+Ce3BeQqB98DQmpG+/gduUidoP2GG08CnRDBx60nMBm
	 r1RXzrxvD898oHC5fd+Sk7g6mqhLESMPm0j9cmGlrG7XL03mxdCMQ4DNaWPZ3Am2bC0gx
	 jF7cqsPkBgdndoAubhmcZ2fZU1ynZaWoVn8JgE3vj5fD0w5/4fAauHVnzm7HxsjapsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l0k7XUQ6HvbC0qSBfCgP2QdxE70sodMkbhgLBUQITTc=;
	b=0BIAINJDu1vZQmbct0g/S9QLqEMxUByjlY/OzgLQc4jEfz4qzbUfdXshF2YwshpL9gVz
	 aOeH4YcjexyLYnh+pDAnbhqhrkE+0mvxPFWxf28Fdl9f67ArcISoJZfn1U8nyW40FnMvM
	 V+dgG7kcqSfMBGyUlCMx8zBzk+fMUPG6OSPaNmVT27ey7jKdHlrbflhsh5ZOrBUAYF3KI
	 kC8FW3TQojYdfW+5jBw4oWIwRrNOb/fORi23U844GnZqv6bVQ7lDRO3qzSV5B0gxiYDuS
	 k66s5YD/bnb4XeIbBldNp99obN3rZKHKeyEyGnbJxA2ZAVyfIhXnaod+izzWgbeQ9Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UddLQjq9;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118C606A32C
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D118C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UddLQjq9
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5366463571cso10353381cf.3
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988374; x=1794593174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0k7XUQ6HvbC0qSBfCgP2QdxE70sodMkbhgLBUQITTc=;
        b=UddLQjq9gX+mJnUyQzCeyi6pEZAsQyOCG4Ysx3pi8AkpGeGQdajdhQ4jEstphmaqIk
         0dDh49HjDHGjuP65SHpJwSefCrAe+H7avNeQxmB9UuKZFYzORN7ZZ81ZyENfqERrFrdu
         JmpoHf3J7dWOpCIvOM1upPAMNdEnyrlwxWzfXZM4/TrAtUQpi1mHnaYGZnxchu0Ed1ac
         ++cR5rg7trkEBvufmyX8ac/eKvkZDWiyndg5rWZxOdA2SbAY6EQ2eoLfnpy299CYyGm7
         lgEBNPaaCEoqoDbzWURbnSqZKDxqIHK0I2Bl7FODwMhhOwm1LlrJqVsGH+2JR8MVQrZi
         AjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988374; x=1794593174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0k7XUQ6HvbC0qSBfCgP2QdxE70sodMkbhgLBUQITTc=;
        b=06iMSAEheoDsk/oQiXn6zj1O8QcQYC+NQ77BQ3X4PnAWtGDJXe3sMqEBVBCM4Hegd9
         b2zn5ChODa6kRmmgfaR7s6fnCNKtNiX1XhZHaQlfRJ07l1jA0m4mEB7d9msKT6woYoxC
         naYrh0UlNOUUJ/Nspd37DZsGAfocRiLX0XWhPsOHiAwLTbFStZDvZLox2+etWOoNzFIE
         KM0mDdrbYppII+SkeyHGaBz33iVn5Gi8A35Pj2ZQUznsYz5nnWJ73KxazbxfWcl1WsxC
         BudR+Vv3owExbM5dhS7UAi0DlsVqRptD9OqpW6AV+bpl2kaHxVXugv1HsNkQZwf71sCl
         pUbw==
X-Gm-Message-State: APuU4Z++z01pns5+6N6OYAe6oQ2eT1gm+CxO/J7K6pE0Hs1UjGfOhnRJ
	+7hfXqDCoVKwUyM8VZWabdvaLNKnvJqNu17RKptGBSJKCVUlik1KbSlz4UcXwLNx
X-Gm-Gg: AYBFou2U6Agmqi22sAkHwqOuab0+hYgFdMrbZYQNtrtyVZuoAPUQZImy8z6+03kDMgU
	F05fWYV5TflYRf0B7ctvUATjvNPFHKwuh+spNn9nuguoUNrPX1uf4etjg1V3iQfbahZv0oqEwuf
	zHMhjXVZeiat4+4atu2/BXjwyxtK83Ct2JieyHICWQa8z4Vh3P6n3yH/xACd/AGfSQbg8VY0man
	Fo8I59uJq5kamnfcJTPoWKBJFGUN2VdqgYLs/liCZiV1zEBkk7MAFXhPoGd/EFyTUd4/QlCPqv7
	c/6zoPDk15KJogdC1y1huPE1XfkbUSPZvdVq9pH/4wSShYuuGlUGpW4E2TfsIMf3RYOOfpgzU5I
	fukwkr0fLVOeQTUfql+ciU0HERK2qE6qdPuEZ71+pDZkHQbxf2UTrepwuS5NW5m3sgoCINxnJ9f
	VSNQO/NYSHaPQFlhVGRN/XM8xKaGGOx4EalUYnSQyP/xDec1a2q5W7mWam8+vCVIkzOXNxvLsNv
	IPwN9KezHzZNZ5kbBXrodm/PhyKE/JCI4F+Qw263vLDw4FLatBQLK7bbE76rD2jGeIZQBFhApxY
	LV84+Wi274swGoxF8xGGrCt7+/MO6gEkCQz7lyhqk2Y1EY26G209BzQHlRHdfiLsW7mA7ag8+ks
	RSsgosIWmMMaiA2XZeTZNCzx1BJ2ayZJbbfi5cLkz8hXwdndRO8IOoNoCTD3+GVjoN5yRy45Zrk
	XpOUKgeO5PpVDTQQQ1IT9wB6sh+RrY5GbSE/HIJtWmT0OL+yuYVKM=
X-Received: by 2002:a05:622a:38a:b0:532:91f2:dd45 with SMTP id d75a77b69052e-54e14761738mr49979451cf.44.1793988373832;
        Fri, 06 Nov 2026 10:06:13 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26259cf0sm25893461cf.15.2026.11.06.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:06:13 -0800 (PST)
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
Subject: [PATCH 3/4] libselinux: unwind audit2why initialization completely
Date: Fri,  6 Nov 2026 13:05:55 -0500
Message-ID: <20261106180556.243798-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
References: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
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

Initialization errors after boolean enumeration leave boolcnt stale and
leak the loaded boolean entries. A subsequent init can report success with
an empty boolean list and crash during finish. Enumeration failures are
also ignored, allowing incomplete advice to be reported as success.

Share complete policy cleanup between failed initialization and finish.
Clear libsepol's borrowed pointers before freeing the private policy,
free partial boolean entries, and reset the count. Check handle creation,
boolean count and enumeration, free the policy-file wrapper on success,
and return NULL when initialization has set a Python exception.

Add an optional native Python regression for allocation and enumeration
failures, repeated cleanup, and retry with a valid compiled policy.

Fixes: f8c290cc5901 ("libselinux: audit2why: clear static variables on init failure")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/Makefile                   |   6 ++
 libselinux/src/audit2why.c            |  81 +++++++-------
 libselinux/tests/audit2why/.gitignore |   1 +
 libselinux/tests/audit2why/Makefile   |  35 ++++++
 libselinux/tests/audit2why/fault.c    | 150 ++++++++++++++++++++++++++
 libselinux/tests/audit2why/policy.c   |  31 ++++++
 libselinux/tests/audit2why/policy.cil |  21 ++++
 libselinux/tests/audit2why/test.py    |  52 +++++++++
 8 files changed, 340 insertions(+), 37 deletions(-)
 create mode 100644 libselinux/tests/audit2why/.gitignore
 create mode 100644 libselinux/tests/audit2why/Makefile
 create mode 100644 libselinux/tests/audit2why/fault.c
 create mode 100644 libselinux/tests/audit2why/policy.c
 create mode 100644 libselinux/tests/audit2why/policy.cil
 create mode 100644 libselinux/tests/audit2why/test.py

diff --git a/libselinux/Makefile b/libselinux/Makefile
index be3923f0..1176b31e 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -93,3 +93,9 @@ clean-rubywrap:
 
 test: all
 	$(MAKE) -C tests test
+
+# Optional: requires Python development headers and a built tree libsepol.
+test-audit2why:
+	$(MAKE) -C tests/audit2why test
+
+.PHONY: test-audit2why
diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 50dfefc3..5abc853d 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -46,6 +46,27 @@ static struct avc_t *avc = NULL;
 
 static sidtab_t sidtab;
 
+static void policy_destroy(void)
+{
+	for (int i = 0; i < boolcnt; i++) {
+		free(boollist[i]->name);
+		free(boollist[i]);
+	}
+	free(boollist);
+	boollist = NULL;
+	boolcnt = 0;
+	if (avc) {
+		sepol_set_policydb(NULL);
+		sepol_set_sidtab(NULL);
+		sepol_sidtab_shutdown(&sidtab);
+		sepol_sidtab_destroy(&sidtab);
+		sepol_policydb_free(avc->policydb);
+		sepol_handle_destroy(avc->handle);
+		free(avc);
+		avc = NULL;
+	}
+}
+
 static int load_booleans(const sepol_bool_t *boolean, void *arg)
 {
 	const unsigned int *boolmax = arg;
@@ -182,31 +203,10 @@ static int check_booleans(struct boolean_t **bools)
 
 static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args)
 {
-	PyObject *result = 0;
-
-	if (PyArg_ParseTuple(args, ":finish")) {
-		int i = 0;
-		if (!avc)
-			Py_RETURN_NONE;
-
-		for (i = 0; i < boolcnt; i++) {
-			free(boollist[i]->name);
-			free(boollist[i]);
-		}
-		free(boollist);
-		sepol_sidtab_shutdown(&sidtab);
-		sepol_sidtab_destroy(&sidtab);
-		sepol_policydb_free(avc->policydb);
-		sepol_handle_destroy(avc->handle);
-		free(avc);
-		avc = NULL;
-		boollist = NULL;
-		boolcnt = 0;
-
-		/* Boilerplate to return "None" */
-		Py_RETURN_NONE;
-	}
-	return result;
+	if (!PyArg_ParseTuple(args, ":finish"))
+		return NULL;
+	policy_destroy();
+	Py_RETURN_NONE;
 }
 
 static int __policy_init(const char *init_path)
@@ -268,6 +268,10 @@ static int __policy_init(const char *init_path)
 	fp = NULL;
 	sepol_set_policydb(&avc->policydb->p);
 	avc->handle = sepol_handle_create();
+	if (!avc->handle) {
+		PyErr_NoMemory();
+		goto err;
+	}
 	/* Turn off messages */
 	sepol_msg_set_callback(avc->handle, NULL, NULL);
 
@@ -278,6 +282,10 @@ static int __policy_init(const char *init_path)
 		goto err;
 	}
 
+	if (cnt > INT_MAX) {
+		PyErr_SetString(PyExc_OverflowError, "too many booleans\n");
+		goto err;
+	}
 	if (cnt > 0) {
 		boollist = calloc(cnt, sizeof(*boollist));
 		if (!boollist) {
@@ -285,8 +293,13 @@ static int __policy_init(const char *init_path)
 			goto err;
 		}
 
-		sepol_bool_iterate(avc->handle, avc->policydb, load_booleans,
-				   &cnt);
+		rc = sepol_bool_iterate(avc->handle, avc->policydb,
+					load_booleans, &cnt);
+		if (rc < 0 || (unsigned int)boolcnt != cnt) {
+			PyErr_SetString(PyExc_RuntimeError,
+					"unable to load booleans\n");
+			goto err;
+		}
 	}
 
 	/* Initialize the sidtab for subsequent use by sepol_context_to_sid
@@ -297,19 +310,11 @@ static int __policy_init(const char *init_path)
 		goto err;
 	}
 	sepol_set_sidtab(&sidtab);
+	sepol_policy_file_free(pf);
 	return 0;
 
 err:
-	free(boollist);
-	boollist = NULL;
-	if (avc) {
-		if (avc->handle)
-			sepol_handle_destroy(avc->handle);
-		if (avc->policydb)
-			sepol_policydb_free(avc->policydb);
-		free(avc);
-		avc = NULL;
-	}
+	policy_destroy();
 	if (pf)
 		sepol_policy_file_free(pf);
 	if (fp)
@@ -329,6 +334,8 @@ static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args)
 	if (!PyArg_ParseTuple(args, "|s:policy_init", &init_path))
 		return NULL;
 	result = __policy_init(init_path);
+	if (result)
+		return NULL;
 	return Py_BuildValue("i", result);
 }
 
diff --git a/libselinux/tests/audit2why/.gitignore b/libselinux/tests/audit2why/.gitignore
new file mode 100644
index 00000000..84c048a7
--- /dev/null
+++ b/libselinux/tests/audit2why/.gitignore
@@ -0,0 +1 @@
+/build/
diff --git a/libselinux/tests/audit2why/Makefile b/libselinux/tests/audit2why/Makefile
new file mode 100644
index 00000000..c2860a7e
--- /dev/null
+++ b/libselinux/tests/audit2why/Makefile
@@ -0,0 +1,35 @@
+PYTHON ?= python3
+PYTHON_CONFIG ?= $(PYTHON)-config
+LIBSEPOL ?= ../../../libsepol/src/libsepol.a
+LIBSELINUX ?= ../../src/libselinux.so.1
+BUILD = build
+CFLAGS ?= -O2 -g -Wall -Wextra -Werror
+override CPPFLAGS += -I../../../libsepol/include -I../../include
+PY_CFLAGS := $(shell $(PYTHON_CONFIG) --includes)
+WRAPS = sepol_sidtab_init sepol_handle_create sepol_bool_iterate strdup sepol_policy_file_create sepol_policy_file_free
+
+$(BUILD):
+	mkdir -p $@
+
+$(BUILD)/audit2why.o: ../../src/audit2why.c | $(BUILD)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(PY_CFLAGS) -fPIC -Dmalloc=audit_malloc -Dcalloc=audit_calloc -Dstrdup=audit_strdup -Dfree=audit_free -c $< -o $@
+
+$(BUILD)/fault.o: fault.c | $(BUILD)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -D_GNU_SOURCE -fPIC -c $< -o $@
+
+$(BUILD)/audit2why.so: $(BUILD)/audit2why.o $(BUILD)/fault.o $(LIBSEPOL) $(LIBSELINUX)
+	$(CC) -shared $(LDFLAGS) -o $@ $^ $(foreach sym,$(WRAPS),-Wl,--wrap=$(sym)) -Wl,-rpath,$(abspath $(dir $(LIBSELINUX)))
+
+$(BUILD)/policy: policy.c $(LIBSEPOL) | $(BUILD)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBSEPOL)
+
+$(BUILD)/policy.bin: policy.cil $(BUILD)/policy
+	./$(BUILD)/policy $< $@
+
+test: $(BUILD)/audit2why.so $(BUILD)/policy.bin
+	PYTHONPATH=$(abspath $(BUILD)) $(PYTHON) test.py $(abspath $(BUILD)/policy.bin)
+
+clean:
+	rm -rf $(BUILD)
+
+.PHONY: test clean
diff --git a/libselinux/tests/audit2why/fault.c b/libselinux/tests/audit2why/fault.c
new file mode 100644
index 00000000..350c51fa
--- /dev/null
+++ b/libselinux/tests/audit2why/fault.c
@@ -0,0 +1,150 @@
+#include <assert.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sepol/booleans.h>
+#include <sepol/policydb/sidtab.h>
+
+void audit_fault(int kind, int nth);
+int audit_fault_hits(void);
+int audit_live(void);
+void *audit_malloc(size_t size);
+void *audit_calloc(size_t n, size_t size);
+char *audit_strdup(const char *s);
+void audit_free(void *p);
+int __real_sepol_sidtab_init(sidtab_t *s);
+int __wrap_sepol_sidtab_init(sidtab_t *s);
+sepol_handle_t *__real_sepol_handle_create(void);
+sepol_handle_t *__wrap_sepol_handle_create(void);
+char *__real_strdup(const char *s);
+char *__wrap_strdup(const char *s);
+int __real_sepol_bool_iterate(sepol_handle_t *, const sepol_policydb_t *,
+			      int (*)(const sepol_bool_t *, void *), void *);
+int __wrap_sepol_bool_iterate(sepol_handle_t *, const sepol_policydb_t *,
+			      int (*)(const sepol_bool_t *, void *), void *);
+int __real_sepol_policy_file_create(sepol_policy_file_t **pf);
+int __wrap_sepol_policy_file_create(sepol_policy_file_t **pf);
+void __real_sepol_policy_file_free(sepol_policy_file_t *pf);
+void __wrap_sepol_policy_file_free(sepol_policy_file_t *pf);
+
+static int mode, position, seen, hits, files;
+static int iterating, in_callback;
+static void *allocations[4096];
+static int (*iterator_callback)(const sepol_bool_t *, void *);
+
+void audit_fault(int kind, int nth)
+{
+	mode = kind;
+	position = nth;
+	seen = hits = 0;
+}
+
+int audit_fault_hits(void)
+{
+	return hits;
+}
+
+int audit_live(void)
+{
+	int n = files;
+	for (size_t i = 0; i < 4096; i++)
+		n += allocations[i] != NULL;
+	return n;
+}
+
+static int fail(int kind)
+{
+	if (mode == kind && ++seen == position) {
+		hits++;
+		errno = ENOMEM;
+		return 1;
+	}
+	return 0;
+}
+
+static void *track(void *p)
+{
+	if (!p)
+		return NULL;
+	for (size_t i = 0; i < 4096; i++) {
+		if (!allocations[i]) {
+			allocations[i] = p;
+			return p;
+		}
+	}
+	abort();
+}
+
+void *audit_malloc(size_t size)
+{
+	return fail(1) ? NULL : track(malloc(size));
+}
+
+char *audit_strdup(const char *s)
+{
+	return fail(2) ? NULL : track(strdup(s));
+}
+
+void *audit_calloc(size_t n, size_t size)
+{
+	return fail(5) ? NULL : track(calloc(n, size));
+}
+
+void audit_free(void *p)
+{
+	for (size_t i = 0; i < 4096; i++)
+		if (allocations[i] == p)
+			allocations[i] = NULL;
+	free(p);
+}
+
+int __wrap_sepol_sidtab_init(sidtab_t *s)
+{
+	return fail(6) ? -ENOMEM : __real_sepol_sidtab_init(s);
+}
+
+sepol_handle_t *__wrap_sepol_handle_create(void)
+{
+	return fail(7) ? NULL : __real_sepol_handle_create();
+}
+
+char *__wrap_strdup(const char *s)
+{
+	if (iterating && !in_callback && fail(4))
+		return NULL;
+	return __real_strdup(s);
+}
+
+static int callback(const sepol_bool_t *b, void *arg)
+{
+	in_callback = 1;
+	int rc = iterator_callback(b, arg);
+	in_callback = 0;
+	return rc;
+}
+
+int __wrap_sepol_bool_iterate(sepol_handle_t *h, const sepol_policydb_t *p,
+			      int (*fn)(const sepol_bool_t *, void *),
+			      void *arg)
+{
+	iterator_callback = fn;
+	iterating = 1;
+	int rc = __real_sepol_bool_iterate(h, p, callback, arg);
+	iterating = 0;
+	return rc;
+}
+
+int __wrap_sepol_policy_file_create(sepol_policy_file_t **pf)
+{
+	int rc = __real_sepol_policy_file_create(pf);
+	if (!rc)
+		files++;
+	return rc;
+}
+
+void __wrap_sepol_policy_file_free(sepol_policy_file_t *pf)
+{
+	if (pf)
+		files--;
+	__real_sepol_policy_file_free(pf);
+}
diff --git a/libselinux/tests/audit2why/policy.c b/libselinux/tests/audit2why/policy.c
new file mode 100644
index 00000000..f4739d92
--- /dev/null
+++ b/libselinux/tests/audit2why/policy.c
@@ -0,0 +1,31 @@
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sepol/cil/cil.h>
+
+int main(int argc, char **argv)
+{
+	assert(argc == 3);
+	FILE *f = fopen(argv[1], "rb");
+	assert(f);
+	char text[8192];
+	size_t n = fread(text, 1, sizeof(text), f);
+	assert(n && n < sizeof(text) && !ferror(f));
+	assert(!fclose(f));
+	cil_db_t *db;
+	sepol_policydb_t *p;
+	cil_db_init(&db);
+	assert(!cil_add_file(db, argv[1], text, n));
+	assert(!cil_compile(db));
+	assert(!cil_build_policydb(db, &p));
+	void *image;
+	size_t len;
+	assert(!sepol_policydb_to_image(NULL, p, &image, &len));
+	f = fopen(argv[2], "wb");
+	assert(f && fwrite(image, 1, len, f) == len);
+	assert(!fclose(f));
+	free(image);
+	sepol_policydb_free(p);
+	cil_db_destroy(&db);
+	return 0;
+}
diff --git a/libselinux/tests/audit2why/policy.cil b/libselinux/tests/audit2why/policy.cil
new file mode 100644
index 00000000..2036a833
--- /dev/null
+++ b/libselinux/tests/audit2why/policy.cil
@@ -0,0 +1,21 @@
+(handleunknown deny)
+(mls true)
+(sid security)
+(sidorder (security))
+(sensitivity s0)
+(sensitivityorder (s0))
+(user system_u)
+(userrole system_u object_r)
+(userlevel system_u (s0))
+(userrange system_u ((s0) (s0)))
+(role object_r)
+(roletype object_r test_t)
+(type test_t)
+(sidcontext security (system_u object_r test_t ((s0) (s0))))
+(class file (read write))
+(classorder (file))
+(allow test_t self (file (read)))
+(boolean first_bool false)
+(boolean second_bool false)
+(booleanif first_bool (true (allow test_t self (file (write)))))
+(booleanif second_bool (true (allow test_t self (file (write)))))
diff --git a/libselinux/tests/audit2why/test.py b/libselinux/tests/audit2why/test.py
new file mode 100644
index 00000000..36aef535
--- /dev/null
+++ b/libselinux/tests/audit2why/test.py
@@ -0,0 +1,52 @@
+import ctypes
+import os
+import subprocess
+import sys
+
+
+def analyze(api, permission="read"):
+    return api.analyze("system_u:object_r:test_t:s0",
+                       "system_u:object_r:test_t:s0", "file", [permission])
+
+
+def child(policy, kind, nth):
+    import audit2why as api
+    fault = ctypes.CDLL(api.__file__)
+    fault.audit_fault.argtypes = [ctypes.c_int, ctypes.c_int]
+    api.finish()
+    if kind:
+        fault.audit_fault(kind, nth)
+        try:
+            api.init(policy)
+        except (RuntimeError, MemoryError) as exc:
+            assert not isinstance(exc, SystemError), str(exc)
+        else:
+            raise AssertionError("init accepted an injected failure")
+        assert fault.audit_fault_hits() == 1
+        assert fault.audit_live() == 0
+        assert analyze(api) == (api.NOPOLICY, None)
+        api.finish()
+        api.finish()
+    fault.audit_fault(0, 0)
+    for _ in range(3):
+        assert api.init(policy) == 0
+        assert analyze(api) == (api.ALLOW, None)
+        try:
+            api.init(policy)
+        except RuntimeError:
+            pass
+        else:
+            raise AssertionError("double init accepted")
+        api.finish()
+        assert fault.audit_live() == 0
+
+
+if len(sys.argv) == 4:
+    child(sys.argv[1], int(sys.argv[2]), int(sys.argv[3]))
+else:
+    cases = [(0, 0), (6, 1), (7, 1)]
+    cases += [(kind, nth) for kind in (1, 2, 4, 5) for nth in (1, 2)]
+    for kind, nth in cases:
+        subprocess.run([sys.executable, __file__, sys.argv[1], str(kind), str(nth)],
+                       check=True, timeout=30, env=os.environ)
+    print("audit2why initialization: 11 cases passed")
-- 
2.56.0

