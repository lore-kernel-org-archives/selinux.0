Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E706C3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B2220665
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZLc2gLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgB1OFw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:05:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39225 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB1OFu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 09:05:50 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so1345519pjr.4
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=baf+vqMKorNyJjSyiAU08gSE2Z3ulLrcORZbh2mLQ1U=;
        b=mZLc2gLpZKxTl/ppF+GJ0sbSoa/Qt9xNNN4sFltSVWRatyMm81L9KZZ1qDyAW+HU9g
         YHqHwpH6Rgy+7VlnnsTc+cuS4o9tyqNnpKLMHtEEfZRaCXGOMiMhXxBp+S1PjHkR2OD4
         gZnPisK9O9hHjzgmKneKZj/BIL24yWPpiBCFuDV0xA5h8Up4TrXCmi7K8/sLqja1oKy8
         1s7gwj0gDcxUkMWQT7Et9VByPJoScLghtKkBykiyVMMcyHzmSLsLuV2/uUXKa3I/fYde
         +q8qGxsouevqdrHyCpCwxwxvUqB5xk3erk6Ks4H24bJyrWE7FvFIhcKSikjd8qKAs3WM
         Ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=baf+vqMKorNyJjSyiAU08gSE2Z3ulLrcORZbh2mLQ1U=;
        b=or74QO5SXkYrIEw70NFb/pHM3nIZ/dfDWNDU9qkuYoyHTtg3IUsOmgLv4GEogu0LbC
         atyB8r13apG6LUxztYT13UoGcqljgM6vJbz0v7j06WHJYnnAnU8kGJ3qQr6sBWPXRSgD
         bNVyqzPDYmfPdQoZqya5DrDdXHRnftRHswa5pOvaQa3QPKtiPJCaVWf8OAxKeas73jKz
         4J1erDh2iAYlNjsXCsQUB5GnykfweQAx78BFVMO0JnDrbHl/4F1B09+d55XzB1VdDPV+
         Zw0e8e6IC+NCDuTP1Y09Wt5kgOnBsgDpQ5UUsBGk5BeDboER8W7IsCrWxqCiOTmuh+oT
         GcZA==
X-Gm-Message-State: APjAAAUY7vHLSFzuLqkoxz0pfS8OqpOEAn8RuuTNQH17panqcI3eYSCv
        MDiZGISZ/T+MU916ZqwNn/wRgqaS
X-Google-Smtp-Source: APXvYqxN14m60AOfah93TNkMu/vup7ygi6jJ4fwlHja15Mbzc5Rqm98r8K/DdyArZBPOMnZIm4/JtA==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr4390895plt.64.1582898746774;
        Fri, 28 Feb 2020 06:05:46 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id t11sm2656903pjo.21.2020.02.28.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:05:46 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 1/4] dso: drop hidden_proto and hidden_def
Date:   Fri, 28 Feb 2020 08:05:21 -0600
Message-Id: <20200228140524.2404-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228140524.2404-1-william.c.roberts@intel.com>
References: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
 <20200228140524.2404-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/avc.c                          |   5 -
 libselinux/src/avc_internal.h                 |  52 ++++----
 libselinux/src/avc_sidtab.h                   |  11 +-
 libselinux/src/booleans.c                     |   5 -
 libselinux/src/callbacks.h                    |  11 +-
 libselinux/src/canonicalize_context.c         |   2 -
 libselinux/src/checkAccess.c                  |   1 -
 libselinux/src/check_context.c                |   2 -
 libselinux/src/checkreqprot.c                 |   1 -
 libselinux/src/compute_av.c                   |   4 -
 libselinux/src/compute_create.c               |   4 -
 libselinux/src/compute_member.c               |   1 -
 libselinux/src/compute_relabel.c              |   1 -
 libselinux/src/compute_user.c                 |   2 -
 libselinux/src/context.c                      |   9 +-
 libselinux/src/context_internal.h             |  12 --
 libselinux/src/deny_unknown.c                 |   1 -
 libselinux/src/disable.c                      |   1 -
 libselinux/src/dso.h                          |  23 ----
 libselinux/src/enabled.c                      |   2 -
 libselinux/src/fgetfilecon.c                  |   1 -
 libselinux/src/freecon.c                      |   1 -
 libselinux/src/freeconary.c                   |   1 -
 libselinux/src/fsetfilecon.c                  |   1 -
 libselinux/src/get_context_list.c             |   3 -
 libselinux/src/get_context_list_internal.h    |   4 -
 libselinux/src/get_default_type_internal.h    |   2 -
 libselinux/src/get_initial_context.c          |   2 -
 libselinux/src/getenforce.c                   |   1 -
 libselinux/src/getfilecon.c                   |   2 -
 libselinux/src/getpeercon.c                   |   1 -
 libselinux/src/init.c                         |   4 -
 libselinux/src/label_internal.h               |  19 ++-
 libselinux/src/label_support.c                |   6 +-
 libselinux/src/lgetfilecon.c                  |   1 -
 libselinux/src/load_policy.c                  |   2 -
 libselinux/src/lsetfilecon.c                  |   1 -
 libselinux/src/matchpathcon.c                 |   3 +-
 libselinux/src/policyvers.c                   |   2 -
 libselinux/src/procattr.c                     |  21 +---
 libselinux/src/regex.h                        |  21 ++--
 libselinux/src/reject_unknown.c               |   1 -
 .../src/selinux_check_securetty_context.c     |   1 -
 libselinux/src/selinux_config.c               |  36 ------
 libselinux/src/selinux_internal.h             | 117 +-----------------
 libselinux/src/setenforce.c                   |   1 -
 libselinux/src/setfilecon.c                   |   1 -
 libselinux/src/setrans_client.c               |   8 +-
 libselinux/src/seusers.c                      |   2 +-
 libselinux/src/sha1.c                         |   7 +-
 libselinux/src/stringrep.c                    |   1 -
 libselinux/src/validatetrans.c                |   2 -
 52 files changed, 69 insertions(+), 357 deletions(-)
 delete mode 100644 libselinux/src/dso.h

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 5230efd2323a..ab10b0f9f1cb 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -294,7 +294,6 @@ void avc_av_stats(void)
 		slots_used, AVC_CACHE_SLOTS, max_chain_len);
 }
 
