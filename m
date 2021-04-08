Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE88C433ED
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C46B61103
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhDHTQl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDHTQk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE0C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:28 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f12so2328691qtf.2
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGp8CG8ZwKsh42+s8xC53KdJNxA3ZmtfgGM2bRaeXOI=;
        b=coUepOon4DSmNzCo203453E6SnIWAlK9d9Q9gSJQy/pQl3vGXPcEQvyprSXYh143n6
         c/AaXbYQqChtoloLfdLEfUDzwd4j7df/RbB1pK0LBm9g9DVABBlDwAoic6+vuhQcs0DN
         DQjt1EY1INrOTyVN6Fqs72PQ7xZPnITkKf7entHzrAM5m14nyJ1Ia+N0fipgBFKPylci
         W7z0vSzLKHzGU8kbHLou9Or+ZZ6UtG1wCajb2fwzEci2E+QKJph1o6i+X/ped6izosPN
         JPbFHjfsvZYdad/aqMPuewBTGeD7oyEYIm4jbRbhzxY8HVGWP1jZGPTNYJE3kMvn7EX5
         Ny6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGp8CG8ZwKsh42+s8xC53KdJNxA3ZmtfgGM2bRaeXOI=;
        b=lprkZnKmiZ49cJwx0kx/oIMPEqVJlQCwM7D673J59l9oZ1iAbhm5++WH5/yaQbUReg
         yQuHkVIvQRPyUmjJp6lM0RlhMrnHOdpyzkSiZddGohKuPXnh4U5VlcMKsqd01NS4N4lQ
         NNIj9tePP/gEARyn1DrC1N7jTeQFr+3xo7SPbpjZGWby8ui0/v2pqqTXvfvhu4Xn+wCm
         +es38uI56aw+7tH0f93bcILWMMy3jQIU460resiwCiP/fBW977faz1pdTaMY9zJmj9E7
         sSmuDVOrcoXtDXx+z5thwkkUDfJPb1fwrw//D38OWY5xyykBLOESGh0dneGuiGBvjsv2
         3r0g==
X-Gm-Message-State: AOAM532jiI6/ghi2CAoiNA6ZA7Dcver5dgufWsht0T2ES5kwv6CB0PVj
        gv6AffYqI13i1YmRSF08gHvf4HMWrlU2NQ==
X-Google-Smtp-Source: ABdhPJxUrtT3oj7tH34oABs1xnA3gk5kYcEC3b9BfEy/nk/ZKFzh041/KJtYZZSRGlS6L58MjCQI3w==
X-Received: by 2002:ac8:7b8d:: with SMTP id p13mr9067839qtu.94.1617909387273;
        Thu, 08 Apr 2021 12:16:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:27 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 03/11] libsepol/cil: Destroy classperm list when resetting map perms
Date:   Thu,  8 Apr 2021 15:16:06 -0400
Message-Id: <20210408191614.262173-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Map perms share the same struct as regular perms, but only the
map perms use the classperms field. This field is a pointer to a
list of classperms that is created and added to when resolving
classmapping rules, so the map permission doesn't own any of the
data in the list and this list should be destroyed when the AST is
reset.

When resetting a perm, destroy the classperms list without destroying
the data in the list.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index db70a535..89f91e56 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -36,7 +36,7 @@ static void cil_reset_class(struct cil_class *class)
 
 static void cil_reset_perm(struct cil_perm *perm)
 {
-	cil_reset_classperms_list(perm->classperms);
+	cil_list_destroy(&perm->classperms, CIL_FALSE);
 }
 
 static inline void cil_reset_classperms(struct cil_classperms *cp)
-- 
2.26.3

