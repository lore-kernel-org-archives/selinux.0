Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9CAC32788
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5232220841
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5232220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJKWEG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:04:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeJKWEG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 18:04:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so9963363wrd.4
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 07:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hjG/qidPGET9OFrXSEQJgttS4TuVegksBD00i8Ot5WE=;
        b=D50ZFvBiaxQXfVGeR40jvwu2R5H4XwnuumjRoje+bWIVInmzxO5A8jOCho3NcvKOdQ
         KOIXxhy0ZkWkCYHN4AKtDTTr7h1qGVbAAo7Pu4UHm/e1JIsToy5k9yEwwV777mhrjglx
         j5d8hdbKRQVEGQM2QWZgwNjVzHxlw1paYILEZE9Xb2jenfXTNM6skORmpQ9bxOxdvTb2
         vNLZduT4iV1s0fzx/USa7bBTpk+ObdP7024ERBrHSO9wo7ipQ/Xj35mtEqCaMrNo8R2j
         Bw9xo76KHZZHRBkbk/KR5yLPSbngrJUUESkf2E/Fkc2ctL6rht/Ksyzoep95S+NWlyU4
         3JOQ==
X-Gm-Message-State: ABuFfoiXZw3oFezqFS9I8tl2HVoxMGAUJIE3AqCEBHuPHeeY9yCgbGNH
        BwrTo72BLmkbgrH57N0SFMzCyxmwx/N4vA==
X-Google-Smtp-Source: ACcGV60av9bJ2p6Yc9ZWR0yGjpNbXRBaLLUtGb/Ey+MnvC3M/uJ1NTTrEpBqd0aJb7KD28QGz8ZX2A==
X-Received: by 2002:adf:ee88:: with SMTP id b8-v6mr1960431wro.48.1539268597503;
        Thu, 11 Oct 2018 07:36:37 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g186-v6sm21391329wmf.19.2018.10.11.07.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 07:36:36 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        James Morris <james.l.morris@oracle.com>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] selinux: fix byte order and alignment issues in policydb.c
Date:   Thu, 11 Oct 2018 16:36:30 +0200
Message-Id: <20181011143630.9052-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add missing LE conversions to the Infiniband-related range checks. These
were causing a failure to load any policy with an ibendportcon rule on
BE systems.

Also, the temporary buffers are only guaranteed to be aligned for 32-bit
access so use (get/put)_unaligned_be64() for 64-bit accesses.

Finally, do not use the 'nodebuf' (u32) buffer where 'buf' (__le32)
should be used instead.

Tested internally on a ppc64 machine with a RHEL 7 kernel with this
patch applied.

Cc: Daniel Jurgens <danielj@mellanox.com>
Cc: Eli Cohen <eli@mellanox.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: <stable@vger.kernel.org> # 4.13+
Fixes: a806f7a1616f ("selinux: Create policydb version for Infiniband support")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f4eadd3f7350..2b310e8f2923 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -37,6 +37,7 @@
 #include <linux/errno.h>
 #include <linux/audit.h>
 #include <linux/flex_array.h>
+#include <asm/unaligned.h>
 #include "security.h"
 
 #include "policydb.h"
@@ -2108,7 +2109,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 {
 	int i, j, rc;
 	u32 nel, len;
-	__le32 buf[3];
+	__le32 buf[4];
 	struct ocontext *l, *c;
 	u32 nodebuf[8];
 
@@ -2218,20 +2219,20 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				break;
 			}
 			case OCON_IBPKEY:
-				rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
+				rc = next_entry(buf, fp, sizeof(u32) * 4);
 				if (rc)
 					goto out;
 
-				c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
+				c->u.ibpkey.subnet_prefix = get_unaligned_be64(buf);
 
-				if (nodebuf[2] > 0xffff ||
-				    nodebuf[3] > 0xffff) {
+				if (le32_to_cpu(buf[2]) > 0xffff ||
+				    le32_to_cpu(buf[3]) > 0xffff) {
 					rc = -EINVAL;
 					goto out;
 				}
 
-				c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
-				c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
+				c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
+				c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
 
 				rc = context_read_and_validate(&c->context[0],
 							       p,
@@ -2249,7 +2250,8 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				if (rc)
 					goto out;
 
-				if (buf[1] > 0xff || buf[1] == 0) {
+				if (le32_to_cpu(buf[1]) > 0xff ||
+				    le32_to_cpu(buf[1]) == 0) {
 					rc = -EINVAL;
 					goto out;
 				}
@@ -3105,7 +3107,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
 {
 	unsigned int i, j, rc;
 	size_t nel, len;
-	__le32 buf[3];
+	__le32 buf[4];
 	u32 nodebuf[8];
 	struct ocontext *c;
 	for (i = 0; i < info->ocon_num; i++) {
@@ -3192,12 +3194,12 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
 					return rc;
 				break;
 			case OCON_IBPKEY:
-				*((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
+				put_unaligned_be64(c->u.ibpkey.subnet_prefix, buf);
 
-				nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
-				nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
+				buf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
+				buf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
 
-				rc = put_entry(nodebuf, sizeof(u32), 4, fp);
+				rc = put_entry(buf, sizeof(u32), 4, fp);
 				if (rc)
 					return rc;
 				rc = context_write(p, &c->context[0], fp);
-- 
2.17.1