-hidden_def(avc_av_stats)
 
 static inline struct avc_node *avc_reclaim_node(void)
 {
@@ -494,7 +493,6 @@ void avc_cleanup(void)
 {
 }
 
-hidden_def(avc_cleanup)
 
 int avc_reset(void)
 {
@@ -539,7 +537,6 @@ int avc_reset(void)
 	return rc;
 }
 
-hidden_def(avc_reset)
 
 void avc_destroy(void)
 {
@@ -733,7 +730,6 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
 	avc_release_lock(avc_log_lock);
 }
 
-hidden_def(avc_audit)
 
 
 static void avd_init(struct av_decision *avd)
@@ -825,7 +821,6 @@ int avc_has_perm_noaudit(security_id_t ssid,
 	return rc;
 }
 
-hidden_def(avc_has_perm_noaudit)
 
 int avc_has_perm(security_id_t ssid, security_id_t tsid,
 		 security_class_t tclass, access_vector_t requested,
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index f8516590bd75..3f8a6bb1cf84 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -14,24 +14,23 @@
 #include <string.h>
 #include <selinux/avc.h>
 #include "callbacks.h"
-#include "dso.h"
 
 /* callback pointers */
-extern void *(*avc_func_malloc) (size_t) hidden;
-extern void (*avc_func_free) (void *)hidden;
+extern void *(*avc_func_malloc) (size_t) ;
+extern void (*avc_func_free) (void *);
 
-extern void (*avc_func_log) (const char *, ...) __attribute__((__format__(printf,1,2))) hidden;
-extern void (*avc_func_audit) (void *, security_class_t, char *, size_t)hidden;
+extern void (*avc_func_log) (const char *, ...) __attribute__((__format__(printf,1,2))) ;
+extern void (*avc_func_audit) (void *, security_class_t, char *, size_t);
 
-extern int avc_using_threads hidden;
-extern int avc_app_main_loop hidden;
-extern void *(*avc_func_create_thread) (void (*)(void))hidden;
-extern void (*avc_func_stop_thread) (void *)hidden;
+extern int avc_using_threads ;
+extern int avc_app_main_loop ;
+extern void *(*avc_func_create_thread) (void (*)(void));
+extern void (*avc_func_stop_thread) (void *);
 
-extern void *(*avc_func_alloc_lock) (void)hidden;
-extern void (*avc_func_get_lock) (void *)hidden;
-extern void (*avc_func_release_lock) (void *)hidden;
-extern void (*avc_func_free_lock) (void *)hidden;
+extern void *(*avc_func_alloc_lock) (void);
+extern void (*avc_func_get_lock) (void *);
+extern void (*avc_func_release_lock) (void *);
+extern void (*avc_func_free_lock) (void *);
 
 static inline void set_callbacks(const struct avc_memory_callback *mem_cb,
 				 const struct avc_log_callback *log_cb,
@@ -61,10 +60,10 @@ static inline void set_callbacks(const struct avc_memory_callback *mem_cb,
 
 /* message prefix and enforcing mode*/
 #define AVC_PREFIX_SIZE 16
-extern char avc_prefix[AVC_PREFIX_SIZE] hidden;
-extern int avc_running hidden;
-extern int avc_enforcing hidden;
-extern int avc_setenforce hidden;
+extern char avc_prefix[AVC_PREFIX_SIZE] ;
+extern int avc_running ;
+extern int avc_enforcing ;
+extern int avc_setenforce ;
 
 /* user-supplied callback interface for avc */
 static inline void *avc_malloc(size_t size)
@@ -155,28 +154,23 @@ static inline void avc_free_lock(void *lock)
 /* internal callbacks */
 int avc_ss_grant(security_id_t ssid, security_id_t tsid,
 		 security_class_t tclass, access_vector_t perms,
-		 uint32_t seqno) hidden;
+		 uint32_t seqno) ;
 int avc_ss_try_revoke(security_id_t ssid, security_id_t tsid,
 		      security_class_t tclass,
 		      access_vector_t perms, uint32_t seqno,
-		      access_vector_t * out_retained) hidden;
+		      access_vector_t * out_retained) ;
 int avc_ss_revoke(security_id_t ssid, security_id_t tsid,
 		  security_class_t tclass, access_vector_t perms,
-		  uint32_t seqno) hidden;
-int avc_ss_reset(uint32_t seqno) hidden;
+		  uint32_t seqno) ;
+int avc_ss_reset(uint32_t seqno) ;
 int avc_ss_set_auditallow(security_id_t ssid, security_id_t tsid,
 			  security_class_t tclass, access_vector_t perms,
-			  uint32_t seqno, uint32_t enable) hidden;
+			  uint32_t seqno, uint32_t enable) ;
 int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 			 security_class_t tclass, access_vector_t perms,
-			 uint32_t seqno, uint32_t enable) hidden;
+			 uint32_t seqno, uint32_t enable) ;
 
 /* netlink kernel message code */
-extern int avc_netlink_trouble hidden;
+extern int avc_netlink_trouble ;
 
-hidden_proto(avc_av_stats)
-    hidden_proto(avc_cleanup)
-    hidden_proto(avc_reset)
-    hidden_proto(avc_audit)
-    hidden_proto(avc_has_perm_noaudit)
 #endif				/* _SELINUX_AVC_INTERNAL_H_ */
diff --git a/libselinux/src/avc_sidtab.h b/libselinux/src/avc_sidtab.h
index bce9b877ae79..cc5abe354a01 100644
--- a/libselinux/src/avc_sidtab.h
+++ b/libselinux/src/avc_sidtab.h
@@ -7,7 +7,6 @@
 
 #include <selinux/selinux.h>
 #include <selinux/avc.h>
-#include "dso.h"
 
 struct sidtab_node {
 	struct security_id sid_s;
@@ -24,13 +23,13 @@ struct sidtab {
 	unsigned nel;
 };
 
-int sidtab_init(struct sidtab *s) hidden;
-int sidtab_insert(struct sidtab *s, const char * ctx) hidden;
+int sidtab_init(struct sidtab *s) ;
+int sidtab_insert(struct sidtab *s, const char * ctx) ;
 
 int sidtab_context_to_sid(struct sidtab *s,
-			  const char * ctx, security_id_t * sid) hidden;
+			  const char * ctx, security_id_t * sid) ;
 
-void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen) hidden;
-void sidtab_destroy(struct sidtab *s) hidden;
+void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen) ;
+void sidtab_destroy(struct sidtab *s) ;
 
 #endif				/* _SELINUX_AVC_SIDTAB_H_ */
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ffa8d26b0f3a..ef1f64a05d84 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -414,8 +414,3 @@ char *selinux_boolean_sub(const char *name __attribute__((unused)))
 }
 #endif
 
-hidden_def(security_get_boolean_names)
-hidden_def(selinux_boolean_sub)
-hidden_def(security_get_boolean_active)
-hidden_def(security_set_boolean)
-hidden_def(security_commit_booleans)
diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
index 2a572e08d534..03d87f0cbdfe 100644
--- a/libselinux/src/callbacks.h
+++ b/libselinux/src/callbacks.h
@@ -9,22 +9,21 @@
 #include <stdlib.h>
 #include <string.h>
 #include <selinux/selinux.h>
-#include "dso.h"
 
 /* callback pointers */
 extern int __attribute__ ((format(printf, 2, 3)))
-(*selinux_log) (int type, const char *, ...) hidden;
+(*selinux_log) (int type, const char *, ...) ;
 
 extern int
-(*selinux_audit) (void *, security_class_t, char *, size_t) hidden;
+(*selinux_audit) (void *, security_class_t, char *, size_t) ;
 
 extern int
-(*selinux_validate)(char **ctx) hidden;
+(*selinux_validate)(char **ctx) ;
 
 extern int
-(*selinux_netlink_setenforce) (int enforcing) hidden;
+(*selinux_netlink_setenforce) (int enforcing) ;
 
 extern int
-(*selinux_netlink_policyload) (int seqno) hidden;
+(*selinux_netlink_policyload) (int seqno) ;
 
 #endif				/* _SELINUX_CALLBACKS_H_ */
diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
index ba4c9a2c7d46..faab730592c2 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -60,7 +60,6 @@ int security_canonicalize_context_raw(const char * con,
 	return ret;
 }
 
-hidden_def(security_canonicalize_context_raw)
 
 int security_canonicalize_context(const char * con,
 				      char ** canoncon)
