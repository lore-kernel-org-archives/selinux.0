Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F1C2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2A02073C
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTzR35ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBLLvr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:51:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgBLLvr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 06:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581508307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HkRP7g0jEgiHpLPzc0At0Ieuda5Q/FMIYn8zdmxBCm4=;
        b=CTzR35EDh+T0PfPDcVZKjs3IaTxDSY55XfsTcMb+Er2i8tvaDachXBZnNetSoaVjsVHUKD
        1jvjyiB8JWqF5yaazK3ayWnJK57/o//BrOtLqsp7g5qOkrzGh0yvahDyJ+sBNqz2SmVKE+
        9IZ/7B3f/05w7AglkSB1dun+gLWNj6s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-iLwgDQFjNL-uRzhHtNx5DQ-1; Wed, 12 Feb 2020 06:51:44 -0500
X-MC-Unique: iLwgDQFjNL-uRzhHtNx5DQ-1
Received: by mail-wm1-f70.google.com with SMTP id o24so635164wmh.0
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 03:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkRP7g0jEgiHpLPzc0At0Ieuda5Q/FMIYn8zdmxBCm4=;
        b=UwUKFOZleG/fXDlnD0s+tOGnaAElaRMLdsYtPdELPQyTCmty88Ce/76TYWhqaYZO8H
         7ZpIqNurpk7zXvavG0Ta3pwha8FlPkbWTWpg0FMMeNbjRgZ9ib2TipXi0nPxe2krrNP8
         +PAvIB9hV3YbIVTeY1tg6/XQE/AFLk2SVzdYpYVDGQx4lbpx9+/V1yvCRwe0aijrFHqu
         GaWvN42ylBv3CrdhdBGwp6oqiOql011T+7jakuq1J5S5LUaGbyxsBk8O+fPw7NUElXYs
         JloXpAE/+KlfIT+39+ZUajn9MtnIYZcDemrYWCH4pBE+gfkgaZ55TgWVdi5LK9ZjoTjp
         aHBw==
X-Gm-Message-State: APjAAAVREU7z/O+aEYPFFgSBuE77CQnmnwDL3M7g9FqZ6je28IBmT+xD
        rX0SPMiB7+l5XMUOT4HUCurACimbxWs6TfNCbjg43G/0i6tBBY8Zfq04T8h/HE7oO9gG102uiKG
        Fw5MMB1JRi9kaccU97A==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr14199829wrl.190.1581508303010;
        Wed, 12 Feb 2020 03:51:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOJfYp5kp1UrKpkvAcjUtSctY/qUhjho1N872fFuOjA2p0ONhhyG/h9yKaKuokF4pE0tAZGA==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr14199814wrl.190.1581508302786;
        Wed, 12 Feb 2020 03:51:42 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f8sm361542wru.12.2020.02.12.03.51.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 03:51:41 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] libsepol: cache ebitmap cardinality value
Date:   Wed, 12 Feb 2020 12:51:40 +0100
Message-Id: <20200212115140.107017-1-omosnace@redhat.com>
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
decreased from ~21.4s to ~18.6s (2.8s saved).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
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

