Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388546;
	b=mqKbdUhoOajIKs6eOGOPLFvvA54VLwCG6xer+jDcru37z813ZZ68y1D79Tbxd+T3WZr0
	 Adf0700CnAwNZRv+aU82GhOavf3MJhpTufBYmj3qmEbTd4SfuKe+P6bbLLlokI4RdK3ED
	 mZXmmXSqgRFhy4ExKjtgh3RelZN9+iwrU5IsAM6XhQFAMpgulMNvFZSVS81VBCQWPc815
	 HtLR48dFXqsM/uuoJ6+/Gf6pHnalfqaUIZi16IAxx+9IrLRXxpwCCEhLXa9sMgTAXkVL9
	 aExLdZiTTSsSLKrT+e1axti7T/K9pLS/T0MhXz7hDmwY4fzTD7BAKDdxcrY5rlEJIBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2qe36Gu5hgzj+GrWIQs15vi0GQBpWEZZpc/cJeoIelo=;
	b=hr2HCrOgJHttT4rPgercFnRvczGn4ZVqUUsMWOSRKaJa1dEy9ByNZLMHq6dwOyrntfHP
	 S8YvX/HYuKP39BY8vaMIFe3Ax5ZCP7HCVl2hJSxvZ183VJESiq/PP9AC75jtU6rjy8lNc
	 yHH/0FsSKIKoKpiEvwWpGx0RsdBcOKCCgF3Vt0w5XIl2wj1S3/mnyK3guGo8gcLEIDw9w
	 1Z7nZI2q3G8gkC4g2/v9v8TE/Xdt5LMN+aWjbElKqPxeiPdlotsHBIs4WyE0dp+nK1xcY
	 9yjKAcPdHpGfozqgkj7/C6cu1tUYS0LdcWZNrJUQX1RuGou/uinl/WLDYZgLuDqWQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g7WU1Umu;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF4606A321
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52FF4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g7WU1Umu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5365d725440so10101691cf.0
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388545; x=1793993345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qe36Gu5hgzj+GrWIQs15vi0GQBpWEZZpc/cJeoIelo=;
        b=g7WU1UmumTxKI/jc4z9LJ9BppJ6knS3h37MIVajoofW6D/lV+zikjRb0+wsdAOkIiH
         rPZc/LJ3DHa7ODFqn/JjqTotq/0FhGlxQyCDRL+UUk8wjbFXhR8900ugcYFGjyvj8SYT
         0ZWExkYFMNqeTKUHrvzymsanQuUWtLjfQ9En503T9OayQG8XtXP3qOBLgUYTGNo9Q0yC
         AD4rfbTba+IrRG796LFRCJgSFwgo73aishyHaPUHwYF8kfNlLNDdTqlt8ro9j2g0L7XY
         Iub5BNf6vv7CTfw0Ibh5JeNI2yZQfuak3lCXxBsRmHYraNBknig7aSS4+g5CUgi+/Y4J
         KPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388545; x=1793993345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2qe36Gu5hgzj+GrWIQs15vi0GQBpWEZZpc/cJeoIelo=;
        b=qWtDgifZvOvoA3e5DSqQBhQ6ih4Y/xxsNASUU6lQzq9vfYBwWOmBxlqfiJm0Se9iv8
         wf3KZ1blvqTF0oAqGn8mC5SequsSu39WtVrcoDvB7GWlbJKtfcuyVCwNlyT3hQzfLI5o
         01KBZAWjozWAmIeafFaIdlk3P/GbMB1deL5WiubW/H7qwZ7FHsXvnh/glzJyc51IGD7y
         /mAmMgqpq60ucSO5hB9EtLVKJclAvYkv5qrgCQvg/eOwEsy5zL44c8UbLiLQ8Txk5DZV
         siirOl7NZJL1/K8y2/LPdrPiVhOYaSdX/wPW8pFy7TWBo5ubO/9n5XVGfIEygdVCdYqk
         q0cw==
X-Gm-Message-State: AFq9FYKCAYchGlw8z2muILwzAdpIBPE0MBgxOrcK+yRkhrzBM6+5GsMs
	Nw+w98HTlBPMi442S7mlrkkUQQhfdKQX0H7CMUiJYrpKGd93thHb6qpEA59geBwe
