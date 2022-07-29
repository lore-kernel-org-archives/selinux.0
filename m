Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593BC19F2B
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiG2MCy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiG2MCx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D79A7863E0
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNOT6iq1zNt3X66GT+gYQ98w9CMnfrHbff5MoR0393g=;
        b=IaYoOe9vfl7sQfGHzj2GgTBnxh/lBBTjt4l01t3gdtXQsL4Wx79AFCs90CPQrGw1UnsG4z
        STAbi2+J+nezDCJakwa+1VEqKQPZiK6G+e2epp799O4qdQ6bEtRQELdIOXIS8bR7uEoHO/
        sZJrlOgpP5J+nxo+TlOTnHHY81sSSQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-9p3Nqt-LMbOhGhTcSfPS_g-1; Fri, 29 Jul 2022 08:02:49 -0400
X-MC-Unique: 9p3Nqt-LMbOhGhTcSfPS_g-1
Received: by mail-wr1-f71.google.com with SMTP id e3-20020adf9bc3000000b0021e50518071so1126763wrc.2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=zNOT6iq1zNt3X66GT+gYQ98w9CMnfrHbff5MoR0393g=;
        b=hGBvKeKe1BBkn3bXjav5JvAZLMWAQWeLgCRRRIGp3r4cWyTQIUPQnaUmv51FPuxE5V
         MBlG+25MFsNWF3IAzQaUQswzU50FVjWlP+9NCn3S41YTZD8ghz1z1vRPQ3HyWNq3sRAm
         hgfeIIK6emASnLvmaO0Xb1RxcYfQLSWkLOw1meU99KuIGqrTixEJKt4V4V+/4qecXmSw
         NH5iPsm/8eBYMbWGTr+XkzhzVOO48KuBXsxUv4/16M1wcX9MBrt5mwnV7RTeEWvNp9QT
         5y9nEleTkdFywv6kdbV0nrchoUrTF3eXJD52P3Iv9KxBWM/jmJBxc/ErDC2sqYu+VIrH
         fTyw==
X-Gm-Message-State: ACgBeo1N/yu2FvGrgpR/oqhT6av6674KbC3Z3a5GVvyyEYFg+MjYM0c9
        nTk/xPVp3RiqWtxCHwfFQFWZEfv3pbkbFuIHAIUe4hkPj34yGqxMXcwmMpIm+Mn867eqiZpFhz4
        tbg7bQjTL6nX9LuzChnxxOH/Xy7Ao8yNm14+fVNo8DCCimu9a2ABsazLbITyLmyd8TSX7dQ==
X-Received: by 2002:a05:6000:3cc:b0:21e:7f8a:3925 with SMTP id b12-20020a05600003cc00b0021e7f8a3925mr2295983wrg.570.1659096167304;
        Fri, 29 Jul 2022 05:02:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR70OLKCU1npfYGbp2+hp9SFhSzcI7uXpJEgH3p0x4nbBjdu1hPSvC9P8B3c52/4CmxukYktcw==
X-Received: by 2002:a05:6000:3cc:b0:21e:7f8a:3925 with SMTP id b12-20020a05600003cc00b0021e7f8a3925mr2295947wrg.570.1659096166611;
        Fri, 29 Jul 2022 05:02:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:45 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 09/24] policy: move miscfiles_domain_entry_test_files() to general policy
