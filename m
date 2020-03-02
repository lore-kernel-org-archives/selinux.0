Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56749C3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3D721D56
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAGQz8+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCBQl0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:41:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46760 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCBQl0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 11:41:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id o24so5795513pfp.13
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLCy5wAvWVD2u0F8d+QCHPjwvw2Q4FFL8KdhB7Bv9MM=;
        b=aAGQz8+2BN5G4UOlNZO3I7fRsy2B2r8Thgc4k2QJj/BCCNkA3EWQl1k6pIVx8xgKG9
         MDj105luJndztosKqPmSGci90kjhzfL3TtaNEdxxAnMd4y9OskefVemoX9qBwKZVnYPc
         C8sbmgP1RDzbhC65yy3NJmjX90FGqDGaD3D3gd1N5n8zAJRugKXQU1blBuSk9RTu1Api
         4ASVDWZytzFsmzQSPFej245hqNgYwG9yIwEL0bF12GNumzOREc2gKTataTmdfCKMJ0iW
         g8aumTqycy+RGBegTW71zJUNd7luUE93+9GInDNUuvTM17i5LAP2al27KFSDNqP2Z13v
         uoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLCy5wAvWVD2u0F8d+QCHPjwvw2Q4FFL8KdhB7Bv9MM=;
        b=QIsnUHetu+5856iViCZGC6yoMwJrxfQoTS814W4PpmY0riBtt0sae/djGS8r2Eb1ja
         DRi85mHH26TEDtSKEQqs677yzvC4AduDvvzTawTJr5OU2no8g+J+j8ona5hOIobGVAPu
         32L6kkEKf13WA/tecg68LN1AQA7MKugyp984ORJ5607RaKfI+XxHXE7AkflKrind9e5d
         B5U+3Nop+DQjQ3l1D/8PFUxxhMi/prqoUjj6Hq66xaaLemT7Gh2Rk/IoZWXq7PD9LweD
         DfpkWhri/RNhAP/VKZZ90yORr9UfB4rmjj50jfLsm/L8g6c/nCDiPAVvrpnhBXu50LcP
         A5Hg==
X-Gm-Message-State: APjAAAXhGxLrtUjQFYNzlJVh7XGOHJmQCsy5gkutphJFBBXcdZlx5651
        FX2L1zwWEBfkpI0R36l+KkI=
X-Google-Smtp-Source: APXvYqwMl+xxEUMR7bpsTPWhPnsI1KsmOkl77rQFK1Q0PRKbc1313Kf3jL+hSgIrYy+kHaa7+5phtQ==
X-Received: by 2002:a63:c601:: with SMTP id w1mr19340996pgg.449.1583167285219;
        Mon, 02 Mar 2020 08:41:25 -0800 (PST)
Received: from localhost.localdomain ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id o6sm23331087pfg.180.2020.03.02.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 08:41:24 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
Date:   Mon,  2 Mar 2020 10:41:10 -0600
Message-Id: <20200302164112.10669-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302164112.10669-1-william.c.roberts@intel.com>
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Add -fno-semantic-interposition to CFLAGS. This will restore
the DSO infrastructures protections to insure internal callers
of exported symbols call into libselinux and not something laoding first
in the library list.

Clang has this enabled by default.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 7f5a5d7418e9..c76110fbc650 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -65,7 +65,7 @@ EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nan
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
 	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
-	-Wstrict-overflow=5
+	-Wstrict-overflow=5 -fno-semantic-interposition
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
-- 
2.17.1