@@ -83,4 +82,3 @@ int security_canonicalize_context(const char * con,
 	return ret;
 }
 
-hidden_def(security_canonicalize_context)
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 7227ffe51eac..677e2ecd7df4 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -99,7 +99,6 @@ int selinux_check_passwd_access(access_vector_t requested)
 	return status;
 }
 
-hidden_def(selinux_check_passwd_access)
 
 int checkPasswdAccess(access_vector_t requested)
 {
diff --git a/libselinux/src/check_context.c b/libselinux/src/check_context.c
index 8a7997f03598..5096a2c40993 100644
--- a/libselinux/src/check_context.c
+++ b/libselinux/src/check_context.c
@@ -31,7 +31,6 @@ int security_check_context_raw(const char * con)
 	return 0;
 }
 
-hidden_def(security_check_context_raw)
 
 int security_check_context(const char * con)
 {
@@ -48,4 +47,3 @@ int security_check_context(const char * con)
 	return ret;
 }
 
-hidden_def(security_check_context)
diff --git a/libselinux/src/checkreqprot.c b/libselinux/src/checkreqprot.c
index 9b4b12d75021..3dc79d9719c5 100644
--- a/libselinux/src/checkreqprot.c
+++ b/libselinux/src/checkreqprot.c
@@ -37,4 +37,3 @@ int security_get_checkreqprot(void)
 	return checkreqprot;
 }
 
