Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6062415F18
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455147; cv=none; b=L9W+f9XoiKVSPdHV/tOccDtQEKeq8OFir/kmDp7n69Am5s/O2BUn9LOIss0Qyuixe95wjtXwaMCUjpDXq2aD+Ksd/pWxDMgLL02wqBfAX5UxbCGJbGQ9iIgPThYU4zKHYD5zRZr3F0Op9ZJ0lLb/9rr6o/BjVv7iWuH6o4TsnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455147; c=relaxed/simple;
	bh=g5JI2ISuJpDK1rGZXzBnJjdbj1LWap5IiNy3B60XDFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw5yrurD5/wHetdaHsiFsKZiUFoxBYTQyIi1X8CQ2VRh1BKaRIIqZCgda6Y2by5+V5BRncGTjjNdarejsZuiEc0xE4UMtp8KFfkBYR8t34WoOExxztM0Sn6Vd7DCxs4fGbrPE5LedDZzNq9S67z6UH0GC/YwTt4ke1RnaNtmYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFPouuRO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFPouuRO"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9061a795d76so3985626d6.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455144; x=1786059944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37JfktnWKSwnsVTmyOwT4tNbEmQBNW4uYVQkWjpnTqE=;
        b=GFPouuROcz6ugxIHaVAki2vlYjr4mflpEJijkejWsj3ry0f1ZDVi6yog4/amul3QJF
         Fcw8m53cQCl587c38e/t461TLC2j/9KBbtOjL4/XrDpn3hJMnAlJcbx9ITWGTvvvlcED
         qwIj2NLPSNzj72Xrp/lH7afLhpSWLTSM6THX4mIg6Q5Sc2sgYUuPmZJXZr4IhTrKYrdh
         2QTq+6RadmWOKKQKOKYvbCg67L4DcEmcF3xyyKkBTtXvgHD7vA2ZDf0J0t112YSVyE0A
         GfbScAoKZiNXY9GlwN7DdcDVJ+iHY4nQHsI2b7jCQDzf5yRWSqjP4LtlxjjAKeXCh4D3
         zHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455144; x=1786059944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=37JfktnWKSwnsVTmyOwT4tNbEmQBNW4uYVQkWjpnTqE=;
        b=Qn5W40N0p8caXb9Jwz5c45ul9b1VMijFrrb9bnkuzpL8e4ivv/RHTqkFydqmUFPMPq
         /beTWSSlIL2g2VB6A2J50VokplHapzz5gF2+H8WK4v+xCtWRPxWLJNsYYhLx3zRcqrC5
         2xYANiW64n24TPpxuET4bcZY8vUFxxZJoa4MKT2jK8+nAFu/aXAz0yN8rVcdUX4BSikA
         ao+jOdTaKZUrVJEpQEAhwPqcWaKr7kAX3R0zK2H6l5v3YzEq3TlH3qze59GTvsewU1Zl
         8/cljT0C95MyuT8PF+9XES3e6LqWXNcxRgUUMu7vTNyOjQdaZgmjsxoUEu4k7RbJjVf7
         Px5w==
X-Forwarded-Encrypted: i=1; AHgh+Rqox1i3/1MSnEv0246FnnoETNCy/w7SN1tPkzrYdTPjVolgcaw5vxAMSdqfyqTTFNEWhdMv6Fji@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXhuP3RGNeOfVniQ8cvP38rlRaWLTGmzKXamIy1iieKXxteui
	0if8x3XeJOEtb0IWPorUUnFx+kKV4k0kebrw8WOLzorkE9uBzAlmTT9S
