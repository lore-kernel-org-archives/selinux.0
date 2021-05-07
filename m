Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD1CC433ED
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024BB61443
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhEGLl4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 07:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234181AbhEGLlz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 07:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620387655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LspZM+MkqQ3DiGR0xkhvj8Q5WxoRLe1cqgKeSBtf40g=;
        b=Rthh9stEJvOgRNTppEU1WkjZbVn/gb7P0DEUUI6z76ytf/DdpzJbcprIaipUh9e1GGLQue
        4TtPq/AGM4W8JpEXFsgsduiZFSoW0bao9wvP23O1Xxh5aXHvQSNq615zwwK625BANUOAjZ
        7v8TFkWS8OIE424WGJUTNO+K6PMdMBY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-48s5xCMgPie7evYIkovMVw-1; Fri, 07 May 2021 07:40:54 -0400
X-MC-Unique: 48s5xCMgPie7evYIkovMVw-1
Received: by mail-ed1-f71.google.com with SMTP id r19-20020a05640251d3b02903888eb31cafso4304008edd.13
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 04:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LspZM+MkqQ3DiGR0xkhvj8Q5WxoRLe1cqgKeSBtf40g=;
        b=PIMK3CysA62+Jly6tMY8frRUR1RWND0cZ+6/hhj1pcGxsQpPXEC4Oe7dxJ2KZ8gZEx
         6TXYWsRzTMhPZRSNoUwDbh61GvPzrU9COkM4TrTukkgCxs628qFkHDvZXBTie7kigh37
         Lj8A1cX/b2vLG3ptB8CgtOZrfIvMH0Sjyh4AEQkmPIV0JKhsrKpdNh6ZYddJkewgekqg
         Dfqsz7WCthc98FWq2CIqahG9J6yfjS8O6bPLpuShtGV4jTEjWnwgfOyYThyxtljz0dOQ
         7A/RGUUNmOBCYWG/8FDfFWEbfaEljDDyPutGlyO0lLZe22/MjdPrsllonUyLQY8sCOSA
         AGwg==
X-Gm-Message-State: AOAM530mntqAiyPjH4KKyzxIPJ3Zv2REWC48cq6wXyL2Frc6VjKApyzh
        +sIYyz4YPmyqjvvArRNg66R1p/nLV7OAVoyT29UrPGIoNTIKzKL8VoMJiWkg7SMG/9WtYoTwlZL
        nbIlO4PbYid4egpo5NQ==
X-Received: by 2002:a17:906:a103:: with SMTP id t3mr9641309ejy.334.1620387653029;
        Fri, 07 May 2021 04:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywdR6MRssJqrq0gs7f9Bj2ljf47LHUQteWxO5byrxHZ0BFN+xLVaNVcjuKxvdjBE/ZCBSWWw==
X-Received: by 2002:a17:906:a103:: with SMTP id t3mr9641289ejy.334.1620387652773;
        Fri, 07 May 2021 04:40:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id l26sm3349312ejz.27.2021.05.07.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:40:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lockdown,selinux: fix bogus SELinux lockdown permission checks
Date:   Fri,  7 May 2021 13:40:48 +0200
Message-Id: <20210507114048.138933-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
lockdown") added an implementation of the locked_down LSM hook to
SELinux, with the aim to restrict which domains are allowed to perform
operations that would breach lockdown.

However, in several places the security_locked_down() hook is called in
situations where the current task isn't doing any action that would
directly breach lockdown, leading to SELinux checks that are basically
bogus.

Since in most of these situations converting the callers such that
security_locked_down() is called in a context where the current task
would be meaningful for SELinux is impossible or very non-trivial (and
could lead to TOCTOU issues for the classic Lockdown LSM
implementation), fix this by adding a separate hook
security_locked_down_globally() that is to be used in such situations
and convert all these problematic callers to call this hook instead. The
new hook is then left unimplemented in SELinux and in Lockdown LSM it is
backed by the same implementation as the locked_down hook.

The callers migrated to the new hook are:
1. arch/powerpc/xmon/xmon.c
     Here the hook seems to be called from non-task context and is only
     used for redacting some sensitive values from output sent to
     userspace.
2. fs/tracefs/inode.c:tracefs_create_file()
     Here the call is used to prevent creating new tracefs entries when
     the kernel is locked down. Assumes that locking down is one-way -
     i.e. if the hook returns non-zero once, it will never return zero
     again, thus no point in creating these files.
3. kernel/trace/bpf_trace.c:bpf_probe_read_kernel{,_str}_common()
     Called when a BPF program calls a helper that could leak kernel
     memory. The task context is not relevant here, since the program
     may very well be run in the context of a different task than the
     consumer of the data.
     See: https://bugzilla.redhat.com/show_bug.cgi?id=1955585
