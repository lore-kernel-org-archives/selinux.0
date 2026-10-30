Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388545;
	b=jYLrEUZ6klJF3gXyV5+dbafL6DULLLzUUKJRAr3oe4ohl8K20desOKaY6GtoA6jyO/GI
	 rpIrh4EhMgZI/0J+whIx+9xV0GMyNhM+zowL3t0LGdq074+VtXp31jXf+Y7ahp7CBug+6
	 yEHN9+o3SIWQJXlqQ+IQHjTDjy+PQQNKy+XuiikSuGI22tR5fY6tOlgSh3rz0Wp99UnEJ
	 ADO8CPIVMXTtelVrRYa5jAvomDVFwSu+ylKcGwz+8MjapFmsPrd7JCxTLBaZmwPwBEhGX
	 TCXDuyCv6RmADs7+T2zbCT74pu7HaEmnSYTZ1GvVosCet9qgqEnSfARG9IKvhGtVpGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TD+GeaDBH+4MYxcfPfoY3Jbo9G3vICAGWsJHndrcjGo=;
	b=CnCYj2ZjAIU43IgHWKRLtx547ZogoYZg5KQx17qzV9JE260p/zV2UkE81BgXh8gvMNgK
	 uav4qiWwjyq8M+n8JfVpRWo7XFPURAp+jKm51dtsj6UP41AWWg7/qgx57cm2/X5V87Rjy
	 iE3KfgFeFtldMcbB4Upco/b0L0FBRuNIAI2AgCTgL0cdIF/ofq8mZ4oy/6Tt9LhY19WEB
	 4wlHBBiBdTXeMbMRazs1Y9twoeXJfiaVxWqJEeP7dFcmugX9ZzBpBAWZkSqkWJbQQfI1E
	 P+rO10u1wlQvcfXmIjWaOmQQH5U28cLTfakZuSx9hxLg+a+ANkdpGtMNaU7a0j+3kWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HS07UOOc;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1A606A31A
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HS07UOOc
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5363316fa0cso12506461cf.3
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388544; x=1793993344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TD+GeaDBH+4MYxcfPfoY3Jbo9G3vICAGWsJHndrcjGo=;
        b=HS07UOOcWtKphHp7hAsanfN5DqCpEPI4xvKT0CoxhNWF3tf+B7ybzg3TM4Lh5nrqnU
         Y+cQsTN0u3stpJd2OEAaMcUEC/Js/+Xp8ly2gUzwCXoOPxCAOZbe7bmTvMl89m7L4urQ
         mxPndAsEJgb+/g/Q9nYfzQaaoxM3eIIbz9puDyIiYj5qADlF4S7EYjulkN5a4Xax7i0e
         qD7ZUNj68Vrn4AA4eQ/NFTVMmUKPMINA9jSddaDN8I0+A3lP/iRF1SKQS3jH0IpGP4M2
         N2+NSFCCC6zHG+fBGo4RQYfSzXdGM37Kv9+zAR/hFXB6zzvBxwMTbYBSZ1yKbZ1k6iF/
         qjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388544; x=1793993344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TD+GeaDBH+4MYxcfPfoY3Jbo9G3vICAGWsJHndrcjGo=;
        b=vanRUrxofJT63ndW6eqiEUbWmKLwrezvm6mjddRSCCQcN78iLKxbcm2x0cYWfvVOx0
         LyTa66BDrDRvaTPrFb12+JgkjVNCN1Am7e4YwBpRLrL7vec/2P1r98hHo8aKmifMBSBm
         pyHd5ldvgn3rhjF62Lviuyv21dCA1pyhT0BdciO1q61rhjGwuYnvQnaF+bwyNYzUnfk+
         baHZCuhvL0ZyQOe6C3x6rkxRXh7xkYEkXzAnwHjOCX2RTi4ymdEfyua9rrlQOwuieUCd
         1D9TW43oahJPlW2XASsmALoQzDSTFq9Bv4+pOaVVUVgiz8+tOiDmqTbj38u9VWVxgjTo
         1x+w==
X-Gm-Message-State: AFq9FYKeJ1NCda3W9M1ae0oI1nBeLxMP3LB1CwQHE/8Smw/nTlwUu16N
	bCIrsywZoHctLRGUnyQwpSqmBoL/qgco7+St2+WXGEovdjSiaNrcDLynbkgyLNja
