Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D43C07E95
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE73600D4
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhGNAOY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhGNAOY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 20:14:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE389C0613DD;
        Tue, 13 Jul 2021 17:11:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h1so337918plf.6;
        Tue, 13 Jul 2021 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2NwPGcMH3u191Xzah8DNFvqeaN7pXMntM5EVPzjXpXI=;
        b=XHEhdDQvb46nZF7qgoJhfsKtwPduEdmwOKc8dzdS1FP7zSR79OiJLcvoTiavy5YrXZ
         uLI4FNADWBYLq6vEW9CzU1kICAySoaSZZkZPMyhUPn40GQXwWKF/j9og9ff3im5aVUFu
         xFHtNZ6Sfvgy13oh8Dn+Unrqot59J2E/0hx7lbt0jGByiu3eluh7P9QnUwduJVkToNfV
         8NQc+AMMAWqYYsBhiuiFsYRFY2+x7mc9niM9Yi+AyoRKxLcN4VId3tfVSUm6P1PXjmX6
         o5p4r8P0Zgppi5JKJfLhzelYqP/O2nU8wVpiPTrgyQuQVyu7Z+kavRBVgW+gAmUuK3Sw
         p45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2NwPGcMH3u191Xzah8DNFvqeaN7pXMntM5EVPzjXpXI=;
        b=KMy9zB8QOIgIn1njMThe9KYpRoziH1BKDjDVa8Ui/Y/KGjGjH8GEy5gonyMScI30hu
         kdL4FazkwojROqemVAYnC5CANo6869TDmBI8S+QrzDgVUrGVC5nZkTyZPwzbYHK53ip+
         c5+jHqELDbqYiG0v2JloveB0IwB6McusTDqrs4KglV/N63fMk5B+Wf/qm82mi8lGPgGi
         zbVdVoHEKA5/2VwHk2ejn/I2PSnajhfQprQAfBR4BB/5S5wbIkUvIY39ppgTtIYQrGEJ
         kxb9jJ5SS6qfWmJPcdAL/O3WNluxi2LWL9kLEyWEMQK0aQjYJIyUsQ/nZI/cZn7C6kcF
         CJSg==
X-Gm-Message-State: AOAM530K+5NT4wVBmH5FnOvScOlzdayOogp75kapzmXNQu851yHIWXFD
        Pw700/4IbdV8mt0yz1/RfWs=
X-Google-Smtp-Source: ABdhPJy9QJsalJEAPuBp++oFrJX2tpSvmER8PZGaqRSpwQFV3Wp6p3vKidUbvNxABexjPWjdqU+67Q==
X-Received: by 2002:a17:90a:454b:: with SMTP id r11mr6511032pjm.60.1626221492377;
        Tue, 13 Jul 2021 17:11:32 -0700 (PDT)
Received: from raspberrypi ([210.183.35.240])
        by smtp.gmail.com with ESMTPSA id y11sm286842pfm.190.2021.07.13.17.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:11:32 -0700 (PDT)
Date:   Wed, 14 Jul 2021 01:11:27 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        austin.kim@lge.com, kernel-team@lge.com, austindh.kim@gmail.com
Subject: [PATCH v2] lsm_audit,selinux: return early for possible NULL audit
 buffers
Message-ID: <20210714001127.GA994@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

audit_log_start() may return NULL in below cases:

  - when audit is not initialized.
  - when audit backlog limit exceeds.

After the call to audit_log_start() is made and then possible NULL audit
buffer argument is passed to audit_log_*() functions, 
audit_log_*() functions return immediately in case of a NULL audit buffer 
argument.

But it is optimal to return early when audit_log_start() returns NULL,
because it is not necessary for audit_log_*() functions to be called with
NULL audit buffer argument.

So add exception handling for possible NULL audit buffers where
return value can be handled from callers.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/selinux/hooks.c       | 4 ++++
 security/selinux/ss/services.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b0032c42333e..9e84e6635f2f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3325,6 +3325,8 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
 			}
 			ab = audit_log_start(audit_context(),
 					     GFP_ATOMIC, AUDIT_SELINUX_ERR);
+			if (!ab)
+				return rc;
 			audit_log_format(ab, "op=setxattr invalid_context=");
 			audit_log_n_untrustedstring(ab, value, audit_size);
 			audit_log_end(ab);
@@ -6552,6 +6554,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				ab = audit_log_start(audit_context(),
 						     GFP_ATOMIC,
 						     AUDIT_SELINUX_ERR);
+				if (!ab)
+					return error;
 				audit_log_format(ab, "op=fscreate invalid_context=");
 				audit_log_n_untrustedstring(ab, value, audit_size);
 				audit_log_end(ab);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d84c77f370dc..e5f1b2757a83 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1673,6 +1673,8 @@ static int compute_sid_handle_invalid_context(
 	if (context_struct_to_string(policydb, newcontext, &n, &nlen))
 		goto out;
 	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR);
+	if (!ab)
+		goto out;
 	audit_log_format(ab,
 			 "op=security_compute_sid invalid_context=");
 	/* no need to record the NUL with untrusted strings */
-- 
2.20.1

