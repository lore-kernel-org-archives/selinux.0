Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58690C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 19:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKIT4z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKIT4w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 14:56:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A02F00A
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 11:56:51 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f27so49824691eje.1
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 11:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3evPF9n6/pYBL1A2bZLvFrT14TggGNeYka+kkhwyBk=;
        b=Kyi4xfycQBr1DMYW+um/cJpvjrfDIA5LvgH32PtE2z4xJRd2H77Yq7UN7GV1mu0tQq
         jr5xXqq6NiEOovM0ExjZ1gQ1ceN5Ongsn/0lJPAiQLPmL7cyBz0mi73kgZvF+H3xmVhT
         2E7WFeQwE0P3jTE5EvNwqMTYqFA+IsmPCqs73nf1qkS3vpkD86DELgp/cjYrWr2+0Km4
         7F6WF0ZO6zDDGVtpa6NnN0s/PDbDjsYPwlmvSQOxNLoQ3g72oFFaudqIfFCmMS+Y0nwA
         s/HIUgkQXOhC6aGsa2rzHVGOYBf5kJ7vpOSmPoQlmm5Mo2TDLFCGKaq9eiE5z27VnpFM
         PGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3evPF9n6/pYBL1A2bZLvFrT14TggGNeYka+kkhwyBk=;
        b=6eqgssrg/wQwYegRYLxdvNLn7Oo4N96Y6VwiuV00rsAA9PX7kCXTTOLYwL9C+ObMPD
         nAfOFbzBqWzgiujA94xl8qJ+eYWwFma8mO4MDVFljAywVWkpsnnjBdUjCi3vXy7OGd7W
         UVXRgZoncm9uXupICdpF5othY6XfC57q1XVyF4mmsuhsYCO4SSTPS8fP5FjaAY25rYXV
         2xMbPaTictEvAuZdM7vTyBb1ahbCIKJqSHqPVuj0HTHYM7u0mZVxqTHkujDhT2Zas54f
         sOSpJ2BVPIUHticrpJ3rdqgEWQebF23EI5eNsjWi658D97QSHvfVWd6RnkLbjIzjHNi+
         tYXw==
X-Gm-Message-State: ACrzQf3UDOAtakW84Ww0xb3/ebpv94Wy7nc+y4TczG36FYNcZd3A3rYC
        1YPwfhAWfia1I576XZoIGhiWvNY890U=
X-Google-Smtp-Source: AMsMyM4U0r4ewolUkDMWKQNiGDQ3rIec+Mm1abwaJMr47EWCg/ttJNQaGCBk5GLEdlnD8y/TmJ3B8A==
X-Received: by 2002:a17:907:a05c:b0:7ad:f563:815d with SMTP id gz28-20020a170907a05c00b007adf563815dmr40053796ejc.371.1668023809724;
        Wed, 09 Nov 2022 11:56:49 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-185-019.77.10.pool.telefonica.de. [77.10.185.19])
        by smtp.gmail.com with ESMTPSA id bh1-20020a170906a0c100b00787a6adab7csm6379089ejb.147.2022.11.09.11.56.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:56:49 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libselinux: make use of strndup
Date:   Wed,  9 Nov 2022 20:56:38 +0100
Message-Id: <20221109195640.60484-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using strndup(3) instead of malloc(3) followed by strncpy(3) simplifies
the code and pleases GCC:

    In file included from /usr/include/string.h:535,
                     from context.c:2:
    In function ‘strncpy’,
        inlined from ‘context_new’ at context.c:74:3:
    /usr/include/x86_64-linux-gnu/bits/string_fortified.h:95:10: error: ‘__builtin_strncpy’ destination unchanged after copying no bytes [-Werror=stringop-truncation]
       95 |   return __builtin___strncpy_chk (__dest, __src, __len,
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       96 |                                   __glibc_objsize (__dest));
          |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/context.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index 9dddbc5a..a6779a03 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -68,11 +68,9 @@ context_t context_new(const char *str)
 			for (p = tok; *p; p++) {	/* empty */
 			}
 		}
-		n->component[i] = (char *)malloc(p - tok + 1);
+		n->component[i] = strndup(tok, p - tok);
 		if (n->component[i] == 0)
 			goto err;
-		strncpy(n->component[i], tok, p - tok);
-		n->component[i][p - tok] = '\0';
 		tok = *p ? p + 1 : p;
 	}
 	return result;
-- 
2.38.1