X-Gm-Gg: AYBFou05UEczHpKhxsNQCaKpKmzhMgZsmbL9EJQr5levmLr3gx2yZftX+TBYrBv3aQe
	ged8UumhhE5kotOelXuG44Xf5b+vKYP6FA9vV7kaCLSkzaTILYCf9p1i+awhHT3g0eDWLxJW9Lm
	swWDX/H8y0qubhPQLPNLjeVhi1FOq+l6uaLblSlhxyXKh2egAwoCS8iPi4IZMs0py07/w6yLzKG
	5CuomlPu9bHa7x3RvRzKTp8KWw7tdbhraGEw30wbpKqmTOJkS0oBnHo3bohlnsQyJ5zWJagFbmQ
	Im/URm2neCYci3Cv+ofohctqzF4cAD1hkh6yKRoFNEo02oN0YQZOO+aft/EzPsmysXhKYDvSKAp
	rc2VV34TYdwPTLXfP79Ih7IIj3j123PjeZpI6dWif1JXR6ytE8j4L6xoKNBlYMjjhBQN6EK9sbl
	2ONIJaKDr9wgwpbqPrmRd+/ZwDuHbRrfp/ykfXRkb03ulfFHYg8uPBTfPl8zKUB2HdD9MFOPEUy
	ys3OYdENVbiATg5rhvNdyZB/YYYkP62avxd5xIdsr6NHpuqPK+q4L1xdAo77z4GX4uvTx4rn1/z
	8L0ucPH7q0igEDZLf7DoDBrN2Yr0dz/XPOcAHEtOLF3P8Qcex3ECO0/iq9FU2Y1CAJWar6RdX7Y
	lttlCO6ZVtvuXwzYSnPC9Kg6lgvh+KSdhYtsd5EqERMBZttiPj/wY6Em8LmZJSx3qLv2q68o9vq
	NLOvDw1wrl0WPWpxtT0BhG2CO3Hxoajc1Jpxk80HPzL7WOmUGIJR8=
X-Received: by 2002:ac8:5a47:0:b0:535:d4d8:eed6 with SMTP id d75a77b69052e-542b7144f56mr50630841cf.32.1793388543522;
        Fri, 30 Oct 2026 12:29:03 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:03 -0700 (PDT)
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
Subject: [PATCH 01/11] libsemanage/tests: cover user join caches across transactions
Date: Fri, 30 Oct 2026 15:28:38 -0400
Message-ID: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
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

Retain regression coverage for the user join cache synchronization fixed
by 6423998bc7b1 ("libsemanage: synchronize user join caches across
transactions"). The production fix is already upstream; this patch adds
only its previously unmerged tests and build wiring.

Exercise add, modify, and delete with warm and cold caches, both with and
without a read-only store root. Verify persistence after disconnect and
reconnect using isolated stores without loading host policy.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |  10 +-
 .../regression/test_user_join_transaction.c   | 164 ++++++++++++++++++
 libsemanage/tests/regression/user_join.cil    |  18 ++
 4 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_user_join_transaction.c
 create mode 100644 libsemanage/tests/regression/user_join.cil

diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 8a2a866a..796479e6 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,2 +1,3 @@
 libsemanage-tests
+test-user-join-transaction
 *.policy
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 241ff17a..cef19b42 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -5,6 +5,7 @@ CILS = $(sort $(wildcard *.cil))
 ###########################################################################
 
 EXECUTABLE = libsemanage-tests
+USER_JOIN_TEST = test-user-join-transaction
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
 override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
@@ -12,7 +13,10 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES)
+all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST)
+
+$(USER_JOIN_TEST): regression/test_user_join_transaction.c ../src/libsemanage.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
@@ -21,8 +25,8 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST)
 
 test: all
 	./$(EXECUTABLE)
