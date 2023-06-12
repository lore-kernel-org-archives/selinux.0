Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4C3C7EE25
	for <selinux@archiver.kernel.org>; Mon, 12 Jun 2023 09:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjFLJHF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jun 2023 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjFLJGD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jun 2023 05:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAEA3AB5
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686560517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=72dtxnkr0Tcp6e0NkfTevtUkpERHyeT6uO99VaDbDoQ=;
        b=as0SjfeiI0XcD5nGD7EDYdys/Y+xgi4JYI+u3uJiYwp13RsderQJkHR9q+vEjAxdhU0ykx
        jvVx85Py7GldVCOrQMHwau+mYQHysJtvgoD95kv1Wbc/rRxpZYlUamBCdjRrM55LtEDuWp
        B0joTKhf3Lj5bLQGuZmhFF4nA7UEKac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-yXGMRssDP-msWwk2nntNEQ-1; Mon, 12 Jun 2023 05:01:50 -0400
X-MC-Unique: yXGMRssDP-msWwk2nntNEQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-970e0152da7so476679066b.2
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560508; x=1689152508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72dtxnkr0Tcp6e0NkfTevtUkpERHyeT6uO99VaDbDoQ=;
        b=kYMza+GIDDB9K3Cn/FrtAetv5Oqyvtf0uxUfIMfeJagoa/mE8vFxXz6Vgd8IxAeITf
         O2QeTt+KJJpeg7twKWBVLRrDeTjA3Ure7cir6WbM7JOvS8PuI23UpGoichI6iMvk4RP0
         PL5HPPYOobIsMPG+pHDBsWdXybt024NpPl3Uk8AzoS7LydoktbLX2vXjaVAsBUFUVh+d
         qstvnceWECK//AFo5bW9Iu8LiwnpzbgH5qPrCziInjhVcrLMVtMU5192D2TtNRO14bW0
         XdHquv8km1L7ZWSakqn8fbHRbvmFwjiscU3somlGQzrJUDQGRuepqEv+xh2rE/CLOiQh
         08Jg==
X-Gm-Message-State: AC+VfDzRz9sVVao0rEfQQPS0BtR5LmUwkYTqg9C93Q6VS/YNx6cu6gEs
        xLIkAL/sw/1WKbAaBa7YXwch3JgCWBzc2lJnCnycMRsIAvhaJHYzaM5mJnKGjqUvFHRfiHQ5eP1
        SGmTrb2c+8j65wqklaifihA8WUj4N
X-Received: by 2002:a17:906:6a1e:b0:96f:88a3:3a0e with SMTP id qw30-20020a1709066a1e00b0096f88a33a0emr10582585ejc.0.1686560508418;
        Mon, 12 Jun 2023 02:01:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5R51U0tEAypR2si70K951Oc8CANkcCgu9WA6Y4vojTGx/mOzse41D2W3Y/ucVGvTy4Nh457Q==
X-Received: by 2002:a17:906:6a1e:b0:96f:88a3:3a0e with SMTP id qw30-20020a1709066a1e00b0096f88a33a0emr10582568ejc.0.1686560508048;
        Mon, 12 Jun 2023 02:01:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id dc18-20020a170906c7d200b0096ace7ae086sm4943756ejb.174.2023.06.12.02.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:01:47 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: [PATCH] selinux: introduce an initial SID for early boot processes
Date:   Mon, 12 Jun 2023 11:01:45 +0200
Message-Id: <20230612090145.1059245-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, SELinux doesn't allow distinguishing between kernel threads
and userspace processes that are started before the policy is first
loaded - both get the label corresponding to the kernel SID. The only
way a process that persists from early boot can get a meaningful label
is by doing a voluntary dyntransition or re-executing itself.

Reusing the kernel label for userspace processes is problematic for
several reasons:
1. The kernel is considered to be a privileged domain and generally
   needs to have a wide range of permissions allowed to work correctly,
   which prevents the policy writer from effectively hardening against
   early boot processes that might remain running unintentionally after
   the policy is loaded (they represent a potential extra attack surface
   that should be mitigated).
2. Despite the kernel being treated as a privileged domain, the policy
   writer may want to impose certain special limitations on kernel
   threads that may conflict with the requirements of intentional early
   boot processes. For example, it is a good hardening practice to limit
   what executables the kernel can execute as usermode helpers and to
   confine the resulting usermode helper processes. However, a
   (legitimate) process surviving from early boot may need to execute a
   different set of executables.
3. As currently implemented, overlayfs remembers the security context of
   the process that created an overlayfs mount and uses it to bound
   subsequent operations on files using this context. If an overlayfs
   mount is created before the SELinux policy is loaded, these "mounter"
   checks are made against the kernel context, which may clash with
   restrictions on the kernel domain (see 2.).

To resolve this, introduce a new initial SID (reusing the slot of the
former "init" initial SID) that will be assigned to any userspace
process started before the policy is first loaded. This is easy to do,
as we can simply label any process that goes through the
bprm_creds_for_exec LSM hook with the new init-SID instead of
propagating the kernel SID from the parent.

