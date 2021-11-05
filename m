Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F84C433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5061183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhKEPs4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbhKEPst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9C4C06120A
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v11so31974229edc.9
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AFTYGqfNHrZJ1ACQz2/zGM09rICj9wugDVtYqFIeVTI=;
        b=AYfA8F1kBcxiqBt98G0skwq9C5j24xz5OI8K8Dv7SI+AjRNWpbFThEfMBvh1hYmf55
         Ban8GTYzXGclHUg3eT4Sboi4139w4Y0rzUu6Nz90tpzrebum/9Iwmy+nV+0uv7RcjQFo
         UEhHd8BDeS8ISd17rYfs+zgqIGfuQ/uoqD2SewTGdFsrni52R4ct8zmQLzcEMNQg/9cZ
         SsQcMt9ZR1zCApYEw+fCGd7Zrz1/WEZ7eiBb8X+8H40eM+dJt08h0KN7iRMwd9X40xAZ
         0bseegvMLyNYquSGfkxMGmjgZymFxJOj6S3GHzm+jYyUBfqFqWNplO7mL9Yph0KgKTgj
         rQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFTYGqfNHrZJ1ACQz2/zGM09rICj9wugDVtYqFIeVTI=;
        b=3tN3rU7XY3lW4LOVoJHBZfp0ZtHy8HNw1dNwVPafnmB5sNSiWBNw6s3o2EGpPqcjgF
         kr20U9e3ZWqK6BOZYtG2NT9Lo6TrlgvQYA2IKi1jeTUyd6pU7G9SdS6z1JldtwQqsS/X
         OvkVvehL1skQV9nRciGTsYlDQ6jk+eSjdJJsT+r0nizgXUI3lhBUqDy07NSJBe0WUtWP
         Ctxm2PlW15rtaRYwGRM0cxZr1dxhdyjVRSVKIIZkvTNlsahpcKlpT34jhp3z2S4YgPZo
         1TNwZ0typjbK/zaxUvkpe9QKAATKGOYezSZm4+OKdHq+jlUnfQpl20U5mUF7ScvgVLVL
         514Q==
X-Gm-Message-State: AOAM532lw6gL9MuRoBSNf85WFw4oHByC6AAnOKIHidDpnAeBP/plg+j3
        WNffF7CDtdQ146KkW5YRz7gnxNcvMDg=
X-Google-Smtp-Source: ABdhPJy7dZXoIRfNYqGzdPzFBfLi1oMmodXMgqbbRVvtNN7X/SqM1QimyNzQ/QzGILhPmI7sURblSw==
X-Received: by 2002:a17:906:5811:: with SMTP id m17mr73808420ejq.289.1636127167894;
        Fri, 05 Nov 2021 08:46:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 35/36] libsepol: validate fsuse types
Date:   Fri,  5 Nov 2021 16:45:37 +0100
Message-Id: <20211105154542.38434-36-cgzones@googlemail.com>
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

Check the fsuse type is valid, e.g. of type xattr, trans or task.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   do not reject in binary reading, but check at validation step
---
 libsepol/src/policydb_validate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 9b18ac68..1c5ca0dd 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -2,6 +2,7 @@
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/policydb.h>
+#include <sepol/policydb/services.h>
 
 #include "debug.h"
 #include "policydb_validate.h"
@@ -777,6 +778,15 @@ static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, validate_t
 				if (validate_context(&octx->context[1], flavors, p->mls))
 					goto bad;
 				break;
+			case OCON_FSUSE:
+				switch (octx->v.behavior) {
+				case SECURITY_FS_USE_XATTR:
+				case SECURITY_FS_USE_TRANS:
+				case SECURITY_FS_USE_TASK:
+					break;
+				default:
+					goto bad;
+				}
 			}
 		}
 	}
-- 
2.33.1

