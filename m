Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3F3D39B
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931718; cv=none; b=AnGGVuySQECYQrxDDVcOnrRSs/LQTuZCH0sf2WmuAAe1TrfIxhWC4aN883kg56Gs1TRvGjo3URbld04i1cSEwhA4uSG1qVk3IVAy3jOKqm11ZLbG4bVSNO4SZSKBfZM/YMBoHW3nQ+1Nl0xkNVev7JEyWvQL5nsfhCOC0xqvbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931718; c=relaxed/simple;
	bh=M7ix3WmxTxOc3W1Ux120lMmV0oh/86Xw5pUOq37BvLw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iyztlo0d+D96fR5gNOhVSZf9OA4KwJS1PfynNjn8J9s3ESLal1yuFAjJ7JLR/jVJkHtpppRHBmvpEqrY5LReu4p2EzgAPUT64ifPWRr8Z4Y0OZOdr8GtSDp89epYlGkSwz2Bq6Htd6OwV9b42NK9NOlmzj6T6EXzW4N5bx7DSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nATpW03L; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nATpW03L"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337d58942c9so3454365f8f.0
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931714; x=1706536514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgdSVQ8NxxLv1dMhj0tQS8LXissrqixknWBetHXW4M4=;
        b=nATpW03LCaH8u8v3giHLlMpv1b5wouksknR1oDlCKQjyKe4oKd5Shjv5eexY3JN0H2
         5+eDhBmOfyopC8vcNjeCpSF8y3sf1Fx1LdLXGangJQoMusU1JlstRgLUnSNXJFJCi4MI
         9toRe6WFTobsF/1bNa8sAtduE9u9Jm6vcTeyvI1hH6pQySnBb0UDsNksk2aQNKiidgVl
         2SiyFDBUSb7q04HPtUidf8fzVGOlO3ms590sXdYFwfZU+VZDL1URXyEVWVPRm8oCbaWR
         ouQensJrPq/lq47YTNvC1c3XW8hOb7pNuDm4RL4HbNYJlfcz0L9BmkP5TcO/qBI/vZe/
         vVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931714; x=1706536514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgdSVQ8NxxLv1dMhj0tQS8LXissrqixknWBetHXW4M4=;
        b=R5YGgjxsDPlAgTnrF0vyz2TWC1bLcYCuYSOwnPs+xV4nPhRSUpwCPxIJPYjPVwz+LO
         larrJAc72GCromp5/i67RDv9n1XXmjZCvZ/yHZbTl4EYdu7Zs4j2hp3RYIJXsJurSJPn
         Of3KMhYCa3ChcD752PmFmxb0TI4li9ezC6KqRmSnnUeyRON9EhXVfzrVRqxHcyvvZj+k
         wPJkuNxI7veRQ0MqiHI64KEt9scnWi+0AC7qD02sLxNT/xaDL1UaYamJcZ0+eh5g+dre
         IOQc7S38EtPitEYrVtEHamjvV3wT1QnHvmLWPe7g8QHztuTCwKAN1766jIOpyOt3M77h
         Rj6Q==
X-Gm-Message-State: AOJu0YwCJwcsdUFP2xCRhFBE2WXUGN6fIScomgetdaRh0KNwugSrQeXz
	YqOELOuqVbq4xbW9C7CvteBd0sEYEJicuZMdmWUsYAu29fr3XaiuAVScFAtQ
X-Google-Smtp-Source: AGHT+IHWLISIIcOudxeoelQ5e/HVBNTmUCyzOSaCbqaxHxuDcQvLcVDQFSlH3qg/UrYJNPIZT8eVcw==
X-Received: by 2002:a1c:6a02:0:b0:40e:6a93:1c57 with SMTP id f2-20020a1c6a02000000b0040e6a931c57mr2330288wmc.103.1705931714033;
        Mon, 22 Jan 2024 05:55:14 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:13 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 01/15] checkpolicy: add libfuzz based fuzzer
