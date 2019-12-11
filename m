Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD678C2D0C6
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A6F214AF
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9xDn4yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKOIs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:08:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21697 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729664AbfLKOIs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 09:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576073324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H4PTU/VZ6QOrc57J1tK+3fRtILxQ1z8yE1iJ8msPHhw=;
        b=P9xDn4yzyAoXu1MJg7lYis6mzGXmx3sp3CiSk6PHVtpflnF8t/wJIRqNIk/0SgIOmEnCDc
        EKsISafci4sTCiOqYgyy0vVIqDGrz8nUVoeOrnX03uEOWJdLmoyNO8e2KwgUt2gpTx6Dx7
        XFWhUWzRgyT2vHN5BSJyzFypwqRGJF0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-pdgpNMekOvyLj-Qgt_VBDQ-1; Wed, 11 Dec 2019 09:08:43 -0500
Received: by mail-wm1-f72.google.com with SMTP id t4so1170126wmf.2
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2019 06:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GuIH2pantDoiRE9SB/uN49xudXYp2Zj+GzS3BieWPQA=;
        b=Ua/P/DwNSKQ+VI50yeDsxGyeOU/hyIpXtXvkpZwB/QMCvpCpKSkvhLfPDm1FBqtylx
         EFrSneAv/rW5RmQvJCiMsr78eWAbKWzpmLQh5tmIDP5AHfGTg2/zyNUTC7sfotfV2ZEQ
         QBlktCZlB6Oyq10NiooVMNItkculH7OarT0vatvsqp1mqX0QaMI4v1aLyI7IHOz7Vca1
         EntDYWYp1EexdvV7u+sGUIBVnS9Vh8FbWJZaKIltbM0dE+KfGTNUhTGUYz2JLjnxYSuM
         nFQUGkfAeMIxib46C612MpqzNdMO8RKzACSdWyMJ5X0TSxu/0ERDuSPIz/WPlkAsZd7+
         d3NA==
X-Gm-Message-State: APjAAAWzeKjISJopxtYuWmoOEtTkjE6BOsmvb2fewW7ZQmWQt7CCg6bC
        Sp+e62sPWS4FqX3J6K3v2V9DHNx+EzusZcJro1iOrTjAGALb85AkDWMFfstMV725j+8+EP6oHLh
        DASSJznmNySyZfVMAvg==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr4238126wrj.357.1576073317565;
        Wed, 11 Dec 2019 06:08:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOV645Oa5Skcbxwau1tX0UNzZp8d0hi4lM9/cXYgg/NoClQTixaaGiM3KxFNe+aqC0XAbUUg==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr4238044wrj.357.1576073316810;
        Wed, 11 Dec 2019 06:08:36 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n129sm5945315wmb.1.2019.12.11.06.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:08:36 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] LSM: allow an LSM to disable all hooks at once
Date:   Wed, 11 Dec 2019 15:08:33 +0100
Message-Id: <20191211140833.939845-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: pdgpNMekOvyLj-Qgt_VBDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Instead of deleting the hooks from each list one-by-one (which creates
some bad race conditions), allow an LSM to provide a reference to its
"enabled" variable and check this variable before calling the hook.

As a nice side effect, this allows marking the hooks (and other stuff)
__ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
for turning on the runtime disable functionality, to emphasize that this
is only used by SELinux and is meant to be removed in the future.

Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

This is an alternative to [1]. It turned out to be less simple than I
had hoped, but OTOH the hook arrays can now be unconditionally made
__ro_after_init so may be still worth it.

Compile- and boot- tested with SECURITY_SELINUX_DISABLE set to =3Dy and
=3Dn; SELinux enabled. Changes to other LSMs only compile-tested (but
those are trivial).

[1] https://lore.kernel.org/selinux/20191209075756.123157-1-omosnace@redhat=
.com/T/

 include/linux/lsm_hooks.h    | 46 +++++++++----------------------
 security/Kconfig             |  5 ----
 security/apparmor/lsm.c      | 14 ++++++----
 security/commoncap.c         | 11 +++++---
 security/loadpin/loadpin.c   | 10 +++++--
 security/lockdown/lockdown.c | 11 +++++---
 security/safesetid/lsm.c     |  9 +++++--
 security/security.c          | 52 +++++++++++++++++++++---------------
 security/selinux/Kconfig     |  5 ++--
 security/selinux/hooks.c     | 28 ++++++++++++++-----
 security/smack/smack_lsm.c   | 11 +++++---
 security/tomoyo/tomoyo.c     | 13 ++++++---
 security/yama/yama_lsm.c     | 10 +++++--
 13 files changed, 133 insertions(+), 92 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20d8cf194fb7..91b77ebcb822 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -27,7 +27,6 @@
