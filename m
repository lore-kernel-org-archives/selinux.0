Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A4DECDE30
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E0A2151D
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E0A2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJQWnH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:43:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45145 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQWnH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Oct 2018 18:43:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so30034275wrw.12
        for <selinux@vger.kernel.org>; Wed, 17 Oct 2018 07:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eJGkJ0owUL3V+L1BnNpzt4sCGftNBgXEgWmcqcJ8Aiw=;
        b=qU/62/xYBY41cGbAvM4WyDsdIJEY7LA4+zTfx0W1R9IslBeNlzGUV5WYOsfyfkUHo3
         c3fGH6ApFsbZYrSBqbD3F1PD+KaqN6o8ZinJ1eDRb0ur+lsjciSLTXJwNFBp7eGV27pn
         KtxSR4xXSbIYhTp1FnXc0cYnLQcOe3AbOe8IL4ahRp9cIcsxYVxXccbpADoh914UMLGg
         18acYT/N1jCXkpqVFkeb1U0EiJrCFNL+MZC1hUunR40uBXMUcZ4U4PB/DUwPKUceaTaU
         EVN+wDSG3uC/i5/IkAq622Ey+dJh6MudGeZVotmhQdDA8SKRsSvYoASpZ6Go667XKqL2
         RdVg==
X-Gm-Message-State: ABuFfoiRAFdyaPQMQUHyOEe/omu/TwlyfuwNfyR1Jgl46YNWfu/LxIaq
        1O28NpXtU25Kz9pEcl8LyWwmvBe7niFv2w==
X-Google-Smtp-Source: ACcGV610vsV8SjiCKctEmARekorkUcSjCGFsI6MpCKligu9vZFflOEPnGQa2CGqcZm4Zs3+V8BLZ0g==
X-Received: by 2002:adf:a481:: with SMTP id g1-v6mr25817571wrb.167.1539787624586;
        Wed, 17 Oct 2018 07:47:04 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g15-v6sm11561082wrr.36.2018.10.17.07.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 07:47:03 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel Jurgens <danielj@mellanox.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] libsepol: fix endianity in ibpkey range checks
Date:   Wed, 17 Oct 2018 16:46:59 +0200
Message-Id: <20181017144659.10960-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We need to convert from little-endian before dong range checks on the
ibpkey port numbers, otherwise we would be checking a wrong value.

Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/policydb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index a6d76ca3..dc201e2f 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2830,15 +2830,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 				break;
 			case OCON_IBPKEY:
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
-				if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
+				if (rc < 0)
 					return -1;
 
+				c->u.ibpkey.low_pkey  = le32_to_cpu(buf[2]);
+				c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
+
+				if (c->u.ibpkey.low_pkey  > 0xffff ||
+				    c->u.ibpkey.high_pkey > 0xffff)
+					return -1;
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
-- 
2.17.2

