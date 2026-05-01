Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5326299
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640445; cv=none; b=bwL6DdLc7JbcyaiiAub6sJS9+hnkZ0m2Iv3Zx6ktMT7G3QSr5JMpfkU9thTM9RwEy3RXFuK7mbj2OzUgEwXwtub2gZzmTXaOOqZJ2EUHrYsmjLSSUPPxQ/SfJyE3ZfrTQ0qxwNy2tli5JOSKdlaAaV3+MjI7BJGN6ENHvRGZ2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640445; c=relaxed/simple;
	bh=pvlFNv4Vk2YhbsfABX1fSZTHDWpEjwUXCicTODaHVFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=km2i3k8a5axMQXCFUz0kohN/XR99C3KjxZaw/CwhGiA8Xxo8U/n8aIoyKO8aegTW+AWQfi08OVklukgdqKGk/9b2AIbYczw7rPpaGe0Tts/rz+jvjMUCAQGe9ELLxHKGMwTePTAVCTLIXWZsKCTRhqo+1osieugBwOhizDoxvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8tmZX+S; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8tmZX+S"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50d6ab4476eso16869371cf.2
        for <selinux@vger.kernel.org>; Fri, 01 May 2026 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777640441; x=1778245241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QG7EubCab7wkDo+JgEQ3VRkfIRUY4phoDHLLAQHdtS4=;
        b=h8tmZX+SHkOverP1oZ9J6szk4RNGNq3v25BV1/btnDEJRzWM/dclbYi53KLMzdray9
         KBxRZ7okNeIiYLZyYozZ02kgiPlkasAaCaRpWenA+hYv7e2rBLa8Deh7vr5kD6VNRgqZ
         kDASm33R8agvDMDBZgg7Zfi7YMcKNYaBHNMEP9bCfbg/j945Ymag1D/NpLuayIrIil2S
         vnDtvxpYF7TSR2001nhrksd6UmpBl33z4BgYTus/PAMrDbt/w5LzaKT2LEpmIaAbVAdD
         Mt+A5RXqO68wN8RGpOby04gpykXo/jBWZdcy4zCOhneNclXjxWAK6gWnWPl/3fdh65Gu
         RrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777640441; x=1778245241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG7EubCab7wkDo+JgEQ3VRkfIRUY4phoDHLLAQHdtS4=;
        b=e8dePPaHalrtgdhI4M9+2BhybzDc6c13634Jz1rReWwM5Nxe3HekI1mXD6OwV9amM/
         uQN27UXS4X/Mjlmm6swYvlXlbPanqhyr8xfzyKftAYy0BFwo6xMFkFRNRA+v0rEr6omj
         m73FtdHVh3UCMAZVLmJyQskTnQhp9T68KR9Iez/w6c3za32YW/TIyfClogPX/W+KjLn8
         F11WEMCk7aNDYyvjHPKZGdJDyLHUNEwSCI2XvEC4GkBwEyjlqPwu/Bklk/I4azjYKpfX
         Qs8aoVCaIXVCNTeQic8Qt0AvtyZZ4V1Ga7nz1f7eLk1gUnQeG4fBPdqNzicX6IA4yah7
         LL/A==
X-Gm-Message-State: AOJu0Yyg0BT995qV4XUBmiJZHZ0b2SG6jjZYzg5RM3bcZ6B5dvNwhRo0
	DxNUnAOc5r8GuQ9Twb0BBnR/y047upwCh41z+3fzvscQNt8tY+n8B2RbRHiamams
X-Gm-Gg: AeBDietkwTemvcVM/mXbISJIoyVG2GGMwsdSoGA4RZhWVlnm10Ii2lbiUgXyNfpOT3h
	+5oadpOkJAdfmdCFY5vcOQuoFkiHjHJ2qc6zuRyojnymntInbm2E5Mw/aK+lPL6XdykoqAHrBYs
	VK0oKyN3mtvflLw4c1+Lw5rAqdOoU2TMsOb1c+AcOzsS/J2poCbvd9w2OoBq5TLrVfFuERrVogN
	xXfAzJUPgBo/r8zVp689Wrn3r+aGNE66tZO6A4RF40hAT+9GWd0hdKub1MTc3VKPMOlwdxoQJZp
	F/e5zA5zuUfmMCySWO17JM3c1WBiaGWFvR7/YFAqOxYgPd4li5cZ08DHKFV7Qs0HmATlsXd5kCV
	szPN7S6fBcqnukfvDCPcSo4UxhXzYM/Trg+6wCaA7fKTlkLdr94NpE5l83tUrcTKpEr3Fw7PLsI
	IxiP+vV525RuXZosx+X4BVH8fAW0bj1JmtM2qzBKcqiVoKZKGeLst1IcfHhAFSDoFfB+ZHdJ3bH
	aKrrFDWTYHoB/swVKljn7Ptoi1tG1dsR63aqhF0s4dhT7y6Mw==
