Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0699BEB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 12:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGQM2y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGQM2x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 08:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C29B9
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689596885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pBftSAXjGiFOiptLfvmCNbotenEMztHP5WDy4/Za+yI=;
        b=gX5BqY8aauNvf58NwD207dqVrJ3svwyGkaEMph0MMLq7rMUXtuQfW92Q/qWOtQozXixqcy
        oNLT/DPaJ2eEmDFgd7/w12ut0QXfJQPsetAvSFpunNbYYh9m3em5cqDOTnNAbIK6cbEHOF
        laP/DaSmCO79JSYYFUh7OEuI0yYxATE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-5FW9wvToNhyQNH9cGV_vvw-1; Mon, 17 Jul 2023 08:28:04 -0400
X-MC-Unique: 5FW9wvToNhyQNH9cGV_vvw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso258129866b.3
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689596883; x=1692188883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBftSAXjGiFOiptLfvmCNbotenEMztHP5WDy4/Za+yI=;
        b=Nciz6Zu7p5pTxBSfUonowZpBIFzK0TZZLzQ56l4c3W+iy/mHM2r54RkxtRfi3o1JlY
         EsU7B38g3L7RvYv7+/rIB3bJ9UrqA2oqE+8feGbuvDw3AYgL0kJ8D2wqK3R1PFVUzA1n
         DXu/miHUkFRvMKYn/Lr2/I+aoREXgbDHCmdicXgVVe4fICXqi5fwF0CRBnnXJllakylY
         3ea6ODHbUOrLBmIuNo+HqcfgnsR5kTqL+2ytZhpBqEcDW8kfuPPctlf4LOAy7Q8qeUl8
         1OlVx6AQN7Xn8GiL8fnzCKuFQJvncuBSWeaHKOz9XwwHLxmJZkUA+X15vAUzQLTQcsLN
         W6EA==
X-Gm-Message-State: ABy/qLbE1Z/gXyZm7/kVgDtNjCk1MIFAsEbh3AooWcxibpEZjCl9RCL2
        7LNUo4+rit4dWDkJrbcW3J6c/OCbZXkoPPj6iWd0r2sg2nnLERK+rj16ZuN8yHFqu5aADlBuxXl
        AmxYnSy6S+vG8lIoMRBTwT/l95dFIiBINkOYPp8hOuznT6Dab5q4o8HBHl3Jab8JnlumZ+3ghJU
        l0LsRK
X-Received: by 2002:a17:906:20dd:b0:993:f11a:fe42 with SMTP id c29-20020a17090620dd00b00993f11afe42mr10637201ejc.6.1689596882832;
        Mon, 17 Jul 2023 05:28:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHvbYT7neufHb5cBMxVFi9yJeLIzvcFkDdruP8ItpXvisg59LOWVtNqOCAoa7mDVN43NwQvcQ==
X-Received: by 2002:a17:906:20dd:b0:993:f11a:fe42 with SMTP id c29-20020a17090620dd00b00993f11afe42mr10637182ejc.6.1689596882328;
        Mon, 17 Jul 2023 05:28:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id sd16-20020a170906ce3000b00997d76981e0sm135434ejb.208.2023.07.17.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:28:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] policy: allow all test domains to search user/admin home directories
Date:   Mon, 17 Jul 2023 14:28:00 +0200
Message-ID: <20230717122800.619345-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The permissions are sometimes needed to resolve paths when running the
testsuite from a user/admin home directory. To avoid cluttering
individual policy files with macros that allow it, apply the macros to
the whole testsuite_domain attribute. Thankfully this doesn't break the
other tests.

This also fixes the inet_socket test, which started to require these
permissions after a recent change.

While there, also remove userdom_read_user_tmp_files() from
test_overlay_mounter_t, which doesn't seem to be needed.

