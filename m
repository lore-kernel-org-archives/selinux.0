Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B943C433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 17:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiA0RBT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiA0RBT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 12:01:19 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275BCC061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:01:19 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id hu2so3364433qvb.8
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6wH5VTaBGw1hHPKiMvRBC9Vz8Acl4dAIKM4D/PTj3u8=;
        b=tYH0LLeLt7Sn/Jw9uMf9uz/y6lku3xCPN8VW0GXZXBCuKi1A5+mCusc/UPwdn0RGin
         gnIjYUefm9rIyWf+vAcrYQiFpYbZIND5BcBhB/xD0hEFKHvsbl9oxMS2A+3UFX2/ZNLj
         gnJ5GVddTdUn0kXKR7InujQwcBsZIhhDbxUUZcTa7L29I+XuSHrO/dNFV2mi/w1t9AU2
         92xhQwTLODvgU+VbWbieOpZJa0U4Dn2DgBuKbS6ntX0wfH+J9e+/l3TQ7hpJSxbczf53
         hq0yl+e2OrLgoRQSuobzP0Oa1Zl7ioFO2VrUpVIkq5Rn4aOSdaQOFD/fEjmC7HMnFwqc
         eVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=6wH5VTaBGw1hHPKiMvRBC9Vz8Acl4dAIKM4D/PTj3u8=;
        b=4hFGDZxL9jurj+8MkJDa1SnXTV0mR1xWzzWjRepsEUMLuUejjQJjEgBCYugv93XbAS
         jDRbZnrPN40rPdjN+ZytpGcpnDnEgSZruy/8afPMmjO32OTTJufejwkNZcuM0E7/hifc
         UcDLRAqPuunxLWlA9T/A7E8rHAR95JkApz6fhKv4zHSeG5IiFvRBsY/U7UTznD5ERnmc
         s1T1E0oNLbJCBxfv/3WaMi10m+jLmX22T55hS9W7WrfN+3MCxyzpwLDmpuR67CTzrUHh
         mMRVVhNHti0TuGNzfl4BKQgOOefTZ92ppE5WUZJdKTq6FmEX3Wxq17L8orC/zZHFWTz+
         H8Gw==
X-Gm-Message-State: AOAM533X8sPYT44lQbCYFPOn5nJcwOviLqC5xMSUke4Hql8MZb6bdwJW
        wDu7RuiElbO8IDm4MA+Gv2tEqwY+wSfa
X-Google-Smtp-Source: ABdhPJzkW4WvfCe3tkiyELWqy3gWUohCuleN5fGpZ3UW73Gof4IDFl+qYQ9Xhg38ub8VaV32fsMhDw==
X-Received: by 2002:a05:6214:dad:: with SMTP id h13mr4212616qvh.74.1643302877972;
        Thu, 27 Jan 2022 09:01:17 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id i13sm1876614qko.91.2022.01.27.09.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:01:17 -0800 (PST)
Subject: [PATCH] selinux: various sparse fixes
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 27 Jan 2022 12:01:16 -0500
Message-ID: <164330287653.95708.5024040003451330147.stgit@olly>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running the SELinux code through sparse, there are a handful of
warnings.  This patch resolves some of these warnings by casting away
the "__rcu" attribute in a few core kernel function calls.

 % make W=1 C=1 security/selinux/

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c057896e7dcd..da04f3435268 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 	if (rc) {
 		clear_itimer();
 
-		spin_lock_irq(&current->sighand->siglock);
+		spin_lock_irq((__force spinlock_t *)&current->sighand->siglock);
 		if (!fatal_signal_pending(current)) {
 			flush_sigqueue(&current->pending);
 			flush_sigqueue(&current->signal->shared_pending);
@@ -2542,13 +2542,14 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 			sigemptyset(&current->blocked);
 			recalc_sigpending();
 		}
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_unlock_irq((__force spinlock_t *)&current->sighand->siglock);
 	}
 
 	/* Wake up the parent if it is waiting so that it can recheck
 	 * wait permission to the new task SID. */
 	read_lock(&tasklist_lock);
-	__wake_up_parent(current, current->real_parent);
+	__wake_up_parent(current,
+			 (__force struct task_struct *)current->real_parent);
 	read_unlock(&tasklist_lock);
 }
 

