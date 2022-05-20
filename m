Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542AEC433EF
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 13:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbiETNJC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349693AbiETNI7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 09:08:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D51632B3
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c12so10708172eds.10
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4Dk3zB+WfskNYnsoK5lRUri5bHkHXJE7wAl8aVxVDDk=;
        b=GcMaBEtXaa3JnymiOhTuU9bYcRAXrFByk/rWBJyzIHhx3Nx9S9ag0lnWHqzFRdfw+/
         hyIVFhISks7fRsMeOfzwv3THqGOsHz+h4iI1LImZ5ozBeHKnRImHV3+3YlBxTSQCwoII
         MRjtzJM+bsHFnOuGIXKZQ7jry2ZfVPRebJBhoBL5zI8Ig4kcCuAZCej43rGFmlgs0v3r
         ZLjdIyqdoQjaOmzCBr76yoKQSjIlmEGoAYy2wJp3IiYw8Qr65PnMnY9H/ZvdMj2fxeuo
         Vhy2JwkgqmLLHBmpaYJFbm4q346aVipWWBLqUdhUpTU7aBYs0+zJVXkoGfwDFfFaE+lg
         nA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Dk3zB+WfskNYnsoK5lRUri5bHkHXJE7wAl8aVxVDDk=;
        b=eg5WoxHGuksGylnzausTDYv6henfrubCp992RfCq/HERBVNGmF1KaWTOKeS47fEKuR
         Cq1g/SMpfC8qRUhOtkdB8A7/Xb4xstRhOQ7OEvA9utfB5pkAOahGG8e2+djJaqo6xliI
         13FD+zUAAn2BtIiWiV1V/raAkHdI9uRD3DNmlje197yxpFbuszE4ijyoc8lbd9KO2lrk
         v7/IbeXehVPgtMhndcKb2iQVfm/SiQe7AZ/FF79+zeTmkcZBtA1tJL0necdyaU/omZDm
         NVZG62nOptleGNKti7aKd++3FVqb/9+T2NtdW2M4XN1q4a9FATv9YFqClx59iYHmq6Wn
         zC4A==
X-Gm-Message-State: AOAM533qp6RcHz+CLxsDwWr1l5M92k4zC4P7+uI6ga37P2xl+3q23b4o
        +VXYlkdbkPMXpYIHDkeHGz3A6GG1xEs=
X-Google-Smtp-Source: ABdhPJzm4BKQ8iXFpyBwZvgjYpEfQF4ZzSs410digkRpBAqgKcoKhFp1GQlthI/+B+Nr1JOcNjybfw==
X-Received: by 2002:a05:6402:3484:b0:428:1a5e:3d48 with SMTP id v4-20020a056402348400b004281a5e3d48mr11002675edc.401.1653052133873;
        Fri, 20 May 2022 06:08:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id hs33-20020a1709073ea100b006feb71acbb3sm160154ejc.105.2022.05.20.06.08.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:08:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] libselinux: name parameters in context.h
Date:   Fri, 20 May 2022 15:08:46 +0200
Message-Id: <20220520130847.10958-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520130847.10958-1-cgzones@googlemail.com>
References: <20220520130847.10958-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/context.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/libselinux/include/selinux/context.h b/libselinux/include/selinux/context.h
index 949fb1e1..1fb3a69c 100644
--- a/libselinux/include/selinux/context.h
+++ b/libselinux/include/selinux/context.h
@@ -17,7 +17,7 @@ extern "C" {
 
 /* Return a new context initialized to a context string */
 
-	extern context_t context_new(const char *);
+	extern context_t context_new(const char *str);
 
 /* 
  * Return a pointer to the string value of the context_t
@@ -25,24 +25,24 @@ extern "C" {
  * for the same context_t*
  */
 
-	extern char *context_str(context_t);
+	extern char *context_str(context_t con);
 
 /* Free the storage used by a context */
-	extern void context_free(context_t);
+	extern void context_free(context_t con);
 
 /* Get a pointer to the string value of a context component */
 
-	extern const char *context_type_get(context_t);
-	extern const char *context_range_get(context_t);
-	extern const char *context_role_get(context_t);
-	extern const char *context_user_get(context_t);
+	extern const char *context_type_get(context_t con);
+	extern const char *context_range_get(context_t con);
+	extern const char *context_role_get(context_t con);
+	extern const char *context_user_get(context_t con);
 
 /* Set a context component.  Returns nonzero if unsuccessful */
 
-	extern int context_type_set(context_t, const char *);
-	extern int context_range_set(context_t, const char *);
-	extern int context_role_set(context_t, const char *);
-	extern int context_user_set(context_t, const char *);
+	extern int context_type_set(context_t con, const char *type);
+	extern int context_range_set(context_t con, const char *range);
+	extern int context_role_set(context_t con, const char *role);
+	extern int context_user_set(context_t con, const char *user);
 
 #ifdef __cplusplus
 }
-- 
2.36.1