-hidden_def(security_get_checkreqprot);
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index a47cffe98662..9d17339d1a32 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -80,7 +80,6 @@ int security_compute_av_flags_raw(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_av_flags_raw)
 
 int security_compute_av_raw(const char * scon,
 			    const char * tcon,
@@ -107,7 +106,6 @@ int security_compute_av_raw(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_av_raw)
 
 int security_compute_av_flags(const char * scon,
 			      const char * tcon,
@@ -134,7 +132,6 @@ int security_compute_av_flags(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_av_flags)
 
 int security_compute_av(const char * scon,
 			const char * tcon,
@@ -162,4 +159,3 @@ int security_compute_av(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_av)
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index 0975aeac2224..1d75714d852d 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -105,7 +105,6 @@ int security_compute_create_name_raw(const char * scon,
 	close(fd);
 	return ret;
 }
-hidden_def(security_compute_create_name_raw)
 
 int security_compute_create_raw(const char * scon,
 				const char * tcon,
@@ -115,7 +114,6 @@ int security_compute_create_raw(const char * scon,
 	return security_compute_create_name_raw(scon, tcon, tclass,
 						NULL, newcon);
 }
-hidden_def(security_compute_create_raw)
 
 int security_compute_create_name(const char * scon,
 				 const char * tcon,
@@ -146,7 +144,6 @@ int security_compute_create_name(const char * scon,
 
 	return ret;
 }
-hidden_def(security_compute_create_name)
 
 int security_compute_create(const char * scon,
 				const char * tcon,
@@ -155,4 +152,3 @@ int security_compute_create(const char * scon,
 {
 	return security_compute_create_name(scon, tcon, tclass, NULL, newcon);
 }
-hidden_def(security_compute_create)
diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_member.c
index 4e2d221ef9ea..16234b7908f2 100644
--- a/libselinux/src/compute_member.c
+++ b/libselinux/src/compute_member.c
@@ -60,7 +60,6 @@ int security_compute_member_raw(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_member_raw)
 
 int security_compute_member(const char * scon,
 			    const char * tcon,
diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_relabel.c
index 49f77ef3344c..dd20d6525993 100644
--- a/libselinux/src/compute_relabel.c
+++ b/libselinux/src/compute_relabel.c
@@ -60,7 +60,6 @@ int security_compute_relabel_raw(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_relabel_raw)
 
 int security_compute_relabel(const char * scon,
 			     const char * tcon,
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index e7da964ff46d..ae5e7b4a8f68 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -80,7 +80,6 @@ int security_compute_user_raw(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_user_raw)
 
 int security_compute_user(const char * scon,
 			  const char *user, char *** con)
@@ -110,4 +109,3 @@ int security_compute_user(const char * scon,
 	return ret;
 }
 
-hidden_def(security_compute_user)
diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index b673733e1f48..090264a49eb1 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -82,7 +82,6 @@ context_t context_new(const char *str)
 	return 0;
 }
 
-hidden_def(context_new)
 
 static void conditional_free(char **v)
 {
@@ -113,7 +112,6 @@ void context_free(context_t context)
 	}
 }
 
-hidden_def(context_free)
 
 /*
  * Return a pointer to the string value of the context.
@@ -144,7 +142,6 @@ char *context_str(context_t context)
 	return n->current_str;
 }
 
-hidden_def(context_str)
 
 /* Returns nonzero iff failed */
 static int set_comp(context_private_t * n, int idx, const char *str)
@@ -176,8 +173,7 @@ const char * context_ ## name ## _get(context_t context) \
 { \
         context_private_t *n = context->ptr; \
         return n->component[tag]; \
-} \
-hidden_def(context_ ## name ## _get)
+}
 
 def_get(type, COMP_TYPE)
     def_get(user, COMP_USER)
@@ -187,8 +183,7 @@ def_get(type, COMP_TYPE)
 int context_ ## name ## _set(context_t context, const char* str) \
 { \
         return set_comp(context->ptr,tag,str);\
-} \
-hidden_def(context_ ## name ## _set)
+}
     def_set(type, COMP_TYPE)
     def_set(role, COMP_ROLE)
     def_set(user, COMP_USER)
diff --git a/libselinux/src/context_internal.h b/libselinux/src/context_internal.h
index 3c71e8027080..a7698106923e 100644
--- a/libselinux/src/context_internal.h
+++ b/libselinux/src/context_internal.h
@@ -1,14 +1,2 @@
 #include <selinux/context.h>
-#include "dso.h"
 
-hidden_proto(context_new)
-    hidden_proto(context_free)
-    hidden_proto(context_str)
-    hidden_proto(context_type_set)
-    hidden_proto(context_type_get)
-    hidden_proto(context_role_set)
-    hidden_proto(context_role_get)
-    hidden_proto(context_user_set)
-    hidden_proto(context_user_get)
-    hidden_proto(context_range_set)
-    hidden_proto(context_range_get)
diff --git a/libselinux/src/deny_unknown.c b/libselinux/src/deny_unknown.c
index 77d04e370f30..fdd32b50a246 100644
--- a/libselinux/src/deny_unknown.c
+++ b/libselinux/src/deny_unknown.c
@@ -37,4 +37,3 @@ int security_deny_unknown(void)
 	return deny_unknown;
 }
 
-hidden_def(security_deny_unknown);
diff --git a/libselinux/src/disable.c b/libselinux/src/disable.c
index 8d66262aff03..1a5ae4172a8d 100644
--- a/libselinux/src/disable.c
+++ b/libselinux/src/disable.c
@@ -35,4 +35,3 @@ int security_disable(void)
 	return 0;
 }
 
-hidden_def(security_disable)
diff --git a/libselinux/src/dso.h b/libselinux/src/dso.h
deleted file mode 100644
index 12c3d1160fb0..000000000000
--- a/libselinux/src/dso.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef _SELINUX_DSO_H
-#define _SELINUX_DSO_H	1
-
-#ifdef SHARED
-# define hidden __attribute__ ((visibility ("hidden")))
-# define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
-# define __hidden_proto(fct, internal)	\
-     extern __typeof (fct) internal;	\
-     extern __typeof (fct) fct __asm (#internal) hidden;
-# if defined(__alpha__) || defined(__mips__)
-#  define hidden_def(fct) \
-     asm (".globl " #fct "\n" #fct " = " #fct "_internal");
-# else
-#  define hidden_def(fct) \
-     asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");
-#endif
-#else
-# define hidden
-# define hidden_proto(fct)
-# define hidden_def(fct)
-#endif
-
-#endif
diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
index dd628fba86a8..fefb0bd9ae02 100644
--- a/libselinux/src/enabled.c
+++ b/libselinux/src/enabled.c
@@ -20,7 +20,6 @@ int is_selinux_enabled(void)
 #endif
 }
 
-hidden_def(is_selinux_enabled)
 
 /*
  * Function: is_selinux_mls_enabled()
@@ -55,4 +54,3 @@ int is_selinux_mls_enabled(void)
 	return enabled;
 }
 
-hidden_def(is_selinux_mls_enabled)
diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index 5522ac16e385..8c748f8a2e64 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -49,7 +49,6 @@ int fgetfilecon_raw(int fd, char ** context)
 	return ret;
 }
 
-hidden_def(fgetfilecon_raw)
 
 int fgetfilecon(int fd, char ** context)
 {
diff --git a/libselinux/src/freecon.c b/libselinux/src/freecon.c
index 5290dfa13bc4..df2d7e2827ea 100644
--- a/libselinux/src/freecon.c
+++ b/libselinux/src/freecon.c
@@ -8,4 +8,3 @@ void freecon(char * con)
 	free(con);
 }
 
-hidden_def(freecon)
diff --git a/libselinux/src/freeconary.c b/libselinux/src/freeconary.c
index 8d07718ed5f9..fd2dbaabfbcf 100644
--- a/libselinux/src/freeconary.c
+++ b/libselinux/src/freeconary.c
@@ -16,4 +16,3 @@ void freeconary(char ** con)
 	free(con);
 }
 
-hidden_def(freeconary)
diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
index 52707d05ddd4..5cf34e3fa5d0 100644
--- a/libselinux/src/fsetfilecon.c
+++ b/libselinux/src/fsetfilecon.c
@@ -25,7 +25,6 @@ int fsetfilecon_raw(int fd, const char * context)
 	return rc;
 }
 
-hidden_def(fsetfilecon_raw)
 
 int fsetfilecon(int fd, const char *context)
 {
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 26d7b3b98e75..b43652ffd28c 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -52,7 +52,6 @@ int get_default_context_with_role(const char *user,
 	return rc;
 }
 
-hidden_def(get_default_context_with_role)
 
 int get_default_context_with_rolelevel(const char *user,
 				       const char *role,
@@ -385,7 +384,6 @@ int get_ordered_context_list_with_level(const char *user,
 	return rc;
 }
 
-hidden_def(get_ordered_context_list_with_level)
 
 int get_default_context_with_level(const char *user,
 				   const char *level,
@@ -497,4 +495,3 @@ int get_ordered_context_list(const char *user,
 	goto out;
 }
 
-hidden_def(get_ordered_context_list)
diff --git a/libselinux/src/get_context_list_internal.h b/libselinux/src/get_context_list_internal.h
index c224834ebfb4..a7c1d41ba07f 100644
--- a/libselinux/src/get_context_list_internal.h
+++ b/libselinux/src/get_context_list_internal.h
@@ -1,6 +1,2 @@
 #include <selinux/get_context_list.h>
-#include "dso.h"
 
-hidden_proto(get_ordered_context_list)
-    hidden_proto(get_ordered_context_list_with_level)
-    hidden_proto(get_default_context_with_role)
diff --git a/libselinux/src/get_default_type_internal.h b/libselinux/src/get_default_type_internal.h
index 0da3c512d6fb..deb5d2963211 100644
--- a/libselinux/src/get_default_type_internal.h
+++ b/libselinux/src/get_default_type_internal.h
@@ -1,4 +1,2 @@
 #include <selinux/get_default_type.h>
-#include "dso.h"
 
-hidden_proto(selinux_default_type_path)
diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_initial_context.c
index 5e919f478b63..97ae3dcfb5a6 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -53,7 +53,6 @@ int security_get_initial_context_raw(const char * name, char ** con)
 	return ret;
 }
 
-hidden_def(security_get_initial_context_raw)
 
 int security_get_initial_context(const char * name, char ** con)
 {
@@ -69,4 +68,3 @@ int security_get_initial_context(const char * name, char ** con)
 	return ret;
 }
 
-hidden_def(security_get_initial_context)
diff --git a/libselinux/src/getenforce.c b/libselinux/src/getenforce.c
index d909dced73c6..3f1e20021a4e 100644
--- a/libselinux/src/getenforce.c
+++ b/libselinux/src/getenforce.c
@@ -37,4 +37,3 @@ int security_getenforce(void)
 	return !!enforce;
 }
 
-hidden_def(security_getenforce)
diff --git a/libselinux/src/getfilecon.c b/libselinux/src/getfilecon.c
index 20bee8abdbfc..4bee31372172 100644
--- a/libselinux/src/getfilecon.c
+++ b/libselinux/src/getfilecon.c
@@ -49,7 +49,6 @@ int getfilecon_raw(const char *path, char ** context)
 	return ret;
 }
 
-hidden_def(getfilecon_raw)
 
 int getfilecon(const char *path, char ** context)
 {
@@ -70,4 +69,3 @@ int getfilecon(const char *path, char ** context)
 	return ret;
 }
 
-hidden_def(getfilecon)
diff --git a/libselinux/src/getpeercon.c b/libselinux/src/getpeercon.c
index 3a77a2de2c95..a9dca73e438a 100644
--- a/libselinux/src/getpeercon.c
+++ b/libselinux/src/getpeercon.c
@@ -43,7 +43,6 @@ int getpeercon_raw(int fd, char ** context)
 	return ret;
 }
 
-hidden_def(getpeercon_raw)
 
 int getpeercon(int fd, char ** context)
 {
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 083638c47fbf..542c979b9da6 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -12,7 +12,6 @@
 #include <stdint.h>
 #include <limits.h>
 
-#include "dso.h"
 #include "policy.h"
 #include "selinux_internal.h"
 #include "setrans_internal.h"
@@ -79,7 +78,6 @@ int selinuxfs_exists(void)
 	fclose(fp);
 	return exists;
 }
-hidden_def(selinuxfs_exists)
 
 static void init_selinuxmnt(void)
 {
@@ -138,14 +136,12 @@ void fini_selinuxmnt(void)
 	selinux_mnt = NULL;
 }
 
-hidden_def(fini_selinuxmnt)
 
 void set_selinuxmnt(const char *mnt)
 {
 	selinux_mnt = strdup(mnt);
 }
 
-hidden_def(set_selinuxmnt)
 
 static void init_lib(void) __attribute__ ((constructor));
 static void init_lib(void)
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 7ed2a43770a7..361b443cb9c4 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -13,7 +13,6 @@
 #include <stdio.h>
 #include <selinux/selinux.h>
 #include <selinux/label.h>
-#include "dso.h"
 #include "sha1.h"
 
 #if defined(ANDROID) || defined(__APPLE__)
@@ -26,22 +25,22 @@
  */
 int selabel_file_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
-			    unsigned nopts) hidden;
+			    unsigned nopts) ;
 int selabel_media_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
-			    unsigned nopts) hidden;
+			    unsigned nopts) ;
 int selabel_x_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
-			    unsigned nopts) hidden;
+			    unsigned nopts) ;
 int selabel_db_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
