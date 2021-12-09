Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53DFC433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbhLIQ4C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbhLIQz7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75844C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so21204296edd.13
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IP5ZpVNUfmoxrvMlaDS0RbWrW3+lHQdxlkbQD234sJQ=;
        b=UB5eTm3y6cQ1hvscqSiKygpvHCAwOeqU0q3+gzyZ5kiqwvIqqBG9075Z9Yvnn30t7u
         QohDLG0KY3L4n8SNnSN9Q61aGbYsrPx1EPxYnatmtuPzfj0NdSJjnMDRXPcRsU61byB0
         w4i3S8h8UN3UofGzYIVXR7Nq599kOOOdjoGKTcDcTBKnT5al8IAEzKqh/rZdh0q67JEI
         ikE0u/y6xmpIsI+E7OvHHc5q/ul3/2qLO9dVz4Q8w2L4ccNsd9+hDKBMHYcHj9MlP8+D
         pMvAy6htySGCvNgdbAoUNTirpbQ0KbhL/7KMrNopf+UPrSJqD24GF3ZcCsOWlhIzjAe5
         +xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IP5ZpVNUfmoxrvMlaDS0RbWrW3+lHQdxlkbQD234sJQ=;
        b=4cVrZKJXiRKfjNwVew21gHxTtuHiBu/lg4QcUiMnq5AYAIYeV1j6Lgctt5+3KkXhNk
         FrclQjzinTwCYWBpFLExrLbhz7eX0atpRhyEIwvIDEOy3Aq7EeSTrCPaup5S5pLz5ZZ0
         Gzbo5N4GKSYFBJbS7yrZmJYIrKvwbPhQ9BOUhhijuC35j1BkTSFsn/9H7XhSIJ5uqsq3
         KmJfu6JYHPShUl6KUNihrzYQX20lxyQhoZJ6uTISUmWzK9XORd5wvqHQ0p2j0sgPohqN
         SUQ+szJoHHFUv6B6yeqfKsEKjGu5E0BFowNVC2/mxROjtrrj17xyqNzpUhIWOc4K3moJ
         E9rw==
X-Gm-Message-State: AOAM530z6B2Kc1UFpA/u7kPmxMQmDaYzF/x0LBiiHf1DNnexzXcCpZZx
        nrH01Heym/dauk6Z/oDb4qoZ2i5IyYw=
X-Google-Smtp-Source: ABdhPJw2wWad3pAb4jU49qYKTOfAhgo8wA6QTGj2/zw60U5DSjl9U6Vo+Do9Xwv6v6L7qqVy/xcrag==
X-Received: by 2002:a50:9d48:: with SMTP id j8mr29229123edk.192.1639068593521;
        Thu, 09 Dec 2021 08:49:53 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:53 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 27/36] libsepol: validate avtab and avrule types
Date:   Thu,  9 Dec 2021 17:49:19 +0100
Message-Id: <20211209164928.87459-28-cgzones@googlemail.com>
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

Check for invalid avtab or avrule types.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   also check avrule types
---
 libsepol/src/policydb_validate.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 82193379..5ef95c61 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -483,6 +483,20 @@ static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
 		goto bad;
 	if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
 		goto bad;
+	switch (0xFFF & key->specified) {
+	case AVTAB_ALLOWED:
+	case AVTAB_AUDITALLOW:
+	case AVTAB_AUDITDENY:
+	case AVTAB_XPERMS_ALLOWED:
+	case AVTAB_XPERMS_AUDITALLOW:
+	case AVTAB_XPERMS_DONTAUDIT:
+	case AVTAB_TRANSITION:
+	case AVTAB_MEMBER:
+	case AVTAB_CHANGE:
+		break;
+	default:
+		goto bad;
+	}
 
 	return 0;
 
@@ -536,6 +550,23 @@ static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, validate_t
 			if (validate_value(class->tclass, &flavors[SYM_CLASSES]))
 				goto bad;
 		}
+		switch(avrule->specified) {
+		case AVRULE_ALLOWED:
+		case AVRULE_AUDITALLOW:
+		case AVRULE_AUDITDENY:
+		case AVRULE_DONTAUDIT:
+		case AVRULE_NEVERALLOW:
+		case AVRULE_TRANSITION:
+		case AVRULE_MEMBER:
+		case AVRULE_CHANGE:
+		case AVRULE_XPERMS_ALLOWED:
+		case AVRULE_XPERMS_AUDITALLOW:
+		case AVRULE_XPERMS_DONTAUDIT:
+		case AVRULE_XPERMS_NEVERALLOW:
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	return 0;
-- 
2.34.1

