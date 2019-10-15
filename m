Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0B7C10F14
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50C218DE
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="a9rSw5TU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfJON1Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:16 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:20319 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbfJON1Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:16 -0400
X-EEMSG-check-017: 22420372|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="22420372"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146031; x=1602682031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BW59c7kdtByRsIyzmc0RxXEvuBE/xipMs29u3MlrWeQ=;
  b=a9rSw5TUAlmZI17mkK7ns89sifIB0/DOClyQQKzmybl0RHMJlET2JnIH
   ik9XGPlhe3/OIj2BxXE/vFgpeIT+pPFKtnXafehty5eFiueJ8ZOTPybJV
   RnYPBdP87IUyVGZ5X2ia/Eojs9mF/2O1xskNuv8LiwT2FLjPR3w/qlPI7
   l4+/CEWs2m9ATYvttSExtO4xUYmaNSCCf2hG6a0lYgTqudCgsINDvjK34
   agniFOIkbUR7eOc4dLUIDw6RV9XsiNUhKsHDKTm8Jc2rOQxlU1ZgLDHMh
   FAPr2UHnGvOZi6hMzgaVNNo/JSvZsig5zwZl2dN+Wg6msBeQcZZMXg30N
   A==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34156708"
IronPort-PHdr: =?us-ascii?q?9a23=3ALMavgR093ux6gU1HsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIWLvad9pjvdHbS+e9qxAeQG9mCsLQb0KGL7ejJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7F/IRu5oQjRt8QdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LplRx/yjCcMKiA3/mfZhMdtiK5XuRKsqhh6z4PSfYqbNudxfrnFcN0aW2?=
 =?us-ascii?q?RPQ8hfWS9GDIy+YYsAAOUPMP1Eo4T+vVYCsQGzCRWwCO7p1zRGhmX23ao/0+?=
 =?us-ascii?q?k5DA/GwBIvH8oOsHvKqtX+KbocUeWvw6nMyTXMcfNX0ir65YjTbx8huuqBXa?=
 =?us-ascii?q?5wcMXNyUkvEBnJjlOLqYP/JT+V2eMNs3aC4udmSOmhiHYnphlsrjWgycogkI?=
 =?us-ascii?q?nEip8Pxlza+ih13pw5KcC+RUVme9CrCoFQuDufN4ZuR8MiRHxntzgix70dvJ?=
 =?us-ascii?q?67YDAKyJM6xx7Dc/CHc5aH4hbkVOuJPTd3nmhleLOihxap60Sg1u39WdW00F?=
 =?us-ascii?q?ZNtCZFlMXDtmsR2BDJ78iHS/998l+g2TaJyQ/T9vlJLV07mKfUMZIswqM8mo?=
 =?us-ascii?q?ANvUnMACP6glj6gLeTdko+++io7+rnYq/hpp+ZL4J0kRzxMr81l8yjAeU3Lg?=
 =?us-ascii?q?gOX2+B9eS6z73s51f1QLpNjv0oiqXZqozVJdwHpq6lBA9Yyp4j5AyiDzeiy9?=
 =?us-ascii?q?kYhWMILE9BeB6eiojpPFbOIOrmAvuln1uslzJrzejcPrL9GpXNMmTDkLD5cL?=
 =?us-ascii?q?Zm9UFczAszzdZC55NbEbwBPv3zVVHrtNDCDR82LRa0w+D5B9V5zI8eXniPAq?=
 =?us-ascii?q?DKeJ/V5ESF4uMpPvmkeoAYonD+JuIj6vqoimU2ynEHeqz85ocacHC1GLxdJk?=
 =?us-ascii?q?ydZXf9yoMaHXwiohs1TOusjkaLFzFUeSDhDOoH+jgnBdf+Xs/4TYe3jenEgX?=
 =?us-ascii?q?a2?=
