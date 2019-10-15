Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E7C10F14
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D6721925
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MGw0uWew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbfJON1C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:02 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:24971 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbfJON1B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:01 -0400
X-EEMSG-check-017: 35822951|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="35822951"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146020; x=1602682020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hYS0SettzC+4dJh11VdZ5u5mi0jnuv0G8YAGZNFTRk=;
  b=MGw0uWewmOjM0+3zeTsKi5juIfCkpWjMShlJAmbj867wOSz/vdOoX0tq
   FPjlxew42hNhX7oWrXfnbZiwRgzvIgnZ7VET3y6vUnhJhHtxZyzj2+Swn
   HJPkMEDiMTce3WLMKjD+vqEISiZ0lv3sKmtffj5yTyNbGnaaGkMJfO18S
   8p3EAa7vLCAZNQpfVxgFpFPDZwhTJ8XRB5q2T1LAy73GXd0XtdzFW628V
   awxstxK1alXNWasrjsbY4+NWNx6as2tfzKn7XquqeVrKXxjxTnMkn0RBT
   uPP3ku0FkaVZw6nh6dLQcSzK8TKdTAruC/BJ6kGyRY51Pk6dKKt06Im9f
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="28980476"
IronPort-PHdr: =?us-ascii?q?9a23=3A8r1q2xZrA57MJyHhyNe6YK3/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8y+bnLW6fgltlLVR4KTs6sC17ON9f+7EjFeqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrwjcuMYajItjJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlSkINyQ98GrKlMJ+iqxVqw+lqxBmw4PZZISZOfxjda3fYNwaX3?=
 =?us-ascii?q?JMUMZPWSJcDI2ybIwBAOgPPelXoIfwvEcCoBikCAWwHu7j1iNEi3nr1qM6ye?=
 =?us-ascii?q?QhFgTG0RQ9EdISrnvUtNX1O7kUUeuo0afIyC/Mb/dS2Tjj6InDbxcsoeqRUr?=
 =?us-ascii?q?JrasfR1UkuGB/FjlWXs4DlOSiV2f4Xv2iU6OpgS/uihmg6oA9yujii3togh4?=
 =?us-ascii?q?bGi44Pyl3I6D91zJg6KNGmUkJ3fNipG4ZKuS6ALYt5WMYiTnltuCY917IJp4?=
 =?us-ascii?q?a2fDMPyJQ73x7fbOGHc5SQ7hLjSumRJTB4iWp5eL2lnRay8FWgyvbmWsmo0F?=
 =?us-ascii?q?dFsipFkt7WunALyxPT8dSIRuF4/keg3TaDzwHT6udaLkAojafXNpEsz7Eqmp?=
 =?us-ascii?q?cTrEjPBDH6lUrogKOMa0ko4u2o5P7mYrXiqJ+cLYh0igTmP6Q1h8O/Gv81Mh?=
 =?us-ascii?q?QOXmeH+eS806fv/UviQLpQlPE2na7ZsI7CKcQBuqG5GxNV0pok6xunFzepys?=
 =?us-ascii?q?kYnX0cIVJdYh2HkozpN0jLIPD/Cve/mUqjnC13yPDBO73rGo/NIWTbkLf9Yb?=
 =?us-ascii?q?Z97FZRyBEtwtBb5pJUDKwBIf3oV0/vu9zXEAU5Pxa3w+n5EtV90J0RWWaVDq?=
 =?us-ascii?q?+eKqPSvgzA2uV6OOSIZYkIqB7jJPU/of3jl3k0nRkaZ6b684EQbSWDAvl+I0?=
 =?us-ascii?q?ifKUHpi9MFHHZC6hEyV8T2mVaCVnhVfH/0UKUisGJoQLm6BJvOE9j+yIeK2z?=
 =?us-ascii?q?22S9gLN20=3D?=
X-IPAS-Result: =?us-ascii?q?A2DaAQAXxqVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYFzLIE/ATIqk1MBAQEBAQEGiy6RLwkBAQEBAQEBAQEbGQECAQGEQAKCa?=
 =?us-ascii?q?yQ3Bg4CDAEBAQQBAQEBAQUDAQFshTmCOimCaQYnCwFGEFFXGYJjP4JTJbAgM?=
 =?us-ascii?q?4VNgzCBSIE0AYc0hFkYeIEHgRGDUIowBK1KgiyCMZJeDBuZQal8I4FYKwgCG?=
 =?us-ascii?q?AghD4MnUBAUgVsXjj8lAzCBBgEBkEEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4H010187;
        Tue, 15 Oct 2019 09:27:00 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 03/10] selinux: dynamically allocate selinux namespace