X-Received: by 2002:a05:622a:1195:b0:50e:5e8d:87be with SMTP id d75a77b69052e-5102ab423ffmr105495091cf.22.1777640433588;
        Fri, 01 May 2026 06:00:33 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51041ddb598sm11592211cf.13.2026.05.01.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:00:33 -0700 (PDT)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com
Subject: [PATCH testsuite v2] Add tests for namespaces
Date: Fri,  1 May 2026 12:56:34 +0000
Message-ID: <20260501125634.7700-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The base policy can be updated to support the new classes
as follows:

- sudo semodule -c -E base
- sudo vi base.cil

Replace the existing (class user_namespace (create))
line with the following:
(common namespace (create setns))
(class cgroup_namespace ())
(class ipc_namespace ())
(class mnt_namespace (create_anon ))
(class net_namespace ())
(class pid_namespace ())
(class time_namespace ())
(class user_namespace ())
(class uts_namespace ())
(classcommon cgroup_namespace namespace)
(classcommon ipc_namespace namespace)
(classcommon mnt_namespace namespace)
(classcommon net_namespace namespace)
(classcommon pid_namespace namespace)
(classcommon time_namespace namespace)
(classcommon user_namespace namespace)
(classcommon uts_namespace namespace)

Edit the existing (classorder (...)) line by adding
the new classes at the end:
(classorder (... user_namespace cgroup_namespace ipc_namespace
mnt_namespace net_namespace pid_namespace time_namespace
uts_namespace))

Add allow rules for the unconfined_domain_type and
init_t for each class to prevent anything from breaking:
(allow unconfined_domain_type self (cgroup_namespace (create setns)))
(allow unconfined_domain_type self (ipc_namespace (create setns)))
(allow unconfined_domain_type self (mnt_namespace (create create_anon setns)))
(allow unconfined_domain_type self (net_namespace (create setns)))
(allow unconfined_domain_type self (pid_namespace (create setns)))
(allow unconfined_domain_type self (time_namespace (create setns)))
(allow unconfined_domain_type self (user_namespace (create setns)))
(allow unconfined_domain_type self (uts_namespace (create setns)))
(allow init_t self (cgroup_namespace (create setns)))
(allow init_t self (ipc_namespace (create setns)))
(allow init_t self (mnt_namespace (create create_anon setns)))
(allow init_t self (net_namespace (create setns)))
(allow init_t self (pid_namespace (create setns)))
(allow init_t self (time_namespace (create setns)))
(allow init_t self (user_namespace (create setns)))
(allow init_t self (uts_namespace (create setns)))

- sudo semodule -i base.cil
- sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
    /usr/share/selinux/devel/include/support/all_perms.spt.orig
- sudo vi /usr/share/selinux/devel/include/support/all_perms.spt

