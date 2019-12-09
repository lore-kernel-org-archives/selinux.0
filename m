Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A97C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 07:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB6920726
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 07:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eve7eJtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfLIH6b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:58:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54170 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727144AbfLIH6a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 02:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575878307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X4iMg9AEQx3fzXkizyBi6lpX/zQOZ4T6BJEIgDfs+tc=;
        b=eve7eJtg20nlc72PG85ZtAAwfb5A4vRVV2x7P96dX6PGItHJOuaQ4aKFUK8Qfv5AkcoRmo
        4AxjOkOShsoDbzfnIWFGd0Kxvkfhcybj9dZgG4upHV213tx4ytY8Ri9bIpAMg/cJAs8LAF
        6cCnwsHumU9pqumH4KolwEJdbJ9lTE4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-DQYB27IqMWawS2mW1O8kOw-1; Mon, 09 Dec 2019 02:58:00 -0500
Received: by mail-wm1-f72.google.com with SMTP id y125so6783450wmg.1
        for <selinux@vger.kernel.org>; Sun, 08 Dec 2019 23:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnlY9ctQ1PevxFKoOD7h7tcLe7wO+KKqiQJfvLB3RXM=;
        b=Ii+/j1w7x2aKjRv4K0ZeJjJb4O4c0SLw91fn1Bb/aLmWQwEA7P+Z1048Bp4ZbJI4Vc
         Pmvl9mO4uzz7TP7K88m8qwq7Kd9o/QSBCXGgVTOd39T5s5mTFylkquQ7IK8QjCZtrcxB
         o9+eFOtEEjIOEheOf//IAgpob6uuUxRruQX/xH0VD3r5VgYPCRRbhqpa30CQnsKFggmW
         AG+3axzEylHZ84aZ6tF+DNa4HN1RX1OvRulqwXWHIGWUJdwt8I5USyzLEe3L7P6/bp16
         Dsx7JTbf3ulyFDpETLPg+rY4AmZfL1IK+E2o8app00RiToAsZF5eHo7MSPVG8pbEu7OJ
         +XZQ==
X-Gm-Message-State: APjAAAXjwnS47czJwAOhaskN08/XQnVtC0DIlLOxcXe+nyzXBYTXTcZI
        1iruTeaN3vTlW5vdDXQnlgXU9oAcehDK9zZaUfAXKDjnbnJqTW3m5TTPyHlIK45/RTg8XY+rGWW
        oTeEFGeOF8SAglV64eA==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr526580wrt.4.1575878278997;
        Sun, 08 Dec 2019 23:57:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqHSDHEtM5pf+Sa1dpYon/n6ij0O9ZXSheDg/fwY+CmGKCWVRBjwIMEqENSz8yDDneu/3GEw==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr526544wrt.4.1575878278533;
        Sun, 08 Dec 2019 23:57:58 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i5sm16091034wrv.34.2019.12.08.23.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 23:57:57 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: [PATCH] selinux: reorder hooks to make runtime disable less broken
Date:   Mon,  9 Dec 2019 08:57:56 +0100
Message-Id: <20191209075756.123157-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: DQYB27IqMWawS2mW1O8kOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
after setting SELINUX=3Ddisabled in /etc/selinux/config and rebooting
(without adding "selinux=3D0" to kernel command-line).

Reordering the SELinux hooks such that those that allocate structures
are removed last seems to prevent these panics. It is very much possible
that this doesn't make the runtime disable completely race-free, but at
least it makes the operation much less fragile.

An alternative (and safer) solution would be to add NULL checks to each
hook, but doing this just to support the runtime disable hack doesn't
seem to be worth the effort...

Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 97 +++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 31 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 116b4d644f68..5075be8eea2a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6864,6 +6864,21 @@ static int selinux_perf_event_write(struct perf_even=
t *event)
 }
 #endif
