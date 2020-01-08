Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8EC282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE52120643
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 14:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+aMvTpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgAHOKG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:10:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30521 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbgAHOKG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 09:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578492604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fN6yftVObKsjAUHxI+IvOv6OSllKsZv1hxngbGqmthI=;
        b=U+aMvTpAvqNL+mBLCQvsfArsrdpukGKkr6QyBzPBNEX1AqgZ4WAURGav1J/lFWLiLDBOBq
        Owjlzp8hKOpq6XwBQ/7gfwnZ3NeOngnW3nE5uzARkZLDfx4X0J+GE2l7BrXHcsbp7nKheN
        tdsow2k4jrXxLw+uGlCx1lB/g6bikx0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Ped38xBDN-2UfavgT0OYlQ-1; Wed, 08 Jan 2020 09:10:02 -0500
X-MC-Unique: Ped38xBDN-2UfavgT0OYlQ-1
Received: by mail-wr1-f71.google.com with SMTP id w6so1467634wrm.16
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 06:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fN6yftVObKsjAUHxI+IvOv6OSllKsZv1hxngbGqmthI=;
        b=tIGoO7OwgirQeNQ72tHIwVpV180hnq2o21wHdxvXkliDWY/uTRf6/DMjPwOY34Rw+K
         hA6/pzfYjqB5gHm3xVUNPSzx+wsFqPT48hDhpjWqc/30GMhgaICbbkfgnyeBsn2o1WhE
         xzb9rUYFxRI9GprTE/4oMpTC7dKFCENMcKFgwLje9MzvKaM96oqriCw280i+STL3shPl
         vWC11cDV/ZSZOg+DGJRJUW9W6Q0folUoH3faeVP87R9AFYyUyxYW8S+hJLx1dsGI4eK3
         SGZukqQ213QC78YcwrI2bfAvQjcv0vcrh0ukVsxRvuMPibvRaQVhg60ERx0AoTDDlQC6
         rLeg==
X-Gm-Message-State: APjAAAV4CRFHGTYKqSt9tn65WvY8hpJmE91170h60M9phsl2xkA8lhbu
        E5wCXuE+6nXOD2PHO8MfTnGsG8iOBS3NEGxv07RAoa2RbCur1ZzPMjWMNCEjxy+r3JWuiJYmBtR
        sXsMWfksjc8k7Cb5r/g==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr4773009wrp.1.1578492601322;
        Wed, 08 Jan 2020 06:10:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjn/nHRoCgQ/EeHtMa0GLEQ7cw5w9BxEOtlEGXSh1p0DAyPV5j3w9Jkx3VC8v2jsh2Qtaz8A==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr4772961wrp.1.1578492600942;
        Wed, 08 Jan 2020 06:10:00 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x10sm4751508wrp.58.2020.01.08.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:10:00 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: [PATCH v2] selinux: reorder hooks to make runtime disable less broken
Date:   Wed,  8 Jan 2020 15:09:58 +0100
Message-Id: <20200108140958.870283-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
infrastructure to use per-hook lists, which meant that removing the
hooks for a given module was no longer atomic. Even though the commit
clearly documents that modules implementing runtime revmoval of hooks
(only SELinux attempts this madness) need to take special precautions to
avoid race conditions, SELinux has never addressed this.

By inserting an artificial delay between the loop iterations of
security_delete_hooks() (I used 100 ms), booting to a state where
SELinux is enabled, but policy is not yet loaded, and running these
commands:

    while true; do ping -c 1 <some IP>; done &
    echo -n 1 >/sys/fs/selinux/disable
    kill %1
    wait

...I was able to trigger NULL pointer dereferences in various places. I
also have a report of someone getting panics on a stock RHEL-8 kernel
after setting SELINUX=disabled in /etc/selinux/config and rebooting
(without adding "selinux=0" to kernel command-line).

Reordering the SELinux hooks such that those that allocate structures
are removed last seems to prevent these panics. It is very much possible
that this doesn't make the runtime disable completely race-free, but at
least it makes the operation much less fragile.

Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changes in v2:
 - rebased on latest selinux/next
 - added comment above selinux_nf_ip_exit() call to ensure it remains
   ordered correctly

 security/selinux/hooks.c | 101 +++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 31 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 63a6e36abe9f..c06bb63d88bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6896,6 +6896,21 @@ static int selinux_perf_event_write(struct perf_event *event)
 }
 #endif
 