=20
 #include <linux/security.h>
 #include <linux/init.h>
-#include <linux/rculist.h>
=20
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -2086,6 +2085,9 @@ struct security_hook_list {
 =09struct hlist_head=09=09*head;
 =09union security_list_options=09hook;
 =09char=09=09=09=09*lsm;
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+=09const int=09=09=09*enabled;
+#endif
 } __randomize_layout;
=20
 /*
@@ -2112,8 +2114,16 @@ struct lsm_blob_sizes {
 extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
=20
-extern void security_add_hooks(struct security_hook_list *hooks, int count=
,
-=09=09=09=09char *lsm);
+struct security_hook_array {
+=09struct security_hook_list *hooks;
+=09int count;
+=09char *lsm;
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+=09const int *enabled;
+#endif
+};
+
+extern void security_add_hook_array(const struct security_hook_array *arra=
y);
=20
 #define LSM_FLAG_LEGACY_MAJOR=09BIT(0)
 #define LSM_FLAG_EXCLUSIVE=09BIT(1)
@@ -2145,36 +2155,6 @@ extern struct lsm_info __start_early_lsm_info[], __e=
nd_early_lsm_info[];
 =09=09__used __section(.early_lsm_info.init)=09=09=09\
 =09=09__aligned(sizeof(unsigned long))
=20
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
-/*
- * Assuring the safety of deleting a security module is up to
- * the security module involved. This may entail ordering the
- * module's hook list in a particular way, refusing to disable
- * the module once a policy is loaded or any number of other
- * actions better imagined than described.
- *
- * The name of the configuration option reflects the only module
- * that currently uses the mechanism. Any developer who thinks
- * disabling their module is a good idea needs to be at least as
- * careful as the SELinux team.
- */
-static inline void security_delete_hooks(struct security_hook_list *hooks,
-=09=09=09=09=09=09int count)
-{
-=09int i;
-
-=09for (i =3D 0; i < count; i++)
-=09=09hlist_del_rcu(&hooks[i].list);
-}
-#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
-
-/* Currently required to handle SELinux runtime hook disable. */
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define __lsm_ro_after_init
-#else
-#define __lsm_ro_after_init=09__ro_after_init
-#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
-
 extern int lsm_inode_alloc(struct inode *inode);
=20
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 2a1a2d396228..456764990a13 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -32,11 +32,6 @@ config SECURITY
=20
 =09  If you are unsure how to answer this question, answer N.
=20
-config SECURITY_WRITABLE_HOOKS
-=09depends on SECURITY
-=09bool
-=09default n
-
 config SECURITYFS
 =09bool "Enable the securityfs filesystem"
 =09help
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b621ad74f54a..a27f48670b37 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1158,13 +1158,13 @@ static int apparmor_inet_conn_request(struct sock *=
sk, struct sk_buff *skb,
 /*
  * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
  */
-struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init =3D {
 =09.lbs_cred =3D sizeof(struct aa_task_ctx *),
 =09.lbs_file =3D sizeof(struct aa_file_ctx),
 =09.lbs_task =3D sizeof(struct aa_task_ctx),
 };
=20
-static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init =3D =
{
+static struct security_hook_list apparmor_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 =09LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
 =09LSM_HOOK_INIT(capget, apparmor_capget),
@@ -1368,7 +1368,7 @@ static const struct kernel_param_ops param_ops_aaintb=
ool =3D {
 =09.get =3D param_get_aaintbool
 };
 /* Boot time disable flag */
-static int apparmor_enabled __lsm_ro_after_init =3D 1;
+static int apparmor_enabled __ro_after_init =3D 1;
 module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
=20
 static int __init apparmor_enabled_setup(char *str)
@@ -1829,6 +1829,11 @@ __initcall(apparmor_nf_ip_init);
=20
 static int __init apparmor_init(void)
 {
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D apparmor_hooks,
+=09=09.count =3D ARRAY_SIZE(apparmor_hooks),
+=09=09.lsm =3D "apparmor",
+=09};
 =09int error;
=20
 =09aa_secids_init();
@@ -1864,8 +1869,7 @@ static int __init apparmor_init(void)
 =09=09aa_free_root_ns();
 =09=09goto buffers_out;
 =09}
-=09security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-=09=09=09=09"apparmor");
+=09security_add_hook_array(&hook_array);
=20
 =09/* Report that AppArmor successfully initialized */
 =09apparmor_initialized =3D 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..6e9f4b6b6b1d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long re=
