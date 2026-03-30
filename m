Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702C39A070
	for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899501; cv=none; b=u1nwqVxcr55pXr0zGKriQOVvXsO7+Ych28xYij3JtM40mVhrT/0T5MJStqPAj2+Y9RyuMkkS5JTAVWRsT5xSHsfpE35IrGaUuWPc8CcycOc6Bie9pxaDlr5DlTx6u760Rm0lDmepL8iHVmg/S6sXIDGC23Qz2zrBQaihFk6cnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899501; c=relaxed/simple;
	bh=mEaZyVw3Su9S/KZt6bi3Y87yL6o7HMEi1VDoU+n4g7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3tbQiBhzfoqV2abmo9wqopDenyrDQ0tDUREg0D3yQ9B1+6UfD9HphtGOC4xDVF63zCfUmZLw3yIzx9nciXC8fhnw8gzCG0PAGBqFfpGMhSTpRU94hYQ25OX05yBRtO5s6YIPdLdBx38BOzcBFif+k500IxnOQCN7wIk8DkTiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stOkPLVs; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stOkPLVs"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8a032383008so28624066d6.1
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774899497; x=1775504297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUkgDMSVbpM6fm+fSloymf8HU2vAik3EKS+I9B+5P9Q=;
        b=stOkPLVsCMyP7Rl1CFBjeC7GU6rpkN448HkU3tb0i7woOPUsf1r9y13nWKQSiHyXbX
         qroOwedFV108XkbqtiWh65/KL3kz4O83s4YedeKo8ehavGC+Ptepv0h7JkiLnEwx7YhE
         93MdoqUGEHwSx3N1Vllyufdv25txlQCTBH31gQkuJ/jwrZ/n6kHWBvTYsSZNIr3Xsl84
         5ksPvkEsyrlbhc7EXA/VflEJfNfXyke4slTI+ftbz3uzeESZHGxeCZnugxoe1XnnVHBY
         AusA/fh+RFEwxoCi7Z7KmgirBn+6yifkv8tJLkRn8JJ+EJH9/LCsIJiNmrzXzJZ3Ckg+
         67NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899497; x=1775504297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUkgDMSVbpM6fm+fSloymf8HU2vAik3EKS+I9B+5P9Q=;
        b=HR2QpsgtkHKr5wDYaKou2m/Hlr3OCOXOt3y8YK2QLzurW3Ryulf8dyl6qeokF2IMJN
         8tQQlaUV2K81XtFs//o62hfu+4D4F9JkdP0YbZ4/7TH9ZtpZh3ZQhlanBM+LDd4FHqeH
         F7ACz2NsfM9kNc013Sr02WP4Zca9LnAKAkHVqZPkheyIv7tJx9yGbfj2ePiAYoHNwfMp
         gqEO6+jIFSBl/qYQwUjvqAPi8pgUGjopLECEBZlDzNgK99hKNZFlRb3EMFjubAf0gs0q
         HAk3TjSCZN45JjP2GOu9hZ1rtPsaeQMXwE5FRq8H1lCHfep/82XZdz0acm1msFl9gFb8
         618w==
X-Gm-Message-State: AOJu0YxOj9aFN1+B1h3P7iEaOphwTcIHpOL+TxmmaFHgK5nLFTQ2OybR
	Q7Keh9JaIoO9U0c9O4nGamaOROy5yFtTDxqN7Uw8LrTjKD7sQpE4bCw7ybFB3vqT
