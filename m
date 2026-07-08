Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E401A0728
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469408; cv=none; b=ms5RsT5HOLZbR2HtE2uMZVkJRjLQP9PhFwc4jqaRJU0nJ8dDKXTXG259TLxSxPtejoJOLay6Gj/W7l5lZVUDXkIPtU62FArxmC5fT+YzF2e/6gQZ55HnapRJ0Yq6/75ZXbAVEAaOhL0tWYDX/nJzuvL/QKAQlZFfp2VTJG4uNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469408; c=relaxed/simple;
	bh=eux8V6ATnM5qD+SFUwkQpmSQRn1Yojgb3lZ0S3GrT30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su1OLToNC9BhyvM3BHEUKChOQkKoozKLUc8x7PpBQ0QiZbedi9bHhS7PNyqhR4ivX2RzujMarOlUuWpyu2piX8G/gcFbZ+FuO3ICAj1bcC/SHexRucq3aqT7Ag1kTzRg0ppS4o2sux8P7+zm7AePp57Z5Les09EqFwaEmQiAgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A521NSc9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A521NSc9"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e65e18969so5851785a.1
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783469404; x=1784074204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2f2t60Bq3DQP7+8XiXelpBwbMQBxvJVb0y8RBgvfr0g=;
        b=A521NSc9wmRJQ53eHHPwtxZKFWGT04GDfxqaub2fra21WhCR/FTNAWWvOktd89rRhH
         NgXh01liVtTgTo9TpJKJmdxA308kJK/BswvOTR4FGWzkaHCSUhlwtSFRAvg+VI/L4/tJ
         q4RSGAGaVbTiXHk+90A0Mk5LwgZYKRSamkn3ywluPZpwyT4Mt4rVPRFpKb1Zf+f7d2c1
         SO0ZCrZSj6Y1hHS6Pgd1pbKx9QOfjbV1RHvhyG9ES9ofA4khsOYXudXGt9n0YuNBJHOY
         6t+KQvYLypdByyqOs/I46T5sn2YbvT/34PWWK1yXiWwMSqqQVGUkZOUSvZgX07S+WIhJ
         MTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783469404; x=1784074204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2f2t60Bq3DQP7+8XiXelpBwbMQBxvJVb0y8RBgvfr0g=;
        b=fHV32sQr0kundHTvwSQowvs2CsdDit8IvIB+/kcscxz+Je63PapsYsz1JPIU06r0Kh
         vdGjDyaZ0nqwZ4Gm77Jx3fROdgHi4t47g8191PcZk6RhVdwmWmPZ6rb3c9D7T3LxKc8i
         U/gA8XFdrioGO3gHYBaCqUUjO/tCrpA7IH2aPHfyMfsXGes0WnI/n7X9TvJBaPiJNKOq
         yOsij8T57Rd0for0oungGPKe3TpE8XvohPjBsGTztQSZe8kyChUwD8saPvQ/ZOkvu4/5
         lqkU7JmedSoj0lKcYMhaA0MW0E5fuyU3VdlZdINIyHKw5XUMMiXTfi0b0GuP2i7R4/D3
         iqag==
X-Forwarded-Encrypted: i=1; AHgh+RqbTZWDu+wjpHKYVfOJcHpnH8Ww3kcqzYlIAU5EKYoWVoT42yTL2Tfdx4FIUvgQMcWe3K+bDQyi@vger.kernel.org
X-Gm-Message-State: AOJu0Yysk9dM6c0BQSR8CQUfJCBAOA1NhZmIWK3WgatC0lRAIswnTLL+
	i2bJSDoHVfHSvjon5CZrV7rz6RXSFRLk/ubfa2Dre/8Fmc8gM4AI0o6p
X-Gm-Gg: AfdE7cmpYwZl/dskQKiARlgESN2/4aLnlWKLQpPGH4rw4X19MFkECQMXsWqv11NQmwB
	babWj6bm9MjDAYAZJfJECa8HIZXJ01EEBsRO38YDqsNrvKTPMsTWaoFWMC9UXsReLDXkOtvJmuw
	xNWZKOUhrPB3Cv8tMUlB0tvoHySgTZ71xCQhX9/SgYo4ZpAqFc3r8udtX/auroHnegKW0kZdxzu
	+TWsG8d+HAS18E1Nm/37MS+r7yCRPWAfNglWhEtLwB1VXh4tSdH+PF7HYqafh4pofnduhadmtCQ
	TxWIgk5icV2T5+qotpqdg2emCPBvA9ljMlPgEmKCTjVqQgV5XQ+jGAo1LVEc7WwOTkyz3UrKW3u
	aQA94HsdkDyA/arwKAMlPjST41GqygXaiYmVkdwU1RXXwJYKtXvO6AT1hwDIsrvr/lw1TZ1EpAF
	90xdZwYrvOr4AnZ9unNjAETlwJhkUAjq+a3rpOIj4Nbykr7SJscstsWodJZFajWrF+cLsFme789
	u7n7aAAWyTF/qo=
X-Received: by 2002:a05:620a:4612:b0:929:f78f:6bf9 with SMTP id af79cd13be357-92ece91e652mr42005085a.16.1783469403670;
        Tue, 07 Jul 2026 17:10:03 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e93ea5ed3sm1191281885a.29.2026.07.07.17.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:10:03 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v5 bpf-next 3/3] selftests/bpf: add tests for bpf_init_inode_xattr kfunc
