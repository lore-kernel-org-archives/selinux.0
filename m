Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F7C433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 21:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2CD60F6D
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 21:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhIWVUF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbhIWVUF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 17:20:05 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222EC061574
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 14:18:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id gs10so5018766qvb.13
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qDg9v7GfS68GbP8VGxakpRfPg3Js+mkKfYW40P58MfY=;
        b=KY0z3VOvXBy0yPQrxoDoysSkfrCNw9k5jyfp1/0RQ/ynuUiyjSj84caH3l8OjjsGFv
         jrFg+8/oAPizxA1nYI9LD6jQemoZOATqlDTU7jWtRBhocEH1mcq/bPM3x2UvwTfsZ+l4
         rzrZFnLbQsOZ49j3C/zSDm+8ygeMmMToqgUxEEzosqc3aXQoKWp5mDuzcIogaw+0Wsen
         P58V7qXvYtKsQ6syVeNpMP2vh/vc15S1Ex8ELFarJvcVNuS5ZreG4EIB/NK8TNUkVvxX
         H96Ubh1insC1DJ3zIx05Lx2mL+t3JaA57L/c8drEK8QVXQm8Q6Oal8Fze5uSnnyD0Sv6
         lQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=qDg9v7GfS68GbP8VGxakpRfPg3Js+mkKfYW40P58MfY=;
        b=cKXnSJAoXw41w6NqJ+kcxei+VW7F1+3yEp+vSKXu8sLcKLve6kzGjs30K8GaJnMzH9
         WFcVc4IsGzQ2ZwlDazho/6YOMay/XAuu5Z7jHHtbDehQOlTYzhmeB6Yvi2VbQZfv9T/u
         ugE6ZxnjdCwIJZgGljg3d1sxMF0lgzJdm1dakuSt8HYL6LWmWR+WWSRa8kTegtJ571l+
         a5jNz4UhgPKpm1QTSfyBiPDdhuySmFvaFy5BoOGPLbBBAW9EWK7xbfCyxpqSQ1t2jR7p
         CBLFBIUFdKlPwIyC6s5quKPC2qCmXzR4Qc+0GWXszzYj1y8WtFPKxDboMZ4vCkI82jeL
         Fwkg==
X-Gm-Message-State: AOAM532kBk5fMp7t5mY4vJg/81+lqxhOuTSjeuKt3dLutNUETMaNJl2P
        bh8kqaSQOyL226El8u8MN8W6f2zLbnEu
X-Google-Smtp-Source: ABdhPJySUwFo6XwRR7e5WOUE73Mv1rC4kpIeJexVijJZLeWkD9HNOxSnax314uLIwxfiRHxt3dUxuA==
X-Received: by 2002:a0c:aa4f:: with SMTP id e15mr6760553qvb.43.1632431912034;
        Thu, 23 Sep 2021 14:18:32 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id v8sm4041055qtk.49.2021.09.23.14.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:18:31 -0700 (PDT)
Subject: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 23 Sep 2021 17:18:30 -0400
Message-ID: <163243191040.178880.4295195865966623164.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The original SELinux lockdown implementation in 59438b46471a
("security,lockdown,selinux: implement SELinux lockdown") used the
current task's credentials as both the subject and object in the
SELinux lockdown hook, selinux_lockdown().  Unfortunately that
proved to be incorrect in a number of cases as the core kernel was
calling the LSM lockdown hook in places where the credentials from
the "current" task_struct were not the correct credentials to use
in the SELinux access check.

Attempts were made to resolve this by adding a credential pointer
to the LSM lockdown hook as well as suggesting that the single hook
be split into two: one for user tasks, one for kernel tasks; however
neither approach was deemed acceptable by Linus.

In order to resolve the problem of an incorrect SELinux domain being
used in the lockdown check, this patch makes the decision to perform
all of the lockdown access control checks against the
SECINITSID_KERNEL domain.  This is far from ideal, but it is what
we have available to us at this point in time.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Paul Moore <paul@paul-moore.com>

--

NOTES: While trivial, this patch is completely untested; I'm posting
this simply to see what comments there may be within the SELinux
community to such an approach as the current code is flawed and needs
to be corrected.
---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6517f221d52c..4f016a49e3a6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7016,7 +7016,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 static int selinux_lockdown(enum lockdown_reason what)
 {
 	struct common_audit_data ad;
-	u32 sid = current_sid();
+	u32 sid = SECINITSID_KERNEL;
 	int invalid_reason = (what <= LOCKDOWN_NONE) ||
 			     (what == LOCKDOWN_INTEGRITY_MAX) ||
 			     (what >= LOCKDOWN_CONFIDENTIALITY_MAX);