Date: Mon, 22 Jan 2024 14:54:53 +0100
Message-ID: <20240122135507.63506-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a libfuzz[1] based fuzzer testing the parsing and policy
generation code used within checkpolicy(8) and checkmodule(8), similar
to the fuzzer for secilc(8).
The fuzzer will work on generated source policy input and try to parse,
link, expand, optimize, sort and output it.
This fuzzer will also ensure policy validation is not too strict by
checking compilable source policies are valid.

Build the fuzzer in the oss-fuzz script.

[1]: https://llvm.org/docs/LibFuzzer.html

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/Makefile                     |   3 +
 checkpolicy/fuzz/checkpolicy-fuzzer.c    | 274 +++++++++++++++++++++++
 checkpolicy/fuzz/checkpolicy-fuzzer.dict | 101 +++++++++
 checkpolicy/fuzz/min_pol.conf            |  60 +++++
 checkpolicy/fuzz/min_pol.mls.conf        |  65 ++++++
 checkpolicy/module_compiler.c            |  11 +
 checkpolicy/module_compiler.h            |   4 +
 checkpolicy/policy_scan.l                |   8 +
 scripts/oss-fuzz.sh                      |  14 ++
 9 files changed, 540 insertions(+)
 create mode 100644 checkpolicy/fuzz/checkpolicy-fuzzer.c
 create mode 100644 checkpolicy/fuzz/checkpolicy-fuzzer.dict
 create mode 100644 checkpolicy/fuzz/min_pol.conf
 create mode 100644 checkpolicy/fuzz/min_pol.mls.conf

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 036ab905..6e8008e3 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -54,6 +54,9 @@ lex.yy.c: policy_scan.l y.tab.c
 test: checkpolicy
 	./tests/test_roundtrip.sh
 
