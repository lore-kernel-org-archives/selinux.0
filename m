Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388546;
	b=Shxj2W38NpIopJpTwUUmv8UQQhz2zLC28RXd2yjEQjM+WyTsKErYZ9CNHrK3ePCXhyx4
	 8IYuJgACkB8qCBaUrvQZBRbjWLVi+ZMVRkcdVVL/tkzLHSiCTXUfhcdarwjz5Nrx5+Vqe
	 tv71nOSZ5NfPpp2X/d0u6jnLveyE/2Pl41J6P7vdtBny8qSN9nvg+3MJ5rAiYZY2kLk4n
	 gQ9O7gNo7ly+NVDDHwoR1KzV9L8kyDyjfVvsoBFGK++M389MzJqDnW0MKElILPGH0TubW
	 KIUr4h5Pks2aYROpi7WwDSVaE32Cw/nFyc31ncANU8F00GOeZ2a25Q3uyo991bF0Msw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4GDF6QQfgphXrWTIpsHT40M+VcUBGAZNqarcWa5zt7c=;
	b=G9cCuN6dchW/a8sm5ChOt6/BzZV1aFgGatb+9+L6RdxHtnEiZOf7dR6khkMqKDYA0e2q
	 QUW5Csc0323V84x2mdvMyvtkiw8Y8BTqO/8un44HHYABBtdXjT8o4Hx3EbsTCfghjAufq
	 RIECUdgKzcdq/cSRSgwiouC95/g8ac6g66sdy0pqluBT1nXSE7vymG6BKy4nogtAKCvU0
	 6Cg2LfXGcdiuIqYFEmrFeVf84VcWfLUP7Suf3lwpo3rAwVni1MTwq2c5j650JdM9HWFG/
	 U2WLQaS2VICVMY6JxdzNINcY8TitP+vgl0qUCfuWTFOfLJlS+9QjBqFPCJfQ2yIrIMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mE3gyDxb;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F9606A31A
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mE3gyDxb
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5364c951da4so9921251cf.1
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388545; x=1793993345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GDF6QQfgphXrWTIpsHT40M+VcUBGAZNqarcWa5zt7c=;
        b=mE3gyDxb8WmebYdh1w7DQ6cJcgXh4BaohFwx7MjJ6YSK2oGUrhFJ5Z+pMYPLzqtU7S
         FfLMroUhYiL/NFGsCCX0fR5AXcUKisAgV6R7TKonIVUW4jySlhSPtptDEWkh6FfCgtlv
         wgkklyxFCdvroF0ksUlRfZ+wW1+Btpajb8eaDcMg2V5PeY/P+NK9Ca9NBOFTz1XfVW1B
         2FDtlJJAFRjpXJhqpNNGEvvETYZ3pBDkzxw6Bki+ElryVz6GFQjbsdBTAhKTU0L8eiMf
         spFlbF976KuLIB1qm4BhzmOq/OHiFcxlsgRvxoAshGmwuUVfPfmSymaXSlrvSQJFYyVG
         ZDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388545; x=1793993345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4GDF6QQfgphXrWTIpsHT40M+VcUBGAZNqarcWa5zt7c=;
        b=0xBjkXTVTYVxQO3ABA2i6zjrcClZ+pnS/kR/oat3tXWKxXJYMk1o2FpV8Hgx2kWYqp
         mfYNkjqOmjSK5qCNXiBBJ6WduQk56yLGxM+wca3xYEdkq1aE0QK08kJowooUrnjru/tP
         AhF3+7Sd95A2sCXbtfjZan0hNAcVCRmWNUohi1S+o6gwx7gNg2CZeGNt1MUA7hKJ8OSC
         F2BpvQ1hrJvZmhXVXLSUO9xibrlA3wFOrEe2hMnETyKyTKNyJFFcg0fhcqC8mQn9yhPi
         nobNozrGSbucDA6jAuA3wAEuoVnGZNqFREafxd6M8cHhe9HMIN6pq95FInjnIcq3WczM
         d3Zw==
X-Gm-Message-State: AFq9FYK2on/HBNxHyUOvC+F9Hah6yxpoIVmmJXE48Wm1Ljt/s5OtEjwp
	OHelPBPmY3MV57o7DKKpd4Ljttn7EdPTVMWkCOaASA5CVnMrG9BTTOKIuc7iz5ML
