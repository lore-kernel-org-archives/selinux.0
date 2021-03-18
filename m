Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18278C433E9
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9CA64F38
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhCRVxk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhCRVxO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 17:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616104393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D13idU/RGQP/7DvYnIgShNQmcLLiP8MbqYqD1hjQ6Gc=;
        b=WfJSldn3d/yOxQURtKGZS9NKxT5Nuw4oVhYRHzfRrj4DPvZfsa5tPu3eYCL+md85yCfuZe
        rScnB5weeuYdw7KoofmumwjZgRuYdwMPBuN78Q8ptvJjLwLuUD2MhgqBN+kVyYTGc4Z/7P
        ilbBCpHG9gv3ZsnICaNcUNNZxTObZOw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-2u2qY_HGPOKps-lke1lXDA-1; Thu, 18 Mar 2021 17:53:11 -0400
X-MC-Unique: 2u2qY_HGPOKps-lke1lXDA-1
Received: by mail-ed1-f70.google.com with SMTP id q25so7184852eds.16
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 14:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D13idU/RGQP/7DvYnIgShNQmcLLiP8MbqYqD1hjQ6Gc=;
        b=qjIlSsNBsGeuwlz2OYlV/SKCEjkC28Bx/5J9fDJHXBgTle6f1mlRW9x+odtX+5yTKG
         spk84ODKP9/SU58ro//L4L1W3bwHhaQdB+y5CgCZLlLpdNBZQO9ARq2ydERWDY1bsNC6
         9FOg/LfuajySdhPc1P1BEPd4XQVVsapepgZseBEqSvRb6gJADngQJbFxqfgGwOKTlgOg
         2bPvpKy3h8pi87I/er5zkONa0+RdsfNM/FqmFFyyeTn0SV8XSS509JIA7nVH1Td0hAex
         tLvdu/nYmrqJBDNrxTzFJyTITszmqUxiw4PzbAIG3SrWqc0k+OMAX97nq8Y/BaA0yQvt
         zRcw==
X-Gm-Message-State: AOAM5311ijUyPtXWEgtuyAXDfLC3U+xu6aQAdaL7J7CpzwgHKmIWaZkn
        lpm6WPM/Oprnd9Z9F5diagCkSWYmfkXes7iU0XFqEseCNsS4dQ/YmrY0DrIsbMePWbgywhSq36B
        uabqQ55p5KLC5iT2RDvQp1lGIW9JCfEhmTsx1ktJqLhP4dp2RSHmyCLkvFwqwoV1todhWhA==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr6363991edd.258.1616104389978;
        Thu, 18 Mar 2021 14:53:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP7xtEEsXql+EQRVY+e1DCigE4JLxBIKq9jNIkNxr5WWJRwzKIF7KzYGdYVie0Fsk6wGJn6w==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr6363980edd.258.1616104389791;
        Thu, 18 Mar 2021 14:53:09 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id a17sm2620255ejf.20.2021.03.18.14.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 14:53:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 3/3] selinuxfs: unify policy load error reporting
Date:   Thu, 18 Mar 2021 22:53:03 +0100
Message-Id: <20210318215303.2578052-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318215303.2578052-1-omosnace@redhat.com>
References: <20210318215303.2578052-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Let's drop the pr_err()s from sel_make_policy_nodes() and just add one
pr_warn_ratelimited() call to the sel_make_policy_nodes() error path in
sel_write_load().

Changing from error to warning makes sense, since after 02a52c5c8c3b
("selinux: move policy commit after updating selinuxfs"), this error
path no longer leads to a broken selinuxfs tree (it's just kept in the
original state and policy load is aborted).

I also added _ratelimited to be consistent with the other prtin in the
same function (it's probably not necessary, but can't really hurt...
there are likely more important error messages to be printed when
filesystem entry creation starts erroring out).

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/selinuxfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index dc7297abe4ea..e4cd7cb856f3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -566,17 +566,13 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 
 	ret = sel_make_bools(newpolicy, tmp_bool_dir, &tmp_bool_num,
 			     &tmp_bool_names, &tmp_bool_values);
-	if (ret) {
-		pr_err("SELinux: failed to load policy booleans\n");
+	if (ret)
 		goto out;
-	}
 
 	ret = sel_make_classes(newpolicy, tmp_class_dir,
 			       &fsi->last_class_ino);
-	if (ret) {
-		pr_err("SELinux: failed to load policy classes\n");
+	if (ret)
 		goto out;
-	}
 
 	/* booleans */
 	old_dentry = fsi->bool_dir;
@@ -653,6 +649,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
+		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
 		selinux_policy_cancel(fsi->state, &load_state);
 		goto out;
 	}
-- 
2.30.2

