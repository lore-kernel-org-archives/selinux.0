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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A067C07E9A
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 23:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A8B6102A
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhGLXu4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhGLXuz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 19:50:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09242C0613DD;
        Mon, 12 Jul 2021 16:48:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s18so4672713pgq.3;
        Mon, 12 Jul 2021 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gWdbFfSztY1v3e2xBfjhwshs3cxbjPQ523BPYsx0s7k=;
        b=U1R5JSPFs8p6mC94aXzLLQcjwaKpe47CQGq3JXmMcbyv0DqUbxsNFqhKLYL5NNt9u/
         jPZETm0xSKXe4XxshT3/v9ZUjK7jbm3biiLbcQyol5k4S2TDAboya1e7F+HM+rPtu5eD
         V2puXu+taLH536yRHBOtJGEEDo6GPaFfXieQd+eABMX9jZRy3J3oJBIodmYjeNUlbo3U
         EqS+r8kBu+AhwRJbskTLtpj9Qpk7k2NEn02k8HGTfXeflQ4YZiKEr4pLb8aEpUnPHU2+
         90RuTtXFbLBojEQEM8BJbvWv+09AW0g6Wn1qtjbadaF+nspG1K3m0SJzNHvvF2zKf8Sw
         K6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gWdbFfSztY1v3e2xBfjhwshs3cxbjPQ523BPYsx0s7k=;
        b=a4k1ylPEKaqcoXIQcxKlTEjJawz6k8+bjuQmwlf4obHCrVyXucCfgugKN833x0S7XJ
         bOHI0mNzItgHXk4QUfhgkB175d9FKWoUbQj/TXn5ZmUi1Zdgj3YZx2BZ6LjuqYtWk+v2
         aFq2ltf8Tu9R7poD4OHLCw3aSKL88SRHDuMgb5FHq9eAgd7WAUekhqOkqwRsWrJiYE8+
         AGXk4a2GwNxISKsTNtJbix6CWM7eRM/MkYpESMH1grYz1p7UkqPXfdSFH9GAlASmoD7P
         RaFxUBEIj7ytcJ7OLxCZHsoIu85qKrXUvQvH8OMd6byEB6/XxtAwyx8lbwmlorJpBN/I
         AY1g==
X-Gm-Message-State: AOAM530gG7MY66MrZ9mSIUwAy5hP5llUD1akxa+OywaV/SwhFXX1+hD6
        RfQFRCcwjHQwM8nTCIaDo40=
X-Google-Smtp-Source: ABdhPJxHl0RzB/MEeWXneRp8U0rLADpTymP1Xy7ivk1rr3BFJ+Mm+JS48Y3S68W4RCWzF3Nl5ItooA==
X-Received: by 2002:aa7:8489:0:b029:2fb:4ce0:339c with SMTP id u9-20020aa784890000b02902fb4ce0339cmr1705899pfn.16.1626133686620;
        Mon, 12 Jul 2021 16:48:06 -0700 (PDT)
Received: from raspberrypi ([210.183.35.240])
        by smtp.gmail.com with ESMTPSA id h18sm19436351pgl.87.2021.07.12.16.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:48:06 -0700 (PDT)
Date:   Tue, 13 Jul 2021 00:48:01 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        austin.kim@lge.com, kernel-team@lge.com, austindh.kim@gmail.com
Subject: [PATCH] lsm_audit,selinux: add exception handling for possible NULL
 audit buffers
Message-ID: <20210712234801.GA29226@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

It is possible for audit_log_start() to return NULL on error.
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