-			    unsigned nopts) hidden;
+			    unsigned nopts) ;
 int selabel_property_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
-			    unsigned nopts) hidden;
+			    unsigned nopts) ;
 int selabel_service_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
-			    unsigned nopts) hidden;
+			    unsigned nopts) ;
 
 /*
  * Labeling internal structures
@@ -120,14 +119,14 @@ struct selabel_handle {
  */
 extern int
 selabel_validate(struct selabel_handle *rec,
-		 struct selabel_lookup_rec *contexts) hidden;
+		 struct selabel_lookup_rec *contexts) ;
 
 /*
  * Compatibility support
  */
 extern int myprintf_compat;
 extern void __attribute__ ((format(printf, 1, 2)))
-(*myprintf) (const char *fmt, ...) hidden;
+(*myprintf) (const char *fmt, ...) ;
 
 #define COMPAT_LOG(type, fmt...) if (myprintf_compat)	  \
 		myprintf(fmt);				  \
@@ -137,7 +136,7 @@ extern void __attribute__ ((format(printf, 1, 2)))
 extern int
 compat_validate(struct selabel_handle *rec,
 		struct selabel_lookup_rec *contexts,
-		const char *path, unsigned lineno) hidden;
+		const char *path, unsigned lineno) ;
 
 /*
  * The read_spec_entries function may be used to
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 26f9ef155dcf..94ed6e4273cb 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -63,7 +63,7 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
  * This function calls read_spec_entry() to do the actual string processing.
  * As such, can return anything from that function as well.
  */
-int hidden read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
+int  read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
 {
 	char **spec_entry, *buf_p;
 	int len, rc, items, entry_len = 0;
@@ -113,7 +113,7 @@ int hidden read_spec_entries(char *line_buf, const char **errbuf, int num_args,
 }
 
 /* Once all the specfiles are in the hash_buf, generate the hash. */
-void hidden digest_gen_hash(struct selabel_digest *digest)
+void  digest_gen_hash(struct selabel_digest *digest)
 {
 	Sha1Context context;
 
@@ -141,7 +141,7 @@ void hidden digest_gen_hash(struct selabel_digest *digest)
  *
  * Return %0 on success, -%1 with @errno set on failure.
  */
-int hidden digest_add_specfile(struct selabel_digest *digest, FILE *fp,
+int  digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 				    char *from_addr, size_t buf_len,
 				    const char *path)
 {
diff --git a/libselinux/src/lgetfilecon.c b/libselinux/src/lgetfilecon.c
index db67bc60ffe6..d1fb821b23ef 100644
--- a/libselinux/src/lgetfilecon.c
+++ b/libselinux/src/lgetfilecon.c
@@ -49,7 +49,6 @@ int lgetfilecon_raw(const char *path, char ** context)
 	return ret;
 }
 
-hidden_def(lgetfilecon_raw)
 
 int lgetfilecon(const char *path, char ** context)
 {
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 9e75292d2528..fa1a3bf1f441 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -45,7 +45,6 @@ int security_load_policy(void *data, size_t len)
 	return 0;
 }
 
-hidden_def(security_load_policy)
 
 #ifndef ANDROID
 #undef max
@@ -213,7 +212,6 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 	return rc;
 }
 
-hidden_def(selinux_mkload_policy)
 
 /*
  * Mount point for selinuxfs. 
diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
index 1d3b28a1c5fc..213fb684fc66 100644
--- a/libselinux/src/lsetfilecon.c
+++ b/libselinux/src/lsetfilecon.c
@@ -25,7 +25,6 @@ int lsetfilecon_raw(const char *path, const char * context)
 	return rc;
 }
 
-hidden_def(lsetfilecon_raw)
 
 int lsetfilecon(const char *path, const char *context)
 {
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 05a5cfa4cfd5..bddf77a49ce1 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -322,7 +322,7 @@ static void matchpathcon_thread_destructor(void __attribute__((unused)) *ptr)
 
 void __attribute__((destructor)) matchpathcon_lib_destructor(void);
 
-void hidden __attribute__((destructor)) matchpathcon_lib_destructor(void)
+void  __attribute__((destructor)) matchpathcon_lib_destructor(void)
 {
 	if (destructor_key_initialized)
 		__selinux_key_delete(destructor_key);
@@ -351,7 +351,6 @@ int matchpathcon_init_prefix(const char *path, const char *subset)
 	return hnd ? 0 : -1;
 }
 
-hidden_def(matchpathcon_init_prefix)
 
 int matchpathcon_init(const char *path)
 {
diff --git a/libselinux/src/policyvers.c b/libselinux/src/policyvers.c
index c97dd9df7a8a..e5aa2f3f2d55 100644
--- a/libselinux/src/policyvers.c
+++ b/libselinux/src/policyvers.c
@@ -7,7 +7,6 @@
 #include "selinux_internal.h"
 #include <stdio.h>
 #include "policy.h"
-#include "dso.h"
 #include <limits.h>
 
 int security_policyvers(void)
@@ -42,4 +41,3 @@ int security_policyvers(void)
 	return vers;
 }
 
-hidden_def(security_policyvers)
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index c6799ef27533..1aa67ac53f39 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -57,7 +57,7 @@ static void procattr_thread_destructor(void __attribute__((unused)) *unused)
 
 void __attribute__((destructor)) procattr_destructor(void);
 
-void hidden __attribute__((destructor)) procattr_destructor(void)
+void  __attribute__((destructor)) procattr_destructor(void)
 {
 	if (destructor_key_initialized)
 		__selinux_key_delete(destructor_key);
@@ -345,22 +345,3 @@ all_selfattr_def(con, current)
     all_selfattr_def(sockcreatecon, sockcreate)
     all_selfattr_def(keycreatecon, keycreate)
 
-    hidden_def(getcon_raw)
-    hidden_def(getcon)
-    hidden_def(getexeccon_raw)
-    hidden_def(getfilecon_raw)
-    hidden_def(getfilecon)
-    hidden_def(getfscreatecon_raw)
-    hidden_def(getkeycreatecon_raw)
-    hidden_def(getpeercon_raw)
-    hidden_def(getpidcon_raw)
-    hidden_def(getprevcon_raw)
-    hidden_def(getprevcon)
-    hidden_def(getsockcreatecon_raw)
-    hidden_def(setcon_raw)
-    hidden_def(setexeccon_raw)
-    hidden_def(setexeccon)
-    hidden_def(setfilecon_raw)
-    hidden_def(setfscreatecon_raw)
-    hidden_def(setkeycreatecon_raw)
-    hidden_def(setsockcreatecon_raw)
diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
index 6732b349984c..10c3df7856e1 100644
--- a/libselinux/src/regex.h
+++ b/libselinux/src/regex.h
@@ -10,7 +10,6 @@
 #include <pcre.h>
 #endif
 
-#include "dso.h"
 
 enum { REGEX_MATCH,
        REGEX_MATCH_PARTIAL,
@@ -42,7 +41,7 @@ struct mmap_area;
  * expressions are not portable across architectures that do not have a
  * matching arch-string.
  */
-char const *regex_arch_string(void) hidden;
+char const *regex_arch_string(void) ;
 
 /**
  * regex_verison returns the version string of the underlying regular
@@ -55,12 +54,12 @@ char const *regex_arch_string(void) hidden;
  *
  * It may return NULL on error.
  */
-char const *regex_version(void) hidden;
+char const *regex_version(void) ;
 /**
  * This constructor function allocates a buffer for a regex_data structure.
  * The buffer is being initialized with zeroes.
  */
-struct regex_data *regex_data_create(void) hidden;
+struct regex_data *regex_data_create(void) ;
 /**
  * This complementary destructor function frees the a given regex_data buffer.
  * It also frees any non NULL member pointers with the appropriate pcreX_X_free
@@ -68,7 +67,7 @@ struct regex_data *regex_data_create(void) hidden;
  * the pcre_extra data conditionally. Calling this function on a NULL pointer is
  * save.
  */
-void regex_data_free(struct regex_data *regex) hidden;
+void regex_data_free(struct regex_data *regex) ;
 /**
  * This function compiles the regular expression. Additionally, it prepares
  * data structures required by the different underlying engines. For PCRE
@@ -88,7 +87,7 @@ void regex_data_free(struct regex_data *regex) hidden;
  * @retval -1 on error
  */
 int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
-		       struct regex_error_data *errordata) hidden;
+		       struct regex_error_data *errordata) ;
 /**
  * This function loads a serialized precompiled pattern from a contiguous
  * data region given by map_area.
@@ -109,7 +108,7 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 int regex_load_mmap(struct mmap_area *map_area,
 		    struct regex_data **regex,
 		    int do_load_precompregex,
-		    bool *regex_compiled) hidden;
+		    bool *regex_compiled) ;
 /**
  * This function stores a precompiled regular expression to a file.
  * In the case of PCRE, it just dumps the binary representation of the
@@ -122,7 +121,7 @@ int regex_load_mmap(struct mmap_area *map_area,
  *			      the output file (ignored by PCRE1 back-end).
  */
 int regex_writef(struct regex_data *regex, FILE *fp,
-		 int do_write_precompregex) hidden;
+		 int do_write_precompregex) ;
 /**
  * This function applies a precompiled pattern to a subject string and
  * returns whether or not a match was found.
@@ -139,7 +138,7 @@ int regex_writef(struct regex_data *regex, FILE *fp,
  *                     regular expression
  */
 int regex_match(struct regex_data *regex, char const *subject,
-		int partial) hidden;
+		int partial) ;
 /**
  * This function compares two compiled regular expressions (regex1 and regex2).
  * It compares the binary representations of the compiled patterns. It is a very
@@ -150,7 +149,7 @@ int regex_match(struct regex_data *regex, char const *subject,
  *                       the same
  * @retval SELABEL_INCOMPARABLE otherwise
  */