X-Gm-Gg: ATEYQzz4GcQyL5zMWK+hzEqo88LZF0PIVuYyfFaSVawAIKA+TBhzG8v2x7nQCMtFDgN
	L1rqB+YkqVBIgBORpQYz37ER82drJ+w5OkBa8nR2D2/ZJTytynP610Sjshm9f/EdZMltQymKstc
	aKwqCz+iQRKFPsY0H474e5y5i4SY252mOH37rG08Zqcgfq1g47EfSmUp4i3OXPnY9FN5ZNayS6F
	o0FPg9/pM8h9aerXKChKTd30P6U5T7lsZ/eWYJoPDOoxZBee1xvdRaRTQxquxKlOUWUbKoW5uSJ
	/d2aqw9u61X176HGLIg0dE8TdIZB5apWkGDvMja5un8zdOX3nXCatxKXt+U6ayRVTAlfzcE1rJ8
	0sA0DhBouhX3R19euNFPYn4VY4LqgbPILWYw9Gn1UhAvHkUuObd+TPjRxnlY63KCjHYqKXU2pkI
	He49RwNwk09TOhfvf6gThFuY/qeI/JZtvrmvL8cqzUbq7Q/BMPOe+K2WF/1kReAgxRztqQvpw6f
	RvTSPMAs+V6oOMajZCjnSUJvV8=
X-Received: by 2002:a05:6214:4b09:b0:89c:cc9d:6fa3 with SMTP id 6a1803df08f44-89ce8d4d5ebmr203412076d6.11.1774899496761;
        Mon, 30 Mar 2026 12:38:16 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecb5cf18esm72628326d6.4.2026.03.30.12.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:38:16 -0700 (PDT)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com
Subject: [RFC PATCH testsuite] Add tests for namespaces
Date: Mon, 30 Mar 2026 19:37:57 +0000
Message-ID: <20260330193757.5702-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Add tests for namespaces, exercising the namespace
create and setns permissions. Requires the correspending
kernel patch, and the addition of a new set of classes
and permissions to the policy.

The base policy can be updated to support the new class
as follows:

Namespace classes: cgroup_namespace, ipc_namespace,
mnt_namespace, net_namespace, pid_namespace,
time_namespace, user_namespace, uts_namespace

Permissions: create, setns

- sudo semodule -c -E base
- sudo vi base.cil

Add a common class "namespace" with all listed perms.
Add each class to the classorder list.
Add each class with empty permissions. Below each add
a class common declaration using "namespace".
Add allow rules for the unconfined_domain_type and
init_t with the listed permissions for
each class to prevent anything from breaking.

- sudo semodule -i base.cil
- sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
    /usr/share/selinux/devel/include/support/all_perms.spt.orig
- sudo vi /usr/share/selinux/devel/include/support/all_perms.spt

Define "all_namespace_perms" with the listed permissions.
Add each class to the all_kernel_class_perms list with
all_namespace_perms for each.

When finished testing, you can undo the module change and restore
the original all_perms file as follows:
-  sudo semodule -r base
-  sudo cp /usr/share/selinux/devel/include/support/all_perms.spt.orig \
    /usr/share/selinux/devel/include/support/all_perms.spt

Link: https://lore.kernel.org/selinux/20260330193100.3603-1-danieldurning.work@gmail.com/
Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 policy/Makefile                  |  12 ++
 policy/test_cap_userns.te        |   2 +
 policy/test_filesystem.te        |  23 ++
 policy/test_global.te            |   8 +
 policy/test_namespace.te         |  75 +++++++
 policy/test_overlayfs.te         |   1 +
 tests/Makefile                   |   4 +
 tests/namespace/.gitignore       |   2 +
 tests/namespace/Makefile         |   7 +
 tests/namespace/ns_create_test.c |  99 +++++++++
 tests/namespace/setns_test.c     | 352 +++++++++++++++++++++++++++++++
 tests/namespace/test             | 182 ++++++++++++++++
 12 files changed, 767 insertions(+)
 create mode 100644 policy/test_namespace.te
 create mode 100644 tests/namespace/.gitignore
 create mode 100644 tests/namespace/Makefile
 create mode 100644 tests/namespace/ns_create_test.c
 create mode 100644 tests/namespace/setns_test.c
 create mode 100755 tests/namespace/test

diff --git a/policy/Makefile b/policy/Makefile
index 40bf393..39b142a 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -142,6 +142,10 @@ TARGETS += test_perf_event.te
 endif
 endif
 