+# helper target for fuzzing
+checkobjects: $(CHECKOBJS)
+
 install: all
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(MANDIR)/man8
diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
new file mode 100644
index 00000000..0d749a02
--- /dev/null
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -0,0 +1,274 @@
+#include <assert.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <sepol/debug.h>
+#include <sepol/kernel_to_cil.h>
+#include <sepol/kernel_to_conf.h>
+#include <sepol/module_to_cil.h>
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/hierarchy.h>
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/link.h>
+
+#include "module_compiler.h"
+#include "queue.h"
+
+extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
+extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+extern int mlspol;
+extern policydb_t *policydbp;
+extern queue_t id_queue;
+extern unsigned int policydb_errors;
+
+extern int yynerrs;
+extern FILE *yyin;
+extern void init_parser(int);
+extern int yyparse(void);
+extern void yyrestart(FILE *);
+extern int yylex_destroy(void);
+extern void set_source_file(const char *name);
+
+
+// Set to 1 for verbose libsepol logging
+#define VERBOSE 0
+
+static ssize_t full_write(int fd, const void *buf, size_t count)
+{
+	ssize_t written = 0;
+
+	while (count > 0) {
+		ssize_t ret = write(fd, buf, count);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+
+			return ret;
+		}
+
+		if (ret == 0)
+			break;
+
+		written += ret;
+		buf = (const unsigned char *)buf + (size_t)ret;
+		count -= (size_t)ret;
+	}
+
+	return written;
+}
+
+static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
+{
+	int fd, rc;
+	ssize_t wr;
+
+	fd = memfd_create("fuzz-input", MFD_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	wr = full_write(fd, data, size);
+	if (wr < 0 || (size_t)wr != size) {
+		close(fd);
+		return -1;
+	}
+
+	fsync(fd);
+
+	yynerrs = 0;
+
+	yyin = fdopen(fd, "r");
+	if (!yyin) {
+		close(fd);
+		return -1;
+	}
+
+	rewind(yyin);
+
+	set_source_file("fuzz-input");
+
+	id_queue = queue_create();
+	if (id_queue == NULL) {
+		fclose(yyin);
+		yylex_destroy();
+		return -1;
+	}
+
+	policydbp = p;
+	mlspol = p->mls;
+
+	init_parser(1);
+
+	rc = yyparse();
+	// TODO: drop global variable policydb_errors if proven to be redundant
+	assert(rc || !policydb_errors);
+	if (rc || policydb_errors) {
+		queue_destroy(id_queue);
+		fclose(yyin);
+		yylex_destroy();
+		return -1;
+	}
+
+	rewind(yyin);
+	init_parser(2);
+	set_source_file("fuzz-input");
+	yyrestart(yyin);
+
+	rc = yyparse();
+	assert(rc || !policydb_errors);
+	if (rc || policydb_errors) {
+		queue_destroy(id_queue);
+		fclose(yyin);
+		yylex_destroy();
+		return -1;
+	}
+
+	queue_destroy(id_queue);
+	fclose(yyin);
+	yylex_destroy();
+
+	return 0;
+}
+
+static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __attribute__ ((unused)))
+{
+	const level_datum_t *levdatum = (level_datum_t *) datum;
+
+	// TODO: drop member defined if proven to be always set
+	if (!levdatum->isalias && !levdatum->defined) {
+		fprintf(stderr,
+			"Error:  sensitivity %s was not used in a level definition!\n",
+			key);
+		abort();
+	}
+
+	return 0;
+}
+
+static int write_binary_policy(FILE *outfp, policydb_t *p)
+{
+	struct policy_file pf;
+
+	policy_file_init(&pf);
+	pf.type = PF_USE_STDIO;
+	pf.fp = outfp;
+	return policydb_write(p, &pf);
+}
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	policydb_t parsepolicydb = {};
+	policydb_t kernpolicydb = {};
+	policydb_t *finalpolicydb;
+	sidtab_t sidtab = {};
+	FILE *devnull = NULL;
+	int mls, policyvers;
+
+	sepol_debug(VERBOSE);
+
+	/* Take the first byte whether to parse as MLS policy
+	* and the second byte as policy version. */
+	if (size < 2)
+		return 0;
+	switch (data[0]) {
+	case '0':
+		mls = 0;
+		break;
+	case '1':
+		mls = 1;
+		break;
+	default:
+		return 0;
+	}
+	static_assert(0x7F - 'A' >= POLICYDB_VERSION_MAX, "Max policy version should be representable");
+	policyvers = data[1] - 'A';
+	if (policyvers < POLICYDB_VERSION_MIN || policyvers > POLICYDB_VERSION_MAX)
+		return 0;
+	data += 2;
+	size -= 2;
+
+	if (policydb_init(&parsepolicydb))
+		goto exit;
+
+	parsepolicydb.policy_type = POLICY_BASE;
+	parsepolicydb.mls = mls;
+	parsepolicydb.handle_unknown = DENY_UNKNOWN;
+	policydb_set_target_platform(&parsepolicydb, SEPOL_TARGET_SELINUX);
+
+	if (read_source_policy(&parsepolicydb, data, size))
+		goto exit;
+
+	(void) hashtab_map(parsepolicydb.p_levels.table, check_level, NULL);
+
+	if (parsepolicydb.policy_type == POLICY_BASE) {
+		if (link_modules(NULL, &parsepolicydb, NULL, 0, VERBOSE))
+			goto exit;
+
+		if (policydb_init(&kernpolicydb))
+			goto exit;
+
+		if (expand_module(NULL, &parsepolicydb, &kernpolicydb, VERBOSE, /*check_assertions=*/0))
+			goto exit;
+
+		(void) check_assertions(NULL, &kernpolicydb, kernpolicydb.global->branch_list->avrules);
+		(void) hierarchy_check_constraints(NULL, &kernpolicydb);
+
+		kernpolicydb.policyvers = policyvers;
+
+		assert(kernpolicydb.policy_type    == POLICY_KERN);
+		assert(kernpolicydb.handle_unknown == SEPOL_DENY_UNKNOWN);
+		assert(kernpolicydb.mls            == mls);
+
+		finalpolicydb = &kernpolicydb;
+	} else {
+		assert(parsepolicydb.policy_type    == POLICY_MOD);
+		assert(parsepolicydb.handle_unknown == SEPOL_DENY_UNKNOWN);
+		assert(parsepolicydb.mls            == mls);
+
+		finalpolicydb = &parsepolicydb;
+	}
+
+	if (policydb_load_isids(finalpolicydb, &sidtab))
+		goto exit;
+
+	if (finalpolicydb->policy_type == POLICY_KERN && policydb_optimize(finalpolicydb))
+		goto exit;
+
+	if (policydb_sort_ocontexts(finalpolicydb))
+		goto exit;
+
+	if (policydb_validate(NULL, finalpolicydb))
+		/* never generate an invalid policy */
+		abort();
+
+	devnull = fopen("/dev/null", "we");
+	if (devnull == NULL)
+		goto exit;
+
+	if (write_binary_policy(devnull, finalpolicydb))
+		abort();
+
+	if (finalpolicydb->policy_type == POLICY_KERN && sepol_kernel_policydb_to_conf(devnull, finalpolicydb))
+		abort();
+
+	if (finalpolicydb->policy_type == POLICY_KERN && sepol_kernel_policydb_to_cil(devnull, finalpolicydb))
+		abort();
+
+	if (finalpolicydb->policy_type == POLICY_MOD && sepol_module_policydb_to_cil(devnull, finalpolicydb, /*linked=*/0))
+		abort();
+
+exit:
+	if (devnull != NULL)
+		fclose(devnull);
+
+	sepol_sidtab_destroy(&sidtab);
+	policydb_destroy(&kernpolicydb);
+	policydb_destroy(&parsepolicydb);
+
+	id_queue = NULL;
+	policydbp = NULL;
+	module_compiler_reset();
+
+	/* Non-zero return values are reserved for future use. */
+	return 0;
+}
diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.dict b/checkpolicy/fuzz/checkpolicy-fuzzer.dict
new file mode 100644
index 00000000..fb7e66c0
--- /dev/null
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.dict
@@ -0,0 +1,101 @@
+# Keyword dictionary
+
+"clone"
+"common"
+"class"
+"constrain"
+"validatetrans"
+"inherits"
+"sid"
+"role"
+"roles"
+"roleattribute"
+"attribute_role"
+"types"
+"typealias"
+"typeattribute"
+"typebounds"
+"type"
+"bool"
+"tunable"
+"if"
+"else"
+"alias"
+"attribute"
+"expandattribute"
+"type_transition"
+"type_member"
+"type_change"
+"role_transition"
+"range_transition"
+"sensitivity"
+"dominance"
+"category"
+"level"
+"range"
+"mlsconstrain"
+"mlsvalidatetrans"
+"user"
+"neverallow"
+"allow"
+"auditallow"
+"auditdeny"
+"dontaudit"
+"allowxperm"
+"auditallowxperm"
+"dontauditxperm"
+"neverallowxperm"
+"source"
+"target"
+"sameuser"
+"module"
+"require"
+"optional"
+"or"
+"and"
+"not"
+"xor"
+"eq"
+"true"
+"false"
+"dom"
+"domby"
+"incomp"
+"fscon"
+"ibpkeycon"
+"ibendportcon"
+"portcon"
+"netifcon"
+"nodecon"
+"pirqcon"
+"iomemcon"
+"ioportcon"
+"pcidevicecon"
+"devicetreecon"
+"fs_use_xattr"
+"fs_use_task"
+"fs_use_trans"
+"genfscon"
+"r1"
+"r2"
+"r3"
+"u1"
+"u2"
+"u3"
+"t1"
+"t2"
+"t3"
+"l1"
+"l2"
+"h1"
+"h2"
+"policycap"
+"permissive"
+"default_user"
+"default_role"
+"default_type"
+"default_range"
+"low-high"
+"high"
+"low"
+"glblub"
diff --git a/checkpolicy/fuzz/min_pol.conf b/checkpolicy/fuzz/min_pol.conf
new file mode 100644
index 00000000..ff6d50e5
--- /dev/null
+++ b/checkpolicy/fuzz/min_pol.conf
@@ -0,0 +1,60 @@
+class process
+class blk_file
+class chr_file
+class dir
+class fifo_file
+class file
+class lnk_file
+class sock_file
+sid kernel
+sid security
+sid unlabeled
+sid fs
+sid file
+sid file_labels
+sid init
+sid any_socket
+sid port
+sid netif
+sid netmsg
+sid node
+sid igmp_packet
+sid icmp_socket
+sid tcp_socket
+sid sysctl_modprobe
+sid sysctl
+sid sysctl_fs
+sid sysctl_kernel
+sid sysctl_net
+sid sysctl_net_unix
+sid sysctl_vm
+sid sysctl_dev
+sid kmod
+sid policy
+sid scmp_packet
+sid devnull
+class process { dyntransition transition }
+default_role { blk_file } source;
+default_role { chr_file } source;
+default_role { dir } source;
+default_role { fifo_file } source;
+default_role { file } source;
+default_role { lnk_file } source;
+default_role { sock_file } source;
+type sys_isid;
+typealias sys_isid alias { dpkg_script_t rpm_script_t };
+allow sys_isid self : process { dyntransition transition };
+role sys_role;
+role sys_role types { sys_isid };
+user sys_user roles sys_role;
+sid kernel sys_user:sys_role:sys_isid
+sid security sys_user:sys_role:sys_isid
+sid unlabeled sys_user:sys_role:sys_isid
+sid file sys_user:sys_role:sys_isid
+sid port sys_user:sys_role:sys_isid
+sid netif sys_user:sys_role:sys_isid
+sid netmsg sys_user:sys_role:sys_isid
+sid node sys_user:sys_role:sys_isid
+sid devnull sys_user:sys_role:sys_isid
+fs_use_trans devpts sys_user:sys_role:sys_isid;
+fs_use_trans devtmpfs sys_user:sys_role:sys_isid;
diff --git a/checkpolicy/fuzz/min_pol.mls.conf b/checkpolicy/fuzz/min_pol.mls.conf
new file mode 100644
index 00000000..6d15846b
--- /dev/null
+++ b/checkpolicy/fuzz/min_pol.mls.conf
@@ -0,0 +1,65 @@
+class process
+class blk_file
+class chr_file
+class dir
+class fifo_file
+class file
+class lnk_file
+class sock_file
+sid kernel
+sid security
+sid unlabeled
+sid fs
+sid file
+sid file_labels
+sid init
+sid any_socket
+sid port
+sid netif
+sid netmsg
+sid node
+sid igmp_packet
+sid icmp_socket
+sid tcp_socket
+sid sysctl_modprobe
+sid sysctl
+sid sysctl_fs
+sid sysctl_kernel
+sid sysctl_net
+sid sysctl_net_unix
+sid sysctl_vm
+sid sysctl_dev
+sid kmod
+sid policy
+sid scmp_packet
+sid devnull
+class process { dyntransition transition }
+default_role { blk_file } source;
+default_role { chr_file } source;
+default_role { dir } source;
+default_role { fifo_file } source;
+default_role { file } source;
+default_role { lnk_file } source;
+default_role { sock_file } source;
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+mlsconstrain process transition t1 eq t2;
+type sys_isid;
+typealias sys_isid alias { dpkg_script_t rpm_script_t };
+allow sys_isid self : process { dyntransition transition };
+role sys_role;
+role sys_role types { sys_isid };
+user sys_user roles sys_role level s0 range s0 - s0:c0;
+sid kernel sys_user:sys_role:sys_isid:s0
+sid security sys_user:sys_role:sys_isid:s0
+sid unlabeled sys_user:sys_role:sys_isid:s0
+sid file sys_user:sys_role:sys_isid:s0
+sid port sys_user:sys_role:sys_isid:s0
+sid netif sys_user:sys_role:sys_isid:s0
+sid netmsg sys_user:sys_role:sys_isid:s0
+sid node sys_user:sys_role:sys_isid:s0
+sid devnull sys_user:sys_role:sys_isid:s0
+fs_use_trans devpts sys_user:sys_role:sys_isid:s0;
+fs_use_trans devtmpfs sys_user:sys_role:sys_isid:s0;
diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 3188af89..74a9f93c 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -1492,3 +1492,14 @@ static void pop_stack(void)
 	free(stack_top);
 	stack_top = parent;
 }
