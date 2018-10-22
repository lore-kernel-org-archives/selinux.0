Return-Path: <SRS0=10e4=NC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F0C67863
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 08:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F49205F4
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 08:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F49205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJVQfp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:35:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53421 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeJVQfo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Oct 2018 12:35:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id y11-v6so9262952wma.3
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 01:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zPNnaR+OscqGVO8MWgaGTRnSIc7drH7cHgnhJXE09sk=;
        b=KPV+b35h33fvXXoT0a01ix+IUc3M00y2tAYyP8U4SY7iXRcnGYuzY97nPaiIj4MTwO
         9zHHONkuSaeLZmowNwUSJSxM9H4weqMr9TMrlhzNG5xkvi1sg5pQ3KRtVfg33pKEUeHz
         4tGNYxjCF1w4i7+z1UqSvC0KfSD8cigjnja6+8wmgLBUV5Vp3J8/Fq3UaJ245R6acWTC
         VYOpx8oqpaq60q2eoniSJPiSZQGYqb6Am50PSf63H+Xn/cVwSSOj4pQK0iShq9fMNj4I
         mgp+wLpuigeArQfozhiApgVKE2Dtuib1rD+zAt4aXmrnm8o58fq58HUdXPmbbA+I4Uar
         EecA==
X-Gm-Message-State: ABuFfog6reTw76cN/31pRPUkhiA/DfXJ4nJvYAx8ilAyFCfzkOMeLLux
        dWDdycTkbvPkeEY+GTEpsyEJbWxXUTwV7Y1d
X-Google-Smtp-Source: ACcGV63tW0FGzihJii003blCnNK/CLrrVaFFZAiV0+cSkekWyWcD2uB3mlv1TQrXkWcaDEx8mQ04Og==
X-Received: by 2002:a1c:8c46:: with SMTP id o67-v6mr14676868wmd.35.1540196293618;
        Mon, 22 Oct 2018 01:18:13 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i7-v6sm49804785wrb.30.2018.10.22.01.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 01:18:12 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <bill.c.roberts@gmail.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] libsepol: add missing ibendport port validity check
Date:   Mon, 22 Oct 2018 10:18:07 +0200
Message-Id: <20181022081807.5018-1-omosnace@redhat.com>
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

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index db6765ba..e2808b2d 100644
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
+				if (port > 0xff || port == 0)
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

