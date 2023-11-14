Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA7CC4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 15:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjKNPv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 10:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjKNPv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 10:51:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BCD181
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699977081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9ylFt0JLW6RnLoqJhnuWTe9qhV44vTUMh/82AGTPVJY=;
        b=Q5zu30148lv1N+D05HMumny66PoIy0DQq7NrJoQU/7FXRMLjcqTPnajnTjn/vpq0ijYfu5
        OmEdBA0IIkUINW497F+kdZS1kwzL0KPxWipP6I/MSikzYmO0C5XTSzUZ/PK/iMWOnT9tRy
        9YA0w3eMSF2Oxv+ZGVkPVQOr7RtnqQU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-EdU3_t0PMLKnQ_FW7f1tog-1; Tue, 14 Nov 2023 10:51:19 -0500
X-MC-Unique: EdU3_t0PMLKnQ_FW7f1tog-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50985abb593so6025743e87.3
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 07:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977078; x=1700581878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ylFt0JLW6RnLoqJhnuWTe9qhV44vTUMh/82AGTPVJY=;
        b=lF3QGa3sJQ8kElgG7S7iocg3s0UuvJ/fNydAV4ODUfF54PFh4V7TIcpSbhVJGsjycM
         i4Clg1OpKc53/8JG4o4Bq978wGdsieQ/DoBu/yBoJ/iYUSfrTVCZep1eiJjuKvBiKIXj
         g2zyPotoAAIen0qfvFbBG8n5zPhf5GfxugL9e1zxzfxiKkLy5syWqMUHl8ytjDaa1lgb
         AGDzRVDIfgUfOZvAkltuS4GhuuQFBFrxxsrG0wT1bYotFxFMca6Lu25MloL6IGWNMlhB
         Uo/g7FydseY2G+NT1sfwOz2pe48IEExpGv8xP42P1R3J1xgKEZbPj1SJTh/2n93/9hYv
         fG8g==
X-Gm-Message-State: AOJu0YzMQOoQZnJ4ciyjlqGKHNFz3joT/0nOpSHPIMf1MwcQlsWIRas3
        JjJMT/N+/sUdfonWhjPGo/X2CNFm9I2vAeGEf95xA1uCrOyubmy78XG72D3vrGI+BT2j6I2wPEi
        BbQkJEFvz1SMASLWz5w==
X-Received: by 2002:a05:6512:15a2:b0:507:9ff6:75b6 with SMTP id bp34-20020a05651215a200b005079ff675b6mr9799862lfb.50.1699977078069;
        Tue, 14 Nov 2023 07:51:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHtLuqagJGRthkkG4PhTbBgCJqdyFn+wbkwN/LqUGUoXzP4Stg2KC8EO+w23xE59KQnQK9TA==
X-Received: by 2002:a05:6512:15a2:b0:507:9ff6:75b6 with SMTP id bp34-20020a05651215a200b005079ff675b6mr9799834lfb.50.1699977077669;
        Tue, 14 Nov 2023 07:51:17 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id dm20-20020a05640222d400b00537666d307csm5261696edb.32.2023.11.14.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:51:17 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3] selinux: introduce an initial SID for early boot processes
Date:   Tue, 14 Nov 2023 16:51:16 +0100
Message-ID: <20231114155116.462883-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Another small backwards compatibility measure is needed in
security_sid_to_context_core() for before the initial SELinux policy
load - see the code comment for explanation.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

The last version of this patch has been applied [1] and then reverted
[2] because of a regression breaking userspace before the policy is
loaded [3]. This version fixes it using Christian's suggestion [4].

Paul's suggestion from [5] isn't really viable because both existing
users of security_get_initial_sid_context() need the current behavior.

As for security_context_to_sid_core(), it doesn't seem desirable to
remove the ability to e.g. write "init" to /proc/self/attr/exec to
get the exec_sid to SECINITSID_INIT as that shouldn't affect backwards
compatibility. However, the caveat is that after setting something to
SECINITSID_INIT via "init", a query for the string form of the context
will return the "fake" value "kernel" instead of the expected "init".

