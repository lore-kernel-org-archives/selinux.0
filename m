Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FEDC433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 15:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiA0P5i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiA0P5h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 10:57:37 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1613C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:57:37 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id o9so3153010qvy.13
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=niFQcbArFsToaNfucp2ZcradrR8WAF6HQM8hZrn8fXE=;
        b=jxrSkxjLN1fiGtJYpS4w3J1uIODv2DHUWWcxOJGudUoPYUCtUIyqEfnBjg60oLT/Eb
         W7DEIBGcoCVj+FzgGnIh2Q7CdbyQ/7Veag9hVKPznJD7VwSRsM0yAcbYLpGvYfpT/0Qp
         xguwZ54ofPWtBh+lgZxV6vM6XBjN+p3uuaIP337fviW51bn88uuyfivrnfe/wAj6vCmg
         6/D+AIIHn6qnayxuXDo8Ra8JFGX1oREGHmYWRGNgiOrAivmUXrVGshP2JIwOjbrsN6H4
         w3KP0ZZakTMVNSHulSer0vr41NbUPqTm950E6LNzEOLmdcm6FJcUoFOvl8dDd1XVzRD8
         xuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=niFQcbArFsToaNfucp2ZcradrR8WAF6HQM8hZrn8fXE=;
        b=MffO4eDzdnkuTjKMv2/4LTRz207SlAsFr1Na7xUyzWj1e60qZ3ehA6ZUyBAh8DdvXV
         f7VBJxHnT3WPcMUpAvF1L9rPqxX6NILmjk1VDuYSQyl8kdzY/Em6Wblwsp8wM3XlCVFN
         ue4OivRtarrX41xlouISclOTqdVSveydRR6DnlkUEqP4wSt9eNH4dPG2jldJRqGL7wCs
         GSDcDI1QcjvriK7ibvHaba5YnpInR1kp5FfUFLt0H2r77rJzGWxHyHBA9TIbHd8Af2gy
         s1dB8ddQJpTxKq5YyR7HK6H2LIWWmQZ0YQYDk0B9bwPjkDExp/EeZUkyy13MBZ6ZTLc3
         AitA==
X-Gm-Message-State: AOAM530J7AKRQYK86Klh9AeH8u5Dk//Rz6mYSmWo4F3xQhpyoyNTiDdP
        utOzyYL0KRBwMTFAibeNAPNWHfNIH76K
X-Google-Smtp-Source: ABdhPJyx2JcvkIooqR1JLobTT82OOe8rAy9X2MWF4YHnzoyNIYFE863d15sZpFHHPlioaFyA5rTCiw==
X-Received: by 2002:ad4:5dc6:: with SMTP id m6mr4096700qvh.87.1643299056392;
        Thu, 27 Jan 2022 07:57:36 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id x14sm1854357qkp.105.2022.01.27.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 07:57:35 -0800 (PST)
Subject: [PATCH] selinux: fix a type cast problem in cred_init_security()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Date:   Thu, 27 Jan 2022 10:57:34 -0500
Message-ID: <164329905457.31174.9220154812163631144.stgit@olly>
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
index eae7dbd62df1..c057896e7dcd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -213,7 +213,7 @@ static void cred_init_security(void)
 {
 	struct task_security_struct *tsec;
 
-	tsec = selinux_cred(current->real_cred);
+	tsec = selinux_cred((__force const struct cred *)current->real_cred);
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 }
 