+
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+void module_compiler_reset(void)
+{
+	while (stack_top)
+		pop_stack();
+
+	last_block = NULL;
+	next_decl_id = 1;
+}
+#endif
diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.h
index 29b824b4..e43bc6c0 100644
--- a/checkpolicy/module_compiler.h
+++ b/checkpolicy/module_compiler.h
@@ -106,4 +106,8 @@ int begin_optional_else(int pass);
  * return -1. */
 int end_avrule_block(int pass);
 
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+void module_compiler_reset(void);
+#endif
+
 #endif
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index c998ff8b..19c05a58 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -312,6 +312,7 @@ GLBLUB				{ return(GLBLUB); }
 %%
 int yyerror(const char *msg)
 {
+#ifndef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
 	if (source_file[0])
 		fprintf(stderr, "%s:%lu:",
 			source_file, source_lineno);
@@ -322,6 +323,10 @@ int yyerror(const char *msg)
 			yytext,
 			policydb_lineno,
 			linebuf[0], linebuf[1]);
+#else
+	(void)msg;
+#endif
+
 	policydb_errors++;
 	return -1;
 }
@@ -331,6 +336,7 @@ int yywarn(const char *msg)
 	if (werror)
 		return yyerror(msg);
 
+#ifndef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
 	if (source_file[0])
 		fprintf(stderr, "%s:%lu:",
 			source_file, source_lineno);