X-IPAS-Result: =?us-ascii?q?A2CoBwAuxaVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CyBPwEyKpNSAQEBAQEBBosukS8JAQEBAQEBAQEBGxkBAgEBhEACgmskOBMCD?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTmCOimCaQYnCwFGEFFXGYJjP4JTJbArM4VNgy6BS?=
 =?us-ascii?q?IE0hzWEWRh4gQeBEYNQhC6GAgSNB6BDgiyCMZJeDBuZQS2pUCKBWCsIAhgII?=
 =?us-ascii?q?Q+DJ1AQFIFbF44/JQMwgQYBAZBBAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4M010187;
        Tue, 15 Oct 2019 09:27:01 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 08/10] selinux: introduce cred_selinux_ns() and use it
Date:   Tue, 15 Oct 2019 09:25:26 -0400
Message-Id: <20191015132528.13519-9-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When using the SID from a cred, we should pass the selinux
namespace associated with the cred on security server calls
rather than the current selinux namespace, since they could differ.
In some of these cases, the cred is always obtained from the current
task so there is no real change, but this is cleaner and hopefully
less fragile. In other cases, the cred could in fact differ.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 40 ++++++++++++++---------------
 security/selinux/include/security.h |  2 ++
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 28cc75e5361b..227d5bec868e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -484,13 +484,13 @@ static int may_context_mount_sb_relabel(u32 sid,
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  tsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
@@ -502,13 +502,13 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(current_selinux_ns,
+	rc = avc_has_perm(cred_selinux_ns(cred),
 			  sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__ASSOCIATE, NULL);
 	return rc;
@@ -1672,10 +1672,10 @@ static int cred_has_capability(const struct cred *cred,
 		return -EINVAL;
 	}
 
-	rc = avc_has_perm_noaudit(current_selinux_ns,
+	rc = avc_has_perm_noaudit(cred_selinux_ns(cred),
 				  sid, sid, sclass, av, 0, &avd);
 	if (!(opts & CAP_OPT_NOAUDIT)) {
-		int rc2 = avc_audit(current_selinux_ns,
+		int rc2 = avc_audit(cred_selinux_ns(cred),
 				    sid, sid, sclass, av, &avd, rc, &ad, 0);
 		if (rc2)
 			return rc2;
@@ -1702,7 +1702,7 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -1776,7 +1776,7 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_ns,
+		rc = avc_has_perm(cred_selinux_ns(cred),
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -1990,7 +1990,7 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = sb->s_security;
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -2178,7 +2178,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(old),
 			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
@@ -3029,7 +3029,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, isec->sid, isec->sclass, FILE__READ, &ad);
 }
 
@@ -3084,7 +3084,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	rc = avc_has_perm_noaudit(current_selinux_ns,
+	rc = avc_has_perm_noaudit(cred_selinux_ns(cred),
 				  sid, isec->sid, isec->sclass, perms,
 				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
 				  &avd);
@@ -3601,7 +3601,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_ns,
+		rc = avc_has_perm(cred_selinux_ns(cred),
 				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
@@ -3684,7 +3684,7 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(current_selinux_ns,
+		rc = avc_has_perm(cred_selinux_ns(cred),
 				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
@@ -3760,14 +3760,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = avc_has_perm(current_selinux_ns,
+			rc = avc_has_perm(cred_selinux_ns(cred),
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file &&
 			   ((vma->vm_start <= vma->vm_mm->start_stack &&
 			     vma->vm_end >= vma->vm_mm->start_stack) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = avc_has_perm(current_selinux_ns,
+			rc = avc_has_perm(cred_selinux_ns(cred),
 					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
@@ -3967,7 +3967,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_ns,
+	ret = avc_has_perm(tsec->ns,
 			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
@@ -3992,7 +3992,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(current_selinux_ns,
+	ret = avc_has_perm(tsec->ns,
 			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
@@ -4136,7 +4136,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
@@ -6612,7 +6612,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = key->security;
 
-	return avc_has_perm(current_selinux_ns,
+	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 380ef3ede216..802644ce1381 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -166,6 +166,8 @@ static inline u32 current_sid(void)
 
 #define current_selinux_ns (selinux_cred(current_cred())->ns)
 
+#define cred_selinux_ns(cred) (selinux_cred(cred)->ns)
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 static inline bool enforcing_enabled(struct selinux_ns *ns)
 {
-- 
2.21.0