-int regex_cmp(struct regex_data *regex1, struct regex_data *regex2) hidden;
+int regex_cmp(struct regex_data *regex1, struct regex_data *regex2) ;
 /**
  * This function takes the error data returned by regex_prepare_data and turns
  * it in to a human readable error message.
@@ -163,5 +162,5 @@ int regex_cmp(struct regex_data *regex1, struct regex_data *regex2) hidden;
  * @arg buf_size Total size of the given buffer in bytes.
  */
 void regex_format_error(struct regex_error_data const *error_data, char *buffer,
-			size_t buf_size) hidden;
+			size_t buf_size) ;
 #endif /* SRC_REGEX_H_ */
diff --git a/libselinux/src/reject_unknown.c b/libselinux/src/reject_unknown.c
index 5c1d36053812..96e60be396ea 100644
--- a/libselinux/src/reject_unknown.c
+++ b/libselinux/src/reject_unknown.c
@@ -37,4 +37,3 @@ int security_reject_unknown(void)
 	return reject_unknown;
 }
 
-hidden_def(security_reject_unknown);
diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinux/src/selinux_check_securetty_context.c
index 55d4e039ea41..c5c557fd3492 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -50,4 +50,3 @@ int selinux_check_securetty_context(const char * tty_context)
 	return found;
 }
 
-hidden_def(selinux_check_securetty_context)
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index b16a3851ad4a..6c5238953cb1 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -128,7 +128,6 @@ int selinux_getenforcemode(int *enforce)
 	return ret;
 }
 
-hidden_def(selinux_getenforcemode)
 
 static char *selinux_policytype;
 
@@ -141,7 +140,6 @@ int selinux_getpolicytype(char **type)
 	return *type ? 0 : -1;
 }
 
-hidden_def(selinux_getpolicytype)
 
 static int setpolicytype(const char *type)
 {
@@ -249,7 +247,6 @@ void selinux_reset_config(void)
 	init_selinux_config();
 }
 
-hidden_def(selinux_reset_config)
 
 static const char *get_path(int idx)
 {
@@ -262,7 +259,6 @@ const char *selinux_default_type_path(void)
 	return get_path(DEFAULT_TYPE);
 }
 
-hidden_def(selinux_default_type_path)
 
 const char *selinux_policy_root(void)
 {
@@ -305,42 +301,36 @@ const char *selinux_path(void)
 	return selinux_rootpath;
 }
 
-hidden_def(selinux_path)
 
 const char *selinux_default_context_path(void)
 {
 	return get_path(DEFAULT_CONTEXTS);
 }
 
-hidden_def(selinux_default_context_path)
 
 const char *selinux_securetty_types_path(void)
 {
 	return get_path(SECURETTY_TYPES);
 }
 
-hidden_def(selinux_securetty_types_path)
 
 const char *selinux_failsafe_context_path(void)
 {
 	return get_path(FAILSAFE_CONTEXT);
 }
 
-hidden_def(selinux_failsafe_context_path)
 
 const char *selinux_removable_context_path(void)
 {
 	return get_path(REMOVABLE_CONTEXT);
 }
 
-hidden_def(selinux_removable_context_path)
 
 const char *selinux_binary_policy_path(void)
 {
 	return get_path(BINPOLICY);
 }
 
-hidden_def(selinux_binary_policy_path)
 
 const char *selinux_current_policy_path(void)
 {
@@ -365,35 +355,30 @@ const char *selinux_current_policy_path(void)
 	return policy_path;
 }
 
-hidden_def(selinux_current_policy_path)
 
 const char *selinux_file_context_path(void)
 {
 	return get_path(FILE_CONTEXTS);
 }
 
-hidden_def(selinux_file_context_path)
 
 const char *selinux_homedir_context_path(void)
 {
 	return get_path(HOMEDIR_CONTEXTS);
 }
 
-hidden_def(selinux_homedir_context_path)
 
 const char *selinux_media_context_path(void)
 {
 	return get_path(MEDIA_CONTEXTS);
 }
 
-hidden_def(selinux_media_context_path)
 
 const char *selinux_customizable_types_path(void)
 {
 	return get_path(CUSTOMIZABLE_TYPES);
 }
 
-hidden_def(selinux_customizable_types_path)
 
 const char *selinux_contexts_path(void)
 {
@@ -405,7 +390,6 @@ const char *selinux_user_contexts_path(void)
 	return get_path(USER_CONTEXTS);
 }
 
-hidden_def(selinux_user_contexts_path)
 
 /* Deprecated as local policy booleans no longer supported. */
 const char *selinux_booleans_path(void)
