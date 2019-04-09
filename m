Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB45C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079562084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aFMCtvrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDITTU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:20 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:45422
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbfDITTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837555; bh=DXZobVlHba7NLExIjhRRZRkmastZlDIkiPrs42J8njM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aFMCtvrgQ7lFHQgHXD1XE6F/YJ1R/YJxYwTWVPecLGyBr2+sv19CLwB47N6FHwIRUe/PVurJx6vNULTKpWxZptDxWL9I3UHj9LjTafTWXTifsFfJDOzQlCpfIxeXOPPk68K3kOXtAJ8II1zV9zxVSc96nzZ7TcMVjXfiDtAUdn4nu8TjozRGkX3bd7+RgtJFJbBR6Zf9B7VOdl9J7Aagdjglkd662EGdPl0e5OEWv8g65qVSRUYPR9J3LLV61NKiIykt1EkFxo1ajXOtf/vxrebPbpHTUH2yXvI3ERTcFMy/vsMgzusmUQcckSrUjvVfTkVezBRO59jh10JVKD/7JQ==
X-YMail-OSG: sI2ZHkIVM1kH9jJl7ChkR_kxRuR6QvwBtNV9uBQOUwoEw4nvKrrIDB31utbXl7Z
 ExDQJTbHGKO8q4gchEK0w_4KRiYUw.6bl3kbPFg5YVs8hSSPXyS.01KUrMPE60NID6vs4d_Hm1Zh
 4H0dTgJZ9FKq5Jc6m_hXlYJxizeVVjEr0y43b2xC3zUYKPuUeoKQdm5WvHHAw9umTy.JOcWu435C
 IAzU6rEkfyPXV3B7IdWPtqmlzFSsGpF6g1W0ANMDc1meBi14ztYqZDCbExbKjr1KuU3Db4pZt0Pb
 80owm2VPGFHvSJyK_0YpkQHbCRhKLkVSZGfXu7p8trPoKjoYCEWlaUM.AxXoAO3L.Q2ggkVLw7X8
 uU3InfN9IdkUFgK3JyM.r_Sk_7rnB84OlG4HnFVCAcYMawhNnFISEriuwsNy58f5_BGhEKg0f_fL
 u0y35748o5yvIBwGrPe6l.J4kcripaJU4xjNgdOLhxcaYEYP3lBzURhrjhYdp0N2gCTJ80aMvQE2
 ka_nTqWfx8TQSEQAIsZpxczaHRQkX4D6M7S4eZAq_LTRV3izgVF90qA_w8.OG6yVVjsRqA7hBsuJ
 60vLAQhJCIYq_wCGcttaps7ee2.eIx9zT7lCOEr1MRaesf3FTMStdEuYqncUntdQrjEcezYsL1gs
 iM_BCwwfWAh7R2usd9k.8qbj6bH6ChCVMPn45ASuG9TbFkx_4NGc56LGOlNarbc.BRSqEhRuDDe6
 CnVCte3dly2BNtN5i42sRO.Aux7San49nfrkyyADQpjkPyMicH3OwfV8RjY84CVcgFV6UBZLtht_
 Dxno5H9bc.BsPFEplCNMEJotUKTiIg8nPjWW6wTb32qieqC1qQyXps_mnssEcWFHBbK9crE4RDCh
 bm2B.OyASHFLqs25oF8g_73KHEzR6IyaFYO.xeHZC6TfVU9SnXClAWWmUeZQUOhIW7rnQJEuEP3t
 S.VKod0shbgXqu9HUASlwa91qH4InxvCN2b5WHQ_vaWaN9rSmPJu0WhoeDi6qys67xkAJQ.8X81r
 xKE2PWzuhy34RGfHhfgVs32abEDfoqdp9uM1xq8lv0HsPcuzo1emcStJW4l7C5b37.qjW1cWNYmx
 qvR.Onw1Es4r6wxtL4F1ZYaTzRDavEba37R5CiUSIMpLlX.XkW1p8KxE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 28/59] NET: Remove scaffolding on secmarks
Date:   Tue,  9 Apr 2019 12:18:17 -0700
Message-Id: <20190409191848.1380-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in xt_SECMARK.c
This raises an issue, in that Smack users have been
using SECMARK_MODE_SEL, which is suppoed to be exclusively
for SELinux. This is worked around in the code, but not
fully addressed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/xt_SECMARK.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2def8d8898e6..9a2a97c200a2 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -55,6 +55,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
 	if (err) {
 		if (err == -EINVAL)
@@ -63,7 +64,12 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	lsm_export_secid(&le, &info->secid);
+	/* Smack is cheating, using SECMARK_MODE_SEL */
+	if (le.selinux)
+		info->secid = le.selinux;
+	else
+		info->secid = le.smack;
+
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
-- 
2.19.1

