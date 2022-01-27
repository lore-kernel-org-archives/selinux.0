Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993AAC433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243302AbiA0SVq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiA0SVp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 13:21:45 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D8C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 10:21:45 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 71so3422488qkf.4
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Jkr1WhyW22I8VmLvcWGf7sswYes5VO3RD8jpW6dm/2U=;
        b=S6IvCv3RU9Tujz5wWmR4yJmnDnH+W8/QqddyohacnNk2WBxkZAzpTW99UJnX2Yz614
         ltAsY94U3TB1H0IeKZNMoaSSUoMaU1qzU8s29RV+CH70+MiEnaDYhuwQaDj8ETpyCTx7
         bmTFzihzHbCtFwkyMxhV2HPA3ljulZx1lOY/ENVeq+dHHyedr5VeIqjPOlFu7TUgP4V6
         WmWTStlUfHjRmAp+JeA75UkOYq8dCYxwOPDp+EdJ0hW/1Dz812Yp2XZZCzz9izUwhZEh
         gg1byZZ7rNkVe7m2p8Qu/rILDxRjZdfjZ/FJRdrHOLfK0S6HLeGhEfxXHBviVwU1DhY4
         6J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=Jkr1WhyW22I8VmLvcWGf7sswYes5VO3RD8jpW6dm/2U=;
        b=L9jZ3udPlt6x5HiugZa4e4UnJNZf8SNLztjvrT+QGiOOj+MtZLzkpL7Y/XDiiUa/Kn
         EIkKCwCn+Pur80WxjtUvQaRFqvsz9WZi/exrd61tg6MMGUwoEoc3K0yUeTBFODkIoJh/
         oTwwYl/lQhXC9MjztZnbkCymqFK51pnXtpOgmpcZfcqX6gWhPwYAYPikvr+ZgbwjPN6M
         1Y6VUVjvZ/tKneXAy+MNQypGR/bKgmR/B6wqZRYAScx6agx6G+/8QlQPCsYxKIzOHuab
         Vqtxx7nESnk6UHL9iueSTAxGbEtUh5ql5BGJJoviFDjx0nVRDJRC4i5pdodx0qS2Sa7e
         zYmA==
X-Gm-Message-State: AOAM530E1DY8b7mdfEPUhqBzP2ZOkBTh//ZoPtEA7kfDp5Kt1V3fNbJj
        q5fCAn2PeH3P337HrS2E6SN3htJ+QadW
X-Google-Smtp-Source: ABdhPJyfMSrLiflaCeuFKXyjQWosnFaSlybwYxPxst7yLKvJUf3vLBvIvG9xbpuEeWDbRMEWYYAQ/A==
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr3672552qkk.560.1643307703962;
        Thu, 27 Jan 2022 10:21:43 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id k190sm1755001qkf.59.2022.01.27.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 10:21:43 -0800 (PST)
Subject: [PATCH v2] selinux: fix a type cast problem in cred_init_security()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 27 Jan 2022 13:21:42 -0500
Message-ID: <164330770248.138929.14950299877825278226.stgit@olly>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the process of removing an explicit type cast to preserve a cred
const qualifier in cred_init_security() we ran into a problem where
the task_struct::real_cred field is defined with the "__rcu"
attribute but the selinux_cred() function parameter is not, leading
to a sparse warning:

  security/selinux/hooks.c:216:36: sparse: sparse:
    incorrect type in argument 1 (different address spaces)
    @@     expected struct cred const *cred
    @@     got struct cred const [noderef] __rcu *real_cred

As we don't want to add the "__rcu" attribute to the selinux_cred()
parameter, we're going to add an explicit cast back to
cred_init_security().

Fixes: b084e189b01a ("selinux: simplify cred_init_security")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index eae7dbd62df1..221e642025f5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -213,7 +213,7 @@ static void cred_init_security(void)
 {
 	struct task_security_struct *tsec;
 
-	tsec = selinux_cred(current->real_cred);
+	tsec = selinux_cred(unrcu_pointer(current->real_cred));
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 }
 