Date:   Tue, 15 Oct 2019 09:25:21 -0400
Message-Id: <20191015132528.13519-4-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move from static allocation of a single selinux namespace to
dynamic allocation.  Include necessary support for lifecycle management
of the selinux namespace, modeled after the user namespace support.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c              | 32 ++++++++++----
 security/selinux/hooks.c            | 68 ++++++++++++++++++++++++++---
 security/selinux/include/security.h | 25 ++++++++++-
 security/selinux/selinuxfs.c        |  3 +-
 security/selinux/ss/services.c      | 25 ++++++++---
 5 files changed, 129 insertions(+), 24 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index c53582acd99f..d2cf749b5f19 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -88,20 +88,34 @@ struct selinux_avc {
 	struct avc_cache avc_cache;
 };
 
-static struct selinux_avc selinux_avc;
-
-void selinux_avc_init(struct selinux_avc **avc)
+int selinux_avc_create(struct selinux_avc **avc)
 {
+	struct selinux_avc *newavc;
 	int i;
 
-	selinux_avc.avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
+	newavc = kzalloc(sizeof(*newavc), GFP_KERNEL);
+	if (!newavc)
+		return -ENOMEM;
+
+	newavc->avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
+
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
-		spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
+		INIT_HLIST_HEAD(&newavc->avc_cache.slots[i]);
+		spin_lock_init(&newavc->avc_cache.slots_lock[i]);
 	}
-	atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
-	atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
-	*avc = &selinux_avc;
+	atomic_set(&newavc->avc_cache.active_nodes, 0);
+	atomic_set(&newavc->avc_cache.lru_hint, 0);
+
+	*avc = newavc;
+	return 0;
+}
+
+static void avc_flush(struct selinux_avc *avc);
+
+void selinux_avc_free(struct selinux_avc *avc)
+{
+	avc_flush(avc);
+	kfree(avc);
 }
 
 unsigned int avc_get_cache_threshold(struct selinux_avc *avc)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6292fdd2b01f..7a4ed553cec0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -103,7 +103,6 @@
 #include "audit.h"
 #include "avc_ss.h"
 
-static struct selinux_ns init_selinux_ns;
 struct selinux_ns *current_selinux_ns;
 
 /* SECMARK reference count */
@@ -7045,15 +7044,70 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 #endif
 };
 
+static void selinux_ns_free(struct work_struct *work);
+
+int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns **ns)
+{
+	struct selinux_ns *newns;
+	int rc;
+
+	newns = kzalloc(sizeof(*newns), GFP_KERNEL);
+	if (!newns)
+		return -ENOMEM;
+
+	refcount_set(&newns->count, 1);
+	INIT_WORK(&newns->work, selinux_ns_free);
+
+	rc = selinux_ss_create(&newns->ss);
+	if (rc)
+		goto err;
+
+	rc = selinux_avc_create(&newns->avc);
+	if (rc)
+		goto err;
+
+	if (parent)
+		newns->parent = get_selinux_ns(parent);
+
+	*ns = newns;
+	return 0;
+err:
+	selinux_ss_free(newns->ss);
+	kfree(newns);
+	return rc;
+}
+
+static void selinux_ns_free(struct work_struct *work)
+{
+	struct selinux_ns *parent, *ns =
+		container_of(work, struct selinux_ns, work);
+
+	do {
+		parent = ns->parent;
+		selinux_ss_free(ns->ss);
+		selinux_avc_free(ns->avc);
+		kfree(ns);
+		ns = parent;
+	} while (ns && refcount_dec_and_test(&ns->count));
+}
+
+void __put_selinux_ns(struct selinux_ns *ns)
+{
+	schedule_work(&ns->work);
+}
+
+static struct selinux_ns *init_selinux_ns;
+
 static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
 