+/*
+ * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
+ * 1. any hooks that don't belong to (2.) or (3.) below,
+ * 2. hooks that both access structures allocated by other hooks, and allocate
+ *    structures that can be later accessed by other hooks (mostly "cloning"
+ *    hooks),
+ * 3. hooks that only allocate structures that can be later accessed by other
+ *    hooks ("allocating" hooks).
+ *
+ * Please follow block comment delimiters in the list to keep this order.
+ *
+ * This ordering is needed for SELinux runtime disable to work at least somewhat
+ * safely. Breaking the ordering rules above might lead to NULL pointer derefs
+ * when disabling SELinux at runtime.
+ */
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -6918,12 +6933,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
-	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
-	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
-
-	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
-	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
 	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
 	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
 	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
@@ -6933,12 +6943,10 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_umount, selinux_umount),
 	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
 	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
-	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
 
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 
-	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
@@ -7010,21 +7018,15 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
 
-	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
-
-	LSM_HOOK_INIT(msg_queue_alloc_security,
-			selinux_msg_queue_alloc_security),
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
 	LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
 	LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
 
-	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
 	LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
 	LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
 	LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
 
-	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
 	LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
 	LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
@@ -7035,13 +7037,11 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
 
 	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
-	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
 	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
 	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
-	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 
 	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
 	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
@@ -7064,7 +7064,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 			selinux_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram),
-	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
 	LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
@@ -7079,7 +7078,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
 	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
 	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
-	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
 	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
 	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
@@ -7089,17 +7087,11 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 	LSM_HOOK_INIT(ib_endport_manage_subnet,
 		      selinux_ib_endport_manage_subnet),
-	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
 	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
 #endif
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-	LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
-	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
 	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
 	LSM_HOOK_INIT(xfrm_policy_delete_security, selinux_xfrm_policy_delete),
-	LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
-	LSM_HOOK_INIT(xfrm_state_alloc_acquire,
-			selinux_xfrm_state_alloc_acquire),
 	LSM_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
 	LSM_HOOK_INIT(xfrm_state_delete_security, selinux_xfrm_state_delete),
 	LSM_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
@@ -7109,14 +7101,12 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 #endif
 
 #ifdef CONFIG_KEYS
-	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
 	LSM_HOOK_INIT(key_free, selinux_key_free),
 	LSM_HOOK_INIT(key_permission, selinux_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #endif
 
 #ifdef CONFIG_AUDIT
-	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
 	LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
 	LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
 	LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
@@ -7126,21 +7116,66 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bpf, selinux_bpf),
 	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
-	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
-	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
-	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
 	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
 	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
 	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
 #endif
 
 	LSM_HOOK_INIT(locked_down, selinux_lockdown),
+
+	/*
+	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
+	 */
+	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
+	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
+	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
+	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
+#endif
+
+	/*
+	 * PUT "ALLOCATING" HOOKS HERE
+	 */
+	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
+	LSM_HOOK_INIT(msg_queue_alloc_security,
+		      selinux_msg_queue_alloc_security),
+	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
+	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
+	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
+	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
+	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
+	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
+	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
+#ifdef CONFIG_SECURITY_INFINIBAND
+	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
+#endif
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
+	LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
+	LSM_HOOK_INIT(xfrm_state_alloc_acquire,
+		      selinux_xfrm_state_alloc_acquire),
+#endif
+#ifdef CONFIG_KEYS
+	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
+#endif
+#ifdef CONFIG_AUDIT
+	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
+#endif
+#ifdef CONFIG_BPF_SYSCALL
+	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
+	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
+#endif
+#ifdef CONFIG_PERF_EVENTS
+	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
+#endif
 };
 
 static __init int selinux_init(void)
@@ -7319,14 +7354,18 @@ int selinux_disable(struct selinux_state *state)
 
 	pr_info("SELinux:  Disabled at runtime.\n");
 
+	/*
+	 * Unregister netfilter hooks.
+	 * Must be done before security_delete_hooks() to avoid breaking
+	 * runtime disable.
+	 */
+	selinux_nf_ip_exit();
+
 	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
 
 	/* Try to destroy the avc node cache */
 	avc_disable();
 
-	/* Unregister netfilter hooks. */
-	selinux_nf_ip_exit();
-
 	/* Unregister selinuxfs. */
 	exit_sel_fs();
 
-- 
2.24.1

