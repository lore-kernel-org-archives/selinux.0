Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB43C77B7C
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjELJaK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjELJaJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:30:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E816D8
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so87486865a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883807; x=1686475807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EBCVPZ4ojH9zBDKq1crcPMevnTTfX0aXVLhJKQUVjM=;
        b=IA8GfZ+AyLVBerTfJ+xm9n0Uye83Aerqvpnl85j15Z8IYUUhO+FqQeTd12s9dRRIcF
         F99JbqTCYBqgyZRtol0VGCSJFkCGVH7j2T6ctgt9uexOtl2GSxF4FRqmVhiu5ZSeYTfT
         AN+4iLNxhQrqzZrpRL3rT7gqfWRIxQX8CzFoHWcYbQpK2gwhzrV/O7HsEKw5oi6XMMYL
         Zk+BEtTI+WqO4WC3x1wibYZBhcbPZpMC4wUHpywDGzxUe3Z8vv8OPk6tL2zmmPHJq+kZ
         EEdn5JH6lgQwaa5hPgNSQYKsxitoI2aW4hNXXCISncKvqioG5pPCv5xpkOSTxAZ+EgoW
         4OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883807; x=1686475807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EBCVPZ4ojH9zBDKq1crcPMevnTTfX0aXVLhJKQUVjM=;
        b=WctO4TUN4Y6q7mr8ClhpMT1oB2TcQFpg2MN/I+IrqTqgScWeGnJ1k9AkpHid8YTJza
         CAKHW8WTihahuSyBm3L7HiFKQB722AksJj7zjDTt9BhAIkwNv1iuVV38QNGfnkq4CaVa
         kmHQEO0wNCTCXyw25ZYUh4ID7CUYI+x1xl4qdag9GMjJ0IdS9sWUp2Qx/F1EfxJVLED6
         gu+909Pg3i9510a8cYd3BZFNERBguJHjdxyqBJVUdu228nldwrgppTn22RTID2lZuqrU
         XdBPtfVbr+NJ/CVQ8JzsL8SIlthjdqARioXyHDJ2cTrQvXXgsFrdZhqo1IIZ8kNeE9sH
         SCxQ==
X-Gm-Message-State: AC+VfDxpErnUVyNTnnv7r9fcazCIy5zh/hOKB7oZZ5I7lrV8i+RtZ1xQ
        ilTzKh86PpkT3pbULkhbt5dCrje+tf6uGw==
X-Google-Smtp-Source: ACHHUZ4sPfhT6a7IbzoakMr4KYhmGgX5Dimldl8lrDz1hYcnorynErQcGshECpjvDhzM/cZryPg4Eg==
X-Received: by 2002:a17:906:da8c:b0:94a:653b:ba41 with SMTP id xh12-20020a170906da8c00b0094a653bba41mr7921015ejb.15.1683883806770;
        Fri, 12 May 2023 02:30:06 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id tc19-20020a1709078d1300b00969f2d5267asm4636356ejc.114.2023.05.12.02.30.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:30:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/5] libsepol: validate some object contexts
Date:   Fri, 12 May 2023 11:29:57 +0200
Message-Id: <20230512093001.49208-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure various object context entries have a name, since they are
duplicated via strdup(3), and the order for ports and memory regions is
valid.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 301aa200..e0d290ff 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1149,6 +1149,8 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p, valid
 				case OCON_NETIF:
 					if (validate_context(&octx->context[1], flavors, p->mls))
 						goto bad;
+					if (!octx->u.name)
+						goto bad;
 					break;
 				case OCON_PORT:
 					if (octx->u.port.low_port > octx->u.port.high_port)
@@ -1163,6 +1165,34 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p, valid
 					default:
 						goto bad;
 					}
+					if (!octx->u.name)
+						goto bad;
+					break;
+				case OCON_IBPKEY:
+					if (octx->u.ibpkey.low_pkey > octx->u.ibpkey.high_pkey)
+						goto bad;
+					break;
+				case OCON_IBENDPORT:
+					if (!octx->u.ibendport.dev_name)
+						goto bad;
+					break;
+				}
+			} else if (p->target_platform == SEPOL_TARGET_XEN) {
+				switch(i) {
+				case OCON_XEN_IOPORT:
+					if (octx->u.ioport.low_ioport > octx->u.ioport.high_ioport)
+						goto bad;
+					break;
+				case OCON_XEN_IOMEM:
+					if (octx->u.iomem.low_iomem > octx->u.iomem.high_iomem)
+						goto bad;
+					if (p->policyvers < POLICYDB_VERSION_XEN_DEVICETREE && octx->u.iomem.high_iomem > 0xFFFFFFFFULL)
+						goto bad;
+					break;
+				case OCON_XEN_DEVICETREE:
+					if (!octx->u.name)
+						goto bad;
+					break;
 				}
 			}
 		}
-- 
2.40.1

