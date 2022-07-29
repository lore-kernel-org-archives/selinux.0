Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B85C19F2B
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiG2MCk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiG2MCj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A9FA863E0
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yveJT0tpQZ19/jLYDYFneYNa4KX6w1Wf9xDb9Wqao6c=;
        b=TcUdlsD93t1xx1LhHa71vhRpAWKfaG4JYnXtBB54UzUhBZEqvw+D7ok/blv5zDP7O+CPO4
        lC0wd5cWXw1GAUXPruQH+ZyjHh5v6XOsTJd9V1ccTojvicbfv0h3GzexPBY1gHsiv6XKfQ
        zsxyJzImLkkYb4bAx3ujvoNvib2wiWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-c8sqc-OlNrS4q3vsAonfZQ-1; Fri, 29 Jul 2022 08:02:35 -0400
X-MC-Unique: c8sqc-OlNrS4q3vsAonfZQ-1
Received: by mail-wm1-f72.google.com with SMTP id v11-20020a1cf70b000000b003a318238826so796042wmh.2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=yveJT0tpQZ19/jLYDYFneYNa4KX6w1Wf9xDb9Wqao6c=;
        b=aju/xOnVEzH7Y7IDQjEIo+qOVKLoBTG6YKgWQcouKkFn+j75MgW4FIFlnZhXRs5GqV
         G9J35J19gTgLK/rFxiony576EIOmv0vAu0pmzRG3s2JeO9ipDjkkyVqKm5txs2u9ncZt
         R3/OAKiHFUXLT26GBKu+mHOHssfwB/GwpwJ+KnB4zd0/CGJlcfXVpUHa6TSHyE2Nh6BZ
         SY/4gs8OzAPdaHm61c7DNk4akAvBnM29Uu7YVSUfGY0dyUDOBgepQzKs92y8KDrSKDEk
         4JKEK4/6Z6Xxcnj19kQGh1eBGvxqgK1pkb9yjHEGwW9bz9SCQd38xOz84lz7ALr66BaG
         WZzA==
X-Gm-Message-State: AJIora9uaYhpp4wQV/XUGfQ8SCymMHFQda5J0EYnUninNaD1SNWIQRUq
        TYle2mjDz1D4KV6aVeiXcGOCcuEVnLTNTtat8HsbzHzLFDCmEm5eaGJ0JRCGFlIidHYwEng9YI+
        lQ9t9hbVnOFSYYEJZId/Ot/+6TFkmLZy+MKB6k8FBrJnuBk2AHL78Y8uE6/dw+N4htPY0SA==
X-Received: by 2002:a05:600c:3c8a:b0:3a0:4ad8:d3c4 with SMTP id bg10-20020a05600c3c8a00b003a04ad8d3c4mr2707591wmb.43.1659096153752;
        Fri, 29 Jul 2022 05:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sxxw0t9pEDpNBXqgkCEd761wH0v7o7RhuP0q7/bmf+kafDxLI0+0xPEiPjvvFwxJ3uLGilpg==
X-Received: by 2002:a05:600c:3c8a:b0:3a0:4ad8:d3c4 with SMTP id bg10-20020a05600c3c8a00b003a04ad8d3c4mr2707565wmb.43.1659096153300;
        Fri, 29 Jul 2022 05:02:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:32 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 00/24] Clean up testsuite policy and support running as sysadm_t
Date:   Fri, 29 Jul 2022 14:02:05 +0200
Message-Id: <20220729120229.207584-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series aim for two things:
1. Refactor the policy so that it is easier to work with.
2. Leverage the refactoring to fully support running the testsuite
   as sysadm_u:sysadm_r:sysadm_t.

The gist of this work lies in unifying how test domains are defined,
deduplicating the various boilerplate spread out all across the
individual files (and not even used consistently), and in abstracting
the policy caller domain/role away from the individual test policies
into test_general.te. Some tests also had to be massaged to not
hard-code unconfined_* and be generic against the context of the
testsuite caller.

The series also extends the CI to test running the testsuite as sysadm_*
and also verify that no unconfined_t/sysadm_t unexpected denials are
produced (which would usually indicate a missing dontaudit rule in the
testsuite policy).

