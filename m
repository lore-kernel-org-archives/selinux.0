Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BAEC19F29
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiG2MCy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiG2MCy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1515863E2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ek1WsD0jgerpMK6h16W2N412NDepdks0lBqkQEQupco=;
        b=MoH/uJgBYKRyGpIG5uOzMV42VLQAtEXe2kNuUKZvi6P6ZBepFjenZCDyM3otG91KqBjPYr
        M4ydV5lWs1zrxtN6LE3b4A4vGPNl21uF3ZoFvMf7rHDHsQKzkz1LvUye4+SgBvd9v3boZE
        BizBaGwZ21ZqMsCvIIDiosNNgpV0Wtc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-MYACXNmrO6G-AgDYvdkrBQ-1; Fri, 29 Jul 2022 08:02:48 -0400
X-MC-Unique: MYACXNmrO6G-AgDYvdkrBQ-1
Received: by mail-wm1-f71.google.com with SMTP id q19-20020a7bce93000000b003a3264f3de9so795104wmj.3
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=ek1WsD0jgerpMK6h16W2N412NDepdks0lBqkQEQupco=;
        b=U2R31ivTk34pS7zFNjzGYYC1TRnnhSyaj60VYjSrhNOWMVEBLK/B2Zk5k25V1q4piW
         ZoiskGfuArT4H0CBbvAeN6wrK3LxbVARYbqkgJth/xQDyEmfMxFzVC51XQ50VeLIBLna
         Y5rZoFt+URXrqxJHAB1qxXKCPXX1ZnPlMznC5/RoDawlYgF7YHKdapJoSr5ME1UphnRR
         7iRZxUVBd+nLTONl86KUOYIRJBCR60fwRK8qmtR4VRsYWStMomgn46vakPqJ9p81/45P
         Z8NQCw9enYRerYGDKwG4nXp4RAH6c2ron/4oEcXV11tSaDw5LSOYL23FXNNcRwC14KY0
         pOlA==
X-Gm-Message-State: AJIora+bpXt6CeM+VdBtkaiqZFf1Umo0KOp71v3bb5a5QZJpcElisDzb
        WIsm4afAO+D1I2mjaFnyP/oqrOOEzGAdOf3Hr1kkCNds1G2N78xcMplYR4GmW9JorLhR//bmMv1
        21vSlIiK2mSDBjA759rIiLVDhgVIK+n40vrvq9mdHoZFxsDQoKDKbY6+sNCbygLEXvfxftA==
X-Received: by 2002:a05:600c:a184:b0:3a3:e5c3:e5c2 with SMTP id id4-20020a05600ca18400b003a3e5c3e5c2mr2617991wmb.130.1659096166082;
        Fri, 29 Jul 2022 05:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s9YbXDQu3geffGatClJ/Mp2h8mpcp8nEuYXBYZq51hf1tIUFvrR/R5T+U9BUvxa98QsB71QA==
X-Received: by 2002:a05:600c:a184:b0:3a3:e5c3:e5c2 with SMTP id id4-20020a05600ca18400b003a3e5c3e5c2mr2617943wmb.130.1659096165297;
        Fri, 29 Jul 2022 05:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:44 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 08/24] policy: move userdom_sysadm_entry_spec_domtrans_to() to general policy