-
+	./$(USER_JOIN_TEST)
diff --git a/libsemanage/tests/regression/test_user_join_transaction.c b/libsemanage/tests/regression/test_user_join_transaction.c
new file mode 100644
index 00000000..cf96b7db
--- /dev/null
+++ b/libsemanage/tests/regression/test_user_join_transaction.c
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <libgen.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/selinux.h>
+#include <semanage/semanage.h>
+
+#include "handle.h"
+#include "semanage_store.h"
+
+static void write_file(semanage_handle_t *sh, const char *path,
+		       const char *data)
+{
+	char *parent = strdup(path);
+	FILE *fp;
+
+	assert(parent);
+	assert(semanage_mkpath(sh, dirname(parent)) == 0);
+	free(parent);
+	fp = fopen(path, "w");
+	assert(fp);
+	assert(fputs(data, fp) >= 0);
+	assert(fclose(fp) == 0);
+}
+
+static void set_program(external_prog_t *prog)
+{
+	assert(prog);
+	free(prog->path);
+	free(prog->args);
+	prog->path = strdup("/bin/true");
+	prog->args = strdup("");
+	assert(prog->path && prog->args);
+}
+
+static void check_user(semanage_handle_t *sh, semanage_user_key_t *key,
+		       const char *prefix)
+{
+	semanage_user_t *user = NULL;
+	unsigned int count;
+	int exists;
+
+	assert(semanage_user_exists_local(sh, key, &exists) >= 0);
+	assert(exists == (prefix != NULL));
+	assert(semanage_user_count_local(sh, &count) >= 0);
+	assert(count == (prefix ? 1U : 0U));
+	if (prefix) {
+		assert(semanage_user_query_local(sh, key, &user) >= 0);
+		assert(strcmp(semanage_user_get_prefix(user), prefix) == 0);
+		assert(semanage_user_has_role(user, "test_r"));
+		semanage_user_free(user);
+	}
+}
+
+static void run_case(int ro, int warm, int operation)
+{
+	char root[] = "/tmp/semanage-user-join-XXXXXX";
+	semanage_handle_t *sh;
+	semanage_user_t *user = NULL;
+	semanage_user_key_t *key = NULL;
+	const char *expected = operation == 2 ? NULL : "updated";
+	const char *path;
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
+	set_program(sh->conf->sefcontext_compile);
+	set_program(sh->conf->setfiles);
+	if (ro) {
+		assert(sh->conf->n_ro_store_roots == 0);
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
+	assert(semanage_disconnect(sh) == 0);
+
+	/* Seed either vendor or writable records; operation 0 tests addition. */
+	if (operation != 0) {
+		path = ro ? semanage_ro_active_path(0,
+						    SEMANAGE_USERS_BASE_LOCAL) :
+			    semanage_path(SEMANAGE_ACTIVE,
+					  SEMANAGE_USERS_BASE_LOCAL);
+		write_file(
+			sh, path,
+			"user first_u roles { test_r } level s0 range s0;\n");
+		path = ro ? semanage_ro_active_path(
+				    0, SEMANAGE_USERS_EXTRA_LOCAL) :
+			    semanage_path(SEMANAGE_ACTIVE,
+					  SEMANAGE_USERS_EXTRA_LOCAL);
+		write_file(sh, path, "user first_u prefix original;\n");
+	}
+	assert(semanage_connect(sh) == 0);
+	assert(semanage_user_key_create(sh, "first_u", &key) == 0);
+	if (warm)
+		check_user(sh, key, operation ? "original" : NULL);
+	serial = semanage_direct_get_serial(sh);
+	assert(serial >= 0);
+	assert(semanage_begin_transaction(sh) == 0);
+	assert(semanage_direct_get_serial(sh) == serial);
+	if (operation == 2) {
+		assert(semanage_user_del_local(sh, key) >= 0);
+	} else {
+		assert(semanage_user_query(sh, key, &user) >= 0);
+		assert(semanage_user_set_prefix(sh, user, expected) == 0);
+		assert(semanage_user_modify_local(sh, key, user) >= 0);
+		semanage_user_free(user);
+	}
+	assert(semanage_commit(sh) >= 0);
+	assert(semanage_disconnect(sh) == 0);
+	assert(semanage_connect(sh) == 0);
+	check_user(sh, key, expected);
+	semanage_user_key_free(key);
+	assert(semanage_disconnect(sh) == 0);
+	semanage_handle_destroy(sh);
+	assert(semanage_remove_directory(root) == 0);
+}
+
+/* Store paths are process-global. Each case runs without touching host policy. */
+int main(void)
+{
+	int ro, warm, operation, status;
+	pid_t pid;
+
+	for (ro = 0; ro < 2; ro++) {
+		for (warm = 0; warm < 2; warm++) {
+			for (operation = 0; operation < 3; operation++) {
+				pid = fork();
+				assert(pid >= 0);
+				if (pid == 0) {
+					run_case(ro, warm, operation);
+					_exit(0);
+				}
+				assert(waitpid(pid, &status, 0) == pid);
+				assert(WIFEXITED(status) &&
+				       WEXITSTATUS(status) == 0);
+			}
+		}
+	}
+	puts("User JOIN transaction tests passed.");
+	return 0;
+}
diff --git a/libsemanage/tests/regression/user_join.cil b/libsemanage/tests/regression/user_join.cil
new file mode 100644
index 00000000..74850af8
--- /dev/null
+++ b/libsemanage/tests/regression/user_join.cil
@@ -0,0 +1,18 @@
+(handleunknown allow)
+(mls true)
+(sid security)
+(sidorder (security))
+(sensitivity s0)
+(sensitivityorder (s0))
+(user first_u)
+(role object_r)
+(role test_r)
+(type test_t)
+(userrole first_u test_r)
+(userlevel first_u (s0))
+(userrange first_u ((s0) (s0)))
+(roletype test_r test_t)
+(sidcontext security (first_u object_r test_t ((s0) (s0))))
+(class test_class (test_perm))
+(classorder (test_class))
+(allow test_t self (test_class (test_perm)))
-- 
2.56.0