Date:   Fri, 29 Jul 2022 14:02:14 +0200
Message-Id: <20220729120229.207584-10-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is good to have for pretty much all domains, so remove the
individual calls and move it to test_general.te.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_binder.te                | 5 -----
 policy/test_binder_bpf.te            | 5 -----
 policy/test_bounds.te                | 1 -
 policy/test_bpf.te                   | 5 -----
 policy/test_cap_userns.te            | 1 -
 policy/test_capable_file.te          | 1 -
 policy/test_dyntrace.te              | 1 -
 policy/test_dyntrans.te              | 4 ----
 policy/test_execshare.te             | 3 ---
 policy/test_exectrace.te             | 3 ---
 policy/test_extended_socket_class.te | 3 ---
 policy/test_fdreceive.te             | 3 ---
 policy/test_fdreceive_bpf.te         | 3 ---
 policy/test_file.te                  | 3 ---
 policy/test_filesystem.te            | 5 -----
 policy/test_global.te                | 4 +++-
 policy/test_ibendport.te             | 3 ---
 policy/test_ibpkey.te                | 3 ---
 policy/test_inet_socket.te           | 3 ---
 policy/test_inherit.te               | 3 ---
 policy/test_ioctl.te                 | 1 -
 policy/test_ipc.te                   | 1 -
 policy/test_key_socket.te            | 5 -----
 policy/test_keys.te                  | 5 -----
 policy/test_mmap.te                  | 3 ---
 policy/test_module_load.te           | 5 -----
 policy/test_mqueue.te                | 3 ---
 policy/test_netlink_socket.te        | 3 ---
 policy/test_notify.te                | 2 --
 policy/test_open.te                  | 3 ---
 policy/test_perf_event.te            | 5 -----
 policy/test_prlimit.te               | 7 -------
 policy/test_ptrace.te                | 4 ----
 policy/test_sctp.te                  | 5 -----
 policy/test_setnice.te               | 1 -
 policy/test_sigkill.te               | 1 -
 policy/test_task_create.te           | 5 -----
 policy/test_task_getpgid.te          | 3 ---
 policy/test_task_getsched.te         | 3 ---
 policy/test_task_getsid.te           | 3 ---
 policy/test_task_setpgid.te          | 3 ---
 policy/test_task_setsched.te         | 3 ---
 policy/test_tun_tap.te               | 5 -----
 policy/test_unix_socket.te           | 3 ---
 policy/test_userfaultfd.te           | 3 ---
 policy/test_vsock_socket.te          | 3 ---
 policy/test_watchkey.te              | 5 -----
 47 files changed, 3 insertions(+), 152 deletions(-)