Date:   Fri, 29 Jul 2022 14:02:13 +0200
Message-Id: <20220729120229.207584-9-omosnace@redhat.com>
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
 policy/test_atsecure.te              | 3 ---
 policy/test_binder.te                | 1 -
 policy/test_binder_bpf.te            | 1 -
 policy/test_bpf.te                   | 1 -
 policy/test_capable_file.te          | 1 -
 policy/test_dyntrace.te              | 1 -
 policy/test_dyntrans.te              | 1 -
 policy/test_entrypoint.te            | 1 -
 policy/test_execshare.te             | 1 -
 policy/test_exectrace.te             | 1 -
 policy/test_execute_no_trans.te      | 1 -
 policy/test_extended_socket_class.te | 1 -
 policy/test_fdreceive.te             | 1 -
 policy/test_fdreceive_bpf.te         | 1 -
 policy/test_file.te                  | 1 -
 policy/test_filesystem.te            | 1 -
 policy/test_global.te                | 3 +++
 policy/test_ibendport.te             | 1 -
 policy/test_ibpkey.te                | 1 -
 policy/test_inet_socket.te           | 1 -
 policy/test_inherit.te               | 1 -
 policy/test_ioctl.te                 | 1 -
 policy/test_ipc.te                   | 1 -
 policy/test_key_socket.te            | 1 -
 policy/test_keys.te                  | 1 -
 policy/test_mac_admin.te             | 1 -
 policy/test_module_load.te           | 1 -
 policy/test_mqueue.te                | 1 -
 policy/test_netlink_socket.te        | 1 -
 policy/test_notify.te                | 1 -
 policy/test_open.te                  | 1 -
 policy/test_perf_event.te            | 1 -
 policy/test_prlimit.te               | 1 -
 policy/test_ptrace.te                | 1 -
 policy/test_sctp.te                  | 1 -
 policy/test_sigkill.te               | 1 -
 policy/test_task_create.te           | 1 -
 policy/test_task_getpgid.te          | 1 -
 policy/test_task_getsched.te         | 1 -
 policy/test_task_getsid.te           | 1 -
 policy/test_task_setpgid.te          | 1 -
 policy/test_task_setsched.te         | 1 -
 policy/test_transition.te            | 3 ---
 policy/test_tun_tap.te               | 1 -
 policy/test_unix_socket.te           | 1 -
 policy/test_userfaultfd.te           | 1 -
 policy/test_vsock_socket.te          | 1 -
 policy/test_watchkey.te              | 1 -
 48 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/policy/test_atsecure.te b/policy/test_atsecure.te
index f7ab29a..90e58f1 100644
--- a/policy/test_atsecure.te
+++ b/policy/test_atsecure.te
@@ -35,6 +35,3 @@ allow_map(atsecuredomain, test_file_t, file)
 # Only allow the allowed domain noatsecure permission to the
 # new domain.
 allow test_atsecure_allowed_t test_atsecure_newdomain_t:process noatsecure;
-
-# Allow all of these domains to be entered from the sysadm domain.
-userdom_sysadm_entry_spec_domtrans_to(atsecuredomain)
diff --git a/policy/test_binder.te b/policy/test_binder.te
index e74a2fc..096c467 100644
--- a/policy/test_binder.te
+++ b/policy/test_binder.te
@@ -99,4 +99,3 @@ allow_map(test_binder_client_no_transfer_t, device_t, chr_file)
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(binderdomain)
-userdom_sysadm_entry_spec_domtrans_to(binderdomain)
diff --git a/policy/test_binder_bpf.te b/policy/test_binder_bpf.te
index 8c04d19..2d91af2 100644
--- a/policy/test_binder_bpf.te
+++ b/policy/test_binder_bpf.te
@@ -62,4 +62,3 @@ allow_map(test_binder_client_no_bpf_perm_t, device_t, chr_file)
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(binderbpfdomain)
-userdom_sysadm_entry_spec_domtrans_to(binderbpfdomain)
diff --git a/policy/test_bpf.te b/policy/test_bpf.te
index 58daebd..fb21c29 100644
--- a/policy/test_bpf.te
+++ b/policy/test_bpf.te
@@ -62,4 +62,3 @@ allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_loa
 ############ Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(bpfdomain)
-userdom_sysadm_entry_spec_domtrans_to(bpfdomain)
diff --git a/policy/test_capable_file.te b/policy/test_capable_file.te
index 73ad856..9ce9487 100644
--- a/policy/test_capable_file.te
+++ b/policy/test_capable_file.te
@@ -40,7 +40,6 @@ libs_exec_lib_files(capabledomain)
 
 # Allow test_file_t and bin_t to be entered from sysadm role
 miscfiles_domain_entry_test_files(capabledomain)
-userdom_sysadm_entry_spec_domtrans_to(capabledomain)
 corecmd_bin_entry_type(capabledomain)
 sysadm_bin_spec_domtrans_to(capabledomain)
 
diff --git a/policy/test_dyntrace.te b/policy/test_dyntrace.te
index 28836b8..0a598a4 100644
--- a/policy/test_dyntrace.te
+++ b/policy/test_dyntrace.te
@@ -26,7 +26,6 @@ typeattribute test_dyntrace_notchild_t dyntracedomain;
 
 # Allow test_files_t to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(dyntracedomain)
