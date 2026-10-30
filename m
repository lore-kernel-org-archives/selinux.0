Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388550;
	b=2C91ZVdiHC/3VqMPM3u2cwLARzEBfyNw9we8m+KBWGlZqXFow/PbNAzy1KoBCCbbLq2d
	 wcEcL0mSMsNjz+VPp5rneisr0KhIypoM2Ii0xFA6Eq3jwbPTDOxp2PHVwNHIZIhL+jD/G
	 LqFnz6F/RAsVbhz4D268o+Kg1XTwTHQ4MbyNd33vVv+wTpZUD4WqKTxNzo9TmeYmtGbNA
	 dLENPNbia2rIdo8gxTS7yKZcaBPZAXTmunTUz69NV+qxrQr9oBNNpRPj7cHQCZviXxz3y
	 UAd/Iqan1nLTBPW3/IJgdGS+DzDAaDmNLOcbyyxEgJ8jeoo8xKjYFtThMKJfC02YaZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VraW9hNsD/9eKRzAOB8GI675LBs+BGfUzc70PCVCGyI=;
	b=pexg1upJHpcWWDsOJ18jLo+z1AS0p5dOGeX3Jpbr+r+dWflEaqwVCUw8gyME3uEZ/hHJ
	 OHeFwHHpUiYU/a1qSk53FqUS87KTtamPjqYVqRrCvooOghBb9f/fxdLDL1qHmk1hQrCIC
	 vQ9UOxrR6qgk4DCOTz2thd4aZFtoXjTcFfdOnA825STh9N3Lpe2eIeG28H79vhEb2EmVT
	 JNOLJe+1qM4A+mlUKh2I1Q4fEnk8pHYVmdIEcHRtgiITq3Ir4cbJFBuHNHnfw20i7Z3Na
	 V6nKt8dexNCfJJAKRBgu2NO9CugGyuQJwmLFtmRbCu/3VsPi7H0N8m7HpvaZM1CI3Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBStkAAz;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A5606A31A
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 097A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBStkAAz
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53644b28706so15154881cf.3
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388549; x=1793993349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VraW9hNsD/9eKRzAOB8GI675LBs+BGfUzc70PCVCGyI=;
        b=RBStkAAzahoYu1pI6AR5GFK6sRYHJHixjjOuBmKz/IADNnB5sJ/WCjWdP59sjLJwvU
         SwQbPad2GLcshIvGSQ6ZL2HjRlHbZyQ6lkcqLiFk4pF+LWLch66Wyr6N1rkdC0GPGtE9
         glVmAZLmIBt1bo3MQIk0oe6I0GgflMcsMEw2tz5hrgDvkjZPxEOoWPpdHqbI39jwLQBo
         3i8LkIK2RlhfRZ5OzAiS0RiL0QGbySGIMWLNHhRxyJ13CaH6p3NMA5u3RZmr5zBUbFZg
         qcCBeIYdsVmaWWwHRiJAyaGwysyZ2bhA28T8hsqXX4x5o09kid28Dc+tTNYDauj41g+X
         RNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388549; x=1793993349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VraW9hNsD/9eKRzAOB8GI675LBs+BGfUzc70PCVCGyI=;
        b=mls2ytAzvlQ4v/XP0UqRzGN9VOx+H1eOAU8zebkvIaVSj3wYOX+AEXSbLcNzB9tQjL
         x8aE3amOJEAdWkJZumfSUTAQzs5nht1HSYKywkuXEkNiyn8G5N7goVtAqJo8DI3m3CPT
         ajZQtOVbKsVIZlw7gCKnhiW2v08JUaC3SPmGFN5HjlMMbwzxYC9L8V//h8V4S1VG6cVR
         DSJveU8w8tiEkt6CVQrfeoL0Mvei10uiuHFPTxWjYH8OD6ksjbx48a2+ZMEXO064qQFj
         8E1FtDvvVEv902jDv66ZTp4KkiUdqetvf5RhqFStAZWudoFTrHSI+VGuuhlAB+isgPEU
         jDzA==
X-Gm-Message-State: AFq9FYJgkLLlw3B90VW696S2NOjnu0wf64aroKbyDzxsZadsFiuYUp1A
	25LnXWeYodB7uZ9SEyogl47LmEQ0YxfOnWb3Q5b4O+RypPPuShoFic9YmmNnddN9