qprot,
=20
 #ifdef CONFIG_SECURITY
=20
-static struct security_hook_list capability_hooks[] __lsm_ro_after_init =
=3D {
+static struct security_hook_list capability_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(capable, cap_capable),
 =09LSM_HOOK_INIT(settime, cap_settime),
 =09LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
@@ -1362,8 +1362,13 @@ static struct security_hook_list capability_hooks[] =
__lsm_ro_after_init =3D {
=20
 static int __init capability_init(void)
 {
-=09security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-=09=09=09=09"capability");
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D capability_hooks,
+=09=09.count =3D ARRAY_SIZE(capability_hooks),
+=09=09.lsm =3D "capability",
+=09};
+
+=09security_add_hook_array(&hook_array);
 =09return 0;
 }
=20
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ee5cb944f4ad..5fadd4969d90 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -180,7 +180,7 @@ static int loadpin_load_data(enum kernel_load_data_id i=
d)
 =09return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
 }
=20
-static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list loadpin_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 =09LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 =09LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
@@ -224,10 +224,16 @@ static void __init parse_exclude(void)
=20
 static int __init loadpin_init(void)
 {
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D loadpin_hooks,
+=09=09.count =3D ARRAY_SIZE(loadpin_hooks),
+=09=09.lsm =3D "loadpin",
+=09};
+
 =09pr_info("ready to pin (currently %senforcing)\n",
 =09=09enforce ? "" : "not ");
 =09parse_exclude();
-=09security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin")=
;
+=09security_add_hook_array(&hook_array);
 =09return 0;
 }
=20
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eb..bcfa0ff4ee63 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -71,19 +71,24 @@ static int lockdown_is_locked_down(enum lockdown_reason=
 what)
 =09return 0;
 }
=20
-static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init =3D =
{
+static struct security_hook_list lockdown_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
=20
 static int __init lockdown_lsm_init(void)
 {
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D lockdown_hooks,
+=09=09.count =3D ARRAY_SIZE(lockdown_hooks),
+=09=09.lsm =3D "lockdown",
+=09};
+
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
 =09lock_kernel_down("Kernel configuration", LOCKDOWN_INTEGRITY_MAX);
 #elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
 =09lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
-=09security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-=09=09=09   "lockdown");
+=09security_add_hook_array(&hook_array);
 =09return 0;
 }