-userdom_sysadm_entry_spec_domtrans_to(dyntracedomain)
 miscfiles_exec_test_files(dyntracedomain)
 
 # Grant the necessary permissions for the child domain.
diff --git a/policy/test_dyntrans.te b/policy/test_dyntrans.te
index c749340..e4110c5 100644
--- a/policy/test_dyntrans.te
+++ b/policy/test_dyntrans.te
@@ -26,5 +26,4 @@ allow test_dyntrans_fromdomain_t test_dyntrans_todomain_t:process dyntransition;
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(dyntransdomain)
-userdom_sysadm_entry_spec_domtrans_to(dyntransdomain)
 
diff --git a/policy/test_entrypoint.te b/policy/test_entrypoint.te
index 28f4705..1fcbf0c 100644
--- a/policy/test_entrypoint.te
+++ b/policy/test_entrypoint.te
@@ -16,5 +16,4 @@ corecmd_exec_bin(test_entrypoint_t)
 
 # Allow this domain to be entered via its entrypoint type.
 domain_entry_file(test_entrypoint_t, test_entrypoint_execute_t)
-userdom_sysadm_entry_spec_domtrans_to(test_entrypoint_t)
 
diff --git a/policy/test_execshare.te b/policy/test_execshare.te
index 6d8b12e..22ed09f 100644
--- a/policy/test_execshare.te
+++ b/policy/test_execshare.te
@@ -22,7 +22,6 @@ typeattribute test_execshare_notchild_t execsharedomain;
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(execsharedomain)
-userdom_sysadm_entry_spec_domtrans_to(execsharedomain)
 
 # Grant the necessary permissions for the child domain.
 domain_entry_file_spec_domtrans(test_execshare_parent_t, test_execshare_child_t)
diff --git a/policy/test_exectrace.te b/policy/test_exectrace.te
index a4a8b96..302ba80 100644
--- a/policy/test_exectrace.te
+++ b/policy/test_exectrace.te
@@ -25,7 +25,6 @@ typeattribute test_exectrace_notchild_t exectracedomain;
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(exectracedomain)
-userdom_sysadm_entry_spec_domtrans_to(exectracedomain)
 
 # Grant the necessary permissions for the child domain.
 domain_entry_file_spec_domtrans(test_exectrace_parent_t, test_exectrace_child_t)
diff --git a/policy/test_execute_no_trans.te b/policy/test_execute_no_trans.te
index d0a46bc..e310353 100644
--- a/policy/test_execute_no_trans.te
+++ b/policy/test_execute_no_trans.te
@@ -18,7 +18,6 @@ testsuite_domain_type(test_execute_notrans_t);
 
 # Allow this domain to be entered via the shell.
 corecmd_shell_entry_type(test_execute_notrans_t)
-userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
 
 #Allow test_execute_notrans permissions to the allowed type
 can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
diff --git a/policy/test_extended_socket_class.te b/policy/test_extended_socket_class.te
index 75636ec..681a71d 100644
--- a/policy/test_extended_socket_class.te
+++ b/policy/test_extended_socket_class.te
@@ -57,4 +57,3 @@ kernel_request_load_module(extsocktestdomain)
 
 # Entry into the test domains via the test program.
 miscfiles_domain_entry_test_files(extsocktestdomain)
-userdom_sysadm_entry_spec_domtrans_to(extsocktestdomain)
diff --git a/policy/test_fdreceive.te b/policy/test_fdreceive.te
index e060ffd..9987503 100644
--- a/policy/test_fdreceive.te
+++ b/policy/test_fdreceive.te
@@ -32,7 +32,6 @@ typeattribute test_fdreceive_server_t fdreceivedomain;
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(fdreceivedomain)
-userdom_sysadm_entry_spec_domtrans_to(fdreceivedomain)
 
 # Grant the necessary permissions for the server domain.
 ## Create the Unix domain socket file.
