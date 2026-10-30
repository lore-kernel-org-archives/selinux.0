Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388547;
	b=IEcbFAaCHHZMdUr3ijZYfuNHSBGSGbE6HGudD0pADRwJGsCU+nYaZlBpKIluYGCZdRv8
	 5xpz8SjzqoMx886erIJNckxnXZ1tMYOKc0o/dObTapmMqnonEbN2d5NPH0U6+zPXJSOAi
	 t4GZF9IkfKf+moEy//WKZm/pnaaJLTO6riFQsAjjbrcQGW6gY9lhlxtJ88k7qgwdfDdTZ
	 C7bjpJDT3UxLpb1dZ92rp1f6noFICNEudmRuwlNPo1EJC6Ov2OLCIvmdriKwkzRkGNKg9
	 RlHxMtKgB20EwqgCvfTFsxj/Mrh3LURV3z7VEt20uigYOXBKnNBAVFbC3r8gIM0meNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=090mrxbGlCp5OLW9NA9RE2+cjdS2t9j5tow9k66y1DI=;
	b=OIQv9EH0h9FXF0hVgZVK5elErAFqcwGuCOpzTDwOEY1Rh1tYsD2HACZpfKdvJJP/kKOV
	 QlYLZzXRxmd3oDvMOL51erMbC8St62gpQiQA0Ng0sTYrLoYgcxNmzMu7GmqWqK/kLbP1n
	 mWSXYdbME02rjjN3w9Jc4g41ommVjI3vLfwUgmgkmmM+OvcEowifXfnJIgnYSrbUQftY7
	 YWwU6Ix6e9bgJMjh8dbhVDaIqFTKP8YXp78QgsImLU+dFv+rOiASRpGtj5bedG3qUoVXb
	 2hQirOXVuEAd/72/EOz4ME6PkEoLfei8i8CQfotvMJfu7iKI/3tHFQwPCxC6l3vVLAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSXD172d;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65193606A321
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65193606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSXD172d
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53665358476so11977121cf.2
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388546; x=1793993346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=090mrxbGlCp5OLW9NA9RE2+cjdS2t9j5tow9k66y1DI=;
        b=tSXD172dlGNNnC7VD5f97BeVJHa84B4/i0jHF8zjE63u/8RfPqeUQTXv8pnIv9dUy5
         dtFdNu42vAeCc/pmbFw3y9gjTLtHXJxxSuTRhCHCKHp/8stEa8EzJMAx1zxhPYXWsX8j
         J5+oQoZsNenZtux5D6ZSSdYWsgadUsyh8PpMkRkCvNWKem1Wd1AL00NdyKYUaPXnISwf
         p4m+0ACURNc3VcxzmeoIEA3JgmDRifKfRJYr/Hl4Nh3z0SAgIffH2aiCqgEKpc2GhwT5
         yoV1mcSIEpL9qu3HRIHQruz3MFC2WL0Sj9TFmLl8yGztAsMW/dx1EzVATtdbCjeJiDjL
         rRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388546; x=1793993346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=090mrxbGlCp5OLW9NA9RE2+cjdS2t9j5tow9k66y1DI=;
        b=q93xQjUXZEyfLPsEPRXxvQ8HlmEoLrFqoY9Z2xuoXkOJ1l8XtDLHRxGUFx72QhhYwD
         7aYekBR+wUC4Luw5ckxh0Z0MsEAnvRZue8utLNWZgmrJu0iOAEKyu1TqKSWGhtTuo3lJ
         P2fP6pdB2lEuGQBO5Xgpwewv1wSM1W4PdPSCd8pMj31OndW/v+FkKI5LmDjSXYW5yfH6
         XSjTskkl8NY2AlcGKRlO+Bpq4qd+0dBL5gRigbYEpQcwJu4vnftPp/embWtb9CbegTXJ
         bAKKAFRVStnMlXd1Hyt6ANot4xuUQ6tcdQ4m7LhhkFBJ44+KjOGQYh+n+zsO/9w4SFhH
         DVGg==
