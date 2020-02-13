Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE642C2BA83
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90378218AC
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXm45fzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgBMNkI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:40:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25722 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729971AbgBMNkH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 08:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581601206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VxgMRYY0kZDT9n0t5ATZrSt+yQanrEPvvvH0hv9Pu8I=;
        b=DXm45fztJA3xOfg5jv0jy6J49FBIZIBLWBpQ31FAEPQ29uP0nnu1LovgvGuUR0lQgxQRKh
        VTBxhbSq1TJ9QT3QoIeybCvSw3WSuCqpWkDtRTHd56xeoeCgreInhbCCmWT5lNGMNB7v1L
        v/r7OFV9w6BNJs1Qql5ZWUx7GHCStyE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-T3IWTYE-P1Wb3X2cYiZ3kg-1; Thu, 13 Feb 2020 08:40:04 -0500
X-MC-Unique: T3IWTYE-P1Wb3X2cYiZ3kg-1
Received: by mail-wm1-f71.google.com with SMTP id w12so2027135wmc.3
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 05:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxgMRYY0kZDT9n0t5ATZrSt+yQanrEPvvvH0hv9Pu8I=;
        b=eFBP1wQbQSDJbVSSWtedJzL7CB5672H5goLUzyNtcReWEOKbQgBvAIQtRJ6Ti83R3b
         SBydemPZr23jYPwOaclrETV7cZjHdiUt24QNG9veMQLwPqLaExZJuB/axzZlP62GP5Tq
         KnPdjPa8GfU66VWroCWhxHZUDzyXrjEI0tvcQ4MYWnjoNASPPWng/aG5ZCjeiGxD1GNb
         tlGPl9qHjovbHC2ZjZkKOKZXCIJfDhJQJXEmRQ+M29O2grYBYb6WoAwxcxj4eZv8+79p
         PUpDXPk6c5z0Zn8dzikaTy7rNog94jo7vqrzStqd3g5mOWbuN1ajCxAI5vpLt7DuBhZ/
         Tbyw==
X-Gm-Message-State: APjAAAUNIwP1KtkJlMttGU7Wxc+1x/1vSXg3WqZ2ScamOuZh4Vcwmtw4
        d7GfHRU0u8pOGTe5dW537K/FynmP87C60FZn6f3WLaiMY+iOQGvdV3t5lgHI13R9B1fX5moqjB1
        OsjUV7JvNgQGBi67AFA==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr5887589wma.89.1581601202631;
        Thu, 13 Feb 2020 05:40:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjSq31ZPt+p5ah3ocivTzBAqyZnVZNFiVjG+xBSVzofTpAuTP2euM9GTWw4Ai3mzPeIZ5Uag==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr5887571wma.89.1581601202342;
        Thu, 13 Feb 2020 05:40:02 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n3sm3128445wmc.27.2020.02.13.05.40.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:40:01 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
Date:   Thu, 13 Feb 2020 14:39:59 +0100
Message-Id: <20200213133959.14217-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

According to profiling of semodule -BN, ebitmap_cardinality() is called
quite often and contributes a lot to the total runtime. Cache its result
in the ebitmap struct to reduce this overhead. The cached value is
invalidated on most modifying operations, but ebitmap_cardinality() is
usually called once the ebitmap doesn't change any more.

After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
decreased from ~14.6s to ~12.4s (2.2s saved).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: corrected time values in commit message

 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/ebitmap.c                    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index e62df01c..53fafdaa 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -37,6 +37,7 @@ typedef struct ebitmap_node {
 typedef struct ebitmap {
 	ebitmap_node_t *node;	/* first node in the bitmap */
 	uint32_t highbit;	/* highest position in the total bitmap */
+	unsigned int cardinality;	/* cached value of cardinality */
 } ebitmap_t;
 
 #define ebitmap_length(e) ((e)->highbit)
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 6c9951b7..d23444ce 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -67,6 +67,7 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 	ebitmap_destroy(dst);
 	dst->node = tmp.node;
 	dst->highbit = tmp.highbit;
+	dst->cardinality = 0;
 
 	return 0;
 }
@@ -128,9 +129,14 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int ma
 unsigned int ebitmap_cardinality(ebitmap_t *e1)
 {
 	unsigned int i, count = 0;
+
+	if (e1->cardinality || e1->highbit == 0)
+		return e1->cardinality;
+
 	for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
 		if (ebitmap_get_bit(e1, i))
 			count++;
+	e1->cardinality = count;
 	return count;
 }
 
@@ -194,6 +200,7 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 	}
 
 	dst->highbit = src->highbit;
+	dst->cardinality = src->cardinality;
 	return 0;
 }
 
@@ -309,6 +316,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 					free(n);
 				}
 			}
+			e->cardinality = 0; /* invalidate cached cardinality */
 			return 0;
 		}
 		prev = n;
@@ -339,6 +347,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 		e->node = new;
 	}
 
+	e->cardinality = 0; /* invalidate cached cardinality */
 	return 0;
 }
 
@@ -358,6 +367,7 @@ void ebitmap_destroy(ebitmap_t * e)
 
 	e->highbit = 0;
 	e->node = 0;
+	e->cardinality = 0;
 	return;
 }
 
-- 
2.24.1