diff --git a/policy/test_fdreceive_bpf.te b/policy/test_fdreceive_bpf.te
index 5a23931..264a703 100644
--- a/policy/test_fdreceive_bpf.te
+++ b/policy/test_fdreceive_bpf.te
@@ -51,4 +51,3 @@ allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:bpf { map_write };
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(fdreceivebpfdomain)
-userdom_sysadm_entry_spec_domtrans_to(fdreceivebpfdomain)
diff --git a/policy/test_file.te b/policy/test_file.te
index e20ae3e..9acc211 100644
--- a/policy/test_file.te
+++ b/policy/test_file.te
@@ -55,7 +55,6 @@ libs_exec_lib_files(fileopdomain)
 
 # Allow all of these domains to be entered from sysadm domain
 miscfiles_domain_entry_test_files(fileopdomain)
-userdom_sysadm_entry_spec_domtrans_to(fileopdomain)
 
 corecmd_bin_entry_type(fileopdomain)
 sysadm_bin_spec_domtrans_to(fileopdomain)
diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 71075fb..fd06d5d 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -413,4 +413,3 @@ allow test_move_mount_no_mounton_t dosfs_t:filesystem { associate };
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(filesystemdomain)
-userdom_sysadm_entry_spec_domtrans_to(filesystemdomain)
diff --git a/policy/test_global.te b/policy/test_global.te
index 03acc19..5ef3b02 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -40,6 +40,9 @@ term_use_all_terms(testsuite_domain)
 allow testsuite_domain init_t:fd use;
 allow testsuite_domain initrc_t:fd use;
 
+# Allow the test domain to be entered from sysadm_t
+userdom_sysadm_entry_spec_domtrans_to(testsuite_domain)
+
 # Allow the test domains to access the test directory and files
 # even if they are not root owned.
 allow testsuite_domain self:capability { dac_override dac_read_search };
diff --git a/policy/test_ibendport.te b/policy/test_ibendport.te
index 674293f..a403be0 100644
--- a/policy/test_ibendport.te
+++ b/policy/test_ibendport.te
@@ -32,4 +32,3 @@ allow test_ibendport_manage_subnet_t test_ibendport_t:infiniband_endport manage_
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(ibendportdomain)
-userdom_sysadm_entry_spec_domtrans_to(ibendportdomain)
diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
index e65895f..de0f5e1 100644
--- a/policy/test_ibpkey.te
+++ b/policy/test_ibpkey.te
@@ -25,4 +25,3 @@ corenet_ib_access_unlabeled_pkeys(test_ibpkey_access_t)
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(ibpkeydomain)
-userdom_sysadm_entry_spec_domtrans_to(ibpkeydomain)
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index da507d1..dd0e83c 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -161,4 +161,3 @@ kernel_recvfrom_unlabeled_peer(inetsocketdomain)
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(inetsocketdomain)
-userdom_sysadm_entry_spec_domtrans_to(inetsocketdomain)
diff --git a/policy/test_inherit.te b/policy/test_inherit.te
index 31d719e..15ab8fc 100644
--- a/policy/test_inherit.te
+++ b/policy/test_inherit.te
@@ -33,7 +33,6 @@ typeattribute test_inherit_nowrite_t inheritdomain;
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(inheritdomain)
-userdom_sysadm_entry_spec_domtrans_to(inheritdomain)
 
 # Grant the necessary permissions for the parent domain.
 allow test_inherit_parent_t test_inherit_file_t:file rw_file_perms;
diff --git a/policy/test_ioctl.te b/policy/test_ioctl.te
index 24cff32..955695d 100644
--- a/policy/test_ioctl.te
+++ b/policy/test_ioctl.te
@@ -31,7 +31,6 @@ libs_exec_lib_files(ioctldomain)
 # Allow all of these domains to be entered from sysadm domain
 # via a shell script in the test directory or by....
 miscfiles_domain_entry_test_files(ioctldomain)
-userdom_sysadm_entry_spec_domtrans_to(ioctldomain)
 corecmd_bin_entry_type(ioctldomain)
 sysadm_bin_spec_domtrans_to(ioctldomain)
 
diff --git a/policy/test_ipc.te b/policy/test_ipc.te
index 07f8b4a..f68d35c 100644
--- a/policy/test_ipc.te
+++ b/policy/test_ipc.te
@@ -68,7 +68,6 @@ fs_rw_tmpfs_files(ipcdomain)
 # Allow all of these domains to be entered from user domains.
 # via a shell script in the test directory or by another program.
 miscfiles_domain_entry_test_files(ipcdomain)
