Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B468C6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F71820672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UeX3hPoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F71820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLKWnx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:53 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:42166
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbeLKWnx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568231; bh=yzS41n1rCVRHChOBSSjNfES4FV7tKjQHrZu9+D9erQU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UeX3hPoKqVD/YNQuBS8PHgMl5zaQDEJqy0q6m5QWgDOzRZDBd7QiX3mjvVy/7wR+uZh3ngZ7yU2BXXl7bxSZh2gJq+r8VHApWZWlw5bRpmhDY76LuSAMEd5xx+hZimH+GZ+KspZp2YrBoimByLaIqi59nQi3zflWM6P71D8nofPsPduxuxYa+DW3v0GVa8EIejjaDz8FM+TpGLufaO4lUkEapkZFkunujjYa0TyCEbcJbDwizEaXwPsBij8y87ZkeSxVwxGHTPbDP7EAueGQLLmGOfD2UDosFCkhIXXowZGXqaB1cgT2GYLdmYxtLx7TuFg8bJn/wlQHPZz5vVP6Rw==
X-YMail-OSG: R.R8J4wVM1kHGFDRAkC59YJWoZP3nfRZMilZ24D_9Gqo94RD1cb7jqe2n.NPlLP
 _gg4RQaA6XXE0lKnoFjxHqRFapXHT1gVWCM7Ombddy9dOBkXnXUZfUuAPOyiWIXYbZvPRNRdBgqP
 WFo_cuZ9TPwY.AjLUsP8z4.xFIc12BOg.OYFRsyQ2aovskvQULOFzOT1xushjxuK1KuSCoS0McNN
 58PnS2HhyuOw4SociF9MXeiJzQ3l6wQHJGU4pAZM4Lb9cGtTDQJuG5f.EjvQ.wKAdl27iGxwxD09
 aBY0a3bXY1AjQHdPaVFweQpGCnpkj1to9EkvQg6KHcaiFMskGgKYCcxenUyGbui_6pP0cuwI366c
 cdJyK4Mx2rkVMZ_QoI215IgADJkgtWvHBwA0pJEdy7ONfuBozmyIgP1E6xjuEc0CCTXuFYE0LNJs
 uBeeKlGUpI45sIO.ChNpGkdTF517KdrcTtrr6a4JAlCJdJrE8KFgG22NFSITvan4F2UjIe3iP.J9
 HQP1kD2RfpqlnAzpCyGbAq978AGDmQm2.4JlflPHeXptPmr1d9_8v80Sl8.iM3ogriUsuIB3r44Z
 Km7uSKVPa7IW6juQ4Da.ZHmb_VN3umpurSP6A7dbDxi7ZQWDYtdxGLcRJHNQbq.TxUh40HsujnNf
 Wa5mb1yBCVQxLL6i6Kd.hdntbE1JNL30FyNDPL23esBKV6cl6wzupgEm48mR8q79mt.K8OqJ94ni
 BRsRsnQUQ0BmlXPIQHM8p_DdW01IUAB79BAov5STMR62ujI_e7X_hkfq.iW0vQkG8fCm0FWT3o3n
 SnAN5iOkYctkVqd2.l1AWoCPU.4SEJ.wCpSEoPwkfBMKHuCBucO.XQHFKhKXCN_ptgfjB5ITG_f1
 dVqQUzHSI8deCACV0WZnalq6R92LreJxMhlomAmEPgumdTNzKKbTggD3xa1KaknMFcJvamCX4ADp
 KT32j48jOs2UDOetdUF78wbWrPbiN.R8Kn5lry5hAAqrbOlXBE.UQ0_suEbuDBARl9jqksHGn2oJ
 rpl278XV3Y1oq6SXfMeZKw4BaKDrfeT_8CbnIiyt6e8OAAC5nnoHzuKdfblN6bLFmerWUfH_Bi4X
 lnxRbe2vLWQiCbQXmDy9XaKtWFdcLX6.pM1nrAg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:51 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 23/38] SELinux: Remove cred security blob poisoning
Date:   Tue, 11 Dec 2018 14:42:59 -0800
Message-Id: <20181211224314.22412-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The SELinux specific credential poisioning only makes sense
if SELinux is managing the credentials. As the intent of this
patch set is to move the blob management out of the modules
and into the infrastructure, the SELinux specific code has
to go. The poisioning could be introduced into the infrastructure
at some later date.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/cred.c            | 13 -------------
 security/selinux/hooks.c |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index ecf03657e71c..fa2061ee4955 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
 {
 	if (cred->magic != CRED_MAGIC)
 		return true;
-#ifdef CONFIG_SECURITY_SELINUX
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	if (selinux_is_enabled() && cred->security) {
-		if ((unsigned long) cred->security < PAGE_SIZE)
-			return true;
-		if ((*(u32 *)cred->security & 0xffffff00) ==
-		    (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
-			return true;
-	}
-#endif
 	return false;
 }
 EXPORT_SYMBOL(creds_are_invalid);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 24b6b459fa2a..41b230d459a6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3922,12 +3922,6 @@ static void selinux_cred_free(struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
-	cred->security = (void *) 0x7UL;
 	kfree(tsec);
 }
 
-- 
2.14.5

