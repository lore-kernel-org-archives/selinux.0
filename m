Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B569C433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B767207BB
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVWRu4CM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgHTRAz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgHTRAt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 13:00:49 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7374EC061386
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 10:00:48 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so2104113qkf.10
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=837Ue1DUQT9NZPTwJVrTlTmI5/0nEHB0EDdpxuJGt/k=;
        b=sVWRu4CMc5eHnHInroNqhXKgFImXwxIkvaD/D+gZjiuaMQPkReUsIbF+WdYtZ4h9S5
         2ecPf18ztVIyIIi5Cm/bdZVE5JFRhXjy/JFOtJGQ1GR53Ca/IhGo7/tAGZnijtBt8AaI
         kFzhfMu6qG7PGPZG7Bo3t4R2mBAA6qFWlcUuG4EwlurTbmSs0Z2KkveFl+XHF/pdj27l
         4Ejt81dUyoLl8jFGvKIBYlcJKPYarZdz3tkPlM7sAqS8M2ZTlF19fW43z5kdXiGNMdg1
         aKoaBqG75QJNkx9HDqvqU6kJXdY5hcXg70Cxp1cqQmWXsYN2H0Ldw+F+Mcfh1Qkj7JES
         gx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=837Ue1DUQT9NZPTwJVrTlTmI5/0nEHB0EDdpxuJGt/k=;
        b=ozIfs5k9rpfR+ZtU8PbimYUgJsYzZk8ubCmFWrTIflYeQkldRfBKAS9AXiptLT4u1N
         aemR75u7OfZ4rLkcSEKQZgwjO0tUie3O3mBY+nXzcl99s3qWVsT5T0BqUQgi1z0GBmzr
         Hw2LKG7XSzJxAGf6n760gV2LSKqH+FgvdU//rTZ9X6gYAvYJp0o7QvgCbK7HLRGOc/7G
         /gajRZ9At67Vua+ilVo6OQ4WN9cGuvQ3+HV1NfIoRAopW2zywrJN/U0niIabTPJWH7Jp
         5zhT+rPz5ToiScpVHsixH5S/GjhrdLhdt4tBp26tzLlGDtvXK5bqwC5xTejLm9Ay55Ls
         UXzw==
X-Gm-Message-State: AOAM533V0E/wpCYYM8wnTatF8im73m1IQ4wEbTzvYIwhjqq7xZpjZzjB
        sBaxPsWtB1fI3q0/JWDEx/w=
X-Google-Smtp-Source: ABdhPJwb2N2oH6OwLkGF0STT8qEzNDeCm67PrvrJSIiiwIeb4sf6iIihQqQyc267EG22w0miw5N3Zg==
X-Received: by 2002:a37:4e8a:: with SMTP id c132mr3314689qkb.472.1597942847721;
        Thu, 20 Aug 2020 10:00:47 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id 20sm2715424qkh.110.2020.08.20.10.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:00:47 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, plautrba@redhat.com, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: permit removing security.selinux xattr before policy load
Date:   Thu, 20 Aug 2020 13:00:40 -0400
Message-Id: <20200820170040.64664-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently SELinux denies attempts to remove the security.selinux xattr
always, even when permissive or no policy is loaded.  This was originally
motivated by the view that all files should be labeled, even if that label
is unlabeled_t, and we shouldn't permit files that were once labeled to
have their labels removed entirely.  This however prevents removing
SELinux xattrs in the case where one "disables" SELinux by not loading
a policy (e.g. a system where runtime disable is removed and selinux=0
was not specified).  Allow removing the xattr before SELinux is
initialized.  We could conceivably permit it even after initialization
if permissive, or introduce a separate permission check here.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ca901025802a..89d3753b7bd5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3271,6 +3271,9 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 	}
 
+	if (!selinux_initialized(&selinux_state))
+		return 0;
+
 	/* No one is allowed to remove a SELinux security label.
 	   You can change the label, but all data must be labeled. */
 	return -EACCES;
-- 
2.25.1