-userdom_sysadm_entry_spec_domtrans_to(ipcdomain)
 corecmd_bin_entry_type(ipcdomain)
 sysadm_bin_spec_domtrans_to(ipcdomain)
 
diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
index fad5dfd..2763472 100644
--- a/policy/test_key_socket.te
+++ b/policy/test_key_socket.te
@@ -52,7 +52,6 @@ allow test_key_sock_no_read_t self:key_socket { create write setopt };
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(keysockdomain)
-userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
 
 # For CONFIG_NET_KEY=m
 kernel_request_load_module(keysockdomain)
diff --git a/policy/test_keys.te b/policy/test_keys.te
index 142a70c..de1b46c 100644
--- a/policy/test_keys.te
+++ b/policy/test_keys.te
@@ -169,4 +169,3 @@ allow test_request_keys_no_link_t test_keyring_service_t:key { read write search
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(keydomain)
-userdom_sysadm_entry_spec_domtrans_to(keydomain)
diff --git a/policy/test_mac_admin.te b/policy/test_mac_admin.te
index e816b03..d63dc80 100644
--- a/policy/test_mac_admin.te
+++ b/policy/test_mac_admin.te
@@ -47,4 +47,3 @@ allow mac_admintestdomain unlabeled_t:dir { getattr create };
 
 # Entry into the test domains via the test program.
 corecmd_bin_entry_type(mac_admintestdomain)
-userdom_sysadm_entry_spec_domtrans_to(mac_admintestdomain)
diff --git a/policy/test_module_load.te b/policy/test_module_load.te
index bbb805a..770b2dd 100644
--- a/policy/test_module_load.te
+++ b/policy/test_module_load.te
@@ -46,4 +46,3 @@ neverallow test_kmodule_deny_module_request_t kernel_t:system { module_request }
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(kmoduledomain)
-userdom_sysadm_entry_spec_domtrans_to(kmoduledomain)
diff --git a/policy/test_mqueue.te b/policy/test_mqueue.te
index b9e84e7..ea3fa68 100644
--- a/policy/test_mqueue.te
+++ b/policy/test_mqueue.te
@@ -57,7 +57,6 @@ files_type(mqop_mqrw_t)
 
 # basic permision for all mqopdomains
 miscfiles_domain_entry_test_files(mqopdomain)
-userdom_sysadm_entry_spec_domtrans_to(mqopdomain)
 
 corecmd_bin_entry_type(mqopdomain)
 sysadm_bin_spec_domtrans_to(mqopdomain)
diff --git a/policy/test_netlink_socket.te b/policy/test_netlink_socket.te
index 0d6fc5e..589e372 100644
--- a/policy/test_netlink_socket.te
+++ b/policy/test_netlink_socket.te
@@ -43,7 +43,6 @@ netlink_socket_test(netlink_crypto_socket)
 
 # Entry into the test domains via the test program.
 miscfiles_domain_entry_test_files(netlinksocktestdomain)
-userdom_sysadm_entry_spec_domtrans_to(netlinksocktestdomain)
 
 # Trigger kernel module auto-loading of the protocol implementations.
 kernel_request_load_module(netlinksocktestdomain)
diff --git a/policy/test_notify.te b/policy/test_notify.te
index 86979a5..4ffd287 100644
--- a/policy/test_notify.te
+++ b/policy/test_notify.te
@@ -75,4 +75,3 @@ typeattribute test_rdonly_t test_notify_domain;
 allow test_rdonly_t test_notify_file_t:dir { read open watch };
 
 miscfiles_domain_entry_test_files(test_notify_domain)
-userdom_sysadm_entry_spec_domtrans_to(test_notify_domain)
diff --git a/policy/test_open.te b/policy/test_open.te
index acb31d8..0d662f0 100644
--- a/policy/test_open.te
+++ b/policy/test_open.te
@@ -31,4 +31,3 @@ allow test_append_t test_open_file_t:file append_file_perms;
 
 # Allow all of these domains to be entered from sysadm domain
 miscfiles_domain_entry_test_files(test_open_domain)
-userdom_sysadm_entry_spec_domtrans_to(test_open_domain)
diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
index 6d3828a..8a914ff 100644
--- a/policy/test_perf_event.te
+++ b/policy/test_perf_event.te
@@ -75,4 +75,3 @@ allow_lockdown_confidentiality(test_perf_no_write_t)
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(perfdomain)
-userdom_sysadm_entry_spec_domtrans_to(perfdomain)
diff --git a/policy/test_prlimit.te b/policy/test_prlimit.te
index 3f32136..4b6a5c8 100644
--- a/policy/test_prlimit.te
+++ b/policy/test_prlimit.te
@@ -43,4 +43,3 @@ prlimit_test(getrlimit)
 
 # Entry into the test domains via the test program.
 miscfiles_domain_entry_test_files(prlimittestdomain)
-userdom_sysadm_entry_spec_domtrans_to(prlimittestdomain)
diff --git a/policy/test_ptrace.te b/policy/test_ptrace.te
index 34aa636..f327cc5 100644
--- a/policy/test_ptrace.te
+++ b/policy/test_ptrace.te
@@ -36,7 +36,6 @@ allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
 # Allow all of these domains to be entered from the sysadm domains.
 # via a program in the test directory.
 miscfiles_domain_entry_test_files(ptracedomain)
-userdom_sysadm_entry_spec_domtrans_to(ptracedomain)
 
 # Allow execution of helper programs.
 corecmd_exec_bin(ptracedomain)
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 4c18c72..7b24b8c 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -234,4 +234,3 @@ allow sctpsocketdomain self:unix_dgram_socket { create ioctl };
 ############ Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(sctpsocketdomain)
-userdom_sysadm_entry_spec_domtrans_to(sctpsocketdomain)
diff --git a/policy/test_sigkill.te b/policy/test_sigkill.te
index a0dce3b..04bed89 100644
--- a/policy/test_sigkill.te
+++ b/policy/test_sigkill.te
@@ -41,7 +41,6 @@ allow test_kill_signal_t test_kill_server_t:process signal;
 # Allow all of these domains to be entered from the sysadm domains,
 # via kill or a program in the test directory.
 miscfiles_domain_entry_test_files(killdomain)
-userdom_sysadm_entry_spec_domtrans_to(killdomain)
 corecmd_bin_entry_type(killdomain)
 sysadm_bin_spec_domtrans_to(killdomain)
 
diff --git a/policy/test_task_create.te b/policy/test_task_create.te
index eb51cd2..54acb50 100644
--- a/policy/test_task_create.te
+++ b/policy/test_task_create.te
@@ -25,4 +25,3 @@ typeattribute test_create_no_t test_create_d;
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_create_d)
-userdom_sysadm_entry_spec_domtrans_to(test_create_d)
diff --git a/policy/test_task_getpgid.te b/policy/test_task_getpgid.te
index 1f81f56..dad584e 100644
--- a/policy/test_task_getpgid.te
+++ b/policy/test_task_getpgid.te
@@ -26,7 +26,6 @@ typeattribute test_getpgid_no_t test_getpgid_d;
 
 # Allow domain to be entered from the sysadm domain
 miscfiles_domain_entry_test_files(test_getpgid_d)