Replace the existing define(`all_user_namespace_perms',`{ create }')
line with the following:
define(`all_namespace_perms',`{ create setns }')
define(`all_mnt_namespace_perms',`{ create create_anon setns }')

Replace the existing class user_namespace all_user_namespace_perms
line with the following:
class user_namespace all_namespace_perms;
	class cgroup_namespace all_namespace_perms;
	class ipc_namespace all_namespace_perms;
	class mnt_namespace all_mnt_namespace_perms;
	class net_namespace all_namespace_perms;
	class pid_namespace all_namespace_perms;
	class time_namespace all_namespace_perms;
	class uts_namespace all_namespace_perms;

When finished testing, you can undo the module change and restore
the original all_perms file as follows:
-  sudo semodule -r base
-  sudo cp /usr/share/selinux/devel/include/support/all_perms.spt.orig \
    /usr/share/selinux/devel/include/support/all_perms.spt

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
Link: https://lore.kernel.org/selinux/20260501124613.6589-1-danieldurning.work@gmail.com/
---
Changes in v2:
- Added tests for anonymous mount namespaces
- Changed instructions for policy modification for clarify
- Fixed allow rules in policy to silence an avc denial
- Fixed a missing return in change_ctx()
---
 policy/Makefile                       |  12 +
 policy/test_cap_userns.te             |   2 +
 policy/test_filesystem.te             |  24 ++
 policy/test_global.te                 |  16 ++
 policy/test_namespace.te              | 298 ++++++++++++++++++++++
 policy/test_overlayfs.te              |   1 +
 tests/Makefile                        |   4 +
 tests/namespace/.gitignore            |   3 +
 tests/namespace/Makefile              |   7 +
 tests/namespace/ns_create_anon_test.c |  64 +++++
 tests/namespace/ns_create_test.c      |  99 +++++++
 tests/namespace/setns_test.c          | 354 ++++++++++++++++++++++++++
 tests/namespace/test                  | 185 ++++++++++++++
 13 files changed, 1069 insertions(+)
 create mode 100644 policy/test_namespace.te
 create mode 100644 tests/namespace/.gitignore
 create mode 100644 tests/namespace/Makefile
 create mode 100644 tests/namespace/ns_create_anon_test.c
 create mode 100644 tests/namespace/ns_create_test.c
 create mode 100644 tests/namespace/setns_test.c
 create mode 100755 tests/namespace/test

diff --git a/policy/Makefile b/policy/Makefile
index bf1ea76..5e43abe 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -143,6 +143,10 @@ TARGETS += test_perf_event.te
 endif
 endif
 
+ifeq ($(shell grep -q " mnt_namespace" $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_namespace.te
+endif
+
 # Older kernels may still have the legacy lockdown class, so we need to add
 # the appropriate rules when the policy declares it.
 ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
@@ -188,6 +192,14 @@ ifeq ($(shell grep -q user_namespace $(POLDEV)/include/support/all_perms.spt &&
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
index f60b0c8..dfe72c1 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -397,3 +397,27 @@ allow test_filesystem_no_mount_t dosfs_t:filesystem { associate };
 allow test_filesystem_no_remount_t dosfs_t:filesystem { associate };
 allow test_filesystem_no_unmount_t dosfs_t:filesystem { associate };
 allow test_move_mount_no_mounton_t dosfs_t:filesystem { associate };
+
+#
+####### Allow mount namespace creation #################
+#
+allow_mntns_create_anon(test_filesystem_fscontext_t)
+allow_mntns_create_anon(test_filesystem_no_quotaget_t)
+allow_mntns_create_anon(test_filesystem_no_quotamod_t)
+allow_mntns_create_anon(test_file_no_quotaon_t)
+allow_mntns_create_anon(test_move_mount_no_mounton_t)
+allow_mntns_create_anon(test_filesystem_context_t)
+allow_mntns_create_anon(test_filesystem_inode_relabel_no_associate_t)
+allow_mntns_create_anon(test_filesystem_inode_setxattr_no_associate_t)
+allow_mntns_create_anon(test_filesystem_may_create_no_associate_t)
+allow_mntns_create_anon(test_filesystem_no_getattr_t)
+allow_mntns_create_anon(test_filesystem_no_inode_no_relabelfrom_t)
+allow_mntns_create_anon(test_filesystem_no_mount_t)
+allow_mntns_create_anon(test_filesystem_no_remount_t)
+allow_mntns_create_anon(test_filesystem_no_unmount_t)
+allow_mntns_create_anon(test_filesystem_no_watch_mount_t)
+allow_mntns_create_anon(test_filesystem_no_watch_sb_t)
+allow_mntns_create_anon(test_filesystem_no_watch_t)
+allow_mntns_create_anon(test_filesystem_sb_relabel_no_relabelfrom_t)
+allow_mntns_create_anon(test_filesystem_sb_relabel_no_relabelto_t)
+allow_mntns_create_anon(test_filesystem_t)
diff --git a/policy/test_global.te b/policy/test_global.te
index cb7d9c2..83eecde 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -73,6 +73,10 @@ dontaudit testsuite_caller_domain testsuite_domain:process { noatsecure rlimitin
 # sigkill - needed for some tests to pass
 allow testsuite_caller_domain testsuite_domain:process { ptrace sigkill };
 
+# Allow test caller domain to create namespaces
+allow testsuite_caller_domain self:mnt_namespace { create };
+allow testsuite_caller_domain self:pid_namespace { create };
+
 # keys test may trigger search AVCs for root's keys
 dontaudit testsuite_domain testsuite_caller_domain:key { search };
 
@@ -192,3 +196,15 @@ ifdef(`lockdown_defined', `allow $1 self:lockdown confidentiality;')
 define(`allow_userns_create',
 ifdef(`user_namespace_defined', `allow $1 self:user_namespace create;')
 )
+
+define(`allow_mntns_create',
+ifdef(`mnt_namespace_defined', `allow $1 self:mnt_namespace create;')
+)
+
+define(`allow_mntns_create_anon',
+ifdef(`mnt_namespace_defined', `allow $1 self:mnt_namespace create_anon;')
+)
+
+define(`allow_pidns_create',
+ifdef(`pid_namespace_defined', `allow $1 self:pid_namespace create;')
+)
diff --git a/policy/test_namespace.te b/policy/test_namespace.te
new file mode 100644
index 0000000..3788fad
--- /dev/null
+++ b/policy/test_namespace.te
@@ -0,0 +1,298 @@
+#
+################# namespace selinux-testsuite policy module ######################
+#
+
+require {
+    type nsfs_t;
+    type tmpfs_t;
+}
+
+attribute namespacedomain;
+
+define(`allow_common_ns_perms', `
+    allow $1 self:capability { sys_resource sys_admin sys_chroot };
+    allow $1 self:cap_userns { sys_admin };
+    allow $1 nsfs_t:file { read open };
+    allow $1 tmpfs_t:filesystem mount;
+')
+
+############################ Main cgroup namespace ########################
+type test_cgroupns_t;
+testsuite_domain_type(test_cgroupns_t)
+typeattribute test_cgroupns_t namespacedomain;
+
+allow_common_ns_perms(test_cgroupns_t)
+allow test_cgroupns_t test_cgroupns_parent_t:process { dyntransition };
+allow test_cgroupns_t self:cgroup_namespace { create };
+
+############################ Main ipc namespace ###########################
+type test_ipcns_t;
+testsuite_domain_type(test_ipcns_t)
+typeattribute test_ipcns_t namespacedomain;
+
+allow_common_ns_perms(test_ipcns_t)
+allow test_ipcns_t test_ipcns_parent_t:process { dyntransition };
+allow test_ipcns_t self:ipc_namespace { create };
+
+############################ Main mount namespace #########################
+type test_mntns_t;
+testsuite_domain_type(test_mntns_t)
+typeattribute test_mntns_t namespacedomain;
+
+allow_common_ns_perms(test_mntns_t)
+allow test_mntns_t test_mntns_parent_t:process { dyntransition };
+allow test_mntns_t self:mnt_namespace { create create_anon };
+
+############################ Main net namespace ##########################
+type test_netns_t;
+testsuite_domain_type(test_netns_t)
+typeattribute test_netns_t namespacedomain;
+
+allow_common_ns_perms(test_netns_t)
+allow test_netns_t test_netns_parent_t:process { dyntransition };
+allow test_netns_t self:net_namespace { create };
+
+############################ Main pid namespace ##########################
+type test_pidns_t;
+testsuite_domain_type(test_pidns_t)
+typeattribute test_pidns_t namespacedomain;
+
+allow_common_ns_perms(test_pidns_t)
+allow test_pidns_t test_pidns_parent_t:process { dyntransition };
+allow test_pidns_t self:pid_namespace { create };
+
+############################ Main time namespace #########################
+type test_timens_t;
+testsuite_domain_type(test_timens_t)
+typeattribute test_timens_t namespacedomain;
+
+allow_common_ns_perms(test_timens_t)
+allow test_timens_t test_timens_parent_t:process { dyntransition };
+allow test_timens_t self:time_namespace { create };
+
+############################ Main user namespace #########################
+type test_userns_t;
+testsuite_domain_type(test_userns_t)
+typeattribute test_userns_t namespacedomain;
+
+allow_common_ns_perms(test_userns_t)
+allow test_userns_t test_userns_parent_t:process { dyntransition };
+allow test_userns_t self:user_namespace { create };
+
+############################ Main uts namespace #########################
+type test_utsns_t;
+testsuite_domain_type(test_utsns_t)
+typeattribute test_utsns_t namespacedomain;
+
+allow_common_ns_perms(test_utsns_t)
+allow test_utsns_t test_utsns_parent_t:process { dyntransition };
+allow test_utsns_t self:uts_namespace { create };
+
+#################### Deny cgroup namespace create #######################
+type test_cgroupns_deny_create_t;
+testsuite_domain_type(test_cgroupns_deny_create_t)
+typeattribute test_cgroupns_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_cgroupns_deny_create_t)
+
+#################### Deny ipc namespace create #########################
+type test_ipcns_deny_create_t;
+testsuite_domain_type(test_ipcns_deny_create_t)
+typeattribute test_ipcns_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_ipcns_deny_create_t)
+
+#################### Deny mount namespace create #######################
+type test_mntns_deny_create_t;
+testsuite_domain_type(test_mntns_deny_create_t)
+typeattribute test_mntns_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_mntns_deny_create_t)
+allow test_mntns_deny_create_t self:mnt_namespace { create_anon };
+
+#################### Deny net namespace create ########################
+type test_netns_deny_create_t;
+testsuite_domain_type(test_netns_deny_create_t)
+typeattribute test_netns_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_netns_deny_create_t)
+
+#################### Deny pid namespace create ########################
+type test_pidns_deny_create_t;
+testsuite_domain_type(test_pidns_deny_create_t)
+typeattribute test_pidns_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_pidns_deny_create_t)
+
+#################### Deny time namespace create #######################
+type test_timens_deny_create_t;
+testsuite_domain_type(test_timens_deny_create_t)
+typeattribute test_timens_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_timens_deny_create_t)
+
+#################### Deny user namespace create #######################
+type test_userns_deny_create_t;
+testsuite_domain_type(test_userns_deny_create_t)
+typeattribute test_userns_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_userns_deny_create_t)
+
+#################### Deny uts namespace create #######################
+type test_utsns_deny_create_t;
+testsuite_domain_type(test_utsns_deny_create_t)
+typeattribute test_utsns_deny_create_t namespacedomain;
+
+allow_common_ns_perms(test_utsns_deny_create_t)
+
+################## Deny mount namespace create anon #####################
+type test_mntns_deny_create_anon_t;
+testsuite_domain_type(test_mntns_deny_create_anon_t)
+typeattribute test_mntns_deny_create_anon_t namespacedomain;
+
+allow_common_ns_perms(test_mntns_deny_create_anon_t)
+allow test_mntns_deny_create_anon_t self:mnt_namespace { create };
+
+#################### Deny cgroup namespace setns #######################
+type test_cgroupns_deny_setns_t;
+testsuite_domain_type(test_cgroupns_deny_setns_t)
+typeattribute test_cgroupns_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_cgroupns_deny_setns_t)
+allow test_cgroupns_deny_setns_t test_cgroupns_parent_t:process { dyntransition };
+allow test_cgroupns_deny_setns_t self:cgroup_namespace { create };
+
+#################### Deny ipc namespace setns #########################
+type test_ipcns_deny_setns_t;
+testsuite_domain_type(test_ipcns_deny_setns_t)
+typeattribute test_ipcns_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_ipcns_deny_setns_t)
+allow test_ipcns_deny_setns_t test_ipcns_parent_t:process { dyntransition };
+allow test_ipcns_deny_setns_t self:ipc_namespace { create };
+
+#################### Deny mount namespace setns #######################
+type test_mntns_deny_setns_t;
+testsuite_domain_type(test_mntns_deny_setns_t)
+typeattribute test_mntns_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_mntns_deny_setns_t)
+allow test_mntns_deny_setns_t test_mntns_parent_t:process { dyntransition };
+allow test_mntns_deny_setns_t self:mnt_namespace { create };
+
+#################### Deny net namespace setns ########################
+type test_netns_deny_setns_t;
+testsuite_domain_type(test_netns_deny_setns_t)
+typeattribute test_netns_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_netns_deny_setns_t)
+allow test_netns_deny_setns_t test_netns_parent_t:process { dyntransition };
+allow test_netns_deny_setns_t self:net_namespace { create };
+
+#################### Deny pid namespace setns ########################
+type test_pidns_deny_setns_t;
+testsuite_domain_type(test_pidns_deny_setns_t)
+typeattribute test_pidns_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_pidns_deny_setns_t)
+allow test_pidns_deny_setns_t test_pidns_parent_t:process { dyntransition };
+allow test_pidns_deny_setns_t self:pid_namespace { create };
+
+#################### Deny time namespace setns #######################
+type test_timens_deny_setns_t;
+testsuite_domain_type(test_timens_deny_setns_t)
+typeattribute test_timens_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_timens_deny_setns_t)
+allow test_timens_deny_setns_t test_timens_parent_t:process { dyntransition };
+allow test_timens_deny_setns_t self:time_namespace { create };
+
+#################### Deny user namespace setns #######################
+type test_userns_deny_setns_t;
+testsuite_domain_type(test_userns_deny_setns_t)
+typeattribute test_userns_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_userns_deny_setns_t)
+allow test_userns_deny_setns_t test_userns_parent_t:process { dyntransition };
+allow test_userns_deny_setns_t self:user_namespace { create };
+
+#################### Deny uts namespace setns #######################
+type test_utsns_deny_setns_t;
+testsuite_domain_type(test_utsns_deny_setns_t)
+typeattribute test_utsns_deny_setns_t namespacedomain;
+
+allow_common_ns_perms(test_utsns_deny_setns_t)
+allow test_utsns_deny_setns_t test_utsns_parent_t:process { dyntransition };
+allow test_utsns_deny_setns_t self:uts_namespace { create };
+
+###################### Parent for cgroup namespace #####################
+type test_cgroupns_parent_t;
+testsuite_domain_type(test_cgroupns_parent_t)
+typeattribute test_cgroupns_parent_t namespacedomain;
+
+allow_common_ns_perms(test_cgroupns_parent_t)
+allow test_cgroupns_parent_t test_cgroupns_t:cgroup_namespace { setns };
+allow test_cgroupns_parent_t test_cgroupns_deny_create_t:cgroup_namespace { setns };
+
+###################### Parent for ipc namespace #######################
+type test_ipcns_parent_t;
+testsuite_domain_type(test_ipcns_parent_t)
+typeattribute test_ipcns_parent_t namespacedomain;
+
+allow_common_ns_perms(test_ipcns_parent_t)
+allow test_ipcns_parent_t test_ipcns_t:ipc_namespace { setns };
+allow test_ipcns_parent_t test_ipcns_deny_create_t:ipc_namespace { setns };
+
+###################### Parent for mount namespace #####################
+type test_mntns_parent_t;
+testsuite_domain_type(test_mntns_parent_t)
+typeattribute test_mntns_parent_t namespacedomain;
+
+allow_common_ns_perms(test_mntns_parent_t)
+allow test_mntns_parent_t test_mntns_t:mnt_namespace { setns };
+allow test_mntns_parent_t test_mntns_deny_create_t:mnt_namespace { setns };
+
+###################### Parent for net namespace #####################
+type test_netns_parent_t;
+testsuite_domain_type(test_netns_parent_t)
+typeattribute test_netns_parent_t namespacedomain;
+
+allow_common_ns_perms(test_netns_parent_t)
+allow test_netns_parent_t test_netns_t:net_namespace { setns };
+allow test_netns_parent_t test_netns_deny_create_t:net_namespace { setns };
+
+###################### Parent for pid namespace #####################
+type test_pidns_parent_t;
+testsuite_domain_type(test_pidns_parent_t)
+typeattribute test_pidns_parent_t namespacedomain;
+
+allow_common_ns_perms(test_pidns_parent_t)
+allow test_pidns_parent_t test_pidns_t:pid_namespace { setns };
+allow test_pidns_parent_t test_pidns_deny_create_t:pid_namespace { setns };
+
+###################### Parent for time namespace #####################
+type test_timens_parent_t;
+testsuite_domain_type(test_timens_parent_t)
+typeattribute test_timens_parent_t namespacedomain;
+
+allow_common_ns_perms(test_timens_parent_t)
+allow test_timens_parent_t test_timens_t:time_namespace { setns };
+allow test_timens_parent_t test_timens_deny_create_t:time_namespace { setns };
+
+###################### Parent for user namespace #####################
+type test_userns_parent_t;
+testsuite_domain_type(test_userns_parent_t)
+typeattribute test_userns_parent_t namespacedomain;
+
+allow_common_ns_perms(test_userns_parent_t)
+allow test_userns_parent_t test_userns_t:user_namespace { setns };
+allow test_userns_parent_t test_userns_deny_create_t:user_namespace { setns };
+
+###################### Parent for uts namespace #####################
+type test_utsns_parent_t;
+testsuite_domain_type(test_utsns_parent_t)
+typeattribute test_utsns_parent_t namespacedomain;
+
+allow_common_ns_perms(test_utsns_parent_t)
+allow test_utsns_parent_t test_utsns_t:uts_namespace { setns };
+allow test_utsns_parent_t test_utsns_deny_create_t:uts_namespace { setns };
diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index c09b577..6e601b3 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -36,6 +36,7 @@ files_type(test_overlay_files_noaccess_t)
 allow test_overlay_mounter_t self:dir list_dir_perms;
 allow test_overlay_mounter_t self:file read_file_perms;
 allow test_overlay_mounter_t self:capability { sys_admin dac_override dac_read_search };