[1] 5b0eea835d4e ("selinux: introduce an initial SID for early boot processes")
[2] 817199e006e5 ("selinux: revert SECINITSID_INIT support")
[3] https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse/
[4] https://lore.kernel.org/selinux/CAJ2a_DdZHFTHiRu5+ZENAwUq1Cor-jVoE9qdhb2x5uSej-MaRA@mail.gmail.com/
[5] https://lore.kernel.org/selinux/CAHC9VhQVQv78Xr1bDoJcuT5s441Lvc8AanMvMh8KXG-PuPTVAQ@mail.gmail.com/

 security/selinux/hooks.c                      | 28 +++++++++++++++++++
 .../selinux/include/initial_sid_to_string.h   |  2 +-
 security/selinux/include/policycap.h          |  1 +
 security/selinux/include/policycap_names.h    |  1 +
 security/selinux/include/security.h           |  6 ++++
 security/selinux/ss/policydb.c                | 27 ++++++++++++++++++
 security/selinux/ss/services.c                | 13 ++++++++-
 7 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 10350534de6d6..522ade540aac0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2315,6 +2315,19 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
+		/* also clear the exec_sid just in case */
+		new_tsec->exec_sid = 0;
+		return 0;
+	}
+
 	if (old_tsec->exec_sid) {
 		new_tsec->sid = old_tsec->exec_sid;
 		/* Reset exec SID on execve. */
@@ -4547,6 +4560,21 @@ static int sock_has_perm(struct sock *sk, u32 perms)
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
 	ad_net_init_from_sk(&ad, &net, sk);
 
 	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index ecc6e74fa09bd..5e5f0993dac2f 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -10,7 +10,7 @@ static const char *const initial_sid_to_string[] = {
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
index 49bbe120d1735..28e4c9ee23997 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -14,6 +14,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"nnp_nosuid_transition",
 	"genfs_seclabel_symlinks",
 	"ioctl_skip_cloexec",
+	"userspace_initial_context",
 };
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a9de89af8fdc5..074d439fe9ad5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -189,6 +189,12 @@ static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 		selinux_state.policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
+static inline bool selinux_policycap_userspace_initial_context(void)
+{
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 595a435ea9c85..0530346351e59 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -864,6 +864,8 @@ void policydb_destroy(struct policydb *p)
 int policydb_load_isids(struct policydb *p, struct sidtab *s)
 {
 	struct ocontext *head, *c;
+	bool isid_init_supported = ebitmap_get_bit(&p->policycaps,
+						   POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT);
 	int rc;
 
 	rc = sidtab_init(s);
@@ -887,6 +889,13 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		if (!name)
 			continue;
 
+		/*
+		 * Also ignore SECINITSID_INIT if the policy doesn't declare
+		 * support for it
+		 */
+		if (sid == SECINITSID_INIT && !isid_init_supported)
+			continue;
+
 		rc = sidtab_set_initial(s, sid, &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
@@ -894,6 +903,24 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
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
+		if (sid == SECINITSID_KERNEL && !isid_init_supported) {
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
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1eeffc66ea7d7..344c598fc1e74 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1322,8 +1322,19 @@ static int security_sid_to_context_core(u32 sid, char **scontext,
 	if (!selinux_initialized()) {
 		if (sid <= SECINITSID_NUM) {
 			char *scontextp;
-			const char *s = initial_sid_to_string[sid];
+			const char *s;
 
+			/*
+			 * Before the policy is loaded, translate
+			 * SECINITSID_INIT to "kernel", because systemd and
+			 * libselinux < 2.6 take getcon_raw() != "kernel" to
+			 * mean than SELinux is not enabled as the major LSM
+			 * and thus returning "init" would make them misbehave.
+			 */
+			if (sid == SECINITSID_INIT)
+				sid = SECINITSID_KERNEL;
+
+			s = initial_sid_to_string[sid];
 			if (!s)
 				return -EINVAL;
 			*scontext_len = strlen(s) + 1;
-- 
2.41.0