-	enforcing_set(&init_selinux_ns, selinux_enforcing_boot);
-	init_selinux_ns.checkreqprot = selinux_checkreqprot_boot;
-	selinux_ss_init(&init_selinux_ns.ss);
-	selinux_avc_init(&init_selinux_ns.avc);
-	current_selinux_ns = &init_selinux_ns;
+	if (selinux_ns_create(NULL, &init_selinux_ns))
+		panic("SELinux: Could not create initial namespace\n");
+
+	enforcing_set(init_selinux_ns, selinux_enforcing_boot);
+	init_selinux_ns->checkreqprot = selinux_checkreqprot_boot;
+	current_selinux_ns = init_selinux_ns;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
@@ -7226,7 +7280,7 @@ int selinux_disable(struct selinux_ns *ns)
 	 * within the ns will interpret the absence of a selinuxfs mount
 	 * as SELinux being disabled.
 	 */
-	if (ns != &init_selinux_ns)
+	if (ns != init_selinux_ns)
 		return 0;
 
 	pr_info("SELinux:  Disabled at runtime.\n");
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e22e281992d8..971fd5f53b6e 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -99,6 +99,8 @@ struct selinux_avc;
 struct selinux_ss;
 
 struct selinux_ns {
+	refcount_t count;
+	struct work_struct work;
 	bool disabled;
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 	bool enforcing;
@@ -108,10 +110,29 @@ struct selinux_ns {
 	bool policycap[__POLICYDB_CAPABILITY_MAX];
 	struct selinux_avc *avc;
 	struct selinux_ss *ss;
+	struct selinux_ns *parent;
 };
 
-void selinux_ss_init(struct selinux_ss **ss);
-void selinux_avc_init(struct selinux_avc **avc);
+int selinux_ns_create(struct selinux_ns *parent, struct selinux_ns **ns);
+void __put_selinux_ns(struct selinux_ns *ns);
+
+int selinux_ss_create(struct selinux_ss **ss);
+void selinux_ss_free(struct selinux_ss *ss);
+
+int selinux_avc_create(struct selinux_avc **avc);
+void selinux_avc_free(struct selinux_avc *avc);
+
+static inline void put_selinux_ns(struct selinux_ns *ns)
+{
+	if (ns && refcount_dec_and_test(&ns->count))
+		__put_selinux_ns(ns);
+}
+
+static inline struct selinux_ns *get_selinux_ns(struct selinux_ns *ns)
+{
+	refcount_inc(&ns->count);
+	return ns;
+}
 
 extern struct selinux_ns *current_selinux_ns;
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a69381f94d37..41270a783cf5 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -90,7 +90,7 @@ static int selinux_fs_info_create(struct super_block *sb)
 
 	mutex_init(&fsi->mutex);
 	fsi->last_ino = SEL_INO_NEXT - 1;
-	fsi->ns = current_selinux_ns;
+	fsi->ns = get_selinux_ns(current_selinux_ns);
 	fsi->sb = sb;
 	sb->s_fs_info = fsi;
 	return 0;
@@ -102,6 +102,7 @@ static void selinux_fs_info_free(struct super_block *sb)
 	int i;
 
 	if (fsi) {
+		put_selinux_ns(fsi->ns);
 		for (i = 0; i < fsi->bool_num; i++)
 			kfree(fsi->bool_pending_names[i]);
 		kfree(fsi->bool_pending_names);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index defc70ac9fd1..57d6b8dddc54 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -76,13 +76,28 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"nnp_nosuid_transition"
 };
 
-static struct selinux_ss selinux_ss;
+int selinux_ss_create(struct selinux_ss **ss)
+{
+	struct selinux_ss *newss;
+
+	newss = kzalloc(sizeof(*newss), GFP_KERNEL);
+	if (!newss)
+		return -ENOMEM;
+	rwlock_init(&newss->policy_rwlock);
+	mutex_init(&newss->status_lock);
+	*ss = newss;
+	return 0;
+}
 
-void selinux_ss_init(struct selinux_ss **ss)
+void selinux_ss_free(struct selinux_ss *ss)
 {
-	rwlock_init(&selinux_ss.policy_rwlock);
-	mutex_init(&selinux_ss.status_lock);
-	*ss = &selinux_ss;
+	if (ss->sidtab)
+		sidtab_destroy(ss->sidtab);
+	policydb_destroy(&ss->policydb);
+	kfree(ss->map.mapping);
+	if (ss->status_page)
+		__free_page(ss->status_page);
+	kfree(ss);
 }
 
 /* Forward declaration. */
-- 
2.21.0

