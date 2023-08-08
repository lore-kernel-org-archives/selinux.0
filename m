Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7EC001DB
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjHHQ1O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjHHQZP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 12:25:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDCB8903
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 08:50:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7653bd3ff2fso550679885a.3
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691509817; x=1692114617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIMVGsnPDd9NzQvddDnXfyEFVxWimgutNOe5FxMhcr4=;
        b=ELnIFFoU7kbriS6b/YeBKKTaRl92tL+ZVEWsFj7qqseb4gCE3vJpZFkvYh34JpdlmH
         +WOt7HCSKLNEeG7omUX0Kzz53uRuFbwUhjQH1M5Tf3ET7r/HMuMs1LjOC2xu6wnd0j6n
         MQeQVhF8o62ZtpNCdrN+LKHhdoZ67XjEkdBOFktFGfd9LIFmE33iadBuowrXDTptOGrG
         rSJp0Oc94+uj0PRV+mtUH3mQE680C/NWvnzERiXLHSkj+w7oNFyCkPhc1vuh90gqfc3d
         1Q501ac8J9yD6ZPxpXOrk1k58KsnDkW9pxEP/Nd9bEHrpdcvoNnRcTEep6W8DCytg7ZC
         qpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509817; x=1692114617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIMVGsnPDd9NzQvddDnXfyEFVxWimgutNOe5FxMhcr4=;
        b=CsauKmpKgaKnvxBPWZHQDscB+hQWNUKROikTQTcAicsoWpEJhzNKEuLGlW6mZf/Qpw
         JoCSdLoIMeQoreLsoItbkoblTNZjLb6Jujk3X39diyXQwLYMjcdsXt8WFygX2qfzEq9B
         tNfaAt5KCzYlf8x+tYW4mq9RtqMyrffnywgB2AOL8oC0VWkhhy4jHtus7fR0Bb4oVYqB
         2OL6B7ULSc8QLnbIQZulIPucNxS5dsQ4JK+yXIJTvvM77xvqXW2Yr8V4/qmu3w/SlxbJ
         8rzGTBGjFSOtkWlMSmt9u0o3WvEy4la7vd5471Ssd2XcMaTMadbkIp4z92oEJ9tqPoO7
         Ckvw==
X-Gm-Message-State: AOJu0Yyo4Hqg75tCEwVYkVtgm+4qsPWXCZLUgGD/yCGaRa9EVZ17DTCB
        t88YlJEcWhgTG5pcfO/X7EHR/PdjJrRIikJ9hROc
X-Google-Smtp-Source: AGHT+IEDYQjXiIagkBy0Ey+rA5dKM8nMf26Tp6e81oIk6D6OEDNmJPKlMwtcKzf/hVOSDYTIreIhiw==
X-Received: by 2002:a05:620a:458d:b0:76c:a3a2:ee07 with SMTP id bp13-20020a05620a458d00b0076ca3a2ee07mr121401qkb.16.1691509817441;
        Tue, 08 Aug 2023 08:50:17 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z27-20020a05620a101b00b0076c8fd39407sm3375644qkj.113.2023.08.08.08.50.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:50:17 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: revert SECINITSID_INIT support