=20
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 7760019ad35d..4e36e53f033d 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -156,8 +156,13 @@ static struct security_hook_list safesetid_security_ho=
oks[] =3D {
=20
 static int __init safesetid_security_init(void)
 {
-=09security_add_hooks(safesetid_security_hooks,
-=09=09=09   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D safesetid_security_hooks,
+=09=09.count =3D ARRAY_SIZE(safesetid_security_hooks),
+=09=09.lsm =3D "safesetid",
+=09};
+
+=09security_add_hook_array(&hook_array);
=20
 =09/* Report that SafeSetID successfully initialized */
 =09safesetid_initialized =3D 1;
diff --git a/security/security.c b/security/security.c
index 2b5473d92416..a5dd348bd37e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -68,14 +68,14 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIA=
LITY_MAX+1] =3D {
 =09[LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
 };
=20
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+struct security_hook_heads security_hook_heads __ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
=20
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
=20
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+static struct lsm_blob_sizes blob_sizes __ro_after_init;
=20
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -467,20 +467,20 @@ static int lsm_append(const char *new, char **result)
=20
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @array: the struct describing hooks to add
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count=
,
-=09=09=09=09char *lsm)
+void __init security_add_hook_array(const struct security_hook_array *arra=
y)
 {
 =09int i;
=20
-=09for (i =3D 0; i < count; i++) {
-=09=09hooks[i].lsm =3D lsm;
-=09=09hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+=09for (i =3D 0; i < array->count; i++) {
+=09=09array->hooks[i].lsm =3D array->lsm;
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+=09=09array->hooks[i].enabled =3D array->enabled;
+#endif
+=09=09hlist_add_tail_rcu(&array->hooks[i].list, array->hooks[i].head);
 =09}
=20
 =09/*
@@ -488,7 +488,7 @@ void __init security_add_hooks(struct security_hook_lis=
t *hooks, int count,
 =09 * and fix this up afterwards.
 =09 */
 =09if (slab_is_available()) {
-=09=09if (lsm_append(lsm, &lsm_names) < 0)
+=09=09if (lsm_append(array->lsm, &lsm_names) < 0)
 =09=09=09panic("%s - Cannot get early memory.\n", __func__);
 =09}
 }
@@ -679,11 +679,22 @@ static void __init lsm_early_task(struct task_struct =
*task)
  *=09This is a hook that returns a value.
  */
=20
+#define for_each_hook(p, func) \
+=09hlist_for_each_entry(p, &security_hook_heads.func, list)
+
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+#define for_each_enabled_hook(p, func) \
+=09for_each_hook(p, func) \
+=09=09if (!(p)->enabled || READ_ONCE(*(p)->enabled))
+#else
+#define for_each_enabled_hook for_each_hook
+#endif
+
 #define call_void_hook(FUNC, ...)=09=09=09=09\
 =09do {=09=09=09=09=09=09=09\
 =09=09struct security_hook_list *P;=09=09=09\
 =09=09=09=09=09=09=09=09\
-=09=09hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
+=09=09for_each_enabled_hook(P, FUNC)=09=09=09\
 =09=09=09P->hook.FUNC(__VA_ARGS__);=09=09\
 =09} while (0)
=20
@@ -692,7 +703,7 @@ static void __init lsm_early_task(struct task_struct *t=
ask)
 =09do {=09=09=09=09=09=09=09\
 =09=09struct security_hook_list *P;=09=09=09\
 =09=09=09=09=09=09=09=09\
-=09=09hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+=09=09for_each_enabled_hook(P, FUNC) {=09=09\
 =09=09=09RC =3D P->hook.FUNC(__VA_ARGS__);=09=09\
 =09=09=09if (RC !=3D 0)=09=09=09=09\
 =09=09=09=09break;=09=09=09=09\
@@ -795,7 +806,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, =
long pages)
 =09 * agree that it should be set it will. If any module
 =09 * thinks it should not be set it won't.
 =09 */
-=09hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+=09for_each_enabled_hook(hp, vm_enough_memory) {
 =09=09rc =3D hp->hook.vm_enough_memory(mm, pages);
 =09=09if (rc <=3D 0) {
 =09=09=09cap_sys_admin =3D 0;
@@ -1343,7 +1354,7 @@ int security_inode_getsecurity(struct inode *inode, c=
onst char *name, void **buf
 =09/*
 =09 * Only one module will provide an attribute with a given name.
 =09 */
-=09hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) =
{
+=09for_each_enabled_hook(hp, inode_getsecurity) {
 =09=09rc =3D hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 =09=09if (rc !=3D -EOPNOTSUPP)
 =09=09=09return rc;
@@ -1361,7 +1372,7 @@ int security_inode_setsecurity(struct inode *inode, c=
onst char *name, const void
 =09/*
 =09 * Only one module will provide an attribute with a given name.
 =09 */
-=09hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) =
{
+=09for_each_enabled_hook(hp, inode_setsecurity) {
 =09=09rc =3D hp->hook.inode_setsecurity(inode, name, value, size,
 =09=09=09=09=09=09=09=09flags);
 =09=09if (rc !=3D -EOPNOTSUPP)
@@ -1744,7 +1755,7 @@ int security_task_prctl(int option, unsigned long arg=
2, unsigned long arg3,
 =09int rc =3D -ENOSYS;
 =09struct security_hook_list *hp;
=20
-=09hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+=09for_each_enabled_hook(hp, task_prctl) {
 =09=09thisrc =3D hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 =09=09if (thisrc !=3D -ENOSYS) {
 =09=09=09rc =3D thisrc;
@@ -1913,7 +1924,7 @@ int security_getprocattr(struct task_struct *p, const=
 char *lsm, char *name,
 {
 =09struct security_hook_list *hp;
=20
-=09hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
+=09for_each_enabled_hook(hp, getprocattr) {
 =09=09if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
 =09=09=09continue;
 =09=09return hp->hook.getprocattr(p, name, value);
@@ -1926,7 +1937,7 @@ int security_setprocattr(const char *lsm, const char =
*name, void *value,
 {
 =09struct security_hook_list *hp;
=20
-=09hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
+=09for_each_enabled_hook(hp, setprocattr) {
 =09=09if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
 =09=09=09continue;
 =09=09return hp->hook.setprocattr(name, value, size);
@@ -2327,8 +2338,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_st=
ate *x,
 =09 * For speed optimization, we explicitly break the loop rather than
 =09 * using the macro
 =09 */
-=09hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match=
,
-=09=09=09=09list) {
+=09for_each_enabled_hook(hp, xfrm_state_pol_flow_match) {
 =09=09rc =3D hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 =09=09break;
 =09}
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 996d35d950f7..f64290de1f8a 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -26,7 +26,6 @@ config SECURITY_SELINUX_BOOTPARAM
 config SECURITY_SELINUX_DISABLE
 =09bool "NSA SELinux runtime disable"
 =09depends on SECURITY_SELINUX
-=09select SECURITY_WRITABLE_HOOKS
 =09default n
 =09help
 =09  This option enables writing to a selinuxfs node 'disable', which
@@ -37,8 +36,8 @@ config SECURITY_SELINUX_DISABLE
 =09  portability across platforms where boot parameters are difficult
 =09  to employ.
=20
-=09  NOTE: selecting this option will disable the '__ro_after_init'
-=09  kernel hardening feature for security hooks.   Please consider
+=09  NOTE: Selecting this option might cause memory leaks and random
+=09  crashes when the runtime disable is used. Please consider
 =09  using the selinux=3D0 boot parameter instead of enabling this
 =09  option.
=20
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 47626342b6e5..b76acd98dda5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -123,7 +123,13 @@ __setup("enforcing=3D", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
=20
-int selinux_enabled __lsm_ro_after_init =3D 1;
+/* Currently required to handle SELinux runtime hook disable. */
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+int selinux_enabled =3D 1;
+#else
+int selinux_enabled __ro_after_init =3D 1;
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
+
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 static int __init selinux_enabled_setup(char *str)
 {
@@ -6827,7 +6833,7 @@ static int selinux_lockdown(enum lockdown_reason what=
)
 =09=09=09=09    LOCKDOWN__CONFIDENTIALITY, &ad);
 }
=20
-struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
 =09.lbs_cred =3D sizeof(struct task_security_struct),
 =09.lbs_file =3D sizeof(struct file_security_struct),
 =09.lbs_inode =3D sizeof(struct inode_security_struct),
@@ -6896,7 +6902,7 @@ static int selinux_perf_event_write(struct perf_event=
 *event)
 }
 #endif
=20
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list selinux_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 =09LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 =09LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
@@ -7145,6 +7151,15 @@ static struct security_hook_list selinux_hooks[] __l=
sm_ro_after_init =3D {
=20
 static __init int selinux_init(void)
 {
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D selinux_hooks,
+=09=09.count =3D ARRAY_SIZE(selinux_hooks),
+=09=09.lsm =3D "selinux",
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+=09=09.enabled =3D &selinux_enabled,
+#endif
+=09};
+
 =09pr_info("SELinux:  Initializing.\n");
=20
 =09memset(&selinux_state, 0, sizeof(selinux_state));
@@ -7166,7 +7181,7 @@ static __init int selinux_init(void)
=20
 =09hashtab_cache_init();
=20
-=09security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux")=
;
+=09security_add_hook_array(&hook_array);
=20
 =09if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET)=
)
 =09=09panic("SELinux: Unable to register AVC netcache callback\n");
@@ -7319,9 +7334,10 @@ int selinux_disable(struct selinux_state *state)
=20
 =09pr_info("SELinux:  Disabled at runtime.\n");
=20
-=09selinux_enabled =3D 0;
+=09/* Unregister netfilter hooks. */
+=09selinux_nf_ip_exit();
=20
-=09security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
+=09WRITE_ONCE(selinux_enabled, 0);
=20
 =09/* Try to destroy the avc node cache */
 =09avc_disable();
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ecea41ce919b..c21dda12bc4b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4583,7 +4583,7 @@ static int smack_dentry_create_files_as(struct dentry=
 *dentry, int mode,
 =09return 0;
 }
=20
-struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes smack_blob_sizes __ro_after_init =3D {
 =09.lbs_cred =3D sizeof(struct task_smack),
 =09.lbs_file =3D sizeof(struct smack_known *),
 =09.lbs_inode =3D sizeof(struct inode_smack),
@@ -4591,7 +4591,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after=
_init =3D {
 =09.lbs_msg_msg =3D sizeof(struct smack_known *),
 };
=20
-static struct security_hook_list smack_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list smack_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 =09LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 =09LSM_HOOK_INIT(syslog, smack_syslog),
@@ -4765,6 +4765,11 @@ static __init void init_smack_known_list(void)
  */
 static __init int smack_init(void)
 {
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D smack_hooks,
+=09=09.count =3D ARRAY_SIZE(smack_hooks),
+=09=09.lsm =3D "smack",
+=09};
 =09struct cred *cred =3D (struct cred *) current->cred;
 =09struct task_smack *tsp;
=20
@@ -4787,7 +4792,7 @@ static __init int smack_init(void)
 =09/*
 =09 * Register with LSM
 =09 */
-=09security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+=09security_add_hook_array(&hook_array);
 =09smack_enabled =3D 1;
=20
 =09pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92ec941a..a4075379246d 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -486,7 +486,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, s=
truct msghdr *msg,
 =09return tomoyo_socket_sendmsg_permission(sock, msg, size);
 }
=20
-struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init =3D {
+struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init =3D {
 =09.lbs_task =3D sizeof(struct tomoyo_task),
 };
=20
@@ -533,7 +533,7 @@ static void tomoyo_task_free(struct task_struct *task)
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
  */
-static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list tomoyo_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
 =09LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
 =09LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
@@ -569,7 +569,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_r=
o_after_init =3D {
 /* Lock for GC. */
 DEFINE_SRCU(tomoyo_ss);
=20
-int tomoyo_enabled __lsm_ro_after_init =3D 1;
+int tomoyo_enabled __ro_after_init =3D 1;
=20
 /**
  * tomoyo_init - Register TOMOYO Linux as a LSM module.
@@ -578,10 +578,15 @@ int tomoyo_enabled __lsm_ro_after_init =3D 1;
  */
 static int __init tomoyo_init(void)
 {
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D tomoyo_hooks,
+=09=09.count =3D ARRAY_SIZE(tomoyo_hooks),
+=09=09.lsm =3D "tomoyo",
+=09};
 =09struct tomoyo_task *s =3D tomoyo_task(current);
=20
 =09/* register ourselves with the security framework */
-=09security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+=09security_add_hook_array(&hook_array);
 =09pr_info("TOMOYO Linux initialized\n");
 =09s->domain_info =3D &tomoyo_kernel_domain;
 =09atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 94dc346370b1..ed752f6eafcf 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,7 +421,7 @@ static int yama_ptrace_traceme(struct task_struct *pare=
nt)
 =09return rc;
 }
=20
-static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D {
+static struct security_hook_list yama_hooks[] __ro_after_init =3D {
 =09LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 =09LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
 =09LSM_HOOK_INIT(task_prctl, yama_task_prctl),
@@ -476,8 +476,14 @@ static inline void yama_init_sysctl(void) { }
=20
 static int __init yama_init(void)
 {
+=09struct security_hook_array hook_array =3D {
+=09=09.hooks =3D yama_hooks,
+=09=09.count =3D ARRAY_SIZE(yama_hooks),
+=09=09.lsm =3D "yama",
+=09};
+
 =09pr_info("Yama: becoming mindful.\n");
-=09security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+=09security_add_hook_array(&hook_array);
 =09yama_init_sysctl();
 =09return 0;
 }
--=20
2.23.0