diff --git a/policy/test_binder.te b/policy/test_binder.te
index 096c467..4c7974a 100644
--- a/policy/test_binder.te
+++ b/policy/test_binder.te
@@ -94,8 +94,3 @@ allow test_binder_client_no_transfer_t test_binder_mgr_t:binder { call };
 allow test_binder_client_no_transfer_t test_binder_provider_t:binder { call impersonate };
 allow test_binder_client_no_transfer_t device_t:chr_file { getattr ioctl open read write };
 allow_map(test_binder_client_no_transfer_t, device_t, chr_file)
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(binderdomain)
diff --git a/policy/test_binder_bpf.te b/policy/test_binder_bpf.te
index 2d91af2..fa79320 100644
--- a/policy/test_binder_bpf.te
+++ b/policy/test_binder_bpf.te
@@ -57,8 +57,3 @@ allow test_binder_client_no_bpf_perm_t test_binder_bpf_mgr_t:binder { call };
 allow test_binder_client_no_bpf_perm_t test_binder_bpf_provider_t:fd { use };
 allow test_binder_client_no_bpf_perm_t device_t:chr_file { getattr ioctl open read write };
 allow_map(test_binder_client_no_bpf_perm_t, device_t, chr_file)
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(binderbpfdomain)
diff --git a/policy/test_bounds.te b/policy/test_bounds.te
index 60fbd0b..d132d8a 100644
--- a/policy/test_bounds.te
+++ b/policy/test_bounds.te
@@ -63,5 +63,4 @@ allow test_bounds_child_domain test_bounds_file_green_t : file { getattr setattr
 allow test_bounds_child_domain test_bounds_file_blue_t : file { getattr setattr };
 
 # Allow all of these domains to be entered from sysadm domain
-miscfiles_domain_entry_test_files(test_bounds_domain)
 sysadm_entry_spec_domtrans(test_bounds_domain)
diff --git a/policy/test_bpf.te b/policy/test_bpf.te
index fb21c29..5eab0bd 100644
--- a/policy/test_bpf.te
+++ b/policy/test_bpf.te
@@ -57,8 +57,3 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
 allow test_bpf_deny_prog_run_t self:process { setrlimit };
 allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
-
-#
-############ Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(bpfdomain)
diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index fa90528..cfa510c 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -19,7 +19,6 @@ testsuite_domain_type(test_no_cap_userns_t)
 typeattribute test_no_cap_userns_t capusernsdomain;
 
 # Rules common to both domains.
-miscfiles_domain_entry_test_files(capusernsdomain)
 corecmd_exec_bin(capusernsdomain)
 
 # linux >= v5.12 needs setfcap to map UID 0
diff --git a/policy/test_capable_file.te b/policy/test_capable_file.te
index 9ce9487..2383f6e 100644
--- a/policy/test_capable_file.te
+++ b/policy/test_capable_file.te
@@ -39,7 +39,6 @@ libs_exec_ld_so(capabledomain)
 libs_exec_lib_files(capabledomain)
 
 # Allow test_file_t and bin_t to be entered from sysadm role
-miscfiles_domain_entry_test_files(capabledomain)
 corecmd_bin_entry_type(capabledomain)
 sysadm_bin_spec_domtrans_to(capabledomain)
 
diff --git a/policy/test_dyntrace.te b/policy/test_dyntrace.te
index 0a598a4..09f983a 100644
--- a/policy/test_dyntrace.te
+++ b/policy/test_dyntrace.te
@@ -25,7 +25,6 @@ testsuite_domain_type(test_dyntrace_notchild_t)
 typeattribute test_dyntrace_notchild_t dyntracedomain;
 
 # Allow test_files_t to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(dyntracedomain)
 miscfiles_exec_test_files(dyntracedomain)
 
 # Grant the necessary permissions for the child domain.
diff --git a/policy/test_dyntrans.te b/policy/test_dyntrans.te
index e4110c5..73fe77d 100644
--- a/policy/test_dyntrans.te
+++ b/policy/test_dyntrans.te
@@ -23,7 +23,3 @@ typeattribute test_dyntrans_todomain_t dyntransdomain;
 
 # Allow the fromdomain to dyntrans to the new domain.
 allow test_dyntrans_fromdomain_t test_dyntrans_todomain_t:process dyntransition;
-
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(dyntransdomain)
-
diff --git a/policy/test_execshare.te b/policy/test_execshare.te
index 22ed09f..c127662 100644
--- a/policy/test_execshare.te
+++ b/policy/test_execshare.te
@@ -20,9 +20,6 @@ type test_execshare_notchild_t;
 testsuite_domain_type(test_execshare_notchild_t);
 typeattribute test_execshare_notchild_t execsharedomain;
 
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(execsharedomain)
-
 # Grant the necessary permissions for the child domain.
 domain_entry_file_spec_domtrans(test_execshare_parent_t, test_execshare_child_t)
 allow test_execshare_parent_t test_execshare_child_t:fd use;
diff --git a/policy/test_exectrace.te b/policy/test_exectrace.te
index 302ba80..d5b74ad 100644
--- a/policy/test_exectrace.te
+++ b/policy/test_exectrace.te
@@ -23,9 +23,6 @@ type test_exectrace_notchild_t;
 testsuite_domain_type(test_exectrace_notchild_t)
 typeattribute test_exectrace_notchild_t exectracedomain;
 
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(exectracedomain)
-
 # Grant the necessary permissions for the child domain.
 domain_entry_file_spec_domtrans(test_exectrace_parent_t, test_exectrace_child_t)
 allow test_exectrace_parent_t test_exectrace_child_t:fd use;
diff --git a/policy/test_extended_socket_class.te b/policy/test_extended_socket_class.te
index 681a71d..c8840b4 100644
--- a/policy/test_extended_socket_class.te
+++ b/policy/test_extended_socket_class.te
@@ -54,6 +54,3 @@ extended_socket_class_test(alg_socket, socket)
 
 # Trigger kernel module auto-loading of the network protocol implementations.
 kernel_request_load_module(extsocktestdomain)
-
-# Entry into the test domains via the test program.
-miscfiles_domain_entry_test_files(extsocktestdomain)
diff --git a/policy/test_fdreceive.te b/policy/test_fdreceive.te
index 9987503..df9e974 100644
--- a/policy/test_fdreceive.te
+++ b/policy/test_fdreceive.te
@@ -30,9 +30,6 @@ type test_fdreceive_server_t;
 testsuite_domain_type(test_fdreceive_server_t);
 typeattribute test_fdreceive_server_t fdreceivedomain;
 
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(fdreceivedomain)
-
 # Grant the necessary permissions for the server domain.
 ## Create the Unix domain socket file.
 allow test_fdreceive_server_t test_file_t:dir rw_dir_perms;
diff --git a/policy/test_fdreceive_bpf.te b/policy/test_fdreceive_bpf.te
index 264a703..fd633ae 100644
--- a/policy/test_fdreceive_bpf.te
+++ b/policy/test_fdreceive_bpf.te
@@ -48,6 +48,3 @@ allow test_fdreceive_bpf_client3_t self:process { setrlimit };
 # Server side rules:
 allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:fd { use };
 allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:bpf { map_write };
-
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(fdreceivebpfdomain)
diff --git a/policy/test_file.te b/policy/test_file.te
index 9acc211..5bb0398 100644
--- a/policy/test_file.te
+++ b/policy/test_file.te
@@ -53,9 +53,6 @@ libs_use_shared_libs(fileopdomain)
 libs_exec_ld_so(fileopdomain)
 libs_exec_lib_files(fileopdomain)
 
-# Allow all of these domains to be entered from sysadm domain
-miscfiles_domain_entry_test_files(fileopdomain)
-
 corecmd_bin_entry_type(fileopdomain)
 sysadm_bin_spec_domtrans_to(fileopdomain)
 
diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index fd06d5d..5de489c 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -408,8 +408,3 @@ allow test_filesystem_no_mount_t dosfs_t:filesystem { associate };
 allow test_filesystem_no_remount_t dosfs_t:filesystem { associate };
 allow test_filesystem_no_unmount_t dosfs_t:filesystem { associate };
 allow test_move_mount_no_mounton_t dosfs_t:filesystem { associate };
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(filesystemdomain)
diff --git a/policy/test_global.te b/policy/test_global.te
index 5ef3b02..667c272 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -51,8 +51,10 @@ allow testsuite_domain self:capability { dac_override dac_read_search };
 #allow sysadm_t self:process setexec;
 #selinux_get_fs_mount(sysadm_t)
 
-# Let all test domains read test directories and files.
+# Let all test domains read test directories and files and to use test
+# files as entry points.
 miscfiles_read_test_files(testsuite_domain)
+miscfiles_domain_entry_test_files(testsuite_domain)
 
 # Let the test domains set their current, exec and fscreate contexts.
 allow testsuite_domain self:process setcurrent;
diff --git a/policy/test_ibendport.te b/policy/test_ibendport.te
index a403be0..ccfea28 100644
--- a/policy/test_ibendport.te
+++ b/policy/test_ibendport.te
@@ -29,6 +29,3 @@ corenet_ib_access_unlabeled_pkeys(test_ibendport_manage_subnet_t)
 ')
 
 allow test_ibendport_manage_subnet_t test_ibendport_t:infiniband_endport manage_subnet;
-
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(ibendportdomain)
diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
index de0f5e1..863ff16 100644
--- a/policy/test_ibpkey.te
+++ b/policy/test_ibpkey.te
@@ -22,6 +22,3 @@ corenet_ib_pkey(test_ibpkey_t)
 ifdef(`corenet_ib_access_unlabeled_pkeys',`
 corenet_ib_access_unlabeled_pkeys(test_ibpkey_access_t)
 ')
-
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(ibpkeydomain)
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index dd0e83c..5feb801 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -158,6 +158,3 @@ allow test_inet_client_t test_server_packet_t:packet { send recv };
 # Send/recv unlabeled packets.
 kernel_sendrecv_unlabeled_packets(inetsocketdomain)
 kernel_recvfrom_unlabeled_peer(inetsocketdomain)
-
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(inetsocketdomain)
diff --git a/policy/test_inherit.te b/policy/test_inherit.te
index 15ab8fc..da26ea3 100644
--- a/policy/test_inherit.te
+++ b/policy/test_inherit.te
@@ -31,9 +31,6 @@ type test_inherit_nowrite_t;
 testsuite_domain_type(test_inherit_nowrite_t)
 typeattribute test_inherit_nowrite_t inheritdomain;
 
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(inheritdomain)
-
 # Grant the necessary permissions for the parent domain.
 allow test_inherit_parent_t test_inherit_file_t:file rw_file_perms;
 
diff --git a/policy/test_ioctl.te b/policy/test_ioctl.te
index 955695d..dc645f4 100644
--- a/policy/test_ioctl.te
+++ b/policy/test_ioctl.te
@@ -30,7 +30,6 @@ libs_exec_lib_files(ioctldomain)
 
 # Allow all of these domains to be entered from sysadm domain
 # via a shell script in the test directory or by....
-miscfiles_domain_entry_test_files(ioctldomain)
 corecmd_bin_entry_type(ioctldomain)
 sysadm_bin_spec_domtrans_to(ioctldomain)
 
diff --git a/policy/test_ipc.te b/policy/test_ipc.te
index f68d35c..21d997b 100644
--- a/policy/test_ipc.te
+++ b/policy/test_ipc.te
@@ -67,7 +67,6 @@ fs_rw_tmpfs_files(ipcdomain)
 
 # Allow all of these domains to be entered from user domains.
 # via a shell script in the test directory or by another program.
-miscfiles_domain_entry_test_files(ipcdomain)
 corecmd_bin_entry_type(ipcdomain)
 sysadm_bin_spec_domtrans_to(ipcdomain)
 
diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
index 2763472..27a1545 100644
--- a/policy/test_key_socket.te
+++ b/policy/test_key_socket.te
@@ -48,10 +48,5 @@ typeattribute test_key_sock_no_read_t keysockdomain;
 allow test_key_sock_no_read_t self:capability { net_admin };
 allow test_key_sock_no_read_t self:key_socket { create write setopt };
 
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(keysockdomain)
-
 # For CONFIG_NET_KEY=m
 kernel_request_load_module(keysockdomain)
diff --git a/policy/test_keys.te b/policy/test_keys.te
index de1b46c..250950e 100644
--- a/policy/test_keys.te
+++ b/policy/test_keys.te
@@ -164,8 +164,3 @@ typeattribute test_request_keys_no_link_t keydomain;
 
 allow test_request_keys_no_link_t self:key { create write search read view link setattr };
 allow test_request_keys_no_link_t test_keyring_service_t:key { read write search view setattr };
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(keydomain)
diff --git a/policy/test_mmap.te b/policy/test_mmap.te
index eb59dbe..d0850cc 100644
--- a/policy/test_mmap.te
+++ b/policy/test_mmap.te
@@ -152,6 +152,3 @@ testsuite_domain_type(test_no_execmod_t)
 typeattribute test_no_execmod_t mmaptestdomain;
 allow test_no_execmod_t test_mmap_file_t:file { open read execute };
 allow_map(test_no_execmod_t, test_mmap_file_t, file)
-
-# Allow entrypoint via the test programs.
-miscfiles_domain_entry_test_files(mmaptestdomain)
diff --git a/policy/test_module_load.te b/policy/test_module_load.te
index 770b2dd..a856706 100644
--- a/policy/test_module_load.te
+++ b/policy/test_module_load.te
@@ -41,8 +41,3 @@ allow test_kmodule_deny_module_request_t test_file_t:system { module_load };
 allow test_kmodule_deny_module_request_t self:system { module_load };
 allow_lockdown_integrity(test_kmodule_deny_module_request_t)
 neverallow test_kmodule_deny_module_request_t kernel_t:system { module_request };
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(kmoduledomain)
diff --git a/policy/test_mqueue.te b/policy/test_mqueue.te
index ea3fa68..65ffe6d 100644
--- a/policy/test_mqueue.te
+++ b/policy/test_mqueue.te
@@ -55,9 +55,6 @@ type mqop_mqrw_t;
 files_type(mqop_mqrw_t)
 
 
-# basic permision for all mqopdomains
-miscfiles_domain_entry_test_files(mqopdomain)
-
 corecmd_bin_entry_type(mqopdomain)
 sysadm_bin_spec_domtrans_to(mqopdomain)
 
diff --git a/policy/test_netlink_socket.te b/policy/test_netlink_socket.te
index 589e372..b6d39c2 100644
--- a/policy/test_netlink_socket.te
+++ b/policy/test_netlink_socket.te
@@ -41,8 +41,5 @@ netlink_socket_test(netlink_crypto_socket)
 # Common rules for all netlink socket class test domains.
 #
 
-# Entry into the test domains via the test program.
-miscfiles_domain_entry_test_files(netlinksocktestdomain)
-
 # Trigger kernel module auto-loading of the protocol implementations.
 kernel_request_load_module(netlinksocktestdomain)
diff --git a/policy/test_notify.te b/policy/test_notify.te
index 4ffd287..fe60274 100644
--- a/policy/test_notify.te
+++ b/policy/test_notify.te
@@ -73,5 +73,3 @@ testsuite_domain_type(test_rdonly_t)
 typeattribute test_rdonly_t test_notify_domain;
 
 allow test_rdonly_t test_notify_file_t:dir { read open watch };
-
-miscfiles_domain_entry_test_files(test_notify_domain)
diff --git a/policy/test_open.te b/policy/test_open.te
index 0d662f0..f01a5fe 100644
--- a/policy/test_open.te
+++ b/policy/test_open.te
@@ -28,6 +28,3 @@ type test_append_t;
 testsuite_domain_type(test_append_t)
 typeattribute test_append_t test_open_domain;
 allow test_append_t test_open_file_t:file append_file_perms;
-
-# Allow all of these domains to be entered from sysadm domain
-miscfiles_domain_entry_test_files(test_open_domain)
diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
index 8a914ff..5db46cd 100644
--- a/policy/test_perf_event.te
+++ b/policy/test_perf_event.te
@@ -70,8 +70,3 @@ typeattribute test_perf_no_write_t perfdomain;
 allow test_perf_no_write_t self:capability2 { perfmon };
 allow test_perf_no_write_t self:perf_event { open cpu kernel tracepoint read };
 allow_lockdown_confidentiality(test_perf_no_write_t)
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(perfdomain)
diff --git a/policy/test_prlimit.te b/policy/test_prlimit.te
index 4b6a5c8..b0314f3 100644
--- a/policy/test_prlimit.te
+++ b/policy/test_prlimit.te
@@ -36,10 +36,3 @@ spec_domtrans_pattern(test_no_$1_t, test_file_t, test_$1_child_t)
 
 prlimit_test(setrlimit)
 prlimit_test(getrlimit)
-
-#
-# Common rules for all prlimit test domains.
-#
-
-# Entry into the test domains via the test program.
-miscfiles_domain_entry_test_files(prlimittestdomain)
diff --git a/policy/test_ptrace.te b/policy/test_ptrace.te
index f327cc5..8c1d71c 100644
--- a/policy/test_ptrace.te
+++ b/policy/test_ptrace.te
@@ -33,10 +33,6 @@ userdom_search_user_home_dirs(test_ptrace_traced_t)
 # Let the tracer wait on the traced domain.
 allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
 
-# Allow all of these domains to be entered from the sysadm domains.
-# via a program in the test directory.
-miscfiles_domain_entry_test_files(ptracedomain)
-
 # Allow execution of helper programs.
 corecmd_exec_bin(ptracedomain)
 domain_exec_all_entry_files(ptracedomain)
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 7b24b8c..e276153 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -229,8 +229,3 @@ allow sctpsocketdomain proc_net_t:file { read };
 allow sctpsocketdomain sysctl_net_t:dir { search };
 allow sctpsocketdomain self:udp_socket { create };
 allow sctpsocketdomain self:unix_dgram_socket { create ioctl };
-
-#
-############ Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(sctpsocketdomain)
diff --git a/policy/test_setnice.te b/policy/test_setnice.te
index 34a2e73..2c34643 100644
--- a/policy/test_setnice.te
+++ b/policy/test_setnice.te
@@ -31,7 +31,6 @@ libs_exec_lib_files(setnicedomain)
 
 # Allow all of these domains to be entered from sysadm domain
 # via a shell script in the test directory or by....
-miscfiles_domain_entry_test_files(setnicedomain)
 domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
 domain_transition_pattern(test_setnice_change_t, test_file_t, {test_setnice_set_t test_setnice_noset_t})
 allow test_setnice_change_t test_setnice_set_t:fd use;
diff --git a/policy/test_sigkill.te b/policy/test_sigkill.te
index 04bed89..1aaa0af 100644
--- a/policy/test_sigkill.te
+++ b/policy/test_sigkill.te
@@ -40,7 +40,6 @@ allow test_kill_signal_t test_kill_server_t:process signal;
 
 # Allow all of these domains to be entered from the sysadm domains,
 # via kill or a program in the test directory.
-miscfiles_domain_entry_test_files(killdomain)
 corecmd_bin_entry_type(killdomain)
 sysadm_bin_spec_domtrans_to(killdomain)
 
diff --git a/policy/test_task_create.te b/policy/test_task_create.te
index 54acb50..b90b2e3 100644
--- a/policy/test_task_create.te
+++ b/policy/test_task_create.te
@@ -20,8 +20,3 @@ type test_create_no_t;
 # as it makes the permission effectively unusable in real policy.
 testsuite_domain_type_minimal(test_create_no_t)
 typeattribute test_create_no_t test_create_d;
-
-# General rules for the test_create_d
-
-# Allow domain to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(test_create_d)
diff --git a/policy/test_task_getpgid.te b/policy/test_task_getpgid.te
index dad584e..4c499f7 100644
--- a/policy/test_task_getpgid.te
+++ b/policy/test_task_getpgid.te
@@ -24,8 +24,5 @@ type test_getpgid_no_t;
 testsuite_domain_type(test_getpgid_no_t)
 typeattribute test_getpgid_no_t test_getpgid_d;
 
-# Allow domain to be entered from the sysadm domain
-miscfiles_domain_entry_test_files(test_getpgid_d)
-
 # Give test_getpgid_yes_t the permission needed.
 allow test_getpgid_yes_t test_getpgid_target_t:process getpgid;
diff --git a/policy/test_task_getsched.te b/policy/test_task_getsched.te
index f541d58..98b267f 100644
--- a/policy/test_task_getsched.te
+++ b/policy/test_task_getsched.te
@@ -24,8 +24,5 @@ type test_getsched_no_t;
 testsuite_domain_type(test_getsched_no_t)
 typeattribute test_getsched_no_t test_getsched_d;
 
-# Allow domain to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(test_getsched_d)
-
 # Give test_getsched_yes_t the permission needed.
 allow test_getsched_yes_t test_getsched_target_t:process getsched;
diff --git a/policy/test_task_getsid.te b/policy/test_task_getsid.te
index 8c21d9a..b53d454 100644
--- a/policy/test_task_getsid.te
+++ b/policy/test_task_getsid.te
@@ -24,8 +24,5 @@ type test_getsid_no_t;
 testsuite_domain_type(test_getsid_no_t)
 typeattribute test_getsid_no_t test_getsid_d;
 
-# Allow domain to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(test_getsid_d)
-
 # Give test_getsid_yes_t the permission needed.
 allow test_getsid_yes_t test_getsid_target_t:process getsession;
diff --git a/policy/test_task_setpgid.te b/policy/test_task_setpgid.te
index 25e06d4..bb8afa7 100644
--- a/policy/test_task_setpgid.te
+++ b/policy/test_task_setpgid.te
@@ -15,6 +15,3 @@ typeattribute test_setpgid_yes_t test_setpgid_d;
 type test_setpgid_no_t;
 testsuite_domain_type_minimal(test_setpgid_no_t)
 typeattribute test_setpgid_no_t test_setpgid_d;
-
-# Allow domain to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(test_setpgid_d)
diff --git a/policy/test_task_setsched.te b/policy/test_task_setsched.te
index 432135e..3e75cf6 100644
--- a/policy/test_task_setsched.te
+++ b/policy/test_task_setsched.te
@@ -26,9 +26,6 @@ type test_setsched_no_t;
 testsuite_domain_type(test_setsched_no_t)
 typeattribute test_setsched_no_t test_setsched_d;
 
-# Allow domain to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(test_setsched_d)
-
 # Allow these domains to execute renice.
 corecmd_bin_entry_type(test_setsched_d)
 
diff --git a/policy/test_tun_tap.te b/policy/test_tun_tap.te
index e1aef8d..28efc10 100644
--- a/policy/test_tun_tap.te
+++ b/policy/test_tun_tap.te
@@ -91,8 +91,3 @@ allow test_newcon_no_from_tun_tap_t self:tun_socket { relabelto };
 # For switch back on error:
 allow test_tun_tap_t test_newcon_no_from_tun_tap_t:fd { use };
 allow test_newcon_no_from_tun_tap_t test_tun_tap_t:process { dyntransition };
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(tuntapdomain)
diff --git a/policy/test_unix_socket.te b/policy/test_unix_socket.te
index 69720f0..f4e9e41 100644
--- a/policy/test_unix_socket.te
+++ b/policy/test_unix_socket.te
@@ -58,6 +58,3 @@ allow test_unix_server_t test_unix_dgram_client_t:unix_dgram_socket sendto;
 type test_socketpair_t;
 testsuite_domain_type(test_socketpair_t)
 typeattribute test_socketpair_t unixsocketdomain;
-
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(unixsocketdomain)
diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
index 5cb7d1c..f5a6613 100644
--- a/policy/test_userfaultfd.te
+++ b/policy/test_userfaultfd.te
@@ -45,6 +45,3 @@ userfaultfd_domain_type(test_noread_uffd_t)
 
 # userfaultfd(2) requires CAP_SYS_PTRACE
 allow test_uffd_domain self:capability { sys_ptrace };
-
-# Allow all of these domains to be executed
-miscfiles_domain_entry_test_files(test_uffd_domain)
diff --git a/policy/test_vsock_socket.te b/policy/test_vsock_socket.te
index 4bb989a..dbd47f4 100644
--- a/policy/test_vsock_socket.te
+++ b/policy/test_vsock_socket.te
@@ -42,6 +42,3 @@ vsock_client(noread, connect create getattr getopt setopt shutdown write)
 vsock_client(nogetattr, connect create getopt setopt read shutdown write)
 vsock_client(nogetopt, connect create getattr setopt read shutdown write)
 vsock_client(nosetopt, connect create getattr getopt read shutdown write)
-
-# Allow all of these domains to be entered from the sysadm domain.
-miscfiles_domain_entry_test_files(vsocksocketdomain)
diff --git a/policy/test_watchkey.te b/policy/test_watchkey.te
index 101d68a..a85bd20 100644
--- a/policy/test_watchkey.te
+++ b/policy/test_watchkey.te
@@ -15,8 +15,3 @@ allow test_watchkey_t self:key { view };
 type test_watchkey_no_view_t;
 testsuite_domain_type(test_watchkey_no_view_t)
 typeattribute test_watchkey_no_view_t watchkeydomain;
-
-#
-########### Allow these domains to be entered from sysadm domain ############
-#
-miscfiles_domain_entry_test_files(watchkeydomain)
-- 
2.37.1