+ifeq ($(shell grep -q " mnt_namespace" $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_namespace.te
+endif
+
 # Older kernels may still have the legacy lockdown class, so we need to add
 # the appropriate rules when the policy declares it.
 ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
@@ -187,6 +191,14 @@ ifeq ($(shell grep -q user_namespace $(POLDEV)/include/support/all_perms.spt &&
 export M4PARAM += -Duser_namespace_defined
 endif
 
+ifeq ($(shell grep -q mnt_namespace $(POLDEV)/include/support/all_perms.spt && echo true),true)
+export M4PARAM += -Dmnt_namespace_defined
+endif
+
+ifeq ($(shell grep -q pid_namespace $(POLDEV)/include/support/all_perms.spt && echo true),true)
+export M4PARAM += -Dpid_namespace_defined
+endif
+
 ifeq ($(shell grep -q checkpoint_restore $(POLDEV)/include/support/all_perms.spt && echo true),true)
 export M4PARAM += -Dcheckpoint_restore_defined
 endif
diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index 2994312..8aa1b6b 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -21,6 +21,8 @@ typeattribute test_no_cap_userns_t capusernsdomain;
 
 # Rules common to both domains.
 allow_userns_create(capusernsdomain)
+allow_mntns_create(capusernsdomain)
+allow_pidns_create(capusernsdomain)
 # linux >= v5.12 needs setfcap to map UID 0
 allow capusernsdomain self:capability setfcap;
 
diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index f60b0c8..a1c9701 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -397,3 +397,26 @@ allow test_filesystem_no_mount_t dosfs_t:filesystem { associate };
 allow test_filesystem_no_remount_t dosfs_t:filesystem { associate };
 allow test_filesystem_no_unmount_t dosfs_t:filesystem { associate };
 allow test_move_mount_no_mounton_t dosfs_t:filesystem { associate };
+
+#
+####### Allow mount namespace creation #################
+#
+allow_mntns_create(test_filesystem_fscontext_t)
+allow_mntns_create(test_filesystem_no_quotaget_t)
+allow_mntns_create(test_filesystem_no_quotamod_t)
+allow_mntns_create(test_move_mount_no_mounton_t)
+allow_mntns_create(test_filesystem_context_t)
+allow_mntns_create(test_filesystem_inode_relabel_no_associate_t)
+allow_mntns_create(test_filesystem_inode_setxattr_no_associate_t)
+allow_mntns_create(test_filesystem_may_create_no_associate_t)
+allow_mntns_create(test_filesystem_no_getattr_t)
+allow_mntns_create(test_filesystem_no_inode_no_relabelfrom_t)
+allow_mntns_create(test_filesystem_no_mount_t)
+allow_mntns_create(test_filesystem_no_remount_t)
+allow_mntns_create(test_filesystem_no_unmount_t)
+allow_mntns_create(test_filesystem_no_watch_mount_t)
+allow_mntns_create(test_filesystem_no_watch_sb_t)
+allow_mntns_create(test_filesystem_no_watch_t)
+allow_mntns_create(test_filesystem_sb_relabel_no_relabelfrom_t)
+allow_mntns_create(test_filesystem_sb_relabel_no_relabelto_t)
+allow_mntns_create(test_filesystem_t)
diff --git a/policy/test_global.te b/policy/test_global.te
index cb7d9c2..1978664 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -192,3 +192,11 @@ ifdef(`lockdown_defined', `allow $1 self:lockdown confidentiality;')
 define(`allow_userns_create',
 ifdef(`user_namespace_defined', `allow $1 self:user_namespace create;')
 )
+
+define(`allow_mntns_create',
+ifdef(`mnt_namespace_defined', `allow $1 self:mnt_namespace create;')
+)
+
+define(`allow_pidns_create',
+ifdef(`pid_namespace_defined', `allow $1 self:pid_namespace create;')
+)
diff --git a/policy/test_namespace.te b/policy/test_namespace.te
new file mode 100644
index 0000000..236aaa9
--- /dev/null
+++ b/policy/test_namespace.te
@@ -0,0 +1,75 @@
+#
+################# setns selinux-testsuite policy module ######################
+#
+
+require {
+    type nsfs_t;
+}
+
+attribute setnsdomain;
+
+################################### Main ###################################
+type test_namespace_t;
+testsuite_domain_type(test_namespace_t)
+typeattribute test_namespace_t setnsdomain;
+
+allow test_namespace_t self:capability { sys_resource sys_admin sys_chroot };
+allow test_namespace_t self:cap_userns { sys_admin };
+allow test_namespace_t nsfs_t:file { read open };
+allow test_namespace_t test_namespace_parent_t:process { dyntransition };
+
+allow test_namespace_t self:cgroup_namespace { create };
+allow test_namespace_t self:ipc_namespace { create };
+allow test_namespace_t self:mnt_namespace { create };
+allow test_namespace_t self:net_namespace { create };
+allow test_namespace_t self:pid_namespace { create };
+allow test_namespace_t self:time_namespace { create };
+allow test_namespace_t self:user_namespace { create };
+allow test_namespace_t self:uts_namespace { create };
+
+############################## Deny create #############################
+type test_namespace_deny_create_t;
+testsuite_domain_type(test_namespace_deny_create_t)
+typeattribute test_namespace_deny_create_t setnsdomain;
+
+allow test_namespace_deny_create_t self:capability { sys_resource sys_admin sys_chroot };
+allow test_namespace_deny_create_t self:cap_userns { sys_admin };
+allow test_namespace_deny_create_t nsfs_t:file { read open };
+allow test_namespace_deny_create_t test_namespace_parent_t:process { dyntransition };
+
+############################## Deny install #############################
+type test_namespace_deny_install_t;
+testsuite_domain_type(test_namespace_deny_install_t)
+typeattribute test_namespace_deny_install_t setnsdomain;
+
+allow test_namespace_deny_install_t self:capability { sys_resource sys_admin sys_chroot };
+allow test_namespace_deny_install_t self:cap_userns { sys_admin };
+allow test_namespace_deny_install_t nsfs_t:file { read open };
+allow test_namespace_deny_install_t test_namespace_parent_t:process { dyntransition };
+
+allow test_namespace_deny_install_t self:cgroup_namespace { create };
+allow test_namespace_deny_install_t self:ipc_namespace { create };
+allow test_namespace_deny_install_t self:mnt_namespace { create };
+allow test_namespace_deny_install_t self:net_namespace { create };
+allow test_namespace_deny_install_t self:pid_namespace { create };
+allow test_namespace_deny_install_t self:time_namespace { create };
+allow test_namespace_deny_install_t self:user_namespace { create };
+allow test_namespace_deny_install_t self:uts_namespace { create };
+
+############################## Parent process ##############################
+type test_namespace_parent_t;
+testsuite_domain_type(test_namespace_parent_t)
+typeattribute test_namespace_parent_t setnsdomain;
+
+allow test_namespace_parent_t self:capability { sys_admin sys_chroot };
+allow test_namespace_parent_t self:cap_userns { sys_admin };
+allow test_namespace_parent_t nsfs_t:file { read open };
+
+allow test_namespace_parent_t test_namespace_t:cgroup_namespace { setns };
+allow test_namespace_parent_t test_namespace_t:ipc_namespace { setns };
+allow test_namespace_parent_t test_namespace_t:mnt_namespace { setns };
+allow test_namespace_parent_t test_namespace_t:net_namespace { setns };
+allow test_namespace_parent_t test_namespace_t:pid_namespace { setns };
+allow test_namespace_parent_t test_namespace_t:time_namespace { setns };
+allow test_namespace_parent_t test_namespace_t:user_namespace { setns };
+allow test_namespace_parent_t test_namespace_t:uts_namespace { setns };
diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index c09b577..ceca05c 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -36,6 +36,7 @@ files_type(test_overlay_files_noaccess_t)
 allow test_overlay_mounter_t self:dir list_dir_perms;
 allow test_overlay_mounter_t self:file read_file_perms;
 allow test_overlay_mounter_t self:capability { sys_admin dac_override dac_read_search };
+allow_mntns_create(test_overlay_mounter_t)
 
 kernel_read_system_state(test_overlay_mounter_t)
 kernel_read_proc_symlinks(test_overlay_mounter_t)
diff --git a/tests/Makefile b/tests/Makefile
index 6df220c..97d3388 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -167,6 +167,10 @@ ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt && echo t
 SUBDIRS += io_uring
 endif
 
+ifeq ($(shell grep -q " mnt_namespace" $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS += namespace
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/namespace/.gitignore b/tests/namespace/.gitignore
new file mode 100644
index 0000000..426b2ce
--- /dev/null
+++ b/tests/namespace/.gitignore
@@ -0,0 +1,2 @@
+setns_test
+ns_create_test
diff --git a/tests/namespace/Makefile b/tests/namespace/Makefile
new file mode 100644
index 0000000..8d67853
--- /dev/null
+++ b/tests/namespace/Makefile
@@ -0,0 +1,7 @@
+TARGETS = setns_test ns_create_test
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/namespace/ns_create_test.c b/tests/namespace/ns_create_test.c
new file mode 100644
index 0000000..dfcc654
--- /dev/null
+++ b/tests/namespace/ns_create_test.c
@@ -0,0 +1,99 @@
+#include <stdio.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <linux/sched.h>
+#include <sched.h>
+#include <fcntl.h>
+#include <selinux/selinux.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"Usage: %s -c|-i|-m|-n|-p|-t|-u|-s [-v]\n"
+		"Where:\n\t"
+		"-c Attempt to clone with new cgroup namespace\n\t"
+		"-i Attempt to clone with new IPC namespace\n\t"
+		"-m Attempt to clone with new mount namespace\n\t"
+		"-n Attempt to clone with new net namespace\n\t"
+		"-p Attempt to clone with new pid namespace\n\t"
+		"-t Attempt to clone with new time namespace\n\t"
+		"-u Attempt to clone with new user namespace\n\t"
+		"-s Attempt to clone with new UTS namespace\n\t"
+		"-v Print information.\n", progname);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	int parent_pid, status, opt, ret = 0;
+	struct clone_args args = {0};
+	uint32_t clone_flag;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "cimnptusv")) != -1) {
+		switch (opt) {
+		case 'c':
+			clone_flag = CLONE_NEWCGROUP;
+			break;
+		case 'i':
+			clone_flag = CLONE_NEWIPC;
+			break;
+		case 'm':
+			clone_flag = CLONE_NEWNS;
+			break;
+		case 'n':
+			clone_flag = CLONE_NEWNET;
+			break;
+		case 'p':
+			clone_flag = CLONE_NEWPID;
+			break;
+		case 't':
+			clone_flag = CLONE_NEWTIME;
+			break;
+		case 'u':
+			clone_flag = CLONE_NEWUSER;
+			break;
+		case 's':
+			clone_flag = CLONE_NEWUTS;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind > argc || argc < 2)
+		usage(argv[0]);
+
+	if (verbose)
+		printf("Attempting to create new namespace during clone()...\n");
+	args.flags = clone_flag;
+	args.exit_signal = SIGCHLD;
+	parent_pid = syscall(SYS_clone3, &args, sizeof(struct clone_args));
+	if (parent_pid < 0)
+		return parent_pid;
+
+	if (parent_pid == 0) {
+		exit(EXIT_SUCCESS);
+	} else {
+		ret = waitpid(parent_pid, &status, 0);
+		if (ret < 0) {
+			perror("waitpid");
+			return ret;
+		}
+
+		if (!WIFEXITED(status)) {
+			perror("WIFEXITED");
+			return -1;
+		}
+
+		return -WEXITSTATUS(status);
+	}
+}
diff --git a/tests/namespace/setns_test.c b/tests/namespace/setns_test.c
new file mode 100644
index 0000000..8c61b28
--- /dev/null
+++ b/tests/namespace/setns_test.c
@@ -0,0 +1,352 @@
+// Code derived from: linux/source/tools/testing/selftests/bpf/prog_tests/token.c
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <stdio.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <linux/sched.h>
+#include <sched.h>
+#include <fcntl.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"Usage: %s -c|-i|-m|-n|-p|-t|-u|-s [-v] <parent context type>\n"
+		"Where:\n\t"
+		"-c Attempt to setns on cgroup namespace\n\t"
+		"-i Attempt to setns on IPC namespace\n\t"
+		"-m Attempt to setns on mount namespace\n\t"
+		"-n Attempt to setns on net namespace\n\t"
+		"-p Attempt to setns on pid namespace\n\t"
+		"-t Attempt to setns on time namespace\n\t"
+		"-u Attempt to setns on user namespace\n\t"
+		"-s Attempt to setns on UTS namespace\n\t"
+		"-v Print information.\n", progname);
+	exit(EXIT_FAILURE);
+}
+
+int sendfd(int sockfd, int fd)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	int fds[1] = { fd }, err;
+	char iobuf[1];
+	struct iovec io = {
+		.iov_base = iobuf,
+		.iov_len = sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fds));
+	memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
+
+	err = sendmsg(sockfd, &msg, 0);
+	if (err < 0) {
+		err = -errno;
+		return err;
+	}
+
+	return 0;
+}
+
+int getfd(int sockfd, int *fd)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	int fds[1], err;
+	char iobuf[1];
+	struct iovec io = {
+		.iov_base = iobuf,
+		.iov_len = sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+
+	err = recvmsg(sockfd, &msg, 0);
+	if (err < 0) {
+		err = -errno;
+		return err;
+	}
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+
+	memcpy(fds, CMSG_DATA(cmsg), sizeof(fds));
+	*fd = fds[0];
+
+	return 0;
+}
+
+int change_ctx(char* type)
+{
+	const char *context_s;
+	char *context_tmp;
+	context_t context;
+	int ret;
+
+	ret = getcon(&context_tmp);
+	if (ret < 0) {
+		perror("getcon");
+		return ret;
+	}
+
+	context = context_new(context_tmp);
+	if (!context) {
+		ret = -1;
+		perror("context_new");
+		return ret;
+	}
+
+	ret = context_type_set(context, type);
+	if (ret) {
+		perror("context_type_set");
+		return ret;
+	}
+
+	freecon(context_tmp);
+	context_s = context_str(context);
+	if (!context_s) {
+		ret = -1;
+		perror("context_type_set");
+		return ret;
+	}
+
+	ret = setcon(context_s);
+	if (ret < 0) {
+		perror("setcon");
+		return ret;
+	}
+}
+
+static inline int ns_flag_to_fd(uint32_t clone_flag)
+{
+	switch (clone_flag) {
+	case CLONE_NEWCGROUP:
+		return open("/proc/self/ns/cgroup", O_RDONLY);
+	case CLONE_NEWIPC:
+		return open("/proc/self/ns/ipc", O_RDONLY);
+	case CLONE_NEWNS:
+		return open("/proc/self/ns/mnt", O_RDONLY);
+	case CLONE_NEWNET:
+		return open("/proc/self/ns/net", O_RDONLY);
+	case CLONE_NEWPID:
+		return open("/proc/self/ns/pid", O_RDONLY);
+	case CLONE_NEWTIME:
+		return open("/proc/self/ns/time", O_RDONLY);
+	case CLONE_NEWUSER:
+		return open("/proc/self/ns/user", O_RDONLY);
+	case CLONE_NEWUTS:
+		return open("/proc/self/ns/uts", O_RDONLY);
+	default:
+		fprintf(stderr,
+			"ns_flag_to_fd: bad clone flag\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+int child(int sock_fd, uint32_t clone_flag)
+{
+	int ret, fd;
+
+	fd = ns_flag_to_fd(clone_flag);
+	if (fd < 0) {
+		perror("open");
+		ret = fd;
+		goto out;
+	}
+
+	ret = sendfd(sock_fd, fd);
+	if (ret)
+		perror("sendfd");
+
+out:
+	close(sock_fd);
+	close(fd);
+	return ret;
+}
+
+int parent(int sock_fd, uint32_t clone_flag, char* parent_type)
+{
+	int fd, ret;
+
+	ret = getfd(sock_fd, &fd);
+	if (ret) {
+		perror("getfd");
+		goto out;
+	}
+
+	/* Transition to the parent context */
+	ret = change_ctx(parent_type);
+	if (ret) {
+		perror("change_ctx");
+		goto out;
+	}
+
+	ret = syscall(SYS_setns, fd, clone_flag);
+
+out:
+	close(sock_fd);
+	return ret;
+}
+
+int do_test(uint32_t clone_flag, char* parent_type)
+{
+	int child_pid, status, ret = 0;
+	struct clone_args args = {0};
+	int sock_fds[2] = { -1, -1 };
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds);
+	if (ret < 0) {
+		perror("socketpair");
+		return ret;
+	}
+
+	args.flags = clone_flag;
+	args.exit_signal = SIGCHLD;
+	child_pid = syscall(SYS_clone3, &args, sizeof(struct clone_args));
+	if (child_pid < 0) {
+		perror("do_test clone");
+		return child_pid;
+	}
+
+	if (child_pid == 0) {
+		close(sock_fds[0]);
+		ret = child(sock_fds[1], clone_flag);
+		if (ret < 0) {
+			perror("child");
+			exit(EXIT_FAILURE);
+		}
+		exit(EXIT_SUCCESS);
+	} else {
+		close(sock_fds[1]);
+		ret = parent(sock_fds[0], clone_flag, parent_type);
+		if (ret < 0)
+			return ret;
+
+		ret = waitpid(child_pid, &status, 0);
+		if (ret < 0) {
+			perror("waitpid");
+			return ret;
+		}
+
+		if (!WIFEXITED(status)) {
+			perror("WIFEXITED");
+			return -1;
+		}
+
+		return -WEXITSTATUS(status);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int parent_pid, status, opt, ret = 0;
+	struct clone_args args = {0};
+	uint32_t clone_flag;
+	char *parent_type;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "cimnptusv")) != -1) {
+		switch (opt) {
+		case 'c':
+			clone_flag = CLONE_NEWCGROUP;
+			break;
+		case 'i':
+			clone_flag = CLONE_NEWIPC;
+			break;
+		case 'm':
+			clone_flag = CLONE_NEWNS;
+			break;
+		case 'n':
+			clone_flag = CLONE_NEWNET;
+			break;
+		case 'p':
+			clone_flag = CLONE_NEWPID;
+			break;
+		case 't':
+			clone_flag = CLONE_NEWTIME;
+			break;
+		case 'u':
+			clone_flag = CLONE_NEWUSER;
+			break;
+		case 's':
+			clone_flag = CLONE_NEWUTS;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc)
+		usage(argv[0]);
+
+	parent_type = argv[optind];
+	if (!parent_type)
+		usage(argv[0]);
+
+	if (verbose)
+		printf("Attempting to rejoin namespace after clone...\n");
+	/*
+	 * Init namespaces may not have a security blob. They fall back
+	 * to SECINITSID_KERNEL. Do an initial clone before entering
+	 * do_test() to get us out of the init namespace.
+	 * Always create a new mount namespace since this allows
+	 * the subsequent clone call to make a new user namespace
+	 * without a DAC denial.
+	 */
+	args.flags = clone_flag & CLONE_NEWNS;
+	args.exit_signal = SIGCHLD;
+	parent_pid = syscall(SYS_clone3, &args, sizeof(struct clone_args));
+	if (parent_pid < 0) {
+		perror("clone");
+		return parent_pid;
+	}
+
+	if (parent_pid == 0) {
+		ret = do_test(clone_flag, parent_type);
+		if (ret < 0)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	} else {
+		ret = waitpid(parent_pid, &status, 0);
+		if (ret < 0) {
+			perror("waitpid");
+			return ret;
+		}
+
+		if (!WIFEXITED(status)) {
+			perror("WIFEXITED");
+			return -1;
+		}
+
+		return -WEXITSTATUS(status);
+	}
+}
diff --git a/tests/namespace/test b/tests/namespace/test
new file mode 100755
index 0000000..60482e1
--- /dev/null
+++ b/tests/namespace/test
@@ -0,0 +1,182 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $test_count = 32;
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
+    plan tests => $test_count;
+}
+
+$parent_domain = "test_namespace_parent_t";
+
+# create
+
+# Allow create permission for cgroup namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -c $v";
+ok( $result eq 0 );
+
+# Deny create permission for cgroup namespace
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -c $v";
+ok($result);
+
+# Allow create permission for ipc namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -i $v";
+ok( $result eq 0 );
+
+# Deny create permission for ipc namespace
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -i $v";
+ok($result);
+
+# Allow create permission for mount namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -m $v";
+ok( $result eq 0 );
+
+# Deny create permission for mount namespace ###WEIRD PERM DENIAL - WHY?
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -m $v";
+ok($result);
+
+# Allow create permission for net namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -n $v";
+ok( $result eq 0 );
+
+# Deny create permission for net namespace
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -n $v";
+ok($result);
+
+# Allow create permission for pid namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -p $v";
+ok( $result eq 0 );
+
+# Deny create permission for pid namespace
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -p $v";
+ok($result);
+
+# Allow create permission for time namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -t $v";
+ok( $result eq 0 );
+
+# Deny create permission for time namespace
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -t $v";
+ok($result);
+
+# Allow create permission for user namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -u $v";
+ok( $result eq 0 );
+
+# Deny create permission for user namespace
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -u $v";
+ok($result);
+
+# Allow create permission for uts namespace
+$result = system "runcon -t test_namespace_t $basedir/ns_create_test -s $v";
+ok( $result eq 0 );
+
+# Deny create permission for uts namespace
+$result =
+  system "runcon -t test_namespace_deny_create_t $basedir/ns_create_test -s $v";
+ok($result);
+
+# setns
+
+# Allow setns permission for cgroup namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -c $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for cgroup namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -c $v $parent_domain";
+ok($result);
+
+# Allow setns permission for ipc namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -i $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for ipc namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -i $v $parent_domain";
+ok($result);
+
+# Allow setns permission for mount namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -m $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for mount namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -m $v $parent_domain";
+ok($result);
+
+# Allow setns permission for net namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -n $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for net namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -n $v $parent_domain";
+ok($result);
+
+# Allow setns permission for pid namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -p $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for pid namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -p $v $parent_domain";
+ok($result);
+
+# Allow setns permission for time namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -t $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for time namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -t $v $parent_domain";
+ok($result);
+
+# Allow setns permission for user namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -u $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for user namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -u $v $parent_domain";
+ok($result);
+
+# Allow setns permission for uts namespace
+$result =
+  system "runcon -t test_namespace_t $basedir/setns_test -s $v $parent_domain";
+ok( $result eq 0 );
+
+# Deny setns permission for uts namespace
+$result = system
+"runcon -t test_namespace_deny_install_t $basedir/setns_test -s $v $parent_domain";
+ok($result);
+
+exit;
-- 
2.51.0