To provide backwards compatibility for existing policies that are
unaware of this new semantic of the "init" initial SID, introduce a new
policy capability "userspace_initial_context" and set the "init" SID to
the same context as the "kernel" SID unless this capability is set by
the policy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c                      | 27 +++++++++++++++++++
 .../selinux/include/initial_sid_to_string.h   |  2 +-
 security/selinux/include/policycap.h          |  1 +
 security/selinux/include/policycap_names.h    |  3 ++-
 security/selinux/include/security.h           |  7 +++++
 security/selinux/ss/policydb.c                | 27 +++++++++++++++++++
 6 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 99ded60a6b911..dd410ceb178cb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2264,6 +2264,18 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	new_tsec->keycreate_sid = 0;
 	new_tsec->sockcreate_sid = 0;
 
+	/*
+	 * Before policy is loaded, label any task outside kernel space
+	 * as SECINITSID_INIT, so that any userspace tasks surviving from
+	 * early boot end up with a label different from SECINITSID_KERNEL
+	 * (if the policy chooses to set SECINITSID_INIT != SECINITSID_KERNEL).
+	 */
+	if (!selinux_initialized()) {
+		new_tsec->sid = SECINITSID_INIT;
+		new_tsec->exec_sid = 0; /* just in case */
+		return 0;
+	}
+
 	if (old_tsec->exec_sid) {
 		new_tsec->sid = old_tsec->exec_sid;
 		/* Reset exec SID on execve. */
@@ -4480,6 +4492,21 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 	if (sksec->sid == SECINITSID_KERNEL)
 		return 0;
 
+	/*
+	 * Before POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT, sockets that
+	 * inherited the kernel context from early boot used to be skipped
+	 * here, so preserve that behavior unless the capability is set.
+	 *
+	 * By setting the capability the policy signals that it is ready
+	 * for this quirk to be fixed. Note that sockets created by a kernel
+	 * thread or a usermode helper executed without a transition will
+	 * still be skipped in this check regardless of the policycap
+	 * setting.
+	 */
+	if (!selinux_policycap_userspace_initial_context() &&
+	    sksec->sid == SECINITSID_INIT)
+		return 0;
+
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
 	ad.u.net->sk = sk;
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 60820517aa438..6d450669e9c68 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -7,7 +7,7 @@ static const char *const initial_sid_to_string[] = {
 	NULL,
 	"file",
 	NULL,
-	NULL,
+	"init",
 	"any_socket",
 	"port",
 	"netif",
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index f35d3458e71de..c7373e6effe5d 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -12,6 +12,7 @@ enum {
 	POLICYDB_CAP_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index 2a87fc3702b81..28e4c9ee23997 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -13,7 +13,8 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"cgroup_seclabel",
 	"nnp_nosuid_transition",
 	"genfs_seclabel_symlinks",
-	"ioctl_skip_cloexec"
+	"ioctl_skip_cloexec",
+	"userspace_initial_context",
 };
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8746fafeb7789..2d4ca1b9c5913 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -201,6 +201,13 @@ static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
+static inline bool selinux_policycap_userspace_initial_context(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return READ_ONCE(state->policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 97c0074f9312a..240e0fb1d57f9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -863,6 +863,8 @@ void policydb_destroy(struct policydb *p)
 int policydb_load_isids(struct policydb *p, struct sidtab *s)
 {
 	struct ocontext *head, *c;
+	bool secsid_init_supported = ebitmap_get_bit(&p->policycaps,
+						     POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT);
 	int rc;
 
 	rc = sidtab_init(s);
@@ -886,6 +888,13 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		if (!name)
 			continue;
 
+		/*
+		 * Also ignore SECINITSID_INIT if the policy doesn't declare
+		 * support for it
+		 */
+		if (sid == SECINITSID_INIT && !secsid_init_supported)
+			continue;
+
 		rc = sidtab_set_initial(s, sid, &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
@@ -893,6 +902,24 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 			sidtab_destroy(s);
 			return rc;
 		}
+
+		/*
+		 * If the policy doesn't support the "userspace_initial_context"
+		 * capability, set SECINITSID_INIT to the same context as
+		 * SECINITSID_KERNEL. This ensures the same behavior as before
+		 * the reintroduction of SECINITSID_INIT, where all tasks
+		 * started before policy load would initially get the context
+		 * corresponding to SECINITSID_KERNEL.
+		 */
+		if (sid == SECINITSID_KERNEL && !secsid_init_supported) {
+			rc = sidtab_set_initial(s, SECINITSID_INIT, &c->context[0]);
+			if (rc) {
+				pr_err("SELinux:  unable to load initial SID %s.\n",
+				       name);
+				sidtab_destroy(s);
+				return rc;
+			}
+		}
 	}
 	return 0;
 }
-- 
2.40.1