X-Gm-Gg: AYBFou0O2K/iRrWXLQ22AwhKpuaGiU4TgtfRhmbdRj2/9vKIHeUO4c0TcmfOZGvVXAb
	4FI7z0t38VZuJ6bOwCrWi1hnSy5zz1BGdW/3gkRzPzgxrwDlrU0dQuNcgxGinO1vPFUI59x86Dw
	nlEbzcrjuBcvIeURsVtw8cpCf/yB6GcGQdYp3g6ffLawU41JoOVoZpFJz0cJcmLanOym7bG2kGC
	bFIv8pyD6Y38J+FLv3Gm/XKgHQHSfgSr1OkElxjmzEDoENIGkK3CJFISfABoAy0YSqi4HcEN9FR
	lY8OoJK9yn/KU3R1MpDKWEEFDYBbgiDMPhfNTvG2SrhJlDmsuiMOdN5toX21ZInOnn6s+CPH/Zm
	m3aJ7OuwcX2450GOKdDnZ9E2rPlfhpj8ft40ZhoQ/ZtBcfH8QnLcaqQyqB4scdK5UvqeYS4YfPO
	EiR0B/ExHY3fV1JoV6o3yxo/CgWg6WQ5COIzaakZkNk+eDn7NUXLPCG6KcriHwfi7sMsFe9OQGw
	lzQ+fub9VWHKpaRgIvFg5jynJwxWggftsdnSLultWrJd5cVBg1QYxxV1dlPY1bDvUXSsx36RPNU
	Ew5U8nz91sIaYkabE74zxtChV+jIMH/fpHYXksjR9O7NxZlW+XfxOJmWsxxaMyxTCP/kWz1Ri3w
	8uY3R4y/OefVRw8timtk7jroLQPOjlZNqJlU2be78w0A3KowDP4lOXIQjUFPI4DoaQImksTY4L1
	0JEQzD9+SdHfpn+nkQJWlXJ9r4dlUNBVMDnkSoT1feskKxIWDMkpus
X-Received: by 2002:ac8:5d8d:0:b0:535:a5f7:d589 with SMTP id d75a77b69052e-542b7ef72bbmr54339981cf.67.1793388548775;
        Fri, 30 Oct 2026 12:29:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:08 -0700 (PDT)
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
Subject: [PATCH 09/11] libsemanage: reset cleanup state when restarting transactions
Date: Fri, 30 Oct 2026 15:28:46 -0400
Message-ID: <20261030192849.151830-9-stephen.smalley.work@gmail.com>
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

Clear commit_err only after both directories for a new transaction have
been initialized. Otherwise a previous failed commit prevents scratch
cleanup even after a later successful commit or disconnect.

Reject final-directory removal failures except an absent directory. A
scandir failure returns -1 for errors other than ENOENT too; accepting
those errors can start a transaction with uncleared final files.

Test failed commit, injected setup failure, successful retry, and fresh
commit or disconnect with and without read-only store roots. Verify
error state, lock release, record persistence, and removal of scratch
files.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c                  |   2 +
 libsemanage/src/semanage_store.c              |   3 +-
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |   9 +-
 .../regression/test_transaction_restart.c     | 175 ++++++++++++++++++
 5 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_transaction_restart.c

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 61650f9a..ffe17b18 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -427,6 +427,8 @@ static int semanage_direct_begintrans(semanage_handle_t *sh)
 	if ((semanage_make_final(sh)) < 0) {
 		goto err_unlock;
 	}
+	/* The new transaction no longer owns the previous failure's files. */
+	sh->commit_err = 0;
 	return 0;
 
 err_unlock:
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 2b6e4c41..05383140 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1207,7 +1207,8 @@ int semanage_make_final(semanage_handle_t *sh)
 	/* Delete store specific dir if it exists. */
 	ret = semanage_remove_directory(semanage_final_path(
 		SEMANAGE_FINAL_TMP, SEMANAGE_FINAL_TOPLEVEL));
