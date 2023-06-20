Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E38EB64D7
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 13:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjFTNNZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjFTNNY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 09:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB98185
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687266759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NScies5c9ss2cR8DDEqSseutQ1cnLbkLcmh/NVqjTNw=;
        b=AOOsdSlfBje91VrQ4ajzDVh8r1J4oT9RKZVCvtm2tm2+67Lg6M1UMt/hrNAqRBJ8Wcbrxp
        ZcNEwTRI5Cq63acFeDNpiHCgLNWoTHcIiStVL2UOCoJm5cTX7+MLXztrsQ06LxPjofEW8B
        l6DqvxCDjKZOy8tpAnD65uZrMXQa3w4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-x3CYaxegOk-6uXSuapkD8g-1; Tue, 20 Jun 2023 09:12:37 -0400
X-MC-Unique: x3CYaxegOk-6uXSuapkD8g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f658076c93so3248911e87.0
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 06:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687266748; x=1689858748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NScies5c9ss2cR8DDEqSseutQ1cnLbkLcmh/NVqjTNw=;
        b=XiqZaD0fEMn/agapkAKcn+mtl7ysDDvqNybLQ9KRElvcRrnr2kscVUhT+N87CPyu69
         PpRFdpflFSZ0mPdI1KxAcf2M/QM0qM66MTHYHllv9W6aPBga08qcPOkQXlbPhE79kNit
         LRowHxDsAq043R1ftll1Wj3DB2HmkHCkS3QmumhA9jgWCglEazd+geOrgaOFL7mi9jDn
         HvPGpqEXkWAQrm/cJbpyWSVwEyxD+ztXTMtvZijLwJun1wugp9hKtBOn5FS4Yupp0vSI
         pQ8La1sLU04Z6wtjgn/EqRbOrdSg6YOEt+xjGAtuR+jXoXHOCkNa5qQGpLHDirHbDy5D
         evew==
X-Gm-Message-State: AC+VfDwFzDtEo72cs962W0fixBEI+bxxA9TZTN3qFbAzHtEn8bZAcUcW
        8trHfBAPghVNe3klL+/jwNCqTEPskIIJa8sa+lSXPNPl0t1ZdMwD4HvIrCcktZmuiJ/cjS28fZf
        zbAmDwYOn/COuFPM0purNDGrZtnmj
X-Received: by 2002:a19:6547:0:b0:4f8:7807:a612 with SMTP id c7-20020a196547000000b004f87807a612mr1700572lfj.61.1687266747595;
        Tue, 20 Jun 2023 06:12:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JzOlcXxFkzPxJcRbqBwAgClEA0Xcv4H0EqEKm3t/R2p59BAK0yWxlS5eeu5JPqnzDxt3QVw==
X-Received: by 2002:a19:6547:0:b0:4f8:7807:a612 with SMTP id c7-20020a196547000000b004f87807a612mr1700556lfj.61.1687266747195;
        Tue, 20 Jun 2023 06:12:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id g3-20020adff3c3000000b0030e52d4c1bcsm1963840wrp.71.2023.06.20.06.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:12:25 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: [PATCH v2] selinux: introduce an initial SID for early boot processes
Date:   Tue, 20 Jun 2023 15:12:22 +0200
Message-ID: <20230620131223.431281-1-omosnace@redhat.com>
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

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: apply Paul's style suggestions

 security/selinux/hooks.c                      | 28 +++++++++++++++++++
 .../selinux/include/initial_sid_to_string.h   |  2 +-
 security/selinux/include/policycap.h          |  1 +
 security/selinux/include/policycap_names.h    |  3 +-
 security/selinux/include/security.h           |  6 ++++
 security/selinux/ss/policydb.c                | 27 ++++++++++++++++++
 6 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 99ded60a6b911..83d71433e23e9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2264,6 +2264,19 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
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
@@ -4480,6 +4493,21 @@ static int sock_has_perm(struct sock *sk, u32 perms)
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
index 8746fafeb7789..c08b8b58439c9 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -201,6 +201,12 @@ static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
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
index 97c0074f9312a..c5465a0b8055a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -863,6 +863,8 @@ void policydb_destroy(struct policydb *p)
 int policydb_load_isids(struct policydb *p, struct sidtab *s)
 {
 	struct ocontext *head, *c;
+	bool isid_init_supported = ebitmap_get_bit(&p->policycaps,
+						   POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT);
 	int rc;
 
 	rc = sidtab_init(s);
@@ -886,6 +888,13 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
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
-- 
2.41.0

