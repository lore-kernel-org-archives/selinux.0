Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382BC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62A321736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DJ6lfw6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfDSAql (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:41 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:43199
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbfDSAql (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634799; bh=+cOk5EbWObSrJ4n/q5EXan1kjg10sH4/KzvjAQgXLT4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DJ6lfw6a0X+l7xz5Y+RkFJPS/zDXbt+DkxZbuvwYdHLTVl+dJ2RavtLQnExSfBdl41p1/W0+JKtTi8ofhTnSFORkmTlY2eyIW/IYtGNoC5GJou7q2C1D7DbiXQWz5o7oTQo/7CNKbQsx/87MZ4Z6vSDuDBiQpT+6HlsoVeL5KeTeTYuXGpZHEgIfnfkZH9YqhbPXE/1kIZb7ONtj5sSwTRMAA/AuKm5yvzJcQDWVtwGJQRP9KnfDstiJOMgjtnTUEQW+IVy6HaDMNGTo8BNUICDvR068S8VnEb2aPMTKV6m4Rqtlyhg9lp+90kDFp5SZc0EUBzYaYhfF5eTYb89bvw==
X-YMail-OSG: WEvLf1UVM1l8OpY6Zk6ix9HHDYeinLLuZdEOxanGk_s6gABXscSw0Maki9YPrG2
 6t7UWbOe7LZD47sxH_oTzwddNF6RiA_L.i6nqnRyRiSQdqIz_jkI0LhBgLL7AqJT73glrrFl8iEp
 egBCIXEq07OYD7VYA.ZDxIKDnwdUBLuXGoHRqcyTtOJRS6sTIYmCRbvgQwhOa2tMgLZ_rjTi_6.4
 ubVKuf42dvt15Iud8uGjIN0Q90LQqiA4PTgAzI.09N__3QjHghf6ASA24L9vDuRegm62mZP.X_Jc
 IgsTkBTsm0Mjy0Y7Y.kwsxIu3kZMOinTGXjVvvv95w_TM4hWtq9UCaoRFs_bNVdSkBpD08LrgoDZ
 6Z5oX5UOUB.ywYS9DZ9UvrAs405Bq7ZWRDFAiPFV7TprRCePchmClXIPKg7z6Hd2ohfDiOuirKho
 AV5RoZHxRsztOn08fC.Og41uUDfVeSLjTKVzHNJDY.dfSbyJL7U0AeFGoSW.RX.FZpVIMzjP47BV
 JswcyjA1QdLPjkcdcdSzwnXSH5DqanuAu9ix5WlVUmuYVYUSCxIRtpi2H..IgREgAr6kFZcRbmg8
 t76dEb0oS9YlZtmxK9Wp13okjcWKzrN7i4_9l1nRuHVctvbLXcjjVYHJK9vY.dUbspLJ7IV8BDgw
 1tsli8GZPwZHLL5dSVMr7hhm96kLtoMHDHafA_DxLHRmSYxqvQix.T5cfHhMmxlhC.hWCp089gyg
 ApJTVVu.Gfb7Eb8WqtUKWNnhN14upL.WPtb4QooQzUpDvpTr9alSMq5yPaBoUfy1SLisZYmKhSS2
 x.VdB6GxarQ3Qb9Q8BzsotdIGo9wY3o3qaSslUK9zlJmYq2MlZtKI1xo8NHr52TiBXN57N83qlqp
 dAAkqH8Ve417J6I5IhAGL7Ss_JpC9Pxi.nqCzmvUOnVmRzSxBwwhKkFNiScixW2AjoE6R2TN7fPW
 7R3zOUbv844.eCNri5_nllAb3oDJJ_Mr16BaXpyNhk.gWYtFzaVBOWGn4Qqx5U.vVhlfa2OTJCVc
 IY5dz8px72iAd.yJKpz2VfENxw6QEnySQMoUS5D_prPjdfb6wy1xh6wgZAWFlrowizpcX7EqAhp3
 7Cvik7dDxS0Bc2RhdH1Z2P4BQsVd1luLyRKZsTbNyjLZgUQpSQ0Lz05nq6VRNbm83NFSXWQl3si3
 rKv2TKZwu
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 832c03259c9605aacd6ad56a0995a740;
          Fri, 19 Apr 2019 00:46:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 06/90] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Thu, 18 Apr 2019 17:44:53 -0700
Message-Id: <20190419004617.64627-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