@@ -413,7 +397,6 @@ const char *selinux_booleans_path(void)
 	return get_path(BOOLEANS);
 }
 
-hidden_def(selinux_booleans_path)
 
 /* Deprecated as no longer supported. */
 const char *selinux_users_path(void)
@@ -421,127 +404,108 @@ const char *selinux_users_path(void)
 	return get_path(USERS_DIR);
 }
 
-hidden_def(selinux_users_path)
 
 const char *selinux_usersconf_path(void)
 {
 	return get_path(SEUSERS);
 }
 
-hidden_def(selinux_usersconf_path)
 
 const char *selinux_translations_path(void)
 {
 	return get_path(TRANSLATIONS);
 }
 
-hidden_def(selinux_translations_path)
 
 const char *selinux_colors_path(void)
 {
 	return get_path(COLORS);
 }
 
-hidden_def(selinux_colors_path)
 
 const char *selinux_netfilter_context_path(void)
 {
 	return get_path(NETFILTER_CONTEXTS);
 }
 
-hidden_def(selinux_netfilter_context_path)
 
 const char *selinux_file_context_homedir_path(void)
 {
 	return get_path(FILE_CONTEXTS_HOMEDIR);
 }
 
-hidden_def(selinux_file_context_homedir_path)
 
 const char *selinux_file_context_local_path(void)
 {
 	return get_path(FILE_CONTEXTS_LOCAL);
 }
 
-hidden_def(selinux_file_context_local_path)
 
 const char *selinux_x_context_path(void)
 {
 	return get_path(X_CONTEXTS);
 }
 
-hidden_def(selinux_x_context_path)
 
 const char *selinux_virtual_domain_context_path(void)
 {
 	return get_path(VIRTUAL_DOMAIN);
 }
 
-hidden_def(selinux_virtual_domain_context_path)
 
 const char *selinux_virtual_image_context_path(void)
 {
 	return get_path(VIRTUAL_IMAGE);
 }
 
-hidden_def(selinux_virtual_image_context_path)
 
 const char *selinux_lxc_contexts_path(void)
 {
 	return get_path(LXC_CONTEXTS);
 }
 
-hidden_def(selinux_lxc_contexts_path)
 
 const char *selinux_openrc_contexts_path(void)
 {
     return get_path(OPENRC_CONTEXTS);
 }
 
-hidden_def(selinux_openrc_contexts_path)
 
 const char *selinux_openssh_contexts_path(void)
 {
     return get_path(OPENSSH_CONTEXTS);
 }
 
-hidden_def(selinux_openssh_contexts_path)
 
 const char *selinux_snapperd_contexts_path(void)
 {
     return get_path(SNAPPERD_CONTEXTS);
 }
 
-hidden_def(selinux_snapperd_contexts_path)
 
 const char *selinux_systemd_contexts_path(void)
 {
 	return get_path(SYSTEMD_CONTEXTS);
 }
 
-hidden_def(selinux_systemd_contexts_path)
 
 const char * selinux_booleans_subs_path(void) {
 	return get_path(BOOLEAN_SUBS);
 }
 
-hidden_def(selinux_booleans_subs_path)
 
 const char * selinux_file_context_subs_path(void) {
 	return get_path(FILE_CONTEXT_SUBS);
 }
 
-hidden_def(selinux_file_context_subs_path)
 
 const char * selinux_file_context_subs_dist_path(void) {
 	return get_path(FILE_CONTEXT_SUBS_DIST);
 }
 
-hidden_def(selinux_file_context_subs_dist_path)
 
 const char *selinux_sepgsql_context_path(void)
 {
 	return get_path(SEPGSQL_CONTEXTS);
 }
 
-hidden_def(selinux_sepgsql_context_path)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 61b78aaa7c10..27e9ac532c3f 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -1,116 +1,9 @@
 #include <selinux/selinux.h>
 #include <pthread.h>
-#include "dso.h"
-
-hidden_proto(selinux_mkload_policy)
-    hidden_proto(fini_selinuxmnt)
-    hidden_proto(set_selinuxmnt)
-    hidden_proto(selinuxfs_exists)
-    hidden_proto(security_disable)
-    hidden_proto(security_policyvers)
-    hidden_proto(security_load_policy)
-    hidden_proto(security_get_boolean_active)
-    hidden_proto(security_get_boolean_names)
-    hidden_proto(security_set_boolean)
-    hidden_proto(security_commit_booleans)
-    hidden_proto(security_check_context)
-    hidden_proto(security_check_context_raw)
-    hidden_proto(security_canonicalize_context)
-    hidden_proto(security_canonicalize_context_raw)
-    hidden_proto(security_compute_av)
-    hidden_proto(security_compute_av_raw)
-    hidden_proto(security_compute_av_flags)
-    hidden_proto(security_compute_av_flags_raw)
-    hidden_proto(security_compute_user)
-    hidden_proto(security_compute_user_raw)
-    hidden_proto(security_compute_create)
-    hidden_proto(security_compute_create_raw)
-    hidden_proto(security_compute_create_name)
-    hidden_proto(security_compute_create_name_raw)
-    hidden_proto(security_compute_member_raw)
-    hidden_proto(security_compute_relabel_raw)
-    hidden_proto(security_validatetrans)
-    hidden_proto(security_validatetrans_raw)
-    hidden_proto(is_selinux_enabled)
-    hidden_proto(is_selinux_mls_enabled)
-    hidden_proto(freecon)
-    hidden_proto(freeconary)
-    hidden_proto(getprevcon)
-    hidden_proto(getprevcon_raw)
-    hidden_proto(getcon)
-    hidden_proto(getcon_raw)
-    hidden_proto(setcon_raw)
-    hidden_proto(getpeercon_raw)
-    hidden_proto(getpidcon_raw)
-    hidden_proto(getexeccon_raw)
-    hidden_proto(getfilecon)
-    hidden_proto(getfilecon_raw)
-    hidden_proto(lgetfilecon_raw)
-    hidden_proto(fgetfilecon_raw)
-    hidden_proto(setfilecon_raw)
-    hidden_proto(lsetfilecon_raw)
-    hidden_proto(fsetfilecon_raw)
-    hidden_proto(setexeccon)
-    hidden_proto(setexeccon_raw)
-    hidden_proto(getfscreatecon_raw)
-    hidden_proto(getkeycreatecon_raw)
-    hidden_proto(getsockcreatecon_raw)
-    hidden_proto(setfscreatecon_raw)
-    hidden_proto(setkeycreatecon_raw)
-    hidden_proto(setsockcreatecon_raw)
-    hidden_proto(security_getenforce)
-    hidden_proto(security_setenforce)
-    hidden_proto(security_deny_unknown)
-    hidden_proto(security_reject_unknown)
-    hidden_proto(security_get_checkreqprot)
-    hidden_proto(selinux_boolean_sub)
-    hidden_proto(selinux_current_policy_path)
-    hidden_proto(selinux_binary_policy_path)
-    hidden_proto(selinux_booleans_subs_path)
-    hidden_proto(selinux_default_context_path)
-    hidden_proto(selinux_securetty_types_path)
-    hidden_proto(selinux_failsafe_context_path)
-    hidden_proto(selinux_removable_context_path)
-    hidden_proto(selinux_virtual_domain_context_path)
-    hidden_proto(selinux_virtual_image_context_path)
-    hidden_proto(selinux_lxc_contexts_path)
-    hidden_proto(selinux_file_context_path)
-    hidden_proto(selinux_file_context_homedir_path)
-    hidden_proto(selinux_file_context_local_path)
-    hidden_proto(selinux_file_context_subs_dist_path)
-    hidden_proto(selinux_file_context_subs_path)
-    hidden_proto(selinux_netfilter_context_path)
-    hidden_proto(selinux_homedir_context_path)
-    hidden_proto(selinux_user_contexts_path)
-    hidden_proto(selinux_booleans_path)
-    hidden_proto(selinux_customizable_types_path)
-    hidden_proto(selinux_media_context_path)
-    hidden_proto(selinux_x_context_path)
-    hidden_proto(selinux_sepgsql_context_path)
-    hidden_proto(selinux_openrc_contexts_path)
-    hidden_proto(selinux_openssh_contexts_path)
-    hidden_proto(selinux_snapperd_contexts_path)
-    hidden_proto(selinux_systemd_contexts_path)
-    hidden_proto(selinux_path)
-    hidden_proto(selinux_check_passwd_access)
-    hidden_proto(selinux_check_securetty_context)
-    hidden_proto(matchpathcon_init_prefix)
-    hidden_proto(selinux_users_path)
-    hidden_proto(selinux_usersconf_path);
-hidden_proto(selinux_translations_path);
-hidden_proto(selinux_colors_path);
-hidden_proto(selinux_getenforcemode);
-hidden_proto(selinux_getpolicytype);
-hidden_proto(selinux_raw_to_trans_context);
-hidden_proto(selinux_trans_to_raw_context);
-    hidden_proto(selinux_raw_context_to_color);
-hidden_proto(security_get_initial_context);
-hidden_proto(security_get_initial_context_raw);
-hidden_proto(selinux_reset_config);
-hidden_proto(selinux_flush_class_cache);
-
-extern int require_seusers hidden;
-extern int selinux_page_size hidden;
+
+
+extern int require_seusers ;
+extern int selinux_page_size ;
 
 /* Make pthread_once optional */
 #pragma weak pthread_once