X-Gm-Gg: AR+sD11Y3w8dlE2R2WQ9MkouLK91fIuvOUH4okc/Qp8BLOw0vil7qMuIpIgoolwdgsG
	VGGeRY356+yDej9izXzNU1AOc8o9N1gi7aGytK8jjiH9DAEoSvy8d78ntIfQca/uFBwxf5aGLRW
	Pyx7WKw/bEYenoP2iyVqeEILbllBFsJ/n61blg4d8c5St284ZeMSKGX6GBrMX+NdRpMl8r4aRWA
	uEG24+ldiEO439BGjciTzXCmzCZWWuKZbu75HuV+bmDLVEK/7QQOsnYzN29IiVoF/AC6AQL+OrD
	JO9RX3+7ggwFRKA1tPukLpVsT6bNzVT+6NTE2zzXdHCjcsxA0TI//KQYGLf6uA92cVXxeB54N0F
	hxShNvfFPfvbVlxWSAhy2dNyBde1dsA3aKTBveWqKZcd3wUJIDj3ZV/0FEYqW9D9GBCCoetUxMo
	a2sEx/E0HkLHDm4ysKEOxhtlOSBh3vD0zBkdEeF4++LEtcvcQ/lx3pWRWt51gcQK/ahH+HPrCjU
	qX31ORxGzL5lr0YOxpRcUDzPXx8q+29TduUTrSs6kXGeOwNWWfaietuohBlEwg=
X-Received: by 2002:a05:6214:4a86:b0:907:4598:ad3 with SMTP id 6a1803df08f44-908347b8db0mr47894106d6.50.1785455143760;
        Thu, 30 Jul 2026 16:45:43 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8bc0sm28991836d6.26.2026.07.30.16.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:45:42 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 4/4] selftests/bpf: add tests for bpf_init_inode_xattr kfunc
Date: Thu, 30 Jul 2026 19:45:33 -0400
Message-ID: <20260730234533.1912709-5-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730234533.1912709-1-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
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
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 156 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  33 ++++
 3 files changed, 194 insertions(+)
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
index 43a26ec69a8e..b208522dbd33 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
 #include "test_fsverity.skel.h"
+#include "test_init_inode_xattr.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
@@ -268,6 +269,155 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_init_inode_xattr(void)
+{
+	struct test_init_inode_xattr *skel = NULL;
+	int fd = -1, err;
+	char value_out[64];
+
+	/* This test must be run from a fs that calls
+	 * security_inode_init_security().
+	 */
+	const char *testfile_new = "/dev/shm/test_progs_fs_kfuncs_new";
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
+	/*
+	 * Probably should not be needed as we will be labeling a file
+	 * in /dev/shm, but just in case we check if the hook was actually
+	 * called.
+	 */
+	if (!skel->bss->hook_ran) {
+		printf("%s:SKIP:inode_init_security hook was not invoked\n",
+		       __func__);
+		test__skip();
+		goto out;
+	}
+
+	/* The filesystem does not accept xattrs at inode creation. */
+	if (skel->data->init_result == -EOPNOTSUPP) {
+		printf("%s:SKIP:filesystem does not support LSM init xattrs\n",
+		       __func__);
+		test__skip();
+		goto out;
+	}
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
+	const char *testfile_slot = "/dev/shm/test_progs_fs_kfuncs_slot";
+	int ok = 0, nospc = 0, notrun = 0, other = 0;
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
+	 * Exactly INIT_INODE_XATTR_MAX programs claim a slot; test
+	 * xattr budget accounting with -ENOSPC.
+	 */
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		int res = skel[i]->data->init_result;
+
+		if (!skel[i]->bss->hook_ran || res == -EOPNOTSUPP)
+			notrun++;
+		else if (res == 0)
+			ok++;
+		else if (res == -ENOSPC)
+			nospc++;
+		else
+			other++;
+	}
+
+	if (notrun == INIT_INODE_XATTR_MAX + 1) {
+		printf("%s:SKIP:hook not invoked or fs lacks LSM init xattrs\n",
+		       __func__);
+		test__skip();
+		goto out;
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
@@ -288,4 +438,10 @@ void test_fs_kfuncs(void)
 
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
index 000000000000..ce3d8d39de9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
@@ -0,0 +1,33 @@
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
+int hook_ran;
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
+	hook_ran = 1;
+	bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_ptr);
+	init_result = bpf_init_inode_xattr(xattrs, xattr_name, &value_ptr);
+
+	return 0;
+}
-- 
2.53.0