X-Gm-Message-State: AFq9FYLZk8hwzqI/r9AOyxS4GiUyHt326e4J40UYQYgNqWmbHTZbHPW2
	e8wByq3V+abeo/BxaC3khk9US3AZlDmfyH3o78XxQJUKUbQCHHSBIkBl/o8d0Pmv
X-Gm-Gg: AYBFou1Psd/DaZjlL6Yl5MoovZsXHuBwTrVOhsh0x+2mSRdgZSFxAi0PjEj/pXyLTS+
	2QR4IdA6N9n/Du1OJGp55O7XOlE8tgtyesO4O4bMTturdC/wTXwwgsC9UM0/BWxwdh6nASkNg5x
	KPUCA9hwfNuAY64uNMWjY68lXpeW9VkSTw2lq1Db30eMUQPuiLDvTvBgYABFKgVzBjc/Ovm+BmL
	t5TqJ5PaYeP+UyP1/lYH2EBFWkbNBB2m8UYC9oozvk7Q1N1mP1M6i+l22fgbgXv547QnoY1Qtgr
	BYbML4xWK3mhaP7qETN/5gB5qmWOB2LyfEqOoCPCcXj0AyC6Ox2F8AD60mnO2S6od5jPd0yzEOl
	Gb/i21hpvQ2KWeBYV7XdubEELKR7zsJwFJHcDBzOG01hZln4wfw5yTKXEvfoTBdOV8qdbKxUXxQ
	GvHCzUPODVH6XP498FlJWENzMmsO5AQwvnv5/CMogm37Rgc0tLMO3ijpS4K6kbllCsabt7aUhJt
	VrVKlW6KzOwZZUd+H5Tvwg3SoqS4cRfNt+w1bGWItkGE1JOLlISkIOwCz9aovVOXKBIIbKEyt1J
	S8pw7ZnBKDI6JgJPjZA6NosIf8KVdRetB9rj7j7jbc52IyTuuPVJxgD7JWr5GNGuoC0nmSiUotN
	3gd/VqD80QlM5dtxa20ZGb7frBDF0kl+D4r5g/IEIAO1M3DNIDKede1O/h4vYOCqFKx9n8hgRSr
	dqsDS/Gh7aYSbea+loGMZK4tbbKZkb7FbquIywecwu01Q+92BAYvRisKUnD9fukU0UImdB1ZWR
X-Received: by 2002:ac8:5dd3:0:b0:536:48df:345a with SMTP id d75a77b69052e-542b6d612e7mr52272001cf.32.1793388545976;
        Fri, 30 Oct 2026 12:29:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:05 -0700 (PDT)
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
Subject: [PATCH 05/11] libsemanage: reset handle state after transaction and disconnect errors
Date: Fri, 30 Oct 2026 15:28:42 -0400
Message-ID: <20261030192849.151830-5-stephen.smalley.work@gmail.com>
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

A failed commit ends the transaction but can leave modified database
caches at the active store serial. Starting another transaction on the
same handle recreates the sandbox while boolean cache markers miss the
intervening state change, allowing stale records to carry into the new
transaction.

Drop cached database views after each completed backend commit attempt,
after policy databases have been detached, and preserve the backend
return value and errno.

The direct disconnect backend also releases database objects when
temporary-file cleanup fails. Clear the public connection flags and
database configurations even in that case, retaining the cleanup error
while making repeated disconnect harmless. Document this behavior.