X-Gm-Gg: AYBFou2hldqxZhciIwimsdHMw1rhdAQpQ4yseL1pW0/y2QfRGyAc+SU3NOoR9FzcKYj
	1Bp25rAoDBBU13tA/z8Et9tN9JrUV+Goj/OoQ253ppAk4+rnpdCG1boHMRIoHY7xjjou/L3TZgd
	VqJZpwxjrbcOI5XguJMhY2JsPKtYdv4+4Ug5VTKmC91Qa+5XHRCfqsqOVAtnWyc+lbLrQZocoOW
	K8kq4E6nwq/+kgGHTvpfzpnx7+hbJG5X0C16v7HvsFXN82pCDqKlvpdgerrBXB5KqgXxgyLodPD
	nFDCaQxhtfCW15qflyiSpYiZB62aq+FAz0qWNEmt8vZBWgdwar1/i5obZdEsyGI+Z7qCP8uDf1j
	T+b1q31SWDvDPV2o/G764g1lPQ7RCbNlUGxZ5GSrv9IaKYMKpMVE1cFJLJNsKKtL5NslqvDNXhV
	8JZkmM4hIYCLYCXU39cm6yonWioQ1h5X+uJCunJOzsTzrwLwTrSaJAab/oh36CgsVKoUlFEI6LR
	Z5LMDnDewH0043xcPiGUatKcs7Q3vD5YpvuiiuJtT8xeKU/qTul82+WJ4X0oLQFjYhDJXSYdXzZ
	i57kJWUCdtF7aVamRIUQIdqB5/WIdgV6kyf8P8e2JRRFC8xBLYjmNQ3vrCjhuPt5dttWMyiWQaN
	ZyqNUeRL+hpiAvPG3B/33b/L7CKJpAqMSyyT26BU+KI4x8aseGQ5KGemFvuLnx9xYQtgN+YhbbC
	XIAahJ1zglbIxaHsYQyMgjj8afywCJ6UNIPh+Zc7oasGHOm7hC/Fk=
X-Received: by 2002:a05:622a:48e:b0:531:11ac:23d8 with SMTP id d75a77b69052e-542b79166a8mr56441531cf.49.1793388544741;
        Fri, 30 Oct 2026 12:29:04 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:04 -0700 (PDT)
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
Subject: [PATCH 03/11] libsemanage: release the active lock when caching fails
Date: Fri, 30 Oct 2026 15:28:40 -0400
Message-ID: <20261030192849.151830-3-stephen.smalley.work@gmail.com>
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

An out-of-transaction database read acquires the active-store lock
before caching its records. Cache failure returns without releasing that
lock, and disconnecting and destroying the handle can orphan its
descriptor and block other readers or commits.

Release the active lock on the post-acquisition cache failure path.
Leave lock-acquisition failures and operations inside transactions
unchanged. Add fault-injection coverage for the failing path and
successful-read, transaction, and acquisition-failure controls.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/database.c                    |  6 +-
 libsemanage/tests/.gitignore                  |  1 +
 libsemanage/tests/Makefile                    |  6 +-
 .../tests/regression/test_read_lock_error.c   | 96 +++++++++++++++++++
 4 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_read_lock_error.c

diff --git a/libsemanage/src/database.c b/libsemanage/src/database.c
index e50088b3..6841d82b 100644
--- a/libsemanage/src/database.c
+++ b/libsemanage/src/database.c
@@ -31,8 +31,12 @@ static int enter_ro(semanage_handle_t *handle, dbase_config_t *dconfig)
 		}
 	}
 
-	if (dconfig->dtable->cache(handle, dconfig->dbase) < 0)
+	if (dconfig->dtable->cache(handle, dconfig->dbase) < 0) {
+		if (!handle->is_in_transaction &&
+		    handle->conf->store_type == SEMANAGE_CON_DIRECT)
+			semanage_release_active_lock(handle);
 		goto err;
+	}
 
 	return STATUS_SUCCESS;
 
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 303fbf03..50c3e234 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,4 +1,5 @@
 libsemanage-tests
 test-user-join-transaction
 test-parse-read-error
