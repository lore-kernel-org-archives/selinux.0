Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8284DC282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4B02082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iVSnesLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDIVkF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:05 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:40108
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbfDIVkF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846003; bh=+cOk5EbWObSrJ4n/q5EXan1kjg10sH4/KzvjAQgXLT4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iVSnesLvuWtaGSHlX77nm3XEHEDIgsXjVWup+NZxhREUwFCwjqsXEO2g8R6RNzdEasofcK5zO5n7jFNJf5x3q8nQ/I6Ericb/sDULGgEpzb8aYvrpE7wI7x/NNpIzZo7EyBW3ivmT9dNrlrsAvbXlY35Ocg1oW/1NYV+xjHQv5U4sAHR1UyBkEsFLZjl6EBEbNZ7b2e/n2WdVaWCu75+RNtThIHaMhoDPc1hnguBqekX4ZOTRPWVVHR57jWWNDm6hB383VGs3sdbYLu3P7nYT17R10eLp2GPrpvXLNXq+R82Q14b79LGbULoSwq0V8jc/StE8epRl/LDS9r6byAvew==
X-YMail-OSG: s9q9MmgVM1li3i8R13VahEeBWs2zE6FEmcw8xGG_Kmr6qnIHeaKKfYsCmY.o_6A
 P7L6G6FTLUyGjAP26cx7_E5yEHRAmHP661ZpWN9.7ORAnINzsig5.kyj0sE1yLisPzMjZpvPrnRB
 _ACZfCl8VAVGlAvBf8_LLmoxFB.X0Dd.clUd9l6KBlaPHw3bxPnnR9N6Wk1G5pU3TPzLRs4r5EF0
 91bkb0divxqt_TgGbpEt_LQRZY8hWX4UZ_c3foBmguEPTSY9_X.AZJfxUOwrbUGMAinx6Uu_Uk3r
 j9IcOKRNZq7I.a23hG0mqVEh28BTUksTpnd4xEJwv5DmKroPCPcXh7NLZwB1Vc5UiommlWHrERRO
 nTL2utNzVndnNf90yM4GWNziONuHzNqwXPrI3HSlTmrASjTwh4aGmchYvdnkQ9JLvhqeS0siHyYo
 22uuBeH0P2796XOoIE_6UQgz5Man9TkzknSlueukaQnqIMUUEDBFsd_46WI5WITGW5jURoPVgaVw
 TKo0c1YNnIXEtnFvufWM1WuKoCe6q7yfYOxyrbkQrp5qtgJ1kVXA8Z0lVNSUayWhOTOn7uIceflr
 G06mcb90yAt6wqPq0Bp4dptCGF_b0h_dWEUJhf7rgHS3P_m3eYDjjQYebYZlh5GV5sK.ciDenoLt
 duoqM1M8Ju4eozmoTZEdUnt3tMdysT6P2szU6UF7VAgD8dODyvhxNnhCsZfW7DFqbs8f2FhbK8eb
 UgA4HXTWwhvrb4rmrby5K_KYlkt.abv2w5Ki9Ek0cHlMpWV9P6l6..mbMfd122MA.lPdje90WRso
 y3owWMxhCPgyV1sKVSkT_tkx1986vb4c_D0Td5QhoOUzclyDfz.XIIVaR7RX7dU2rMRkOF8yghud
 aycTg1Y4lEcrEuKCy.OUlgXOTpNegHdPYT68EyisrCqFrIY75peW5HHiTY1od0CfnZUDGpr0S4P0
 SZoN2mF4zpMMqZAgsokbZCh_8UWENHJCZFYbKdFumjcaaEeNf89eunSSEJZrpbmu8SCqmUBH7Nc4
 cAJwR7hlVZthhxevz.wZMkOsxnmEHR8867JJI97w.4Y.bvG4SL3_.63xfWZkaTdUOEFiMW.ZiZl4
 WNcqdLPJlBIBT4Bbv4hVF0mEJaKytE2LVl3O0eUrAa5JDNffmTLalxrAe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41cfc07a55038469dc17a23ac993d21e;
          Tue, 09 Apr 2019 21:40:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 06/59] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Tue,  9 Apr 2019 14:38:53 -0700
Message-Id: <20190409213946.1667-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