@@ -341,6 +347,8 @@ int yywarn(const char *msg)
 			yytext,
 			policydb_lineno,
 			linebuf[0], linebuf[1]);
+#endif
+
 	return 0;
 }
 
diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
index 72d275e8..069f130a 100755
--- a/scripts/oss-fuzz.sh
+++ b/scripts/oss-fuzz.sh
@@ -70,3 +70,17 @@ $CC $CFLAGS -c -o binpolicy-fuzzer.o libsepol/fuzz/binpolicy-fuzzer.c
 $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/binpolicy-fuzzer"
 
 zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin
+
+## checkpolicy fuzzer ##
+
+make -C checkpolicy clean
+make -C checkpolicy V=1 -j"$(nproc)" checkobjects
+# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepted by
+# the compiler/linker so they shouldn't be quoted
+# shellcheck disable=SC2086
+$CC $CFLAGS -Icheckpolicy/ -c -o checkpolicy-fuzzer.o checkpolicy/fuzz/checkpolicy-fuzzer.c
+# shellcheck disable=SC2086
+$CXX $CXXFLAGS $LIB_FUZZING_ENGINE checkpolicy-fuzzer.o checkpolicy/*.o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/checkpolicy-fuzzer"
+
+zip -j "$OUT/checkpolicy-fuzzer_seed_corpus.zip" checkpolicy/fuzz/min_pol.mls.conf
+cp checkpolicy/fuzz/checkpolicy-fuzzer.dict "$OUT/"
-- 
2.43.0