4. net/xfrm/xfrm_user.c:copy_to_user_*()
     Here a cryptographic secret is redacted based on the value returned
     from the hook. There are two possible actions that may lead here:
     a) A netlink message XFRM_MSG_GETSA with NLM_F_DUMP set - here the
        task context is relevant, since the dumped data is sent back to
        the current task.
     b) When deleting an SA via XFRM_MSG_DELSA, the dumped SAs are
        broadcasted to tasks subscribed to XFRM events - here the
        SELinux check is not meningful as the current task's creds do
        not represent the tasks that could potentially see the secret.
     It really doesn't seem worth it to try to preserve the check in the
     a) case, since the eventual leak can be circumvented anyway via b),
     plus there is no way for the task to indicate that it doesn't care
     about the actual key value, so the check could generate a lot of
     noise.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 arch/powerpc/xmon/xmon.c      | 4 ++--
 fs/tracefs/inode.c            | 2 +-
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/security.h      | 5 +++++
 kernel/trace/bpf_trace.c      | 4 ++--
 net/xfrm/xfrm_user.c          | 2 +-
 security/lockdown/lockdown.c  | 1 +
 security/security.c           | 6 ++++++
 8 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3fe37495f63d..a4bad825d424 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -298,7 +298,7 @@ static bool xmon_is_locked_down(void)
 	static bool lockdown;
 
 	if (!lockdown) {
-		lockdown = !!security_locked_down(LOCKDOWN_XMON_RW);
+		lockdown = !!security_locked_down_globally(LOCKDOWN_XMON_RW);
 		if (lockdown) {
 			printf("xmon: Disabled due to kernel lockdown\n");
 			xmon_is_ro = true;
@@ -306,7 +306,7 @@ static bool xmon_is_locked_down(void)
 	}
 
 	if (!xmon_is_ro) {
-		xmon_is_ro = !!security_locked_down(LOCKDOWN_XMON_WR);
+		xmon_is_ro = !!security_locked_down_globally(LOCKDOWN_XMON_WR);
 		if (xmon_is_ro)
 			printf("xmon: Read-only due to kernel lockdown\n");
 	}
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 4b83cbded559..07241435efec 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -396,7 +396,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	struct dentry *dentry;
 	struct inode *inode;
 
-	if (security_locked_down(LOCKDOWN_TRACEFS))
+	if (security_locked_down_globally(LOCKDOWN_TRACEFS))
 		return NULL;
 
 	if (!(mode & S_IFMT))
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 477a597db013..d6e2a6b59277 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -390,6 +390,7 @@ LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *aux)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
+LSM_HOOK(int, 0, locked_down_globally, enum lockdown_reason what)
 
 #ifdef CONFIG_PERF_EVENTS
 LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
diff --git a/include/linux/security.h b/include/linux/security.h
index 8aeebd6646dc..e683dee84f46 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -468,6 +468,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int security_locked_down_globally(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1329,6 +1330,10 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int security_locked_down_globally(enum lockdown_reason what)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0c45d923f0f..f43bca95b261 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -215,7 +215,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 static __always_inline int
 bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
-	int ret = security_locked_down(LOCKDOWN_BPF_READ);
+	int ret = security_locked_down_globally(LOCKDOWN_BPF_READ);
 
 	if (unlikely(ret < 0))
 		goto fail;
@@ -246,7 +246,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_proto = {
 static __always_inline int
 bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr)
 {
-	int ret = security_locked_down(LOCKDOWN_BPF_READ);
+	int ret = security_locked_down_globally(LOCKDOWN_BPF_READ);
 
 	if (unlikely(ret < 0))
 		goto fail;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 5a0ef4361e43..5a56f74262d8 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -851,7 +851,7 @@ static int copy_user_offload(struct xfrm_state_offload *xso, struct sk_buff *skb
 static bool xfrm_redact(void)
 {
 	return IS_ENABLED(CONFIG_SECURITY) &&
-		security_locked_down(LOCKDOWN_XFRM_SECRET);
+		security_locked_down_globally(LOCKDOWN_XFRM_SECRET);
 }
 
 static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 87cbdc64d272..4ac172eaa4b7 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -73,6 +73,7 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
 
 static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
+	LSM_HOOK_INIT(locked_down_globally, lockdown_is_locked_down),
 };
 
 static int __init lockdown_lsm_init(void)
diff --git a/security/security.c b/security/security.c
index 5ac96b16f8fa..b9b990681ae9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2547,6 +2547,12 @@ int security_locked_down(enum lockdown_reason what)
 }
 EXPORT_SYMBOL(security_locked_down);
 
+int security_locked_down_globally(enum lockdown_reason what)
+{
+	return call_int_hook(locked_down_globally, 0, what);
+}
+EXPORT_SYMBOL(security_locked_down_globally);
+
 #ifdef CONFIG_PERF_EVENTS
 int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
-- 
2.31.1

