Return-Path: <SRS0=DaVr=M6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C57C5ACCC
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 07:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F152145D
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 07:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F152145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJRPts (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:49:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45682 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeJRPts (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 11:49:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id f17-v6so731954wrs.12
        for <selinux@vger.kernel.org>; Thu, 18 Oct 2018 00:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2C2yhGazKsUAhM9g+GUWdl5ZKhy3MYA7DgeN/hULiOY=;
        b=Hhu210gN6enSojlXQ9PJCx7cgW3P3B7K3rOOwN1mw6TKj+AmQpGGRER2snAInpcA9N
         Y7kkv0w/nF594ho1bmu0TQYvTXhxb4s2d3+lPaH1z+HqfjPEbTeKN7asZ617/M6F519O
         nAVnpPBnQO2MT93D5MvW6CpcrWTctlML0Dbf72FfcJhEAaHZfdv8KcxMHd3VdtTIW91C
         r0Lfhv/2HoyCBZaldy7yIFWp45D0M06KtF53IWLmNdGD1ewOC1UJN0+bcEEymOv32Yb+
         3woU98ez8VA9dJ5XXM8kU+MoB44g8uUXr8rD6A7WK/4RaP7GS19S2wZMRIBtNoYqdqEV
         JBqQ==
X-Gm-Message-State: ABuFfoidxfwGjH9tLTxU1+zJd+ujpn9DRIrTi4VaC3RURLvOPrE/wesr
        iVeH6XTsTryky6ZnHLIBzler1aJp9+XoMA==
X-Google-Smtp-Source: ACcGV62/nSjOPvaInMoec+K0y2hcrH9rRaDKEQ1fZl3Zp2tP+Wmyp+wDMdCRGmZtzbI4A63O9xE5vA==
X-Received: by 2002:adf:e808:: with SMTP id o8-v6mr26229761wrm.269.1539849001941;
        Thu, 18 Oct 2018 00:50:01 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c14-v6sm5625227wmh.44.2018.10.18.00.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 00:50:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <bill.c.roberts@gmail.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2] libsepol: fix endianity in ibpkey range checks
Date:   Thu, 18 Oct 2018 09:49:57 +0200
Message-Id: <20181018074957.24080-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We need to convert from little-endian before dong range checks on the
ibpkey port numbers, otherwise we would be checking a wrong value on
big-endian systems.

Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/policydb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

Changes in v2:
 - defer assignment to 16-bit struct fields to after the range check

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index a6d76ca3..db6765ba 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2828,21 +2828,32 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 				    (&c->context[1], p, fp))
 					return -1;
 				break;
-			case OCON_IBPKEY:
+			case OCON_IBPKEY: {
+				uint32_t pkey_lo, pkey_hi;
+
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
-				if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
+				if (rc < 0)
+					return -1;
+
+				pkey_lo = le32_to_cpu(buf[2]);
+				pkey_hi = le32_to_cpu(buf[3]);
+
+				if (pkey_lo > UINT16_MAX || pkey_hi > UINT16_MAX)
 					return -1;
 
+				c->u.ibpkey.low_pkey  = pkey_lo;
+				c->u.ibpkey.high_pkey = pkey_hi;
+
+				/* we want c->u.ibpkey.subnet_prefix in network
+				 * (big-endian) order, just memcpy it */
 				memcpy(&c->u.ibpkey.subnet_prefix, buf,
 				       sizeof(c->u.ibpkey.subnet_prefix));
 
-				c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
-				c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
-
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
 				break;
+			}
 			case OCON_IBENDPORT:
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 				if (rc < 0)
-- 
2.17.2