=20
+/*
+ * IMPORTANT NOTE: When adding new hooks, please be careful to keep this o=
rder:
+ * 1. any hooks that don't belong to (2.) or (3.) below,
+ * 2. hooks that both access structures allocated by other hooks, and allo=
cate
+ *    structures that can be later accessed by other hooks (mostly "clonin=
g"
+ *    hooks),
+ * 3. hooks that only allocate structures that can be later accessed by ot=
her
+ *    hooks ("allocating" hooks).
+ *
+ * Please follow block comment delimiters in the list to keep this order.
+ *
+ * This ordering is needed for SELinux runtime disable to work at least so=
mewhat
+ * safely. Breaking the ordering rules above might lead to NULL pointer de=
refs
+ * when disabling SELinux at runtime.
+ */
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =3D {
 =09LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 =09LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -6886,12 +6901,7 @@ static struct security_hook_list selinux_hooks[] __l=
sm_ro_after_init =3D {
 =09LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 =09LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
=20
-=09LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
-=09LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
-
-=09LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
 =09LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
-=09LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
 =09LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
 =09LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
 =09LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
@@ -6901,12 +6911,10 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
 =09LSM_HOOK_INIT(sb_umount, selinux_umount),
 =09LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
 =09LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
-=09LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
=20
 =09LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 =09LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
=20
-=09LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 =09LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 =09LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
 =09LSM_HOOK_INIT(inode_create, selinux_inode_create),
@@ -6978,21 +6986,15 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
 =09LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 =09LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
=20
-=09LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
-
-=09LSM_HOOK_INIT(msg_queue_alloc_security,
-=09=09=09selinux_msg_queue_alloc_security),
 =09LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 =09LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
 =09LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
 =09LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
=20
-=09LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
 =09LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
 =09LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
 =09LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
=20
-=09LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 =09LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
 =09LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
 =09LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
@@ -7003,13 +7005,11 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
 =09LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
=20
 =09LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
-=09LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
 =09LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
 =09LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
 =09LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx)=
,
 =09LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 =09LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
-=09LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
=20
 =09LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
 =09LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
@@ -7032,7 +7032,6 @@ static struct security_hook_list selinux_hooks[] __ls=
m_ro_after_init =3D {
 =09LSM_HOOK_INIT(socket_getpeersec_stream,
 =09=09=09selinux_socket_getpeersec_stream),
 =09LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram)=
,
-=09LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 =09LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
 =09LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
 =09LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
@@ -7047,7 +7046,6 @@ static struct security_hook_list selinux_hooks[] __ls=
m_ro_after_init =3D {
 =09LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
 =09LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
 =09LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
-=09LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
 =09LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
 =09LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
 =09LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
@@ -7057,17 +7055,11 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
 =09LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 =09LSM_HOOK_INIT(ib_endport_manage_subnet,
 =09=09      selinux_ib_endport_manage_subnet),
-=09LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
 =09LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
 #endif
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-=09LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
-=09LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
 =09LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
 =09LSM_HOOK_INIT(xfrm_policy_delete_security, selinux_xfrm_policy_delete),
-=09LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
-=09LSM_HOOK_INIT(xfrm_state_alloc_acquire,
-=09=09=09selinux_xfrm_state_alloc_acquire),
 =09LSM_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
 =09LSM_HOOK_INIT(xfrm_state_delete_security, selinux_xfrm_state_delete),
 =09LSM_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
@@ -7077,14 +7069,12 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
 #endif
=20
 #ifdef CONFIG_KEYS
-=09LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
 =09LSM_HOOK_INIT(key_free, selinux_key_free),
 =09LSM_HOOK_INIT(key_permission, selinux_key_permission),
 =09LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #endif
=20
 #ifdef CONFIG_AUDIT
-=09LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
 =09LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
 =09LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
 =09LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
@@ -7094,19 +7084,64 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
 =09LSM_HOOK_INIT(bpf, selinux_bpf),
 =09LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 =09LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
-=09LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
-=09LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
 =09LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
 =09LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
=20
 #ifdef CONFIG_PERF_EVENTS
 =09LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
-=09LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
 =09LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
 =09LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
 =09LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
 #endif
+
+=09/*
+=09 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
+=09 */
+=09LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
+=09LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
+=09LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
+=09LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+=09LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
+#endif
+
+=09/*
+=09 * PUT "ALLOCATING" HOOKS HERE
+=09 */
+=09LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
+=09LSM_HOOK_INIT(msg_queue_alloc_security,
+=09=09      selinux_msg_queue_alloc_security),
+=09LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
+=09LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
+=09LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
+=09LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
+=09LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+=09LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
+=09LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
+=09LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
+#ifdef CONFIG_SECURITY_INFINIBAND
+=09LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
+#endif
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+=09LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
+=09LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
+=09LSM_HOOK_INIT(xfrm_state_alloc_acquire,
+=09=09      selinux_xfrm_state_alloc_acquire),
+#endif
+#ifdef CONFIG_KEYS
+=09LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
+#endif
+#ifdef CONFIG_AUDIT
+=09LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
+#endif
+#ifdef CONFIG_BPF_SYSCALL
+=09LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
+=09LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
+#endif
+#ifdef CONFIG_PERF_EVENTS
+=09LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
+#endif
 };
=20
 static __init int selinux_init(void)
@@ -7287,14 +7322,14 @@ int selinux_disable(struct selinux_state *state)
=20
 =09selinux_enabled =3D 0;
=20
+=09/* Unregister netfilter hooks. */
+=09selinux_nf_ip_exit();
+
 =09security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
=20
 =09/* Try to destroy the avc node cache */
 =09avc_disable();
=20
-=09/* Unregister netfilter hooks. */
-=09selinux_nf_ip_exit();
-
 =09/* Unregister selinuxfs. */
 =09exit_sel_fs();
=20
--=20
2.23.0