-userdom_sysadm_entry_spec_domtrans_to(test_getpgid_d)
 
 # Give test_getpgid_yes_t the permission needed.
 allow test_getpgid_yes_t test_getpgid_target_t:process getpgid;
diff --git a/policy/test_task_getsched.te b/policy/test_task_getsched.te
index c67019b..f541d58 100644
--- a/policy/test_task_getsched.te
+++ b/policy/test_task_getsched.te
@@ -26,7 +26,6 @@ typeattribute test_getsched_no_t test_getsched_d;
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_getsched_d)
-userdom_sysadm_entry_spec_domtrans_to(test_getsched_d)
 
 # Give test_getsched_yes_t the permission needed.
 allow test_getsched_yes_t test_getsched_target_t:process getsched;
diff --git a/policy/test_task_getsid.te b/policy/test_task_getsid.te
index e5a62f8..8c21d9a 100644
--- a/policy/test_task_getsid.te
+++ b/policy/test_task_getsid.te
@@ -26,7 +26,6 @@ typeattribute test_getsid_no_t test_getsid_d;
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_getsid_d)
-userdom_sysadm_entry_spec_domtrans_to(test_getsid_d)
 
 # Give test_getsid_yes_t the permission needed.
 allow test_getsid_yes_t test_getsid_target_t:process getsession;