+test-read-lock-error
 *.policy
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index d847ae96..27aac8a3 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -6,7 +6,7 @@ CILS = $(sort $(wildcard *.cil))
 
 EXECUTABLE = libsemanage-tests
 USER_JOIN_TEST = test-user-join-transaction
-ERROR_TESTS = test-parse-read-error
+ERROR_TESTS = test-read-lock-error test-parse-read-error
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
 override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
@@ -16,6 +16,9 @@ POLICIES = $(CILS:.cil=.policy)
 
 all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(ERROR_TESTS)
 
+test-read-lock-error: regression/test_read_lock_error.c ../src/database.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
+
 test-parse-read-error: regression/test_parse_read_error.c ../src/parse_utils.c
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
 
@@ -35,3 +38,4 @@ test: all
 	./$(EXECUTABLE)
 	./$(USER_JOIN_TEST)
 	./test-parse-read-error
+	./test-read-lock-error
diff --git a/libsemanage/tests/regression/test_read_lock_error.c b/libsemanage/tests/regression/test_read_lock_error.c
new file mode 100644
index 00000000..09478d84
--- /dev/null
+++ b/libsemanage/tests/regression/test_read_lock_error.c
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include "handle.h"
+#include "database.h"
+
+static int fail_cache;
+static int fail_lock;
+static int acquires;
+static int releases;
+
+int semanage_get_active_lock(semanage_handle_t *sh)
+{
+	acquires++;
+	if (fail_lock)
+		return -1;
+	sh->u.direct.activelock_file_fd = 42;
+	return 0;
+}
+
+void semanage_release_active_lock(semanage_handle_t *sh)
+{
+	releases++;
+	sh->u.direct.activelock_file_fd = -1;
+}
+
+/* Only the lock declarations from semanage_store.h are needed here. */
+#define SEMANAGE_MODULE_STORE_H
+#include "../../src/database.c"
+
+static int cache(semanage_handle_t *sh, dbase_t *db)
+{
+	(void)sh;
+	(void)db;
+	if (fail_cache) {
+		errno = EIO;
+		return -1;
+	}
+	return 0;
+}
+
+static int count(semanage_handle_t *sh, dbase_t *db, unsigned int *out)
+{
+	(void)sh;
+	(void)db;
+	*out = 0;
+	return 0;
+}
+
+static int serial(semanage_handle_t *sh)
+{
+	(void)sh;
+	return 17;
+}
+
+int main(void)
+{
+	semanage_conf_t conf = { .store_type = SEMANAGE_CON_DIRECT };
+	struct semanage_policy_table funcs = { .get_serial = serial };
+	semanage_handle_t sh = { .conf = &conf, .funcs = &funcs };
+	dbase_table_t table = { .cache = cache, .count = count };
+	dbase_config_t db = { .dtable = &table };
+	unsigned int n = 99;
+	int rc;
+
+	sh.u.direct.activelock_file_fd = -1;
+	fail_cache = 1;
+	rc = dbase_count(&sh, &db, &n);
+	printf("cache failure: rc=%d acquired=%d released=%d retained_fd=%d\n",
+	       rc, acquires, releases, sh.u.direct.activelock_file_fd);
+	assert(rc < 0 && acquires == 1 && releases == 1);
+	assert(sh.u.direct.activelock_file_fd == -1 && errno == EIO);
+
+	sh.u.direct.activelock_file_fd = -1;
+	acquires = releases = 0;
+	fail_cache = 0;
+	assert(dbase_count(&sh, &db, &n) == 17);
+	assert(acquires == 1 && releases == 1);
+	puts("success control: lock released");
+
+	acquires = releases = 0;
+	sh.is_in_transaction = 1;
+	fail_cache = 1;
+	assert(dbase_count(&sh, &db, &n) < 0);
+	assert(acquires == 0 && releases == 0);
+	puts("transaction control: no active lock acquired or released");
+
+	sh.is_in_transaction = 0;
+	fail_lock = 1;
+	assert(dbase_count(&sh, &db, &n) < 0);
+	assert(releases == 0);
+	puts("acquisition-failure control: no release");
+	return 0;
+}
-- 
2.56.0

