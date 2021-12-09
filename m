Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E10C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbhLIQ4i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhLIQ4h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32801C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:53:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so21316459edd.0
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AupY0rq/ngLRRYB0lT7kF2uZfvz1ThtPdtvCBt+cFiA=;
        b=DgwexQ+2eQDlMNV0fo/IaHEAcBcgxKiAQeos7jm177wFL0B/YvR8uLlDfE8U8U06fQ
         vV4IWQBjoVt2tY8IagYptokRLGd+9MetvlHTSNMidXXQ2uS/xoqnotlwJb85cN+Kgw7i
         J1nMmh/6LwmpECpqLqjHMyaBxSRQ2K8lklwUx/4TCObkTexNj/tEG8shAFbUyo2DAvEF
         zT//8iX6bMRU3wjf3J9K0s3R/Dg9OWaxIROCnJNu971IaDVuyCmT1qXVSrAlAwETyYiQ
         0qkwDPMr4Ah3iRF3kVWz2iHvszrVrYMfvsyazLDv1Ez20UU43azODSrEZmYMQluzgmDM
         0NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AupY0rq/ngLRRYB0lT7kF2uZfvz1ThtPdtvCBt+cFiA=;
        b=azoK0+8Salzch6rF+paL37ggKvQb5ulM/R0LbyEK0yJZrublIW/SamHlqsOILIG2/j
         76e1xKeI1V2YSJsRP6pOP9mpUkuoLRy5mjvrGTQYO5Q4i5P7bXDqJ2PXTFmqS3mMZLhv
         JDYfyEHsti32TYc4ecoV9yNlvv7cqRz6tSQoABNdjY5ag8+MbRX6G9ms6VVJQZHltn5s
         8iCsM9F3wlaiRxDXqF+rBey3JzFRBPtrGum5Q6O+yg40aLnxwCx4JxWNY9H5EepNonFm
         +yit6PpEMO/T2vJ7v4quTa9ga3/ScGvCNRNzjRc+fFgcTz3XrmQNXte6KZ7xtqIxZUwa
         Ghbw==
X-Gm-Message-State: AOAM533WGdsODbcSLgkSF/drefUcdos9pUDz+oMLIRt5BfmcqHK/gIKv
        HMtJcwM7SKseCsKQ2ZPmMEBwDhjuLDA=
X-Google-Smtp-Source: ABdhPJxU0k+Xix75m1OZrMp2f+0rlfFHkBqVhrpLadLbkNM+oox60fS3yGdXKFeTi8cfZ9BqjgbKbQ==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr30826954edj.87.1639068599624;
        Thu, 09 Dec 2021 08:49:59 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:59 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 35/36] libsepol: validate fsuse types
Date:   Thu,  9 Dec 2021 17:49:27 +0100
Message-Id: <20211209164928.87459-36-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
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
index 2f30a3ad..b2d0e5e5 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -2,6 +2,7 @@
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/policydb.h>
+#include <sepol/policydb/services.h>
 
 #include "debug.h"
 #include "policydb_validate.h"
@@ -778,6 +779,15 @@ static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, validate_t
 					if (validate_context(&octx->context[1], flavors, p->mls))
 						goto bad;
 					break;
+				case OCON_FSUSE:
+					switch (octx->v.behavior) {
+					case SECURITY_FS_USE_XATTR:
+					case SECURITY_FS_USE_TRANS:
+					case SECURITY_FS_USE_TASK:
+						break;
+					default:
+						goto bad;
+					}
 				}
 			}
 		}
-- 
2.34.1