Date:   Tue,  8 Aug 2023 11:50:11 -0400
Message-ID: <20230808155010.76584-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6468; i=paul@paul-moore.com; h=from:subject; bh=lK/rqsfpB30lBBnXqPRnJ9dRAUZoyO9Q1frKhQ9DFms=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBk0mQynirst51aBnSIvEC+fF/GLXad+Pl7i9bdY MUOkNbeIraJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZNJkMgAKCRDqIPLalzeJ c3bKEACVQ80uJ2pnPUK2A/WikLOSafCfnQhz7GheZdEtSAUcq6TIvm6IQ8ogMQkVxi9Rn510dNf ihqGDso6KixgjbJ7rSqltqKXGlcblewYDXqZCuJk6/KYuST8oF9yXUScpBz4F9tEpaVRzPNi8M+ VlMatnz0rmLhhyzyIeR6PAUj5xRlq68AcgTlO5pFgOml9cjsTYj4FOYXV2/87buiAyGgfgNoA37 rnbd7Nf7CeNpHPtTpxApEHIugvGnKWtjRWdXAO6R4kkazx544BNIDcVWKGjQJb+0v60fs7J7wtD bSCqz9w6hZd13KLgEYbK+MDGOilxUCsmNLNGxBpkQ0E1g1Js5l6/6wnMMJVooMLy0Emq8jLrNYB uZKiN4nuI05e44z7pIE67AcLft/p0IYvcFULdd+yclkPAF55svJHcqc5c5P2p2ZiO8b0/EfF/Je FAOwBuBelV1rxEzdRMc3FQjMNxGpjOpD773cwKxwiNSK3uloqStQAMM11vj1KUSfNQxVlqCh7HD slC1kRqY4fvSi2XTEuLsn1/fj4BNGe/Bu37TI+J+THlE2X94QLwiCLZRlXLuvHD6dSi+74pGYty 6ltRdi8kBH+P9L1VghNKGCxBY3iCFPhAS8PmjZ0od4cIw/XKiPX8oPDF0nifCLmz0kawA0M4zsc UWN+APNbXI0EiTw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This commit reverts 5b0eea835d4e ("selinux: introduce an initial SID
for early boot processes") as it was found to cause problems on
distros with old SELinux userspace tools/libraries, specifically
Ubuntu 16.04.

Hopefully we will be able to re-add this functionality at a later
date, but let's revert this for now to help ensure a stable and
backwards compatible SELinux tree.

Link: https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c                      | 28 -------------------
 .../selinux/include/initial_sid_to_string.h   |  2 +-
 security/selinux/include/policycap.h          |  1 -
 security/selinux/include/policycap_names.h    |  1 -
 security/selinux/include/security.h           |  6 ----
 security/selinux/ss/policydb.c                | 27 ------------------
 6 files changed, 1 insertion(+), 64 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7cd687284563..9be291315b91 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2313,19 +2313,6 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	new_tsec->keycreate_sid = 0;
 	new_tsec->sockcreate_sid = 0;
 
-	/*
-	 * Before policy is loaded, label any task outside kernel space
-	 * as SECINITSID_INIT, so that any userspace tasks surviving from
-	 * early boot end up with a label different from SECINITSID_KERNEL
-	 * (if the policy chooses to set SECINITSID_INIT != SECINITSID_KERNEL).
-	 */
-	if (!selinux_initialized()) {
-		new_tsec->sid = SECINITSID_INIT;
-		/* also clear the exec_sid just in case */
-		new_tsec->exec_sid = 0;
-		return 0;
-	}
-
 	if (old_tsec->exec_sid) {
 		new_tsec->sid = old_tsec->exec_sid;
 		/* Reset exec SID on execve. */
@@ -4542,21 +4529,6 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 	if (sksec->sid == SECINITSID_KERNEL)
 		return 0;
 
-	/*
-	 * Before POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT, sockets that
-	 * inherited the kernel context from early boot used to be skipped
-	 * here, so preserve that behavior unless the capability is set.
-	 *
-	 * By setting the capability the policy signals that it is ready
-	 * for this quirk to be fixed. Note that sockets created by a kernel
-	 * thread or a usermode helper executed without a transition will
-	 * still be skipped in this check regardless of the policycap
-	 * setting.
-	 */
-	if (!selinux_policycap_userspace_initial_context() &&
-	    sksec->sid == SECINITSID_INIT)
-		return 0;
-
 	ad_net_init_from_sk(&ad, &net, sk);
 
 	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 5e5f0993dac2..ecc6e74fa09b 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -10,7 +10,7 @@ static const char *const initial_sid_to_string[] = {
 	NULL,
 	"file",
 	NULL,
-	"init",
+	NULL,
 	"any_socket",
 	"port",
 	"netif",
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index c7373e6effe5..f35d3458e71d 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -12,7 +12,6 @@ enum {
 	POLICYDB_CAP_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
-	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index 28e4c9ee2399..49bbe120d173 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -14,7 +14,6 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"nnp_nosuid_transition",
 	"genfs_seclabel_symlinks",
 	"ioctl_skip_cloexec",
-	"userspace_initial_context",
 };
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 074d439fe9ad..a9de89af8fdc 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -189,12 +189,6 @@ static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 		selinux_state.policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
-static inline bool selinux_policycap_userspace_initial_context(void)
-{
-	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
-}
-
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a424997c79eb..954842bde3e6 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -864,8 +864,6 @@ void policydb_destroy(struct policydb *p)
 int policydb_load_isids(struct policydb *p, struct sidtab *s)
 {
 	struct ocontext *head, *c;
-	bool isid_init_supported = ebitmap_get_bit(&p->policycaps,
-						   POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT);
 	int rc;
 
 	rc = sidtab_init(s);
@@ -889,13 +887,6 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 		if (!name)
 			continue;
 
-		/*
-		 * Also ignore SECINITSID_INIT if the policy doesn't declare
-		 * support for it
-		 */
-		if (sid == SECINITSID_INIT && !isid_init_supported)
-			continue;
-
 		rc = sidtab_set_initial(s, sid, &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
@@ -903,24 +894,6 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 			sidtab_destroy(s);
 			return rc;
 		}
-
-		/*
-		 * If the policy doesn't support the "userspace_initial_context"
-		 * capability, set SECINITSID_INIT to the same context as
-		 * SECINITSID_KERNEL. This ensures the same behavior as before
-		 * the reintroduction of SECINITSID_INIT, where all tasks
-		 * started before policy load would initially get the context
-		 * corresponding to SECINITSID_KERNEL.
-		 */
-		if (sid == SECINITSID_KERNEL && !isid_init_supported) {
-			rc = sidtab_set_initial(s, SECINITSID_INIT, &c->context[0]);
-			if (rc) {
-				pr_err("SELinux:  unable to load initial SID %s.\n",
-				       name);
-				sidtab_destroy(s);
-				return rc;
-			}
-		}
 	}
 	return 0;
 }
-- 
2.41.0

