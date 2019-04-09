Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9FC282E2
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194CD2084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="brdKXOVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDITTC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:02 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:42603
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbfDITTA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837539; bh=is2u5Y0DRwzBY1W00Se6/XMCwBAVUpvFG8LStFYaqTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=brdKXOVH4ZGG9eDCWfv7cw0wgGCNJr55iRLlPjwdiZ8vW4imddWLAsdPHyCLI6HXpXtxByGCQ+hz2NSyQpWSM4sfVWUYCiBZejD3w2Ay0fGc5guwy2LA2M/yX5dp4cLEhlTG6+q6RIfsN+9rKiQpo6NjspClIi8b25DAI9x8PQuxGNt95+DX3lmalFb47xfdTFXVbl2sHUMqvw/8Gn7et6gxBzi6CSsrnH7y76qUwQUAQWosYqN/xVPisqpqUl4LdKNGsrOhwM3wk/I+Z9RO7OtZtlWR1DNjK/p4qdtM+/wJj8oQNAiPQjSoxFBTz7tDI5WB40GGXt4vMXDulxw7Pg==
X-YMail-OSG: wa1_NfIVM1lo.t5e66ckfC52nugyNo1vysEdojKWWT_N_Fc8KaP3R.uN0c.i5tZ
 3qXIfVynPAngUC6rHUoi6nasYbnfbXTaVrrj6j6Ss0y1pBnHXWfuOhBAQLiGZ6i0A7njEv1mXvCb
 IrfTpJS8pwvkuFKWAlsCT5k1pbEeIXrUYqeyaKg_H3bKBypDVP6xRC6tjnLQe5qnlunePaG.sXrR
 Bh1gWuU.HNKfeVvNY_4SBnrZXOGqxPdpIRgMLf.sTHFvKJdp6cR_ZAydWIn6LNgN5uvdR4MYqJCp
 XOWpK1cVhZgAwM1rGtCRGVx1yJxAo0QrDb.ld7MKiMGDkculWYYxNso6zQHBzamxNAJ1b_ZpG8rT
 AFZS_9tXVhJ0QziW_.zwwV40dzOYOTIPdaO82xgn1S2ZfW8bCiZ8C1djXdLiaN1yhej2qRc8SZtG
 hxJXNwfKQCBgOkW1UhR7XgUCwx9YRipSq1_4J47CxKuKM6nYRvPRfToNPWkG9qE0pmMl_1IQvyZO
 Iajy0jzhkW61lM7diVAJ0nLvrVtkAdZ29xE0A76Z64we6YJ2ap4KTo7KVDWMLN2jWp6jgMNIXizM
 zcaqcfZHiC2uCK6P.FgpiftEzuINnEHtoSKZeAxjqVHi3ZZv5rQp0ZXY9Vk4qebTOU8h8jMZb1E6
 zHBP40Ld3yiMbYQfsE27jc7qsQQUTmubLlFbuYDx8u.LjZ7NlMRymbbWlXSUGwZIQwkmiKOJZS7b
 x.EaC307AiEi9dA7zdZuhYT2wPSl.y6IjlItQZGwVMKVtFC8N8S_Gr..Mx09.WGA_JQo9xaujQKr
 iI.6jt2cVOpcct6Ty8tLk3U0mValyK7NjUHz5r9e.33Z5J2AC943FB8qlAMZRfKDVyXDd0Pl5jmI
 4s5W1hqH47KkY7ua9gM4EREXl2iGjM0lyrtS6tKCBgkknEvwr6B9BsxEZ9RNcl3BGoAjoVCJoeiw
 Pf1oe.UrDKPAs1VHOvepSTxr5iIX_t2eRQEKl2jdHZ6WvdUB.iO7UZNNO4VOkjkY1LRslECJ9tVU
 NDve.8Is9iPSwoGh1QUNN.t0gcweVTz.GLp.TH1KpHUg.zjqfgvXGvItK4D1Qnv45T1Yk78ufywu
 JWVQfBPyuFtedWBzJLJZfE9.UNfeHGQJPt.z7p.obWKcILnTgTlG3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:18:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b77b874e22efcf04356cc7acbadd009c;
          Tue, 09 Apr 2019 19:18:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 04/59] LSM: Create an lsm_export data structure.
Date:   Tue,  9 Apr 2019 12:17:53 -0700
Message-Id: <20190409191848.1380-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..81f9f79f9a1e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,18 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/* Data exported by the security modules */
+struct lsm_export {
+	u32	selinux;
+	u32	smack;
+	u32	apparmor;
+	u32	flags;
+};
+#define LSM_EXPORT_NONE		0x00
+#define LSM_EXPORT_SELINUX	0x01
+#define LSM_EXPORT_SMACK	0x02
+#define LSM_EXPORT_APPARMOR	0x04
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