Ondrej Mosnacek (24):
  keys: change test_newcon_key_t to be just an object context
  test_global.te: remove unused role require
  test_global.te: don't add domains to system_r
  policy: refactor declaring test domains
  policy: get rid of unconfined_runs_test()
  test_policy.if: remove weird rule from testsuite_domain_type_minimal()
  policy: move unconfined_t-related dontaudit rule to where it fits
    better
  policy: move userdom_sysadm_entry_spec_domtrans_to() to general policy
  policy: move miscfiles_domain_entry_test_files() to general policy
  policy: substitute userdom_sysadm_entry_spec_domtrans_to()
  test_general.te: move sysadm-related rules into an optional block
  test_filesystem.te: remove redundant dontaudit rules
  test_filesystem.te: remove suspicious rules
  tests/nnp_nosuid: avoid hardcoding unconfined_t in the policy
  tests/*filesystem: remove weird uses of unconfined_t
  policy: remove last hardcoded references to unconfined_t
  test_general.te: generalize the dontaudit rule
  policy: don't audit testsuite programs searching the caller's keys
  ci: check for unconfined_t AVCs
  tests/binder: check only the type part of the context
  tests/overlay: don't hard-code SELinux user of the caller
  policy: give sysadm_t perms needed to run quotacheck(8)
  tests/vsock_socket: use modprobe to check vsock availability
  ci: add sysadm_t to the test matrix

 .github/workflows/checks.yml         |   4 +
 Vagrantfile                          |  16 +++
 policy/test_atsecure.te              |  15 +--
 policy/test_attrib.te                |   1 -
 policy/test_binder.te                |  38 ++-----
 policy/test_binder_bpf.te            |  22 +---
 policy/test_bounds.te                |  11 +-
 policy/test_bpf.te                   |  30 +----
 policy/test_cap_userns.te            |   9 +-
 policy/test_capable_file.te          |  18 +--
 policy/test_capable_net.te           |   8 +-
 policy/test_capable_sys.te           |   8 +-
 policy/test_dyntrace.te              |  14 +--
 policy/test_dyntrans.te              |  17 +--
 policy/test_entrypoint.te            |   5 +-
 policy/test_execshare.te             |  16 +--
 policy/test_exectrace.te             |  16 +--
 policy/test_execute_no_trans.te      |   5 +-
 policy/test_extended_socket_class.te |  12 +-
 policy/test_fdreceive.te             |  16 +--
 policy/test_fdreceive_bpf.te         |  16 +--
 policy/test_file.te                  |  16 +--
 policy/test_filesystem.te            |  99 ++++-------------
 policy/test_filesystem_name_trans.te |   4 +-
 policy/test_filesystem_notify.te     |  12 +-
 policy/test_global.te                | 157 ++++++++++++++++++---------
 policy/test_ibendport.te             |   8 +-
 policy/test_ibpkey.te                |   8 +-
 policy/test_inet_socket.te           |  44 ++------
 policy/test_inherit.te               |  20 +---
 policy/test_ioctl.te                 |  10 +-
 policy/test_ioctl_xperms.te          |   8 +-
 policy/test_ipc.te                   |  18 +--
 policy/test_key_socket.te            |  26 +----
 policy/test_keys.te                  | 104 ++++--------------
 policy/test_link.te                  |  24 +---
 policy/test_mac_admin.te             |   9 +-
 policy/test_mkdir.te                 |  20 +---
 policy/test_mmap.te                  |  79 ++++----------
 policy/test_module_load.te           |  47 ++------
 policy/test_mqueue.te                |  16 +--
 policy/test_netlink_socket.te        |  12 +-
 policy/test_nnp_nosuid.te            |  46 ++++----
 policy/test_notify.te                |  35 ++----
 policy/test_open.te                  |  16 +--
 policy/test_overlayfs.te             |  15 +--
 policy/test_perf_event.te            |  38 ++-----
 policy/test_policy.if                |  71 ++++++------
 policy/test_prlimit.te               |  20 +---
 policy/test_ptrace.te                |  17 +--
 policy/test_readlink.te              |   8 +-
 policy/test_relabel.te               |  12 +-
 policy/test_rename.te                |  32 ++----
 policy/test_rxdir.te                 |   8 +-
 policy/test_sctp.te                  |  52 ++-------
 policy/test_setattr.te               |   8 +-
 policy/test_setnice.te               |  13 +--
 policy/test_sigkill.te               |  22 +---
 policy/test_stat.te                  |   8 +-
 policy/test_sysctl.te                |   8 +-
 policy/test_task_create.te           |  38 +------
 policy/test_task_getpgid.te          |  16 +--
 policy/test_task_getsched.te         |  16 +--
 policy/test_task_getsid.te           |  16 +--
 policy/test_task_setpgid.te          |  34 +-----
 policy/test_task_setsched.te         |  16 +--
 policy/test_transition.te            |  15 +--
 policy/test_tun_tap.te               |  34 ++----
 policy/test_unix_socket.te           |  20 +---
 policy/test_userfaultfd.te           |   8 +-
 policy/test_vsock_socket.te          |  12 +-
 policy/test_watchkey.te              |  14 +--
 tests/binder/binder_common.h         |   1 +
 tests/binder/service_provider.c      |  31 ++++--
 tests/binder/test                    |   2 +-
 tests/filesystem/test                |   4 +-
 tests/fs_filesystem/test             |   4 +-
 tests/keys/test                      |   2 +-
 tests/nfs_filesystem/test            |   4 +-
 tests/nnp_nosuid/test                |  45 +++++---
 tests/overlay/setup-overlay          |   2 +-
 tests/overlay/test                   |  34 +++---
 tests/vsock_socket/.gitignore        |   1 -
 tests/vsock_socket/Makefile          |   2 +-
 tests/vsock_socket/check_vsock.c     |  47 --------
 tests/vsock_socket/test              |  11 +-
 86 files changed, 550 insertions(+), 1346 deletions(-)
 delete mode 100644 tests/vsock_socket/check_vsock.c

-- 
2.37.1

