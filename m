Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA8C2BB84
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F9920796
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="q9BXhdl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgIDQBN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgIDQBB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 12:01:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D4AC061244;
        Fri,  4 Sep 2020 09:01:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so9381322ejk.0;
        Fri, 04 Sep 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIz3Dqv9/KGHKChd3/IFzzxn7xbyzIDCFdjTQoSAu6w=;
        b=q9BXhdl5PVF9mLC9vkchxmULiG9xehyXT0Dy35pIMdBIVb2r4uf3zo0DYi5Uy4TT9g
         8HtDMU8X3UsMUtmhW3jmB+GsLG784ov5aFIt3DdqsI6s7+pRgLhN3Hvl5mSOeUe8Ncfs
         RJx7BFIoShGkf/rkq2/jJ/tU5AZxegj5QRXv6XnnqIZZDSy1L0fVaJ8tabsEGyzNHoMd
         2F/JQXKHQGqHSsl0Dx/uK6/36BJ6/onw/wG8iB9evJXvU+ZSreM5vc6/jHG72Y/lYhSh
         BfHjVKV7pCkdnSOdXA39mIocO3m/zYbismyZ/bLDTbpFwTYpEIcpLtHDtcX+hoi5JWnn
         u90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIz3Dqv9/KGHKChd3/IFzzxn7xbyzIDCFdjTQoSAu6w=;
        b=LB4/YPPnngc7Y9X1m+iOqP7GhNYqTaLg5nhoI2undJ97rOYv+Eh3DpShc0YeztsMwK
         dCwutA/sNR8iifu2FMRTO7MTLFa8KTKC0FwECDLobqem/NsHJolM8dwnoy4h9XKV7hdJ
         WDeSe6oPOnsW2cLTGtQywGZszAnT1Dt5S6evcaLNdrudycjULxW3i+qdz0VDRfBF/6Kr
         o6kSGKbvhJXRZyj1tNaPEW3VoPkRheoizNCDZgvGbM6iI72sRQ7A50TY98NJnAfF7121
         024CyqJePbevmUWvp7iKa6e8r0sRYSnWqNk7/2+d1kNZ5HjIHxknJOl0WbVkckGWBgTm
         BU1w==
X-Gm-Message-State: AOAM5329+RV75/spu9Ect5uVJK/ctlGjW6DP4Mr0S6c39frOZ6oOxjFQ
        kdECx9u47A7bfv9++Mot8hiLKuQSMZ0CXSxH
X-Google-Smtp-Source: ABdhPJz3Q8w4Tv7USQ8eui4LVCy5y4lAuTULMivw04dlU/rjS5/aBfLukg0LJ56MBQC+0SmUli78/Q==
X-Received: by 2002:a17:906:5a83:: with SMTP id l3mr8552049ejq.14.1599235259141;
        Fri, 04 Sep 2020 09:00:59 -0700 (PDT)
Received: from debianHome.localdomain (x5f700e02.dyn.telefonica.de. [95.112.14.2])
        by smtp.gmail.com with ESMTPSA id h10sm6276025eds.0.2020.09.04.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:00:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     linux-kernel@vger.kernel.org
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [RFC PATCH] sched: only issue an audit on privileged operation
Date:   Fri,  4 Sep 2020 18:00:31 +0200
Message-Id: <20200904160031.6444-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sched_setattr(2) does via kernel/sched/core.c:__sched_setscheduler()
issue a CAP_SYS_NICE audit event unconditionally, even when the requested
operation does not require that capability / is un-privileged.

Perform privilged/unprivileged catigorization first and perform a
capable test only if needed.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/sched/core.c | 65 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f7eb32..954f968d2466 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5249,13 +5249,19 @@ static int __sched_setscheduler(struct task_struct *p,
 		return -EINVAL;
 
 	/*
-	 * Allow unprivileged RT tasks to decrease priority:
+	 * Allow unprivileged RT tasks to decrease priority.
+	 * Only issue a capable test if needed to avoid audit
+	 * event on non-privileged operations:
 	 */
-	if (user && !capable(CAP_SYS_NICE)) {
+	if (user) {
 		if (fair_policy(policy)) {
 			if (attr->sched_nice < task_nice(p) &&
-			    !can_nice(p, attr->sched_nice))
-				return -EPERM;
+			    !can_nice(p, attr->sched_nice)) {
+				if (capable(CAP_SYS_NICE))
+					goto sys_nice_capable;
+				else
+					return -EPERM;
+			}
 		}
 
 		if (rt_policy(policy)) {
@@ -5263,13 +5269,21 @@ static int __sched_setscheduler(struct task_struct *p,
 					task_rlimit(p, RLIMIT_RTPRIO);
 
 			/* Can't set/change the rt policy: */
-			if (policy != p->policy && !rlim_rtprio)
-				return -EPERM;
+			if (policy != p->policy && !rlim_rtprio) {
+				if (capable(CAP_SYS_NICE))
+					goto sys_nice_capable;
+				else
+					return -EPERM;
+			}
 
 			/* Can't increase priority: */
 			if (attr->sched_priority > p->rt_priority &&
-			    attr->sched_priority > rlim_rtprio)
-				return -EPERM;
+			    attr->sched_priority > rlim_rtprio) {
+				if (capable(CAP_SYS_NICE))
+					goto sys_nice_capable;
+				else
+					return -EPERM;
+			}
 		}
 
 		 /*
@@ -5278,28 +5292,43 @@ static int __sched_setscheduler(struct task_struct *p,
 		  * unprivileged DL tasks to increase their relative deadline
 		  * or reduce their runtime (both ways reducing utilization)
 		  */
-		if (dl_policy(policy))
-			return -EPERM;
+		if (dl_policy(policy)) {
+			if (capable(CAP_SYS_NICE))
+				goto sys_nice_capable;
+			else
+				return -EPERM;
+		}
 
 		/*
 		 * Treat SCHED_IDLE as nice 20. Only allow a switch to
 		 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
 		 */
 		if (task_has_idle_policy(p) && !idle_policy(policy)) {
-			if (!can_nice(p, task_nice(p)))
-				return -EPERM;
+			if (!can_nice(p, task_nice(p))) {
+				if (capable(CAP_SYS_NICE))
+					goto sys_nice_capable;
+				else
+					return -EPERM;
+			}
 		}
 
 		/* Can't change other user's priorities: */
-		if (!check_same_owner(p))
-			return -EPERM;
+		if (!check_same_owner(p)) {
+			if (capable(CAP_SYS_NICE))
+				goto sys_nice_capable;
+			else
+				return -EPERM;
+		}
 
 		/* Normal users shall not reset the sched_reset_on_fork flag: */
-		if (p->sched_reset_on_fork && !reset_on_fork)
-			return -EPERM;
-	}
+		if (p->sched_reset_on_fork && !reset_on_fork) {
+			if (capable(CAP_SYS_NICE))
+				goto sys_nice_capable;
+			else
+				return -EPERM;
+		}
 
-	if (user) {
+sys_nice_capable:
 		if (attr->sched_flags & SCHED_FLAG_SUGOV)
 			return -EINVAL;
 
-- 
2.28.0

