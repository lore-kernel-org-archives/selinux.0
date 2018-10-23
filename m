Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B5C46475
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 06:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D981205F4
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 06:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D981205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeJWPUJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:20:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37531 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJWPUJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 11:20:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id x19-v6so529914wmc.2
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 23:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JAVTWh5BI7wQdHKlITdFENhLjeq6ElqA350PGEEw+3w=;
        b=RDLDbvD54cAPFwDX/6plRVaArgyM3BRWK0EoRdfJQ8gNBuJFj1tM9qNE5wf3R549nT
         MKwRh0sHmpLcQoeTv+I7zxj1h1qQLkd0KMPmQ5VeBcLOnaSw2uGGToBgTaucUJMfnOkM
         6R7daK7Yq+d6ZaW6jownanwLDUw+0xljayVLLIvY+k2ND6mMGQeQXbmHvrBUr9zwdmk3
         HEln7aB+6P93qfmehRy+32p1ZLb7d5JLRhG47zAVuVJG3HleWfkmU4huniPxK9/R7bjv
         qDBJTE0JwQJov63cLnyJJEiK82q2TybGaBF/gyANKn5J2jbAKJ0hdga6DoY6FxoObce3
         W/ew==
X-Gm-Message-State: AGRZ1gI3Bq/49ngfhcZx++k1ihmgmb1XhPe0I3wp285Wygmt3nUDxA28
        cgQAM0PcoZLRacgv2l5RPYOZJyfiB4c+0A==
X-Google-Smtp-Source: ACcGV60f+rN5liSi5ODia1afGL5Q39NjrbsbB0i6EcjrUoKjuNbhUlSeJO3MeDjKEystKNx4DCMbiw==
X-Received: by 2002:a1c:f518:: with SMTP id t24-v6mr1173416wmh.82.1540277883822;
        Mon, 22 Oct 2018 23:58:03 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e6-v6sm285287wrc.70.2018.10.22.23.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 23:58:03 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <bill.c.roberts@gmail.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2] libsepol: add missing ibendport port validity check
Date:   Tue, 23 Oct 2018 08:57:57 +0200
Message-Id: <20181023065757.16784-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The kernel checks if the port is in the range 1-255 when loading an
ibenportcon rule. Add the same check to libsepol.

Fixes: 118c0cd1038e ("libsepol: Add ibendport ocontext handling")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/policydb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Changes in v2:
 - use UINT8_MAX as the limit for ibendport.port value to emphasize that
   it is an 8-bit value

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index db6765ba..96176d80 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2854,7 +2854,9 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 					return -1;
 				break;
 			}
-			case OCON_IBENDPORT:
+			case OCON_IBENDPORT: {
+				uint32_t port;
+
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 				if (rc < 0)
 					return -1;
@@ -2862,6 +2864,10 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 				if (len == 0 || len > IB_DEVICE_NAME_MAX - 1)
 					return -1;
 
+				port = le32_to_cpu(buf[1]);
+				if (port > UINT8_MAX || port == 0)
+					return -1;
+
 				c->u.ibendport.dev_name = malloc(len + 1);
 				if (!c->u.ibendport.dev_name)
 					return -1;
@@ -2869,11 +2875,12 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->u.ibendport.dev_name[len] = 0;
-				c->u.ibendport.port = le32_to_cpu(buf[1]);
+				c->u.ibendport.port = port;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
 				break;
+			}
 			case OCON_PORT:
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 				if (rc < 0)
-- 
2.17.2

