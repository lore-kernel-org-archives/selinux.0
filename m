Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D69C43217
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA5D61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhKEPsy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhKEPsr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E633BC061210
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g14so34006805edz.2
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qvzdy3z/bjxmFj9R7taifjioJvbGerT5kfjGLfP21v0=;
        b=gijWSWLFpl+PuVwe9KzcO1ggUYr0rtA3bVAjmtEafDH7vWohNOMD/o7w6+YmH5HwEP
         Vhwx8iS7EMJHZV03mGOshfBKTdyg7gx47mxOoOEyA6dgqhlvQBQlAMrqVJjY5MphICMM
         1r6GGj4HgJkgkjc5+rxP8sXwR8hCXoR5PCL4+BWZsXNQgN20+RF49AvbSbnrFuuZYxfj
         dBdxzcFr4WKGOndOJTjrF21DdaNkoT2NeuIo6XEbx3jAhOGW4MTVVBB8GhNZBhVuz0Rf
         S93K+Dg4yS5C95sAhn7taxbUHsG0rsivyv+C/kB3Yo9hSAWCEoO85CYPvJRUjhBuxP2r
         h0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qvzdy3z/bjxmFj9R7taifjioJvbGerT5kfjGLfP21v0=;
        b=n44bZXB9fLIO+HAnp+RK0liAao15+cC0PHJVUp2OAiBZfCyDB+uSjw8gNmoqYLV1BD
         a8Pcu3c9tqs8wVvgiaOfQCGee5lyiDX+AzPAL4coFTnVUo8dNE+7XJrmIob90aQdCNjP
         skdFPbyhvTfnlSZd0l8D9rWUECUHrj8ndz5szRB9x7BUYISxmqz9wplP0Y1hBBhtIxma
         P+qp5Fv4ZMDNeXEMbxNA64wUN9LDl0Ho/cmVOfcsEDZisntrPkE8/XWTsIpe5arKAqch
         7oU9Jfqb1Td1uY4yL5VBoF8LIYslpW7WpSalgUGAIzOvplVwmSDC9qBD3Nmu7Dmc9kpG
         8bcQ==
X-Gm-Message-State: AOAM532W7EbAjtwu3sSVm9Y5JuLJez72W3d8bN5wsWlUuR2jLAi7sYF1
        /fMz9ufHQeuN6aDpPRdUV3OCMn7twQY=
X-Google-Smtp-Source: ABdhPJyQXwCdOzwfV+r66VJKovmn+kgRCkzJrs7niavF0fjfbqn/SRVffeyllRqjr4vyEzVViTST7Q==
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr70853503ejd.425.1636127165523;
        Fri, 05 Nov 2021 08:46:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 31/36] libsepol: validate genfs contexts
Date:   Fri,  5 Nov 2021 16:45:33 +0100
Message-Id: <20211105154542.38434-32-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the literal contexts in a genfs statement are defined.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   also check in base modules
---
 libsepol/src/policydb_validate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 96f133c9..5cec143f 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -777,6 +777,25 @@ bad:
 	return -1;
 }
 
+static int validate_genfs(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	genfs_t *genfs;
+	ocontext_t *octx;
+
+	for (genfs = p->genfs; genfs; genfs = genfs->next) {
+		for (octx = genfs->head; octx; octx = octx->next) {
+			if (validate_context(&octx->context[0], flavors, p->mls))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid genfs");
+	return -1;
+}
+
 /*
  * Functions to validate a module policydb
  */
@@ -980,6 +999,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_ocontexts(handle, p, flavors))
 		goto bad;
 
+	if (validate_genfs(handle, p, flavors))
+		goto bad;
+
 	if (validate_scopes(handle, p->scope, p->global))
 		goto bad;
 
-- 
2.33.1

