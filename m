Return-Path: <SRS0=cnGJ=RB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F84C10F00
	for <selinux@archiver.kernel.org>; Tue, 26 Feb 2019 00:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B4B21872
	for <selinux@archiver.kernel.org>; Tue, 26 Feb 2019 00:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BNtnvDYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfBZAGK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:06:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33482 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfBZAGK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Feb 2019 19:06:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so12915009qtz.0
        for <selinux@vger.kernel.org>; Mon, 25 Feb 2019 16:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FsQY+v0ElZ+UC5/pLE9pTQWvKqfzoalmfhBWkpQl2jk=;
        b=BNtnvDYfTTNyfUZtpkP0KG9yslkrrDyEYIcS2Y/131BvhiYUZ98FykDsFOFyusplUw
         57VpYTYZbN9G55YqDsMWekhV74gDCzl3zITTeGHMeAFv/ADuIPWqKijyU7fVf66KMDQe
         m7LSthKdQl8/urBda8+JCAQLZhTUfrIo53ClKESKHxUhhcPcVKnK3MoHVXNKe7GxLtJb
         rshvYtEK+FAFzPP2mQSdwycFF8k5ztuk8NyUHD96mdSDeilghwKgz2iNZoFiJM/VBeFM
         HyEBrC2DaqaePhGd68eHzXH2AJfgzYqCT4Nw62PKddHsMrC2ZJkY9ZnMZANVnmCUg1Av
         HklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=FsQY+v0ElZ+UC5/pLE9pTQWvKqfzoalmfhBWkpQl2jk=;
        b=CrmDydbo6epAMl3SEERc1xYcgrcaADVnR/ehzEMAfmjencuDdFcE0Fx3E5eFQtck+b
         siw1HRj6DJ11y4wmyF4AmBG4Oah8t4igzBXK0Pz2OzgYVgkfKy8XK/K20ax3IV3hm19W
         jgSkXaDHu3Tm2IYjuJcFrB4E9Uo2SYbdXwMVlSKXAWLEY93pAHLIFf1uCLR2ccc61Y/J
         dNZxEotTijmQcL03A3xGOKFUblRZI0fW+fwSIL19e9JF4UKi2Fe0l+V96yTaFPhBeoMo
         Nyo9hsxopS82unr7D1euzR36qs0YX95AHQIdxpaTeCpRP9NyWK4hA2cMGru8jPW5A8uq
         6J7A==
X-Gm-Message-State: AHQUAuZeuP+YovZyWiRnw6oaRuA+ys+D3Wc2KdZUJQY0uQOOl+NOWfMV
        A/60/D9cAXso2WwXnD6WiwLs
X-Google-Smtp-Source: AHgI3IZuHBCds4U35jZctyo5v3ttdMh4QnmOVyfgCebH+r0xL/6V15Bgx9nIS0dzN/eTrgprQcfMDw==
X-Received: by 2002:a0c:d963:: with SMTP id t32mr15638036qvj.231.1551139568527;
        Mon, 25 Feb 2019 16:06:08 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id o2sm8071374qtf.46.2019.02.25.16.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 16:06:07 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] netlabel: fix out-of-bounds memory accesses
To:     netdev@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Mon, 25 Feb 2019 19:06:06 -0500
Message-ID: <155113956675.10125.14312108729252175194.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are two array out-of-bounds memory accesses, one in
cipso_v4_map_lvl_valid(), the other in netlbl_bitmap_walk().  Both
errors are embarassingly simple, and the fixes are straightforward.

As a FYI for anyone backporting this patch to kernels prior to v4.8,
you'll want to apply the netlbl_bitmap_walk() patch to
cipso_v4_bitmap_walk() as netlbl_bitmap_walk() doesn't exist before
Linux v4.8.

Reported-by: Jann Horn <jannh@google.com>
Fixes: 446fda4f2682 ("[NetLabel]: CIPSOv4 engine")
Fixes: 3faa8f982f95 ("netlabel: Move bitmap manipulation functions to the NetLabel core.")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 net/ipv4/cipso_ipv4.c        |    3 ++-
 net/netlabel/netlabel_kapi.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 777fa3b7fb13..f4b83de2263e 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -667,7 +667,8 @@ static int cipso_v4_map_lvl_valid(const struct cipso_v4_doi *doi_def, u8 level)
 	case CIPSO_V4_MAP_PASS:
 		return 0;
 	case CIPSO_V4_MAP_TRANS:
-		if (doi_def->map.std->lvl.cipso[level] < CIPSO_V4_INV_LVL)
+		if ((level < doi_def->map.std->lvl.cipso_size) &&
+		    (doi_def->map.std->lvl.cipso[level] < CIPSO_V4_INV_LVL))
 			return 0;
 		break;
 	}
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index ea7c67050792..ee3e5b6471a6 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -903,7 +903,8 @@ int netlbl_bitmap_walk(const unsigned char *bitmap, u32 bitmap_len,
 		    (state == 0 && (byte & bitmask) == 0))
 			return bit_spot;
 
-		bit_spot++;
+		if (++bit_spot >= bitmap_len)
+			return -1;
 		bitmask >>= 1;
 		if (bitmask == 0) {
 			byte = bitmap[++byte_offset];