Add lifecycle regression coverage for failed and successful commits,
immediate transaction restart, failed and successful disconnects,
repeated disconnect, and error preservation.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/include/semanage/handle.h         |   3 +-
 libsemanage/src/handle.c                      |  22 ++-
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |   9 +-
 .../tests/regression/test_handle_lifecycle.c  | 135 ++++++++++++++++++
 5 files changed, 162 insertions(+), 8 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_handle_lifecycle.c

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index d699f615..b79abb8a 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -126,7 +126,8 @@ extern int semanage_connect(semanage_handle_t *);
 /* Disconnect from the manager given by the handle.  If already
  * disconnected then this function does nothing.  Return 0 if
  * disconnected properly or already disconnected, negative value on
- * error. */
+ * error.  The handle is disconnected even if temporary-file cleanup
+ * fails; a repeated disconnect is harmless. */
 extern int semanage_disconnect(semanage_handle_t *);
 
 /* Attempt to obtain a transaction lock on the manager.	 If another
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 1ff86e60..3013034a 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -353,17 +353,20 @@ int semanage_access_check(semanage_handle_t *sh)
 
 int semanage_disconnect(semanage_handle_t *sh)
 {
+	int retval = 0;
+
 	assert(sh != NULL);
 	if (!sh->is_connected) {
 		return 0;
 	}
-	if (sh->funcs && sh->funcs->disconnect(sh) < 0) {
-		return -1;
-	}
+	if (sh->funcs)
+		retval = sh->funcs->disconnect(sh);
+	/* The backend releases its databases even when disk cleanup fails. */
+	memset(sh->dbase, 0, sizeof(sh->dbase));
 	sh->is_in_transaction = 0;
 	sh->is_connected = 0;
 	sh->modules_modified = 0;
-	return 0;
+	return retval;
 }
 
 void semanage_handle_destroy(semanage_handle_t *sh)
@@ -400,7 +403,7 @@ int semanage_begin_transaction(semanage_handle_t *sh)
 
 int semanage_commit(semanage_handle_t *sh)
 {
-	int retval;
+	int retval, errsv, i;
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
@@ -408,7 +411,16 @@ int semanage_commit(semanage_handle_t *sh)
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);
+	errsv = errno;
+	/* A completed attempt ends this transaction, including its cached views. */
+	for (i = 0; i < DBASE_COUNT; i++) {
+		dbase_config_t *dbase = &sh->dbase[i];
+
+		if (dbase->dtable && dbase->dbase)
+			dbase->dtable->drop_cache(dbase->dbase);
+	}
 	sh->is_in_transaction = 0;
 	sh->modules_modified = 0;
+	errno = errsv;
 	return retval;
 }
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 739a885b..1cf9527b 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,5 +1,6 @@
 libsemanage-tests
 test-user-join-transaction
+test-handle-lifecycle
 test-parse-read-error
 test-read-lock-error
 test-user-delete-error
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index e314ba52..60e48dce 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -6,6 +6,7 @@ CILS = $(sort $(wildcard *.cil))
 
 EXECUTABLE = libsemanage-tests
 USER_JOIN_TEST = test-user-join-transaction
+LIFECYCLE_TEST = test-handle-lifecycle
 ERROR_TESTS = test-read-lock-error test-user-delete-error test-parse-read-error
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
@@ -14,7 +15,10 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(ERROR_TESTS)
+all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS)
+
+$(LIFECYCLE_TEST): regression/test_handle_lifecycle.c ../src/libsemanage.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 test-read-lock-error: regression/test_read_lock_error.c ../src/database.c
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
@@ -35,11 +39,12 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(ERROR_TESTS)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS)
 
 test: all
 	./$(EXECUTABLE)
 	./$(USER_JOIN_TEST)
+	./$(LIFECYCLE_TEST)
 	./test-parse-read-error
 	./test-read-lock-error
 	./test-user-delete-error
