Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A7EC07E9C
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12080613B6
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbhGNSQm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbhGNSQl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 14:16:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9759C06175F
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj21so4470433edb.0
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DlaWKBJ7bf8FBDIVmDY5evDHmATVZTaIfUi9oh+inFY=;
        b=OuQ+iI8HcDtiVEroQ0FLThT/qSy9eyJVtiS+wT8NafVfrOpQih7jRnSrQ6nIFxxoeA
         TpjT+wOdBWflWiJ2o4pkuLbb8o+gNZjCYz6/j2aeDZRGO938vCvXb8RVjKMTPIjsTNNE
         Ru0sFixp5u7/Owjvg4kbkBJgOpLjhX2CRrdZ/z1vzPqOeIKgkn+KYoU2M6zmpTd7TAqY
         I2wZ56JHgWXe++ZOIUkh4eIxwbym7PToZJY23EdWquvcCi2GJP3p43Daav80FBIaKIMH
         ivTwNXZ2BeusLkpY74JOJgKdaOBgTOnutM3vrCjXppHqhKcpR22AUg5RFlPbLkGBEFZJ
         zNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DlaWKBJ7bf8FBDIVmDY5evDHmATVZTaIfUi9oh+inFY=;
        b=LG1a3+gHQt9znOiNX9wWM9YNSU807eypMG95fFF7lnc0XmrxGd/xh0WlQTFLlQbi5r
         PAp0TjW4r94X7gL+ht6x5cfGW2Z+OGkWgue52LpTCzj0EN8ajdVQMxJmH+WEW0D2tXhy
         /b6r5PhpyEKt1UldIiIKxz1IKt7AAgi3Epy9ch+bMwCwrCQDdQ9AwdlwtajZe3zQtA7d
         gEQtejdNLaZbs+/sDETJnoJOA0LcKU8+8cmqGCVbGAuQp4QPUjfBRAAWyBDmo1yRdqtV
         zqkxz54+kqEJvoB8zF9/JAYBBHUGShppjlKQkKnOTchYG0V1J3+HVIOpKJW6jplZbEbG
         c9pw==
X-Gm-Message-State: AOAM532WornAt1oDwuwTl82YGjolWQRHaHYtPSBhXmTvfR3yw73Rqapi
        VUKngycQqxU6YqVGWnBXxHoZLxuQ2Bs=
X-Google-Smtp-Source: ABdhPJy1itcGc3KFsYL4rMlHtKCbYaC7amUSL0BiKNlsONUgDdC9xEd+jb9p3n59Nni/Lc8WkDu4Bg==
X-Received: by 2002:a05:6402:3d4:: with SMTP id t20mr15438360edw.274.1626286428392;
        Wed, 14 Jul 2021 11:13:48 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-198-161.95.116.pool.telefonica.de. [95.116.198.161])
        by smtp.gmail.com with ESMTPSA id ot18sm1020975ejb.109.2021.07.14.11.13.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:13:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/6] secilc: fix memory leaks in secilc2conf
Date:   Wed, 14 Jul 2021 20:13:40 +0200
Message-Id: <20210714181343.58880-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714181343.58880-1-cgzones@googlemail.com>
References: <20210714181343.58880-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When specifying -o more than once, the previous allocation leaks.

Found by scan-build.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/secil2conf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index d4103777..c49522e5 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -111,6 +111,7 @@ int main(int argc, char *argv[])
 				qualified_names = 1;
 				break;
 			case 'o':
+				free(output);
 				output = strdup(optarg);
 				break;
 			case 'h':
-- 
2.32.0