X-Gm-Gg: AYBFou3h7u0DBC7pvN5DjapgZOp3ZUC8rygCQzV2H3Sq31s8IfQ1ZLaoMM9pCeQgCM7
	A7vH3ebWuiWWzfcLOPuol/ob+iIRBkPIQ1b7koiXEP5BT+tonFz85dCzcSWwT7nvAnHAW9CBG59
	P/T8VgSLoXThcEWvngBuWhK+POi7yvmxtiTMWXaDKVoDB9UdhSoaP50QpKBdc2tXrkX0w027WBh
	NUVyT8X4i7pG194LyZSPqLvw7sq0mNKuTpGIAzIN9CA/jq4f3VFeU3vL5BOV0gRHL+0HIQgLcac
	gmy4HdeAbBvAWIQ7GDgxThSaV5o0x2qlth01olU7QSBye0hHaySy4Hel3Hj/sS4Emuwk1MpzzOt
	UvNzM23KFVs4xkik7jQpiM1vGrw0N2g1Mzpg+3huoPGfsZSGR0lMh5Ruv1YPFH97x50BFAcwUl2
	MkgHJZhfIqG0ykqEXZItMsNOQKHyiStW2MbEZQH1FClkzL4g261mpFhPQVPndO/1fWPgy3COYFS
	wteFEaBn06H26NLvYNUulwN7RiizbrFWVK6CmC4Kd7oz9BazLbwRk7Nna69eU5fSh35mSMdO0DR
	q6/HhPjfCjD0VWv3xXNhHDNbFuZiIFwYmercQl9Afiwos2J+c6Y/p7vclYxLCCyDnCFZhX0OFSn
	0M+ICYQnDYcDFVpqNlIE+OsOfNGpnLnqTSqPQaBqRXFffrXHb/gVPb2k5ETnCDqvR3lIbx3PtvE
	uWUMmsq/T8SL4VYVj4dWq4nEfAs8/fl6brpqmylXon6IkO6oTU5+M=
X-Received: by 2002:a05:622a:412:b0:533:3d48:37ff with SMTP id d75a77b69052e-542b7c084ccmr52737171cf.49.1793388545331;
        Fri, 30 Oct 2026 12:29:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.04
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
Subject: [PATCH 04/11] libsemanage: stop user deletion when login lookup fails
Date: Fri, 30 Oct 2026 15:28:41 -0400
Message-ID: <20261030192849.151830-4-stephen.smalley.work@gmail.com>
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

lookup_seuser() ignores the return from semanage_seuser_list_local() and
then iterates and frees output variables that may never have been
initialized. A cache, parse, or allocation failure can therefore crash
instead of returning the lookup error, or allow deletion without a valid
reference check.

Check the list result, release the user record already obtained, and
return failure before consuming the list outputs. Add fault-injection
coverage for EIO and ENOMEM plus referenced and unreferenced user
controls.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/users_local.c                 |   5 +-
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |   6 +-
 .../tests/regression/test_user_delete_error.c | 172 ++++++++++++++++++
 4 files changed, 182 insertions(+), 2 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_user_delete_error.c