diff --git a/policy/test_task_setpgid.te b/policy/test_task_setpgid.te
index 8e98859..25e06d4 100644
--- a/policy/test_task_setpgid.te
+++ b/policy/test_task_setpgid.te
@@ -18,4 +18,3 @@ typeattribute test_setpgid_no_t test_setpgid_d;
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_setpgid_d)
-userdom_sysadm_entry_spec_domtrans_to(test_setpgid_d)
diff --git a/policy/test_task_setsched.te b/policy/test_task_setsched.te
index c30157e..432135e 100644
--- a/policy/test_task_setsched.te
+++ b/policy/test_task_setsched.te
@@ -28,7 +28,6 @@ typeattribute test_setsched_no_t test_setsched_d;
 
 # Allow domain to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(test_setsched_d)
-userdom_sysadm_entry_spec_domtrans_to(test_setsched_d)
 
 # Allow these domains to execute renice.
 corecmd_bin_entry_type(test_setsched_d)
diff --git a/policy/test_transition.te b/policy/test_transition.te
index 8f1f4bf..4adc423 100644
--- a/policy/test_transition.te
+++ b/policy/test_transition.te
@@ -25,6 +25,3 @@ corecmd_bin_entry_type(transitiondomain)
 domain_transition_pattern(test_transition_fromdomain_t,bin_t,test_transition_todomain_t)
 allow test_transition_fromdomain_t test_transition_todomain_t:fd use;
 allow test_transition_todomain_t test_transition_fromdomain_t:fd use;
-
-# Allow all of these domains to be entered from the sysadm domain.
-userdom_sysadm_entry_spec_domtrans_to(transitiondomain)
diff --git a/policy/test_tun_tap.te b/policy/test_tun_tap.te
index be317a2..e1aef8d 100644
--- a/policy/test_tun_tap.te
+++ b/policy/test_tun_tap.te
@@ -96,4 +96,3 @@ allow test_newcon_no_from_tun_tap_t test_tun_tap_t:process { dyntransition };
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(tuntapdomain)
-userdom_sysadm_entry_spec_domtrans_to(tuntapdomain)
diff --git a/policy/test_unix_socket.te b/policy/test_unix_socket.te
index 924475e..69720f0 100644
--- a/policy/test_unix_socket.te
+++ b/policy/test_unix_socket.te
@@ -61,4 +61,3 @@ typeattribute test_socketpair_t unixsocketdomain;
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(unixsocketdomain)
-userdom_sysadm_entry_spec_domtrans_to(unixsocketdomain)
diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
index 0ca733b..5cb7d1c 100644
--- a/policy/test_userfaultfd.te
+++ b/policy/test_userfaultfd.te
@@ -48,4 +48,3 @@ allow test_uffd_domain self:capability { sys_ptrace };
 
 # Allow all of these domains to be executed
 miscfiles_domain_entry_test_files(test_uffd_domain)
-userdom_sysadm_entry_spec_domtrans_to(test_uffd_domain)
diff --git a/policy/test_vsock_socket.te b/policy/test_vsock_socket.te
index abbcc0b..4bb989a 100644
--- a/policy/test_vsock_socket.te
+++ b/policy/test_vsock_socket.te
@@ -45,4 +45,3 @@ vsock_client(nosetopt, connect create getattr getopt read shutdown write)
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(vsocksocketdomain)
-userdom_sysadm_entry_spec_domtrans_to(vsocksocketdomain)
diff --git a/policy/test_watchkey.te b/policy/test_watchkey.te
index 9fa5a70..101d68a 100644
--- a/policy/test_watchkey.te
+++ b/policy/test_watchkey.te
@@ -20,4 +20,3 @@ typeattribute test_watchkey_no_view_t watchkeydomain;
 ########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(watchkeydomain)
-userdom_sysadm_entry_spec_domtrans_to(watchkeydomain)
-- 
2.37.1