Date: Tue,  7 Jul 2026 20:09:56 -0400
Message-ID: <20260708000956.46138-4-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708000956.46138-1-dwindsor@gmail.com>
References: <20260708000956.46138-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test bpf atomic inode xattr labeling in inode_init_security.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 124 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 3 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..2639f9f94195 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -92,4 +92,9 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+struct lsm_xattrs;
+extern int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
+				const char *name__str,
+				const struct bpf_dynptr *value_p) __ksym __weak;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..10be0ab91e70 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
 #include "test_fsverity.skel.h"
+#include "test_init_inode_xattr.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
@@ -268,6 +269,123 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_init_inode_xattr(void)
+{
+	struct test_init_inode_xattr *skel = NULL;
+	int fd = -1, err;
+	char value_out[64];
+	const char *testfile_new = "/tmp/test_progs_fs_kfuncs_new";
+
+	skel = test_init_inode_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_init_inode_xattr__open_and_load"))
+		return;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_init_inode_xattr__attach(skel);
+	if (!ASSERT_OK(err, "test_init_inode_xattr__attach"))
+		goto out;
+
+	/* Trigger inode_init_security */
+	fd = open(testfile_new, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	ASSERT_EQ(skel->data->init_result, 0, "init_result");
+
+	/* initxattrs prepends "security." to the name. */
+	err = getxattr(testfile_new, "security.bpf.test_label", value_out,
+		       sizeof(value_out));
+	if (err < 0 && errno == ENODATA) {
+		printf("%s:SKIP:filesystem did not apply LSM xattrs\n",
+		       __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_GE(err, 0, "getxattr"))
+		goto out;
+
+	ASSERT_EQ(err, (int)sizeof(skel->data->xattr_value), "xattr_size");
+	ASSERT_EQ(strncmp(value_out, "unconfined_u:object_r:user_home_t:s0",
+			  sizeof("unconfined_u:object_r:user_home_t:s0")), 0,
+		  "xattr_value");
+
+out:
+	close(fd);
+	test_init_inode_xattr__destroy(skel);
+	remove(testfile_new);
+}
+
+/* Keep in sync with BPF_LSM_INODE_INIT_XATTRS in include/linux/bpf_lsm.h. */
+#define INIT_INODE_XATTR_MAX 4
+
+/*
+ * Programs may attach to inode_init_security without an attach-time limit, but
+ * the kfunc only lets BPF claim INIT_INODE_XATTR_MAX xattr slots per inode.
+ * Calls beyond that budget are rejected at runtime with -ENOSPC.
+ */
+static void test_init_inode_xattr_slot_limit(void)
+{
+	struct test_init_inode_xattr *skel[INIT_INODE_XATTR_MAX + 1] = {};
+	struct bpf_link *link[INIT_INODE_XATTR_MAX + 1] = {};
+	const char *testfile_slot = "/tmp/test_progs_fs_kfuncs_slot";
+	int ok = 0, nospc = 0, other = 0;
+	int i, fd = -1;
+
+	/* All programs attach successfully; there is no attach-time cap. */
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		skel[i] = test_init_inode_xattr__open();
+		if (!ASSERT_OK_PTR(skel[i], "open"))
+			goto out;
+
+		snprintf(skel[i]->rodata->xattr_name,
+			 sizeof(skel[i]->rodata->xattr_name), "bpf.label_%d",
+			 i);
+
+		if (!ASSERT_OK(test_init_inode_xattr__load(skel[i]), "load"))
+			goto out;
+
+		skel[i]->bss->monitored_pid = getpid();
+
+		link[i] = bpf_program__attach_lsm(skel[i]->progs.test_init_inode_xattr);
+		if (!ASSERT_OK_PTR(link[i], "attach"))
+			goto out;
+	}
+
+	/* Trigger inode_init_security once with all programs attached. */
+	fd = open(testfile_slot, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	/*
+	 * Exactly INIT_INODE_XATTR_MAX programs claim a slot; the program past
+	 * the budget gets -ENOSPC. The order in which programs run is not
+	 * guaranteed, so count results instead of indexing.
+	 */
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		int res = skel[i]->data->init_result;
+
+		if (res == 0)
+			ok++;
+		else if (res == -ENOSPC)
+			nospc++;
+		else
+			other++;
+	}
+
+	ASSERT_EQ(ok, INIT_INODE_XATTR_MAX, "slots_within_budget");
+	ASSERT_EQ(nospc, 1, "slot_over_budget");
+	ASSERT_EQ(other, 0, "unexpected_result");
+
+out:
+	if (fd >= 0)
+		close(fd);
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		bpf_link__destroy(link[i]);
+		test_init_inode_xattr__destroy(skel[i]);
+	}
+	remove(testfile_slot);
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -288,4 +406,10 @@ void test_fs_kfuncs(void)
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
+
+	if (test__start_subtest("init_inode_xattr"))
+		test_init_inode_xattr();
+
+	if (test__start_subtest("init_inode_xattr_slot_limit"))
+		test_init_inode_xattr_slot_limit();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
new file mode 100644
index 000000000000..caade53b87e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cisco Systems, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+int init_result = -1;
+
+const char xattr_name[16] = "bpf.test_label";
+char xattr_value[] = "unconfined_u:object_r:user_home_t:s0";
+
+SEC("lsm/inode_init_security")
+int BPF_PROG(test_init_inode_xattr, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct lsm_xattrs *xattrs)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_ptr);
+	init_result = bpf_init_inode_xattr(xattrs, xattr_name, &value_ptr);
+
+	return 0;
+}
-- 
2.53.0

