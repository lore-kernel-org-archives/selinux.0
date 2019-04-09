Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A55FC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4609C2084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xk+aabNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDITS7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:18:59 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:38015
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbfDITS6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837538; bh=+cOk5EbWObSrJ4n/q5EXan1kjg10sH4/KzvjAQgXLT4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Xk+aabNAa5zyIrshbvQ8vFifwNkPiVvw1eKGsG8Q/0YhCLkdFe6ZacfCGeON//voFMTcJxZuDWe+de2oh1q3AbQcrLvwI8Q+/uRaQv6gJtPzmEFZDc0SAZ511hY10PLIHZXhiSBDN4RDLSU3XG9Z1WIC/oUl3VXwq6EuofVa7BwoxScQcCjCOund4PpmNBNQ4gV4Ydr/+if9TJWxcaOJ+Dy+Vzo1PT1XoTBrmj/nhnBim7V3ysNDeY0emjoIS2ULgUn1BzoN526ieffNqy1jfMOidVq+ZT0Ubqfy8dCJNu1cqLhU2qkKO21KHRWr8M0RCgt8oVtsO9lskbFMGXqbKg==
X-YMail-OSG: xLc4JnQVM1nkasSbLMAjNbYrz2f5yhr.oEoWdvjNbzCCvt9QoRRm4R4igoZg.lJ
 Jakmfrey835P.RCFChXX4kwgSjsL.B0rOKsQ97i_uArCahzgGkgiVjakOQIV8_WxKvcKR981PmYW
 JIefDyi.at467wJuPLpzFPG3Wcl0zF2QEQxmxvdDcfV2uJIjzU96.Qj8DeKeVXSwYdHwYM6bLGdW
 CYddfAcMkSVmEvdyGvchqijRTWwCikhaRCLbiWIjofDlKBgfllUXctqeq7qhP84HnU4osnluSXfe
 gehWtDF9nMtETDBvG2cuhRPXRFICFZHAc6xIAlTcfI81j.Ndcv8EWSIj9S8iII66vVcb89Xzs_Z4
 8f2FUy.lqqmQt08bGle.ocBgElWbPYCL6h_yPbMyDftWzuqtU1VNJdtD8i44hNV7fDglBXiYYSOl
 503QUlAgYy3cX42jLs1oOgai4E7fv931hTC3CUoApeYVSVgoR4e88m.Mo7P7NwzDtevL_XheGVXG
 MeBXSz1isb3xASKUWSjqei7TaIoaAwOt79HFPxZTAJs12EQf_NMZA3.roaXo_wEuZ7w5i4f4alC.
 Kbkh6NHl2PwcbYrkOcZ1wDgBYfY.JGhboCy5zH9PTajssh1BXNKMU8IhiUrIPOSRsc3rtPTHzId9
 YAJEfqZ.8mwqBgglcCVTyw5oOvf7knzDpRvq91PkFD8iJ4rS3vtWUpLwE8yhedxC5WwIMvqzNc9s
 vg4_21J5RYCiYE2MueyofevkFkySKbf2IwufX06zKDRrTKVQlPn9DVAV2GZ87XJ07.0OcCj1qq9d
 uM7NE2F2mAv7CHjnRd.83tQijJX7JFsqcyR6Cr7efY9G3rBB.EF6KTE_6f9aXr2ElO3SegT7y8BU
 2g864Cvwf1exJvlvLOZqNTMnSyDOPPWNlZtL0EKdXvMStw0mptcXIe7dyDqFZk5js2seCMR8yX3V
 5ipZC2PhB5Kh2IOu9gUNKegErgFGcH96bcxQKceV4tyJGg_G3EyTehR4OprIbVwVwR9VEyXMlE5Q
 5AKCI_OM3AfP15se5lGDlkIJtoxfaxCL9es0mKYYbWVjH9Dm6ckgYSJ1bxhbNhQHcAIUBQX00YhS
 9llqr1emPD0nH685pwiGfUuLDMaAVBIpAlVLTjgLL.3MwvRnohB8_5g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:18:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b77b874e22efcf04356cc7acbadd009c;
          Tue, 09 Apr 2019 19:18:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 06/59] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Tue,  9 Apr 2019 12:17:55 -0700
Message-Id: <20190409191848.1380-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the cred_getsecid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_cred_getsecid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 +++--
 security/security.c        | 6 ++++--
 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index baeb83ef487d..2fe54dff3efa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -572,7 +572,8 @@
  *	Transfer data from original creds to new creds
  * @cred_getsecid:
  *	Retrieve the security identifier of the cred structure @c
- *	@c contains the credentials, secid will be placed into @secid.
+ *	@c contains the credentials
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
@@ -1604,7 +1605,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
-	void (*cred_getsecid)(const struct cred *c, u32 *secid);
+	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
diff --git a/security/security.c b/security/security.c
index a1f28a5e582b..ca485a777ca1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1638,8 +1638,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
 void security_cred_getsecid(const struct cred *c, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(cred_getsecid, c, &data);
+	lsm_export_secid(&data, secid);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0e31be22d9bb..f97dd414ac8d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3764,9 +3764,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	*tsec = *old_tsec;
 }
 
-static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
+static void selinux_cred_getsecid(const struct cred *c, struct lsm_export *l)
 {
-	*secid = cred_sid(c);
+	selinux_export_secid(l, cred_sid(c));
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5e345122ccb1..15579bdd7244 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1980,13 +1980,13 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
+static void smack_cred_getsecid(const struct cred *cred, struct lsm_export *l)
 {
 	struct smack_known *skp;
 
 	rcu_read_lock();
 	skp = smk_of_task(smack_cred(cred));
-	*secid = skp->smk_secid;
+	smack_export_secid(l, skp->smk_secid);
 	rcu_read_unlock();
 }
 
-- 
2.19.1

