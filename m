Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6AC3F2D7
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C3F20848
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 09:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiNbVId4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgCCJsU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:48:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23164 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726890AbgCCJsU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 04:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583228899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nx1ThCN2vKHDPCTfuMe5aGxhPQF3uc/q/wGjf0AP2f4=;
        b=FiNbVId4ZmOzueXUbFh4b29VdJzAY4ix+t7cEy3yyUhLnXzu+4x7PL0v7frSUb6LGv/UBU
        m44PhC23+eH9HpIC52u8wx5B4szRg/Z26+Odlqk7SpovbbUHVY962zFoKNZiHOuDh2upBv
        4znL0s80uI6UyCBlOk79YOt4E6haQy8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-vO4DE7qzMoOPTWxeSvn2jw-1; Tue, 03 Mar 2020 04:48:17 -0500
X-MC-Unique: vO4DE7qzMoOPTWxeSvn2jw-1
Received: by mail-wr1-f72.google.com with SMTP id 72so980139wrc.6
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 01:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nx1ThCN2vKHDPCTfuMe5aGxhPQF3uc/q/wGjf0AP2f4=;
        b=eAdlH9R6TtqFA4QGUxNAR+Y5Suk+5W5D//09lkLAvBBvV2OyzeRC/JM8z/QGtm//YP
         n4NuGMGrAcjXr0+4dgTr9uqlCAudnhBjuPLoxLVw/9j+zjEDqPSGBiVk8uEEd6m2QcgR
         rI/flqpPMaij9IrzDImRYxoz4Idsu4fRVykDKPv3Lre2AjtZicJCpmi4551edRyA/Hyb
         h4CnBPjYtWfmjVqHnKwCbvf0TG9FK4EDC1CrQrCaobWk1jcPVHUFDiQFUMZ1AENjcgDU
         yOGtBc2lT8n+bt7mFtPoIcewXV4SUDkF5cMB1N1SmHGrYL3iSRaMUg0AbmQ4gzs7sS/R
         3oZw==
X-Gm-Message-State: ANhLgQ2/SdPX59c57S5tKAgXXwtXDQNjNSgmt84PWm2+4S6i3dWQ3Tq5
        /0N8CvKXp+yWt8D4CDdH5iAN7ZnU8TEfah9duKA/bm9ywgEBchdqI8dWLQes5evAoQzRgbsfIuc
        oEdtMnOUCpPL1iO1hvA==
X-Received: by 2002:adf:fcc3:: with SMTP id f3mr4632108wrs.348.1583228896301;
        Tue, 03 Mar 2020 01:48:16 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu+rMcfnKa6G3KjEVnW9Ks0loJiQJBpKsMfXICfeT6blCvhRIxVgZFb7MFXqruvobw0wtFxGg==
X-Received: by 2002:adf:fcc3:: with SMTP id f3mr4632080wrs.348.1583228895980;
        Tue, 03 Mar 2020 01:48:15 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a7sm2914674wmj.12.2020.03.03.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:48:15 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        William Roberts <bill.c.roberts@gmail.com>
Subject: [PATCH] Revert "libsepol: cache ebitmap cardinality value"
Date:   Tue,  3 Mar 2020 10:48:13 +0100
Message-Id: <20200303094813.142288-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit 542e878690ea1e310bed9adda6dcb28ca8cd1d53.

After 6968ea977501 ("libsepol: make ebitmap_cardinality() of linear
complexity"), the caching only saves ~0.06 % of total semodule -BN
running time (on x86_64 without using the POPCNT instruction), so it's
no longer worth the added complexity.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/include/sepol/policydb/ebitmap.h | 1 -
 libsepol/src/ebitmap.c                    | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 1abfdd71..910834dd 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -37,7 +37,6 @@ typedef struct ebitmap_node {
 typedef struct ebitmap {
 	ebitmap_node_t *node;	/* first node in the bitmap */
 	uint32_t highbit;	/* highest position in the total bitmap */
-	unsigned int cardinality;	/* cached value of cardinality */
 } ebitmap_t;
 
 #define ebitmap_is_empty(e) (((e)->highbit) == 0)
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index a5108b71..963b8080 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -67,7 +67,6 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 	ebitmap_destroy(dst);
 	dst->node = tmp.node;
 	dst->highbit = tmp.highbit;
-	dst->cardinality = 0;
 
 	return 0;
 }
@@ -131,13 +130,9 @@ unsigned int ebitmap_cardinality(ebitmap_t *e1)
 	unsigned int count = 0;
 	ebitmap_node_t *n;
 
-	if (e1->cardinality || e1->highbit == 0)
-		return e1->cardinality;
-
 	for (n = e1->node; n; n = n->next) {
 		count += __builtin_popcountll(n->map);
 	}
-	e1->cardinality = count;
 	return count;
 }
 
@@ -201,7 +196,6 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 	}
 
 	dst->highbit = src->highbit;
-	dst->cardinality = src->cardinality;
 	return 0;
 }
 
@@ -317,7 +311,6 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 					free(n);
 				}
 			}
-			e->cardinality = 0; /* invalidate cached cardinality */
 			return 0;
 		}
 		prev = n;
@@ -348,7 +341,6 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 		e->node = new;
 	}
 
-	e->cardinality = 0; /* invalidate cached cardinality */
 	return 0;
 }
 
@@ -368,7 +360,6 @@ void ebitmap_destroy(ebitmap_t * e)
 
 	e->highbit = 0;
 	e->node = 0;
-	e->cardinality = 0;
 	return;
 }
 
-- 
2.24.1

