Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D9EC6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4411C20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E9qwNAYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4411C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLKWpW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:22 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:43103
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726639AbeLKWoB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568240; bh=qbpXcajJrA98ZZWDlgqmt0cbStnF49zKm903egriuBg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=E9qwNAYrFkRahkCJ18tky1txxWbWFWRN/sEIXOybZkCPV2D0ri1ywlINFYpaW2vaBMVcHF2B+sMKo3FR0rtdmZ+DH8Shghp5c5uxPX2SMUwWYvzOkCgXhIPkH4hSiKVxRSm0zdUnzHKT8tV857xHD43b81axVmaVBvN5pP829ToJEt9znVZEOwxyEFs24RJTgdpxqFiZR/DXymALQV8Pp0zssopVZO/FxU4W0HO3e96Xkcd5OSXmCv3UeFQ4IFFdJ4A9eSAMtwc1HjM8FphUxaT4xiMaGDO5paYneAEyQbjv7aDW/DBalh2v/yhrl+gBKcxkzD8Ds35MtdyQuy6GOw==
X-YMail-OSG: AfjBwb4VM1nSUwDNELJuo9P.WUbp4xyw04hu2DBY1V4bRRDhLUlFqMp.uZfGp6k
 X5x1l1ziSYyEWyr518UzcQ59RHKKuy1tTrwxVvBagXFUtgABVZ5vDHfApWaL92RYSMhV40nXIwPv
 MCukAhZOa41otLqxuYMFPorXUr0Uln16W5QOMfV68m89t.yJ_A.73sKzcJQ8MyXUZB9GL1AKChjt
 FCavrTb8mkF4ub.iDL7CY0pB0DNr4K4R81.px7C9dht4yy7ldc5TY.AxWuUjou.X..RfR6hiXdT6
 fmpkwH647UYlMhvaQ6XTAbPBXTL6chEgsxdwYT5hCn.Uyy.t81mxnI0pIRWcUBs3lFLK0_zqRiMK
 YDqGxY5VBrp4.MQJ8sSV93Msx7XvoRVanS__2t9E2K766boKoJO2VMV9bPGL0nAHpHI.L7b2faJY
 HJfrghLOAgIBkWI8_5FJxFzX.qmINV5TBmcbOWMtqknXbuj3BkS6gnyVZezYQ0wDY_JIeNgngYWj
 7rE9WlQWE6_CgFifIWUj1plXEC3VPMn5EYWE7WNBm.AWcvP1R9W08amDYP_GtEzSgjfTmvJeX4EQ
 6htYG43lHVm9A95qKEUaK_XiBRIuGr0YRi4Q.aVUaLqAoo0wYN21Eg36U3iUCVZOyO22TrxoYH0R
 fzUQlx0FA9FY2kH2t4bZZKZxqQARaWlYqu8lhINIR0E9AMC5ot_fhrsvEWqK3eoEI4z9awEJdgvg
 v6Crxcrwu_U_fn1IUkDNpBMZNhfHS.EJztxHO03Palb4Np96gg4I2w0U_9sl5L7Cx6JO2O4GBN9E
 Y42R2tP.tb1woIPEs6iN7.tBNEBo_aTqeqetC0F3g6rDhS33tdkfdeTSk3y5iBfSAbzcaWMAX80h
 mgySH_YLcOkUdwB2tILEgLCoeYpJWhbJxhOJRq9mH6lvJggrs9VDM4QMlev884hPQL_Ttc6AIvZ6
 3V18a1fCeUFcfzuSJqn1MX45ZMYFw67jhWfe8eRFGtCxyDOtq57Y1PleyEiG3nVmPxd5JKgF4iH3
 XV7796r9YWmlkJEXZfMTimkwGsWRF59c10VRA1O2GcNA7CcNCz.FSjKSWJI2.q044q4taw9L5el6
 iDEr5D9htcl6OmU.iSP4LO3oBxnnHSerNii4uOA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:00 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 28/38] SELinux: Abstract use of file security blob
Date:   Tue, 11 Dec 2018 14:43:04 -0800
Message-Id: <20181211224314.22412-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ac6d8a2d00f1..ce1d37378eb5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -393,7 +393,7 @@ static int file_alloc_security(struct file *file)
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	file->f_security = NULL;
 	kmem_cache_free(file_security_cache, fsec);
 }
@@ -1881,7 +1881,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2225,7 +2225,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3537,7 +3537,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3572,7 +3572,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3824,7 +3824,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3839,7 +3839,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3863,7 +3863,7 @@ static int selinux_file_open(struct file *file)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
@@ -4002,7 +4002,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(&selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c2974b031d05..e0ac2992e059 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -165,4 +165,9 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
 
+static inline struct file_security_struct *selinux_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.14.5