diff --git a/libsemanage/src/users_local.c b/libsemanage/src/users_local.c
index 67cb796b..539951fe 100644
--- a/libsemanage/src/users_local.c
+++ b/libsemanage/src/users_local.c
@@ -36,7 +36,10 @@ static int lookup_seuser(semanage_handle_t *handle,
 	if (semanage_user_query(handle, k, &user) < 0)
 		return 0;
 	name = semanage_user_get_name(user);
-	semanage_seuser_list_local(handle, &records, &count);
+	if (semanage_seuser_list_local(handle, &records, &count) < 0) {
+		semanage_user_free(user);
+		return -1;
+	}
 	for (i = 0; i < count; i++) {
 		sename = semanage_seuser_get_sename(records[i]);
 		if (strcmp(name, sename) == 0) {
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 50c3e234..739a885b 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -2,4 +2,5 @@ libsemanage-tests
 test-user-join-transaction
 test-parse-read-error
 test-read-lock-error
+test-user-delete-error
 *.policy
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 27aac8a3..e314ba52 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -6,7 +6,7 @@ CILS = $(sort $(wildcard *.cil))
 
 EXECUTABLE = libsemanage-tests
 USER_JOIN_TEST = test-user-join-transaction
-ERROR_TESTS = test-read-lock-error test-parse-read-error
+ERROR_TESTS = test-read-lock-error test-user-delete-error test-parse-read-error
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
 override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
@@ -22,6 +22,9 @@ test-read-lock-error: regression/test_read_lock_error.c ../src/database.c
 test-parse-read-error: regression/test_parse_read_error.c ../src/parse_utils.c
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
 
+test-user-delete-error: regression/test_user_delete_error.c ../src/users_local.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
+
 $(USER_JOIN_TEST): regression/test_user_join_transaction.c ../src/libsemanage.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
@@ -39,3 +42,4 @@ test: all
 	./$(USER_JOIN_TEST)
 	./test-parse-read-error
 	./test-read-lock-error
+	./test-user-delete-error
diff --git a/libsemanage/tests/regression/test_user_delete_error.c b/libsemanage/tests/regression/test_user_delete_error.c
new file mode 100644
index 00000000..161176a9
--- /dev/null
+++ b/libsemanage/tests/regression/test_user_delete_error.c
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <semanage/semanage.h>
+
+static int used_failed_list;
+static int deleted;
+static int cleaned_failed_list;
+static int freed_user;
+static int list_error = EIO;
+static int referenced;
+static semanage_seuser_t *sentinel_records[1];
+
+static void probe_free(void *ptr)
+{
+	assert(ptr == sentinel_records);
+	cleaned_failed_list++;
+}
+
+/* Compile the actual implementation; intercept only its dependencies. */
+#define free probe_free
+#include "../../src/users_local.c"
+#undef free
+
+int semanage_user_query(semanage_handle_t *sh, const semanage_user_key_t *key,
+			semanage_user_t **out)
+{
+	(void)sh;
+	(void)key;
+	*out = (semanage_user_t *)1;
+	return 0;
+}
+
+const char *semanage_user_get_name(const semanage_user_t *user)
+{
+	(void)user;
+	return "user_u";
+}
+
+void semanage_user_free(semanage_user_t *user)
+{
+	(void)user;
+	freed_user++;
+}
+
+int semanage_seuser_list_local(semanage_handle_t *sh, semanage_seuser_t ***out,
+			       unsigned int *count)
+{
+	(void)sh;
+	/* Fail without publishing output, as real cache/list failures do. */
+	if (list_error) {
+		errno = list_error;
+		return -1;
+	}
+	*out = sentinel_records;
+	*count = 1;
+	return 0;
+}
+
+const char *semanage_seuser_get_sename(const semanage_seuser_t *record)
+{
+	(void)record;
+	used_failed_list++;
+	return referenced ? "user_u" : "other_u";
+}
+
+const char *semanage_seuser_get_name(const semanage_seuser_t *record)
+{
+	(void)record;
+	return "login";
+}
+
+void semanage_seuser_free(semanage_seuser_t *record)
+{
+	(void)record;
+	cleaned_failed_list++;
+}
+
+int dbase_del(semanage_handle_t *sh, dbase_config_t *db,
+	      const record_key_t *key)
+{
+	(void)sh;
+	(void)db;
+	(void)key;
+	deleted++;
+	return 0;
+}
+
+int dbase_modify(semanage_handle_t *sh, dbase_config_t *db,
+		 const record_key_t *key, const record_t *data)
+{
+	(void)sh;
+	(void)db;
+	(void)key;
+	(void)data;
+	abort();
+}
+
+int dbase_query(semanage_handle_t *sh, dbase_config_t *db,
+		const record_key_t *key, record_t **out)
+{
+	(void)sh;
+	(void)db;
+	(void)key;
+	(void)out;
+	abort();
+}
+
+int dbase_exists(semanage_handle_t *sh, dbase_config_t *db,
+		 const record_key_t *key, int *out)
+{
+	(void)sh;
+	(void)db;
+	(void)key;
+	(void)out;
+	abort();
+}
+
+int dbase_count(semanage_handle_t *sh, dbase_config_t *db, unsigned int *out)
+{
+	(void)sh;
+	(void)db;
+	(void)out;
+	abort();
+}
+
+int dbase_list(semanage_handle_t *sh, dbase_config_t *db, record_t ***out,
+	       unsigned int *count)
+{
+	(void)sh;
+	(void)db;
+	(void)out;
+	(void)count;
+	abort();
+}
+
+int dbase_iterate(semanage_handle_t *sh, dbase_config_t *db,
+		  int (*fn)(const record_t *, void *), void *arg)
+{
+	(void)sh;
+	(void)db;
+	(void)fn;
+	(void)arg;
+	abort();
+}
+
+int main(void)
+{
+	semanage_handle_t sh = { 0 };
+	int rc = semanage_user_del_local(&sh, NULL);
+
+	printf("list returned -1: delete rc=%d output_used=%d cleanup=%d deleted=%d\n",
+	       rc, used_failed_list, cleaned_failed_list, deleted);
+	assert(rc < 0 && errno == EIO && freed_user == 1);
+	assert(used_failed_list == 0 && cleaned_failed_list == 0 &&
+	       deleted == 0);
+	list_error = ENOMEM;
+	assert(semanage_user_del_local(&sh, NULL) < 0 && errno == ENOMEM);
+	assert(freed_user == 2 && deleted == 0 && cleaned_failed_list == 0);
+	list_error = 0;
+	referenced = 1;
+	assert(semanage_user_del_local(&sh, NULL) < 0 && errno == EINVAL);
+	assert(deleted == 0 && freed_user == 3 && cleaned_failed_list == 2);
+	referenced = 0;
+	assert(semanage_user_del_local(&sh, NULL) == 0);
+	assert(deleted == 1 && freed_user == 4 && cleaned_failed_list == 4);
+	puts("User deletion error and success controls passed.");
+	return 0;
+}
-- 
2.56.0