diff --git a/libsemanage/tests/regression/test_handle_lifecycle.c b/libsemanage/tests/regression/test_handle_lifecycle.c
new file mode 100644
index 00000000..779664ed
--- /dev/null
+++ b/libsemanage/tests/regression/test_handle_lifecycle.c
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "handle.h"
+
+static int commit_result;
+static int disconnect_result;
+static int commits;
+static int disconnects;
+static int drops;
+static int begins;
+static int backend_returned;
+
+static int begin(semanage_handle_t *sh)
+{
+	assert(!sh->is_in_transaction);
+	begins++;
+	return 0;
+}
+
+static int commit(semanage_handle_t *sh)
+{
+	assert(sh->is_in_transaction);
+	commits++;
+	backend_returned = 1;
+	errno = commit_result < 0 ? EIO : 0;
+	return commit_result;
+}
+
+static void drop(dbase_t *db)
+{
+	assert(backend_returned);
+	*(int *)db = 0;
+	drops++;
+	/* A cache destructor must not replace the commit error. */
+	errno = EINVAL;
+}
+
+static int disconnect(semanage_handle_t *sh)
+{
+	int i;
+
+	assert(sh->is_connected);
+	disconnects++;
+	for (i = 0; i < DBASE_COUNT; i++)
+		free(sh->dbase[i].dbase);
+	errno = disconnect_result < 0 ? EACCES : 0;
+	return disconnect_result;
+}
+
+static const dbase_table_t table = { .drop_cache = drop };
+static const struct semanage_policy_table funcs = {
+	.begin_trans = begin,
+	.commit = commit,
+	.disconnect = disconnect,
+};
+
+static void check_commit(int result)
+{
+	semanage_handle_t sh = { .funcs = &funcs, .is_connected = 1 };
+	int cached[DBASE_COUNT];
+	int i;
+
+	commits = drops = begins = backend_returned = 0;
+	commit_result = result;
+	for (i = 0; i < DBASE_COUNT; i++) {
+		cached[i] = 20;
+		sh.dbase[i].dbase = (dbase_t *)&cached[i];
+		sh.dbase[i].dtable = &table;
+	}
+	/* No transaction: do not call the backend or discard any cache. */
+	assert(semanage_commit(&sh) < 0);
+	assert(commits == 0 && drops == 0);
+	assert(semanage_begin_transaction(&sh) == 0);
+	assert(semanage_begin_transaction(&sh) == 0 && begins == 1);
+	assert(drops == 0);
+	sh.modules_modified = 1;
+	assert(semanage_commit(&sh) == result);
+	assert(errno == (result < 0 ? EIO : 0));
+	assert(!sh.is_in_transaction && !sh.modules_modified);
+	assert(commits == 1 && drops == DBASE_COUNT);
+	for (i = 0; i < DBASE_COUNT; i++)
+		assert(cached[i] == 0);
+	/* No intervening read: a new transaction must not inherit old records. */
+	assert(semanage_begin_transaction(&sh) == 0 && begins == 2);
+	for (i = 0; i < DBASE_COUNT; i++)
+		assert(cached[i] == 0);
+	printf("commit result %d: all caches dropped, immediate restart clean\n",
+	       result);
+}
+
+static void check_disconnect(int result)
+{
+	semanage_handle_t sh = {
+		.funcs = &funcs,
+		.is_connected = 1,
+		.is_in_transaction = 1,
+		.modules_modified = 1,
+	};
+	int i;
+
+	disconnects = 0;
+	disconnect_result = result;
+	for (i = 0; i < DBASE_COUNT; i++) {
+		sh.dbase[i].dbase = malloc(1);
+		assert(sh.dbase[i].dbase);
+		sh.dbase[i].dtable = &table;
+	}
+	assert(semanage_disconnect(&sh) == result);
+	assert(errno == (result < 0 ? EACCES : 0));
+	assert(!semanage_is_connected(&sh));
+	assert(!sh.is_in_transaction && !sh.modules_modified);
+	for (i = 0; i < DBASE_COUNT; i++) {
+		assert(!sh.dbase[i].dbase);
+		assert(!sh.dbase[i].dtable);
+	}
+	assert(semanage_disconnect(&sh) == 0 && disconnects == 1);
+	assert(semanage_begin_transaction(&sh) < 0);
+	printf("disconnect result %d: state cleared, repeat did not free twice\n",
+	       result);
+}
+
+int main(void)
+{
+	check_commit(-1);
+	check_commit(8);
+	check_disconnect(-1);
+	check_disconnect(0);
+	puts("Handle lifecycle tests passed.");
+	return 0;
+}
-- 
2.56.0