-	if (ret < -1) {
+	if (ret < 0 && (ret != -1 || errno != ENOENT)) {
+		ERR(sh, "Could not remove previous final directory.");
 		status = -1;
 		goto cleanup;
 	}
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 241a6783..484d0853 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,5 +1,6 @@
 libsemanage-tests
 test-final-rollback
+test-transaction-restart
 test-user-join-transaction
 test-handle-lifecycle
 test-parse-read-error
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index e312a283..662bbaee 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -6,6 +6,7 @@ CILS = $(sort $(wildcard *.cil))
 
 EXECUTABLE = libsemanage-tests
 ROLLBACK_TEST = test-final-rollback
+RESTART_TEST = test-transaction-restart
 USER_JOIN_TEST = test-user-join-transaction
 LIFECYCLE_TEST = test-handle-lifecycle
 ERROR_TESTS = test-read-lock-error test-user-delete-error test-parse-read-error
@@ -17,7 +18,10 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST)
+all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST) $(RESTART_TEST)
+
+$(RESTART_TEST): regression/test_transaction_restart.c ../src/libsemanage.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,--wrap=scandir -o $@ $^ $(LDLIBS)
 
 $(ROLLBACK_TEST): regression/test_final_rollback.c ../src/libsemanage.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,--wrap=fsync -Wl,--wrap=rename -Wl,--wrap=link -Wl,--wrap=unlinkat -Wl,--wrap=glob -o $@ $^ $(LDLIBS)
@@ -55,7 +59,7 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST) $(RESTART_TEST)
 
 test: all
 	./$(EXECUTABLE)
@@ -66,3 +70,4 @@ test: all
 	./test-user-delete-error
 	@for test in $(SERIAL_TESTS); do ./$$test || exit 1; done
 	./$(ROLLBACK_TEST)
