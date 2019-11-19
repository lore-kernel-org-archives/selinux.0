Return-Path: <SRS0=SKFz=ZL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E64C432C0
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E651C2067D
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="UndVCpHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfKSLiv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:38:51 -0500
Received: from mailomta27-sa.btinternet.com ([213.120.69.33]:15857 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727733AbfKSLiv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Nov 2019 06:38:51 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20191119113847.ZGNC28776.sa-prd-fep-049.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 19 Nov 2019 11:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1574163527; 
        bh=pLVqCSHorzsRyBPbLBArizgYtTPumoWdPGkHDCmWABQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=UndVCpHMh2D77pH00f2ohka11vXtr8mgtqlZbnhMoGAHh+5Oq6ZtOKbrw6nS83eenIIZLuHD3ykYIW+uQAKQGVFAJ+IlYvhosqzzrGFmg1P11sQbhNOxyjMSiJGhqp2tvGO5dtPp2x1I6lg7NjSPSRlcQCR3Gq0pjVS+1z66Sb7lgA3ZR46SoT0mgZ0Q+rGubERfVgti9pf5NvOOi5KXFl3lkxh+q9fzqASJYT4sL76G+9DoKUm8DCwW591nAs6o2Nj1wjX8ySjrBcza4eve6A4TGu+9os9jhTpGY59K1GaLHWMxxyvfEVorLCcJpXoasIeDMuQM82leoo0Z4SXZ6A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.51.79.186]
X-OWM-Source-IP: 31.51.79.186 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrhedurdejledrudekieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurdejledrudekiedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.79.186) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8362CD0AFC372C; Tue, 19 Nov 2019 11:38:47 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V4] selinux-testsuite: Add kernel module tests
Date:   Tue, 19 Nov 2019 11:38:45 +0000
Message-Id: <20191119113845.89951-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test kernel module loading permissions.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change:
Check permission denial module_load versus module_request by using a
test kernel module for each.
Note: Rawhide (with secnext kernel) adds built-in.a and built-in.a.cmd when
building modules, therefore added to Makefile and .gitignore.
V3 Changes:
As requested in [1] except policy change, coalesced type attributes instead.
V4 Change:
Change attributes initmoddoman and finitmoddomain to a single attribute of
kmoduledomain.

[1] https://lore.kernel.org/selinux/CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com/

 policy/Makefile                           |   4 +
 policy/test_module_load.te                | 108 +++++++++++++++++++
 tests/Makefile                            |   4 +
 tests/module_load/.gitignore              |  11 ++
 tests/module_load/Makefile                |  12 +++
 tests/module_load/finit_load.c            |  94 +++++++++++++++++
 tests/module_load/init_load.c             | 123 ++++++++++++++++++++++
 tests/module_load/setest_module_load.c    |  18 ++++
 tests/module_load/setest_module_request.c |  22 ++++
 tests/module_load/test                    |  62 +++++++++++
 10 files changed, 458 insertions(+)
 create mode 100644 policy/test_module_load.te
 create mode 100644 tests/module_load/.gitignore
 create mode 100644 tests/module_load/Makefile
 create mode 100644 tests/module_load/finit_load.c
 create mode 100644 tests/module_load/init_load.c
 create mode 100644 tests/module_load/setest_module_load.c
 create mode 100644 tests/module_load/setest_module_request.c
 create mode 100755 tests/module_load/test

diff --git a/policy/Makefile b/policy/Makefile
index ad94c43..25dfb69 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -94,6 +94,10 @@ ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt && echo
 TARGETS += test_key_socket.te
 endif
 
+ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS+=test_module_load.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
diff --git a/policy/test_module_load.te b/policy/test_module_load.te
new file mode 100644
index 0000000..5496d86
--- /dev/null
+++ b/policy/test_module_load.te
@@ -0,0 +1,108 @@
+############# Test kernel modules ###################
+#
+attribute kmoduledomain;
+
+#
+############################## Define Macro ################################
+#
+# Replace domain_type() macro as it hides some relevant denials in audit.log
+#
+gen_require(`
+	type setrans_var_run_t, syslogd_t;
+')
+
+define(`module_domain_type',`
+	allow $1 proc_t:dir { search };
+	allow $1 proc_t:lnk_file { read };
+	allow $1 self:dir { search };
+	allow $1 self:file { open read write };
+	dontaudit init_t syslogd_t:fd use;
+	dontaudit $1 security_t:filesystem getattr;
+	dontaudit $1 self:file getattr;
+	dontaudit $1 setrans_var_run_t:dir search;
+	dontaudit unconfined_t $1:process { noatsecure rlimitinh siginh };
+')
+
+#
+############# Test kernel modules with finitmod_module(2) ###################
+#
+type test_finitmod_t;
+module_domain_type(test_finitmod_t)
+unconfined_runs_test(test_finitmod_t)
+typeattribute test_finitmod_t testdomain, kmoduledomain;
+
+allow test_finitmod_t self:capability { sys_module };
+allow test_finitmod_t test_file_t:system { module_load };
+allow test_finitmod_t kernel_t:system { module_request };
+
+############### Deny cap sys_module ######################
+type test_finitmod_deny_sys_module_t;
+module_domain_type(test_finitmod_deny_sys_module_t)
+unconfined_runs_test(test_finitmod_deny_sys_module_t)
+typeattribute test_finitmod_deny_sys_module_t testdomain, kmoduledomain;
+
+neverallow test_finitmod_deny_sys_module_t self:capability { sys_module };
+
+############### Deny sys module_load ######################
+type test_finitmod_deny_module_load_t;
+module_domain_type(test_finitmod_deny_module_load_t)
+unconfined_runs_test(test_finitmod_deny_module_load_t)
+typeattribute test_finitmod_deny_module_load_t testdomain, kmoduledomain;
+
+allow test_finitmod_deny_module_load_t self:capability { sys_module };
+neverallow test_finitmod_deny_module_load_t test_file_t:system { module_load };
+
+############### Deny sys module_request ######################
+type test_finitmod_deny_module_request_t;
+module_domain_type(test_finitmod_deny_module_request_t)
+unconfined_runs_test(test_finitmod_deny_module_request_t)
+typeattribute test_finitmod_deny_module_request_t testdomain, kmoduledomain;
+
+allow test_finitmod_deny_module_request_t self:capability { sys_module };
+allow test_finitmod_deny_module_request_t test_file_t:system { module_load };
+neverallow test_finitmod_deny_module_request_t kernel_t:system { module_request };
+
+#
+############# Test kernel modules with initmod_module(2) ###################
+#
+type test_initmod_t;
+module_domain_type(test_initmod_t)
+unconfined_runs_test(test_initmod_t)
+typeattribute test_initmod_t testdomain, kmoduledomain;
+
+allow test_initmod_t self:capability { sys_module };
+allow test_initmod_t self:system { module_load };
+allow test_initmod_t kernel_t:system { module_request };
+
+############### Deny cap sys_module ######################
+type test_initmod_deny_sys_module_t;
+module_domain_type(test_initmod_deny_sys_module_t)
+unconfined_runs_test(test_initmod_deny_sys_module_t)
+typeattribute test_initmod_deny_sys_module_t testdomain, kmoduledomain;
+
+neverallow test_initmod_deny_sys_module_t self:capability { sys_module };
+
+############### Deny sys module_load ######################
+type test_initmod_deny_module_load_t;
+module_domain_type(test_initmod_deny_module_load_t)
+unconfined_runs_test(test_initmod_deny_module_load_t)
+typeattribute test_initmod_deny_module_load_t testdomain, kmoduledomain;
+
+allow test_initmod_deny_module_load_t self:capability { sys_module };
+neverallow test_initmod_deny_module_load_t self:system { module_load };
+
+############### Deny sys module_request ######################
+type test_initmod_deny_module_request_t;
+module_domain_type(test_initmod_deny_module_request_t)
+unconfined_runs_test(test_initmod_deny_module_request_t)
+typeattribute test_initmod_deny_module_request_t testdomain, kmoduledomain;
+
+allow test_initmod_deny_module_request_t self:capability { sys_module };
+allow test_initmod_deny_module_request_t self:system { module_load };
+neverallow test_initmod_deny_module_request_t kernel_t:system { module_request };
+
+#
+########### Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(kmoduledomain)
+userdom_sysadm_entry_spec_domtrans_to(kmoduledomain)
diff --git a/tests/Makefile b/tests/Makefile
index cca6648..0452887 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -72,6 +72,10 @@ ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.
 SUBDIRS+=notify
 endif
 
+ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS+=module_load
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/module_load/.gitignore b/tests/module_load/.gitignore
new file mode 100644
index 0000000..7fa5772
--- /dev/null
+++ b/tests/module_load/.gitignore
@@ -0,0 +1,11 @@
+finit_load
+init_load
+modules.order
+Module.symvers
+*.a
+*.o
+*.ko
+*.cmd
+*.mod
+*.mod.c
+.*.cmd
diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
new file mode 100644
index 0000000..b6eba25
--- /dev/null
+++ b/tests/module_load/Makefile
@@ -0,0 +1,12 @@
+obj-m = setest_module_load.o setest_module_request.o
+
+TARGETS = finit_load init_load
+LDLIBS += -lselinux
+KDIR = /lib/modules/$(shell uname -r)/build
+
+all: $(TARGETS)
+	$(MAKE) -C $(KDIR) M=$(PWD)
+
+clean:
+	rm -f $(TARGETS)
+	rm -f *.a *.o *.ko *.cmd *.mod *.mod.c .*.cmd Module.symvers modules.order
diff --git a/tests/module_load/finit_load.c b/tests/module_load/finit_load.c
new file mode 100644
index 0000000..1c05d7b
--- /dev/null
+++ b/tests/module_load/finit_load.c
@@ -0,0 +1,94 @@
+#define _GNU_SOURCE 1
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/syscall.h>
+#include <selinux/selinux.h>
+
+static void print_usage(char *progfile_name)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] path name\n"
+		"Where:\n\t"
+		"-v    Print information.\n\t"
+		"path  Kernel module build path.\n\t"
+		"name  Name of kernel module to load.\n", progfile_name);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	char *context, file_name[PATH_MAX];
+	int opt, result, fd, s_errno;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			print_usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc)
+		print_usage(argv[0]);
+
+	result = sprintf(file_name, "%s/%s.ko", argv[optind],
+			 argv[optind + 1]);
+	if (result < 0) {
+		fprintf(stderr, "Failed sprintf\n");
+		exit(-1);
+	}
+
+	fd = open(file_name, O_RDONLY);
+	if (!fd) {
+		fprintf(stderr, "Failed to open %s: %s\n",
+			file_name, strerror(errno));
+		exit(-1);
+	}
+
+	if (verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Failed to obtain process context\n");
+			close(fd);
+			exit(-1);
+		}
+
+		printf("Process context:\n\t%s\n", context);
+		free(context);
+	}
+
+	result = syscall(__NR_finit_module, fd, "", 0);
+	s_errno = errno;
+	close(fd);
+	if (result < 0) {
+		fprintf(stderr, "Failed to load '%s' module: %s\n",
+			file_name, strerror(s_errno));
+		/* Denying: sys_module=EPERM, module_load=EACCES */
+		exit(s_errno);
+	}
+
+	if (verbose)
+		printf("Loaded kernel module:  %s\n", file_name);
+
+	result = syscall(__NR_delete_module, argv[optind + 1], 0);
+	if (result < 0) {
+		fprintf(stderr, "Failed to delete '%s' module: %s\n",
+			argv[optind + 1], strerror(errno));
+		exit(-1);
+	}
+
+	if (verbose)
+		printf("Deleted kernel module: %s\n", argv[optind + 1]);
+
+	return 0;
+}
diff --git a/tests/module_load/init_load.c b/tests/module_load/init_load.c
new file mode 100644
index 0000000..0422c19
--- /dev/null
+++ b/tests/module_load/init_load.c
@@ -0,0 +1,123 @@
+#define _GNU_SOURCE 1
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <selinux/selinux.h>
+
+static void print_usage(char *progfile_name)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] path name\n"
+		"Where:\n\t"
+		"-v    Print information.\n\t"
+		"path  Kernel module build path.\n\t"
+		"name  Name of kernel module to load.\n", progfile_name);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	char *context, file_name[PATH_MAX];
+	int opt, result, fd, s_errno;
+	bool verbose = false;
+	void *elf_image;
+	struct stat st;
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			print_usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc)
+		print_usage(argv[0]);
+
+	result = sprintf(file_name, "%s/%s.ko", argv[optind],
+			 argv[optind + 1]);
+	if (result < 0) {
+		fprintf(stderr, "Failed sprintf\n");
+		exit(-1);
+	}
+
+	fd = open(file_name, O_RDONLY);
+	if (!fd) {
+		fprintf(stderr, "Failed to open %s: %s\n",
+			file_name, strerror(errno));
+		exit(-1);
+	}
+
+	if (verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Failed to obtain process context\n");
+			close(fd);
+			exit(-1);
+		}
+
+		printf("Process context:\n\t%s\n", context);
+		free(context);
+	}
+
+	result = fstat(fd, &st);
+	if (result < 0) {
+		fprintf(stderr, "Failed fstat on %s: %s\n",
+			file_name, strerror(errno));
+		close(fd);
+		exit(-1);
+	}
+
+	elf_image = malloc(st.st_size);
+	if (!elf_image) {
+		fprintf(stderr, "Failed malloc on %s: %s\n",
+			file_name, strerror(errno));
+		close(fd);
+		exit(-1);
+	}
+
+	result = read(fd, elf_image, st.st_size);
+	if (result < 0) {
+		fprintf(stderr, "Failed read on %s: %s\n",
+			file_name, strerror(errno));
+		close(fd);
+		free(elf_image);
+		exit(-1);
+	}
+	close(fd);
+
+	result = syscall(__NR_init_module, elf_image, st.st_size, "");
+	s_errno = errno;
+	free(elf_image);
+	if (result < 0) {
+		fprintf(stderr, "Failed to load '%s' module: %s\n",
+			file_name, strerror(s_errno));
+		/* Denying: sys_module=EPERM, module_load & request=EACCES */
+		exit(s_errno);
+	}
+
+	if (verbose)
+		printf("Loaded kernel module:  %s\n", file_name);
+
+	result = syscall(__NR_delete_module, argv[optind + 1], 0);
+	if (result < 0) {
+		fprintf(stderr, "Failed to delete '%s' module: %s\n",
+			argv[optind + 1], strerror(errno));
+		exit(-1);
+	}
+
+	if (verbose)
+		printf("Deleted kernel module: %s\n", argv[optind + 1]);
+
+	return 0;
+}
diff --git a/tests/module_load/setest_module_load.c b/tests/module_load/setest_module_load.c
new file mode 100644
index 0000000..0be7a26
--- /dev/null
+++ b/tests/module_load/setest_module_load.c
@@ -0,0 +1,18 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+static int __init setest_module_load_init(void)
+{
+	pr_info("INIT - setest_module_load\n");
+	return 0;
+}
+
+static void __exit setest_module_load_exit(void)
+{
+	pr_info("EXIT - setest_module_load\n");
+}
+
+module_init(setest_module_load_init);
+module_exit(setest_module_load_exit);
+MODULE_LICENSE("GPL");
diff --git a/tests/module_load/setest_module_request.c b/tests/module_load/setest_module_request.c
new file mode 100644
index 0000000..f79d4ef
--- /dev/null
+++ b/tests/module_load/setest_module_request.c
@@ -0,0 +1,22 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+static int __init setest_module_request_init(void)
+{
+	int result;
+
+	pr_info("INIT - setest_module_request\n");
+	result = request_module_nowait("dummy-module");
+	pr_info("request_module() returned: %d\n", result);
+	return result;
+}
+
+static void __exit setest_module_request_exit(void)
+{
+	pr_info("EXIT - setest_module_request\n");
+}
+
+module_init(setest_module_request_init);
+module_exit(setest_module_request_exit);
+MODULE_LICENSE("GPL");
diff --git a/tests/module_load/test b/tests/module_load/test
new file mode 100755
index 0000000..c3242fc
--- /dev/null
+++ b/tests/module_load/test
@@ -0,0 +1,62 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # allow info to be shown during tests
+    $v = $ARGV[0];
+    if ($v) {
+        if ( $v ne "-v" ) {
+            plan skip_all => "Invalid option (use -v)";
+        }
+    }
+    else {
+        $v = " ";
+    }
+
+    plan tests => 8;
+}
+
+print "Test finit_module(2)\n";
+$result = system
+"runcon -t test_finitmod_t $basedir/finit_load $v $basedir setest_module_request";
+ok( $result eq 0 );
+
+# Deny capability { sys_module } - EPERM
+$result = system
+"runcon -t test_finitmod_deny_sys_module_t $basedir/finit_load $v $basedir setest_module_load 2>&1";
+ok( $result >> 8 eq 1 );
+
+# Deny system { module_load } - EACCES
+$result = system
+"runcon -t test_finitmod_deny_module_load_t $basedir/finit_load $v $basedir setest_module_load 2>&1";
+ok( $result >> 8 eq 13 );
+
+# Deny system { module_request } - EACCES
+$result = system
+"runcon -t test_finitmod_deny_module_request_t $basedir/finit_load $v $basedir setest_module_request 2>&1";
+ok( $result >> 8 eq 13 );
+
+print "Test init_module(2)\n";
+$result = system
+"runcon -t test_initmod_t $basedir/init_load $v $basedir setest_module_request";
+ok( $result eq 0 );
+
+# Deny capability { sys_module } - EPERM
+$result = system
+"runcon -t test_initmod_deny_sys_module_t $basedir/init_load $v $basedir setest_module_load 2>&1";
+ok( $result >> 8 eq 1 );
+
+# Deny system { module_load } - EACCES
+$result = system
+"runcon -t test_initmod_deny_module_load_t $basedir/init_load $v $basedir setest_module_load 2>&1";
+ok( $result >> 8 eq 13 );
+
+# Deny system { module_request } - EACCES
+$result = system
+"runcon -t test_initmod_deny_module_request_t $basedir/init_load $v $basedir setest_module_request 2>&1";
+ok( $result >> 8 eq 13 );
+
+exit;
-- 
2.23.0