Fixes: 4dcea27ada77 ("tests/inet_socket: cover the MPTCP protocol")
Inspired-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_filesystem.te        | 1 -
 policy/test_filesystem_notify.te | 1 -
 policy/test_global.te            | 7 +++++++
 policy/test_ipc.te               | 2 --
 policy/test_overlayfs.te         | 7 -------
 policy/test_policy.if            | 7 -------
 policy/test_ptrace.te            | 1 -
 7 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 59eac2b..efe1f4d 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -366,7 +366,6 @@ allow test_filesystem_inode_setxattr_no_associate_t test_file_t:file { create re
 #
 ############### Rules for NFS mount ##################
 #
-userdom_search_user_home_content(filesystemdomain)
 allow test_filesystem_t test_filesystem_file_t:filesystem { getattr mount remount unmount relabelto relabelfrom };
 allow test_filesystem_t test_file_t:file { create write relabelfrom };
 allow test_file_t test_filesystem_file_t:filesystem { associate };
diff --git a/policy/test_filesystem_notify.te b/policy/test_filesystem_notify.te
index 30056e4..77d46ae 100644
--- a/policy/test_filesystem_notify.te
+++ b/policy/test_filesystem_notify.te
@@ -16,7 +16,6 @@ allow test_filesystem_t dosfs_t:filesystem { watch };
 #
 ############### Rules for NFS mount with rootcontext option #################
 #
-userdom_search_user_home_content(filesystemdomain)
 allow test_filesystem_no_watch_mount_t nfs_t:filesystem { unmount };
 allow test_filesystem_no_watch_mount_t test_filesystem_file_t:dir { search };
 allow test_filesystem_no_watch_sb_t nfs_t:filesystem { unmount watch };
diff --git a/policy/test_global.te b/policy/test_global.te
index 052c7dd..0078485 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -153,6 +153,13 @@ selinux_compute_create_context(testsuite_domain)
 selinux_compute_relabel_context(testsuite_domain)
 selinux_compute_user_contexts(testsuite_domain)
 
+userdom_search_user_home_content(testsuite_domain)
+# Refpolicy does not have admin_home_t - assume /root will be user_home_dir_t,
+# which is covered by the above call.
+ifdef(`userdom_search_admin_dir', `
+    userdom_search_admin_dir(testsuite_domain)
+')
+
 # Reference policy renamed files_list_pids() to files_list_runtime()
 ifdef(`files_list_pids', `
     files_list_pids(testsuite_domain)
diff --git a/policy/test_ipc.te b/policy/test_ipc.te
index 678eca8..5e26384 100644
--- a/policy/test_ipc.te
+++ b/policy/test_ipc.te
@@ -67,5 +67,3 @@ fs_rw_tmpfs_files(ipcdomain)
 
 allow test_ipc_base_t self:sem create_sem_perms;
 allow test_ipc_base_t self:shm create_shm_perms;
-# ipcrm needs this... 
-userdom_search_user_home_dirs(test_ipc_base_t)
diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index ab589bb..c09b577 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -45,10 +45,6 @@ kernel_search_proc(test_overlay_mounter_t)
 fs_relabelfrom_xattr_fs(test_overlay_mounter_t)
 fs_mount_xattr_fs(test_overlay_mounter_t)
 
-userdom_search_admin_dir(test_overlay_mounter_t)
-userdom_search_user_home_content(test_overlay_mounter_t)
-userdom_read_user_tmp_files(test_overlay_mounter_t)
-
 mount_exec(test_overlay_mounter_t)
 mount_rw_pid_files(test_overlay_mounter_t)
 
@@ -113,9 +109,6 @@ mcs_constrained(test_overlay_client_t)
 kernel_read_system_state(test_overlay_client_t)
 kernel_read_proc_symlinks(test_overlay_client_t)
 
-userdom_search_admin_dir(test_overlay_client_t)
-userdom_search_user_home_content(test_overlay_client_t)
-
 fs_getattr_xattr_fs(test_overlay_client_t)
 
 selinux_getattr_fs(test_overlay_client_t)
diff --git a/policy/test_policy.if b/policy/test_policy.if
index 5458f6c..b20baad 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -82,13 +82,6 @@ interface(`mount_rw_pid_files', `
 ')
 ')
 
-# Refpolicy does not have admin_home_t - assume /root will be user_home_dir_t.
-ifdef(`userdom_search_admin_dir', `', ` dnl
-interface(`userdom_search_admin_dir', `
-    userdom_search_user_home_content($1)
-')
-')
-
 # If the macro is not defined, then most probably module_request permission
 # is just not supported (and relevant operations should be just allowed).
 ifdef(`kernel_request_load_module', `', ` dnl
diff --git a/policy/test_ptrace.te b/policy/test_ptrace.te
index 352ead5..1a8a10d 100644
--- a/policy/test_ptrace.te
+++ b/policy/test_ptrace.te
@@ -27,7 +27,6 @@ allow test_ptrace_traced_t test_file_t:fifo_file rw_file_perms;
 
 # Allow the tracer domain to trace the traced domain.
 allow test_ptrace_tracer_t test_ptrace_traced_t:process ptrace;
-userdom_search_user_home_dirs(test_ptrace_traced_t)
 
 # Let the tracer wait on the traced domain.
 allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
-- 
2.41.0