@@ -180,4 +73,4 @@ extern int selinux_page_size hidden;
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
 
-extern int has_selinux_config hidden;
+extern int has_selinux_config ;
diff --git a/libselinux/src/setenforce.c b/libselinux/src/setenforce.c
index 09cad3ceaf9d..a87ff2d08e30 100644
--- a/libselinux/src/setenforce.c
+++ b/libselinux/src/setenforce.c
@@ -34,4 +34,3 @@ int security_setenforce(int value)
 	return 0;
 }
 
-hidden_def(security_setenforce)
diff --git a/libselinux/src/setfilecon.c b/libselinux/src/setfilecon.c
index d05969c6c2f3..bd45f12cf707 100644
--- a/libselinux/src/setfilecon.c
+++ b/libselinux/src/setfilecon.c
@@ -25,7 +25,6 @@ int setfilecon_raw(const char *path, const char * context)
 	return rc;
 }
 
-hidden_def(setfilecon_raw)
 
 int setfilecon(const char *path, const char *context)
 {
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index fa188a824f78..52a8ba78b2ad 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -19,7 +19,6 @@
 #include <ctype.h>
 #include <unistd.h>
 #include <sys/uio.h>
-#include "dso.h"
 #include "selinux_internal.h"
 #include "setrans_internal.h"
 
@@ -260,7 +259,7 @@ static void setrans_thread_destructor(void __attribute__((unused)) *unused)
 
 void __attribute__((destructor)) setrans_lib_destructor(void);
 
-void hidden __attribute__((destructor)) setrans_lib_destructor(void)
+void  __attribute__((destructor)) setrans_lib_destructor(void)
 {
 	if (!has_setrans)
 		return;
@@ -327,7 +326,6 @@ int selinux_trans_to_raw_context(const char * trans,
 	return *rawp ? 0 : -1;
 }
 
-hidden_def(selinux_trans_to_raw_context)
 
 int selinux_raw_to_trans_context(const char * raw,
 				 char ** transp)
@@ -369,7 +367,6 @@ int selinux_raw_to_trans_context(const char * raw,
 	return *transp ? 0 : -1;
 }
 
-hidden_def(selinux_raw_to_trans_context)
 
 int selinux_raw_context_to_color(const char * raw, char **transp)
 {
@@ -410,7 +407,6 @@ int selinux_raw_context_to_color(const char * raw, char **transp)
 	return *transp ? 0 : -1;
 }
 
-hidden_def(selinux_raw_context_to_color)
 #else /*DISABLE_SETRANS*/
 
 int selinux_trans_to_raw_context(const char * trans,
@@ -426,7 +422,6 @@ int selinux_trans_to_raw_context(const char * trans,
 	return *rawp ? 0 : -1;
 }
 
-hidden_def(selinux_trans_to_raw_context)
 
 int selinux_raw_to_trans_context(const char * raw,
 				 char ** transp)
@@ -440,5 +435,4 @@ int selinux_raw_to_trans_context(const char * raw,
 	return *transp ? 0 : -1;
 }
 
-hidden_def(selinux_raw_to_trans_context)
 #endif /*DISABLE_SETRANS*/
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index 7ec7d12c4546..fff80c1ad47b 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -88,7 +88,7 @@ static int process_seusers(const char *buffer,
 	return -2;		/* error */
 }
 
-int require_seusers hidden = 0;
+int require_seusers  = 0;
 
 #include <pwd.h>
 #include <grp.h>
diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index 004fcd3b28c0..9a8ce01dceda 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -23,7 +23,6 @@
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 #include "sha1.h"
-#include "dso.h"
 #include <memory.h>
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@@ -126,7 +125,7 @@ void
 //
 //  Initialises an SHA1 Context. Use this to initialise/reset a context.
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-void hidden
+void 
     Sha1Initialise
     (
         Sha1Context*                Context
@@ -148,7 +147,7 @@ void hidden
 //  Adds data to the SHA1 context. This will process the data and update the internal state of the context. Keep on
 //  calling this function until all the data has been added. Then call Sha1Finalise to calculate the hash.
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-void hidden
+void 
     Sha1Update
     (
         Sha1Context*        Context,
@@ -191,7 +190,7 @@ void hidden
 //  Performs the final calculation of the hash and returns the digest (20 byte buffer containing 160bit hash). After
 //  calling this, Sha1Initialised must be used to reuse the context.
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-void hidden
+void 
     Sha1Finalise
     (
         Sha1Context*                Context,
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 29757b750878..012a740a622e 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -180,7 +180,6 @@ void selinux_flush_class_cache(void)
 	discover_class_cache = NULL;
 }
 
-hidden_def(selinux_flush_class_cache)
 
 security_class_t string_to_security_class(const char *s)
 {
diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validatetrans.c
index 2aa300cfd90a..66ac7405baac 100644
--- a/libselinux/src/validatetrans.c
+++ b/libselinux/src/validatetrans.c
@@ -57,7 +57,6 @@ out:
 	return ret;
 }
 
-hidden_def(security_validatetrans_raw)
 
 int security_validatetrans(const char *scon,
 			   const char *tcon,
@@ -91,4 +90,3 @@ out:
 	return ret;
 }
 
-hidden_def(security_validatetrans)
-- 
2.17.1

