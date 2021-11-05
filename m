Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B6C433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C063561108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhKEPsw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhKEPsp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C1C06120D
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g14so34006512edz.2
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q2yn6KlZEOXg6v4y/fwUWCIEnFK+T+hsemWr6Rl1Los=;
        b=fVMCtOElDbAfmAq14BvUWzfwL8YhS2xkOrhqU3BHJzzSC6b+xfjktvCD3TEo0vE4yw
         RikwPRBEG4Crc40TBVjX2Fl0VIBAnvq4b5gGNEEd6at4JSe7tdmm3sGs8WpP6Rqnxbob
         WUkTZJBYGk4gh1Q69g9r/KM0bdeQ2+Qf3ZQHqeT/ksN8HUnSo2vQHlsvnBIA3SRh3x5M
         EzGhKT22CTgcfcyXI+Ken+xXTg+ziMVFjmr+bF5xY+yO3NUDtw8WuIX6EsBKJUnQfGrL
         QA1dGZ1qGI2vgJXJrtvS8RPH1NKJ7cYzA0sOauHMoMzVdiTFmTBkpsByuYbjIa8RCLtC
         tEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2yn6KlZEOXg6v4y/fwUWCIEnFK+T+hsemWr6Rl1Los=;
        b=EV6+tnrXPKy6csQ6Fgolbp+wufqIXfjUtf7fRZS8LPaf89qprry0+nDAvMFbWkAlmH
         6V0N7ABfhhum6S17LYsUCY5nlzSiVWZ4TJTBuQVP6zxT+scP/uYBc/xK+PcCNvUiRVzd
         487v7fkcUxDdKIZqnHKAha8PiS0rvVepJMJ5krru9xq/0Dq9MRydE8zcRQkUMKbmZVWF
         0fH55sn11mOR1NKLpxxSBXfCu/rW5OOogdawALar8Y1kCEXsf3GaDUnYRl+KbJYV8JKF
         DXm+fcH4uc0OBsUiqrfoqPYwgAwd+65/ObnKBnVvX8sqWmL/rbc/AMvZ+EG2XzccQcOl
         YEhw==
X-Gm-Message-State: AOAM530W9qIsrjPBF3E/WK1kfJNQuW9M50Y16qCxDuMX1XxxVCi9L7SH
        hHNn+oZW2n4/TxRf4KiN7Y5D8ueWYD4=
X-Google-Smtp-Source: ABdhPJyNJLKpBd1p8km9KN8NOVWbwLXeESVK3c5hCcuL4ZHARJCGX/gG23j4iSgSpGFje/bQkp4Jpg==
X-Received: by 2002:a17:906:3f87:: with SMTP id b7mr63972795ejj.172.1636127163873;
        Fri, 05 Nov 2021 08:46:03 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 28/36] libsepol: validate constraint expression operators and attributes
Date:   Fri,  5 Nov 2021 16:45:30 +0100
Message-Id: <20211105154542.38434-29-cgzones@googlemail.com>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5ef95c61..25c6f0db 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -193,6 +193,49 @@ static int validate_constraint_nodes(sepol_handle_t *handle, constraint_node_t *
 				if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
 					goto bad;
 			}
+
+			if (cexp->expr_type == CEXPR_ATTR || cexp->expr_type == CEXPR_NAMES) {
+				switch (cexp->op) {
+				case CEXPR_EQ:
+				case CEXPR_NEQ:
+				case CEXPR_DOM:
+				case CEXPR_DOMBY:
+				case CEXPR_INCOMP:
+					break;
+				default:
+					goto bad;
+				}
+
+				switch (cexp->attr) {
+				case CEXPR_USER:
+				case CEXPR_USER | CEXPR_TARGET:
+				case CEXPR_USER | CEXPR_XTARGET:
+				case CEXPR_ROLE:
+				case CEXPR_ROLE | CEXPR_TARGET:
+				case CEXPR_ROLE | CEXPR_XTARGET:
+				case CEXPR_TYPE:
+				case CEXPR_TYPE | CEXPR_TARGET:
+				case CEXPR_TYPE | CEXPR_XTARGET:
+				case CEXPR_L1L2:
+				case CEXPR_L1H2:
+				case CEXPR_H1L2:
+				case CEXPR_H1H2:
+				case CEXPR_L1H1:
+				case CEXPR_L2H2:
+					break;
+				default:
+					goto bad;
+				}
+			} else {
+				switch (cexp->expr_type) {
+				case CEXPR_NOT:
+				case CEXPR_AND:
+				case CEXPR_OR:
+					break;
+				default:
+					goto bad;
+				}
+			}
 		}
 	}
 
-- 
2.33.1