+	./$(RESTART_TEST)
diff --git a/libsemanage/tests/regression/test_transaction_restart.c b/libsemanage/tests/regression/test_transaction_restart.c
new file mode 100644
index 00000000..1f4f4d5d
--- /dev/null
+++ b/libsemanage/tests/regression/test_transaction_restart.c
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <dirent.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/selinux.h>
+#include <semanage/semanage.h>
+
+#include "handle.h"
+#include "semanage_store.h"
+
+static const char *fail_scan;
+
+int __real_scandir(const char *path, struct dirent ***entries,
+		   int (*filter)(const struct dirent *),
+		   int (*compare)(const struct dirent **,
+				  const struct dirent **));
+int __wrap_scandir(const char *path, struct dirent ***entries,
+		   int (*filter)(const struct dirent *),
+		   int (*compare)(const struct dirent **,
+				  const struct dirent **));
+
+int __wrap_scandir(const char *path, struct dirent ***entries,
+		   int (*filter)(const struct dirent *),
+		   int (*compare)(const struct dirent **,
+				  const struct dirent **))
+{
+	if (fail_scan && !strcmp(path, fail_scan)) {
+		fail_scan = NULL;
+		errno = EIO;
+		return -1;
+	}
+	return __real_scandir(path, entries, filter, compare);
+}
+
+static void set_program(external_prog_t *prog)
+{
+	free(prog->path);
+	free(prog->args);
+	prog->path = strdup("/bin/true");
+	prog->args = strdup("");
+	assert(prog->path && prog->args);
+}
+
+static void check_missing(const char *path)
+{
+	struct stat st;
+	assert(lstat(path, &st) < 0 && errno == ENOENT);
+}
+
+static void check_local(semanage_handle_t *sh, semanage_user_key_t *key,
+			const char *prefix)
+{
+	semanage_user_t *user = NULL;
+	int exists;
+	assert(semanage_user_exists_local(sh, key, &exists) >= 0);
+	assert(exists == (prefix != NULL));
+	if (!prefix)
+		return;
+	assert(semanage_user_query_local(sh, key, &user) >= 0);
+	assert(!strcmp(semanage_user_get_prefix(user), prefix));
+	semanage_user_free(user);
+}
+
+static void run_case(int ro, int commit)
+{
+	char root[] = "/tmp/semanage-restart-XXXXXX";
+	char blocker[4096];
+	semanage_handle_t *sh;
+	semanage_user_t *user = NULL;
+	semanage_user_key_t *key = NULL;
+	const char *tmp, *final, *flag;
+	FILE *fp;
+	int serial;
+
+	assert(mkdtemp(root));
+	assert(semanage_set_root(root) == 0);
+	sh = semanage_handle_create_with_path("/dev/null");
+	assert(sh);
+	semanage_select_store(sh, "store", SEMANAGE_CON_DIRECT);
+	semanage_set_store_root(sh, "/store");
+	semanage_set_create_store(sh, 1);
+	semanage_set_reload(sh, 0);
+	sh->conf->relabel_store = 0;
+	sh->conf->disable_genhomedircon = 1;
+	sh->do_check_contexts = 0;
+	set_program(sh->conf->setfiles);
+	set_program(sh->conf->sefcontext_compile);
+	if (ro) {
+		sh->conf->ro_store_root_paths = calloc(1, sizeof(char *));
+		assert(sh->conf->ro_store_root_paths);
+		sh->conf->ro_store_root_paths[0] = strdup("/vendor");
+		assert(sh->conf->ro_store_root_paths[0]);
+		sh->conf->n_ro_store_roots = 1;
+	}
+	assert(semanage_connect(sh) == 0);
+	assert(selinux_set_policy_root(semanage_final_path(
+		       SEMANAGE_FINAL_SELINUX, SEMANAGE_FINAL_TOPLEVEL)) == 0);
+	assert(semanage_module_install_file(sh, "regression/user_join.cil") >=
+	       0);
+	assert(semanage_commit(sh) >= 0);
+	serial = semanage_direct_get_serial(sh);
+	assert(serial >= 0);
+	assert(semanage_user_key_create(sh, "first_u", &key) == 0);
+	assert(semanage_begin_transaction(sh) == 0);
+	assert(semanage_user_query(sh, key, &user) >= 0);
+	assert(semanage_user_set_prefix(sh, user, "abandoned") == 0);
+	assert(semanage_user_modify_local(sh, key, user) >= 0);
+	tmp = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
+	final = semanage_final_path(SEMANAGE_FINAL_TMP,
+				    SEMANAGE_FINAL_TOPLEVEL);
+	flag = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
+	assert(mkdir(flag, 0700) == 0);
+	assert(snprintf(blocker, sizeof(blocker), "%s/keep", flag) <
+	       (int)sizeof(blocker));
+	fp = fopen(blocker, "w");
+	assert(fp && fclose(fp) == 0);
+	assert(semanage_commit(sh) < 0);
+	assert(sh->commit_err < 0 && !sh->is_in_transaction);
+	assert(semanage_direct_get_serial(sh) == serial);
+	assert(access(tmp, F_OK) == 0 && access(final, F_OK) == 0);
+
+	/* Failed setup must retain error state and release the transaction lock. */
+	fail_scan = final;
+	assert(semanage_begin_transaction(sh) < 0);
+	assert(!fail_scan && errno == EIO);
+	assert(!sh->is_in_transaction && sh->commit_err < 0);
+	assert(sh->u.direct.translock_file_fd == -1);
+
+	assert(semanage_begin_transaction(sh) == 0);
+	assert(sh->commit_err == 0);
+	check_local(sh, key, NULL);
+	assert(semanage_user_set_prefix(sh, user, "fresh") == 0);
+	assert(semanage_user_modify_local(sh, key, user) >= 0);
+	semanage_user_free(user);
+	if (commit)
+		assert(semanage_commit(sh) >= 0);
+	assert(semanage_disconnect(sh) == 0);
+	check_missing(tmp);
+	check_missing(final);
+	assert(semanage_connect(sh) == 0);
+	check_local(sh, key, commit ? "fresh" : NULL);
+	assert(semanage_disconnect(sh) == 0);
+	semanage_user_key_free(key);
+	semanage_handle_destroy(sh);
+	assert(semanage_remove_directory(root) == 0);
+}
+
+int main(void)
+{
+	int ro, commit, status;
+	pid_t child;
+
+	for (ro = 0; ro < 2; ro++) {
+		for (commit = 0; commit < 2; commit++) {
+			child = fork();
+			assert(child >= 0);
+			if (!child) {
+				run_case(ro, commit);
+				_exit(0);
+			}
+			assert(waitpid(child, &status, 0) == child);
+			assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+		}
+	}
+	puts("Transaction restart and final-directory cleanup tests passed.");
+	return 0;
+}
-- 
2.56.0