+allow_mntns_create_anon(test_overlay_mounter_t)
 
 kernel_read_system_state(test_overlay_mounter_t)
 kernel_read_proc_symlinks(test_overlay_mounter_t)
diff --git a/tests/Makefile b/tests/Makefile
index 4fe6f3c..f05ed15 100644
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
index 0000000..f20ccff
--- /dev/null
+++ b/tests/namespace/.gitignore
@@ -0,0 +1,3 @@
+setns_test
+ns_create_test
+ns_create_anon_test
diff --git a/tests/namespace/Makefile b/tests/namespace/Makefile
new file mode 100644
index 0000000..7b0d217
--- /dev/null
+++ b/tests/namespace/Makefile
@@ -0,0 +1,7 @@
+TARGETS = setns_test ns_create_test ns_create_anon_test
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/namespace/ns_create_anon_test.c b/tests/namespace/ns_create_anon_test.c
new file mode 100644
index 0000000..b8b5747
--- /dev/null
+++ b/tests/namespace/ns_create_anon_test.c
@@ -0,0 +1,64 @@
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
+#include <linux/mount.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"Usage: %s [-v]\n"
+		"Where:\n\t"
+		"-v Print information.\n", progname);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, fs_fd, mnt_fd, ret = 0;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (verbose)
+		printf("Attempting to create new anon mnt namespace during fsmount...\n");
+
+	fs_fd = syscall(__NR_fsopen, "tmpfs", 0);
+	if (fs_fd < 0) {
+		perror("fsopen");
+		ret = fs_fd;
+		goto out;
+	}
+
+	ret = syscall(__NR_fsconfig, fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (ret < 0) {
+		perror("fsconfig");
+		goto out;
+	}
+
+	ret = 0;
+	mnt_fd = syscall(__NR_fsmount, fs_fd, 0, 0);
+	if (mnt_fd < 0)
+		ret = mnt_fd;
+
+out:
+	close(fs_fd);
+	close(mnt_fd);
+	return ret;
+}
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
index 0000000..4002f5e
--- /dev/null
+++ b/tests/namespace/setns_test.c
@@ -0,0 +1,354 @@
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
+
+	return 0;
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
index 0000000..2b56bc3
--- /dev/null
+++ b/tests/namespace/test
@@ -0,0 +1,185 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $test_count = 34;
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
+# Allow create permission for cgroup namespace
+$result = system "runcon -t test_cgroupns_t $basedir/ns_create_test -c $v";
+ok( $result eq 0 );
+
+# Deny create permission for cgroup namespace
+$result =
+  system "runcon -t test_cgroupns_deny_create_t $basedir/ns_create_test -c $v";
+ok($result);
+
+# Allow create permission for ipc namespace
+$result = system "runcon -t test_ipcns_t $basedir/ns_create_test -i $v";
+ok( $result eq 0 );
+
+# Deny create permission for ipc namespace
+$result =
+  system "runcon -t test_ipcns_deny_create_t $basedir/ns_create_test -i $v";
+ok($result);
+
+# Allow create permission for mount namespace
+$result = system "runcon -t test_mntns_t $basedir/ns_create_test -m $v";
+ok( $result eq 0 );
+
+# Deny create permission for mount namespace
+$result =
+  system "runcon -t test_mntns_deny_create_t $basedir/ns_create_test -m $v";
+ok($result);
+
+# Allow create permission for net namespace
+$result = system "runcon -t test_netns_t $basedir/ns_create_test -n $v";
+ok( $result eq 0 );
+
+# Deny create permission for net namespace
+$result =
+  system "runcon -t test_netns_deny_create_t $basedir/ns_create_test -n $v";
+ok($result);
+
+# Allow create permission for pid namespace
+$result = system "runcon -t test_pidns_t $basedir/ns_create_test -p $v";
+ok( $result eq 0 );
+
+# Deny create permission for pid namespace
+$result =
+  system "runcon -t test_pidns_deny_create_t $basedir/ns_create_test -p $v";
+ok($result);
+
+# Allow create permission for time namespace
+$result = system "runcon -t test_timens_t $basedir/ns_create_test -t $v";
+ok( $result eq 0 );
+
+# Deny create permission for time namespace
+$result =
+  system "runcon -t test_timens_deny_create_t $basedir/ns_create_test -t $v";
+ok($result);
+
+# Allow create permission for user namespace
+$result = system "runcon -t test_userns_t $basedir/ns_create_test -u $v";
+ok( $result eq 0 );
+
+# Deny create permission for user namespace
+$result =
+  system "runcon -t test_userns_deny_create_t $basedir/ns_create_test -u $v";
+ok($result);
+
+# Allow create permission for uts namespace
+$result = system "runcon -t test_utsns_t $basedir/ns_create_test -s $v";
+ok( $result eq 0 );
+
+# Deny create permission for uts namespace
+$result =
+  system "runcon -t test_utsns_deny_create_t $basedir/ns_create_test -s $v";
+ok($result);
+
+# Allow create_anon permission for mount namespace
+$result = system "runcon -t test_mntns_t $basedir/ns_create_anon_test $v";
+ok( $result eq 0 );
+
+# Deny create_anon permission for mount namespace
+$result = system
+  "runcon -t test_mntns_deny_create_anon_t $basedir/ns_create_anon_test $v";
+ok($result);
+
+# Allow setns permission for cgroup namespace
+$result = system
+  "runcon -t test_cgroupns_t $basedir/setns_test -c $v test_cgroupns_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for cgroup namespace
+$result = system
+"runcon -t test_cgroupns_deny_setns_t $basedir/setns_test -c $v test_cgroupns_parent_t";
+ok($result);
+
+# Allow setns permission for ipc namespace
+$result =
+  system "runcon -t test_ipcns_t $basedir/setns_test -i $v test_ipcns_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for ipc namespace
+$result = system
+"runcon -t test_ipcns_deny_setns_t $basedir/setns_test -i $v test_ipcns_parent_t";
+ok($result);
+
+# Allow setns permission for mount namespace
+$result =
+  system "runcon -t test_mntns_t $basedir/setns_test -m $v test_mntns_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for mount namespace
+$result = system
+"runcon -t test_mntns_deny_setns_t $basedir/setns_test -m $v test_mntns_parent_t";
+ok($result);
+
+# Allow setns permission for net namespace
+$result =
+  system "runcon -t test_netns_t $basedir/setns_test -n $v test_netns_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for net namespace
+$result = system
+"runcon -t test_netns_deny_setns_t $basedir/setns_test -n $v test_netns_parent_t";
+ok($result);
+
+# Allow setns permission for pid namespace
+$result =
+  system "runcon -t test_pidns_t $basedir/setns_test -p $v test_pidns_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for pid namespace
+$result = system
+"runcon -t test_pidns_deny_setns_t $basedir/setns_test -p $v test_pidns_parent_t";
+ok($result);
+
+# Allow setns permission for time namespace
+$result = system
+  "runcon -t test_timens_t $basedir/setns_test -t $v test_timens_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for time namespace
+$result = system
+"runcon -t test_timens_deny_setns_t $basedir/setns_test -t $v test_timens_parent_t";
+ok($result);
+
+# Allow setns permission for user namespace
+$result = system
+  "runcon -t test_userns_t $basedir/setns_test -u $v test_userns_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for user namespace
+$result = system
+"runcon -t test_userns_deny_setns_t $basedir/setns_test -u $v test_userns_parent_t";
+ok($result);
+
+# Allow setns permission for uts namespace
+$result =
+  system "runcon -t test_utsns_t $basedir/setns_test -s $v test_utsns_parent_t";
+ok( $result eq 0 );
+
+# Deny setns permission for uts namespace
+$result = system
+"runcon -t test_utsns_deny_setns_t $basedir/setns_test -s $v test_utsns_parent_t";
+ok($result);
+
+exit;
-- 
2.53.0

