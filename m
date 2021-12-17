Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BFEC43219
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhLQSTe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhLQSTd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:33 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D997C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:33 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id ke6so3218084qvb.1
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oB1Gkr/CwqG8K0NbDDq6P8Np0LYych3pguT1Dlmmv+w=;
        b=JqjpABqN6thF+9U8ja3pvcSINYpMa6IPxtP04S3FOomuE4hO7/D4wQZ6kAt3MrOmBg
         Shx82NZPh2Iz5ZvXvidGeBljAu+mJelBilwY7KHPjvgsCLC4cBwyVYfOFlBS/dPHgZw9
         jFhSIDp53SkDITX2BjX5aX+QVXZZLJnWdr7ggx/2mNUbf0egwcMjJIQ7nVv/kNO+T9mX
         CuXwlvhFDhSiiwALN3SKwsdyrgZcwlf4ABUItrvh8a2exG4X09yuRAbNZAm5SFRiMlS2
         wUR2H8Pm6iW07OqzsG4WCR72u00NZ7itxTu6k+bz3aCbEGDfscrc97E+/+dJ0mJKVGt/
         lM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oB1Gkr/CwqG8K0NbDDq6P8Np0LYych3pguT1Dlmmv+w=;
        b=THvjmo7hwCV66GftZnh1wz7y16cMDWk8Qbr1BoTu+28nngioEZ473/das7vA2fLVu9
         ANxDhkSAQZo0K8lCkzALi8g7MlkwxF+JUd+3OP2dW3deUFZq5EY5yTmzZLzEePIMcj7L
         lCB0BuXJb6YODTiFirb3qvoG3ePHKJDVva8bPH93ldg+f2qCSUV0VGbgsSIkk+Ax9+ec
         pEyhwlBwIVEEDwA59b2anIIiKxx6w/ofXL7vyjcMB2WBYw15Uaa6O3ED2+Tn8YbquxJE
         4WrOLuQcV2MI0Jf97Qr7O2Jf8u4eSuG/5Y4JeaNjC2fm5lrlfndh/tLoWe0LMm1gXNuM
         3P8w==
X-Gm-Message-State: AOAM531Cm0Ekp03SMkqyxj6jmf2HRL/hsvlkxEFoDCI1iZ9WLYryuarJ
        LjhEiDW100xEDzQ3f8YlkIGpntPZYFw=
X-Google-Smtp-Source: ABdhPJxw+sFmC6CbjKnzAbj+szLKa/L6cYSsl70xHu+1UksQEwzZOqetroVImoo9mWl7ewr8b1SN1w==
X-Received: by 2002:a05:6214:5186:: with SMTP id kl6mr3762698qvb.33.1639765171928;
        Fri, 17 Dec 2021 10:19:31 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:31 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 13/16] libsepol: Make return value clearer when reporting neverallowx errors
Date:   Fri, 17 Dec 2021 13:19:10 -0500
Message-Id: <20211217181913.336360-14-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The value returned from report_assertion_extended_permissions() is
the nubmer of errors, so call it that instead of ret.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 0bd620a7..b8fe8b21 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -148,8 +148,8 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	ebitmap_t *tattr = &p->type_attr_map[ttype];
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
-	int rc = 1;
-	int ret = 0;
+	int rc;
+	int errors = 0;
 
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
@@ -178,15 +178,14 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 							p->p_class_val_to_name[curperm->tclass - 1],
 							sepol_extended_perms_to_string(&error));
 
-					rc = 0;
-					ret++;
+					errors++;
 				}
 			}
 		}
 	}
 
 	/* failure on the regular permissions */
-	if (rc) {
+	if (!errors) {
 		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
 				"allow %s %s:%s {%s };",
 				avrule->source_line, avrule->source_filename, avrule->line,
@@ -194,11 +193,11 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 				p->p_type_val_to_name[ttype],
 				p->p_class_val_to_name[curperm->tclass - 1],
 				sepol_av_to_string(p, curperm->tclass, perms));
-		ret++;
+		errors++;
 
 	}
 
-	return ret;
+	return errors;
 }
 
 static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void *args)
-- 
2.31.1

