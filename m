Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D1EC433E7
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53ABE207D3
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FHqnGYfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBLPd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgIBLPD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Sep 2020 07:15:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B871C061244
        for <selinux@vger.kernel.org>; Wed,  2 Sep 2020 04:15:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so6025816ejo.9
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2020 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLut881fzALym4OODeTNuvoTVMW766H7pUFqq0K3na4=;
        b=FHqnGYfuPn06li4Hp4h3SLqW7hDC8u8Q0rBaj2FX+sLTMd1Zj25FxIA50TFJox2tTn
         1fo2w1pnSOUO3mJlfd1yrS28rAHgzS4W2ti/77ph7/Dhku/ydrN/YzDaa6DQpuwG7yef
         9UmRcDZlbbZ1Wg+4k0G++bua/deuB8nah9YREdwZnrqs6Fyw3rAaHKu1kqoFD+QOnXvz
         UYPnMFKEiVAMYLRvH3a9BLWFSYTJTY5XVsXFMKMH6pKootV4zZYXxaoL1rE9/Qd8ujff
         XMKpMeIEw/YyobcEqwzj7dbIzu3IzH+WQApL5SAPDVrVX6/ZFKzv9nCnKt67aLAfSnCl
         ZPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLut881fzALym4OODeTNuvoTVMW766H7pUFqq0K3na4=;
        b=LVpzLv3H1v9VAP35sdHMObnpjNz1j/niJmsHqX8EdNLsSDGRhXxfKijDx9EfL6Q8oA
         QvyGmcv8fA6bK/650Cv2pG9dbf2vLZ82TPYFVpN08ZiVXIIuutryw00fgYrreiJ7NBA6
         bznMIS87BZtyUIGk9A+2aJyxknTm4+krgwaIe7Nuu60YErNk9ikjWFVm9fq0EZUm2Gyt
         p3skscIu/pbIm48w3d/5JzI1T95sKtURlixWPRMMuXITazcXaS0/ZYnKStAzrQrhl7Si
         w3Hw93it8cCaTXb6+MWUF/08i5vKlGfqbiN0vQfgjw6tasa9yWzhuMUnAQcud/D8Ovpa
         hx3Q==
X-Gm-Message-State: AOAM53006jw/bqxjW4HQSvMmZ5oXG/qnwrhFxthLnPqWhsMM569/2h8u
        tJtllvMwJccs/Au+Nrh3IWBX7FfnALc=
X-Google-Smtp-Source: ABdhPJw4M60R0zT4C7sOvzga0GGkyt/SEhLcKczki89KGhVEmZ6SXIUQTwk/AdAjBqJ+iy8aQh+AgQ==
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr5579154ejx.215.1599045301029;
        Wed, 02 Sep 2020 04:15:01 -0700 (PDT)
Received: from debianHome.localdomain (x4d03ad2d.dyn.telefonica.de. [77.3.173.45])
        by smtp.gmail.com with ESMTPSA id i3sm3828757edn.55.2020.09.02.04.15.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 04:15:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] sched: do not issue an audit on unprivileged operation
Date:   Wed,  2 Sep 2020 13:14:56 +0200
Message-Id: <20200902111456.20610-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sched_setattr(2) does via kernel/sched/core.c:__sched_setscheduler()
issue a CAP_SYS_NICE audit unconditionally, even when the requested
operation does not require that capability.

Use an unaudited check first and perform an additional audited check
only on an actual permission denial.
---
 kernel/sched/core.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f7eb32..b567697a67ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5249,13 +5249,15 @@ static int __sched_setscheduler(struct task_struct *p,
 		return -EINVAL;
 
 	/*
-	 * Allow unprivileged RT tasks to decrease priority:
+	 * Allow unprivileged RT tasks to decrease priority.
+	 * Do not issue an audit event yet, only later on an actual
+	 * permission denial.
 	 */
-	if (user && !capable(CAP_SYS_NICE)) {
+	if (user && !ns_capable_noaudit(&init_user_ns, CAP_SYS_NICE)) {
 		if (fair_policy(policy)) {
 			if (attr->sched_nice < task_nice(p) &&
 			    !can_nice(p, attr->sched_nice))
-				return -EPERM;
+				goto incapable;
 		}
 
 		if (rt_policy(policy)) {
@@ -5264,12 +5266,12 @@ static int __sched_setscheduler(struct task_struct *p,
 
 			/* Can't set/change the rt policy: */
 			if (policy != p->policy && !rlim_rtprio)
-				return -EPERM;
+				goto incapable;
 
 			/* Can't increase priority: */
 			if (attr->sched_priority > p->rt_priority &&
 			    attr->sched_priority > rlim_rtprio)
-				return -EPERM;
+				goto incapable;
 		}
 
 		 /*
@@ -5279,7 +5281,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		  * or reduce their runtime (both ways reducing utilization)
 		  */
 		if (dl_policy(policy))
-			return -EPERM;
+			goto incapable;
 
 		/*
 		 * Treat SCHED_IDLE as nice 20. Only allow a switch to
@@ -5287,16 +5289,16 @@ static int __sched_setscheduler(struct task_struct *p,
 		 */
 		if (task_has_idle_policy(p) && !idle_policy(policy)) {
 			if (!can_nice(p, task_nice(p)))
-				return -EPERM;
+				goto incapable;
 		}
 
 		/* Can't change other user's priorities: */
 		if (!check_same_owner(p))
-			return -EPERM;
+			goto incapable;
 
 		/* Normal users shall not reset the sched_reset_on_fork flag: */
 		if (p->sched_reset_on_fork && !reset_on_fork)
-			return -EPERM;
+			goto incapable;
 	}
 
 	if (user) {
@@ -5470,6 +5472,11 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (pi)
 		cpuset_read_unlock();
 	return retval;
+
+incapable:
+	/* Generate an audit event */
+	(void) capable(CAP_SYS_NICE);
+	return -EPERM;
 }
 
 static int _sched_setscheduler(struct task_struct *p, int policy,
-- 
2.28.0

