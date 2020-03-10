Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A73C10DCE
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AC5215A4
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRN3Ob6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCJVJG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:09:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47061 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgCJVJG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 17:09:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id w12so1913pll.13
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2020 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w1BLOn/WwCUI6P/iUbnLwRBlX0rkCjebBOdJ2mFB1p8=;
        b=HRN3Ob6NbOopfsDlnQRFEGf91Pf4AYN27OaiOo191vUsdYEC8/VZ/m3JjEeBTfq3Ky
         O4Ro7qTNgXWQQcEPAG2ZArrHoMj+8gAttB8rsqQNPVYth+vHQssHRHtqnX7CT5ElYwl8
         KP1Y6+H2s0wFaNNbrtYayJBDR7zouOC9bnhi2VQZzNjpq9AVwNJcJSIaYaGdXi0uWcgD
         0W5iMYUXYSvsYckmi08IQmVySIsqCP2+y1P5+yTtPLatGuU16dwGSf8azyVLwwTThR+4
         iMEnoIv5KRPTGpjpThn5k/U1T3MbTb6XnAvM3f3rALkPi2LanPtSbTiblkFMz6OOvsJ7
         aYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w1BLOn/WwCUI6P/iUbnLwRBlX0rkCjebBOdJ2mFB1p8=;
        b=cJPDJAX6Afd/ILqgNWKRzySyqR6Z5OuL8xLtbFdtvpBwTX3kMaVE2RxedzPoZ7TxZs
         oHhne/NTCcOtCQvsQOz/hehMr/9QyfqWIOv7BNLM0QwyRpyu7LLmV86fRqAH/rGBNtu+
         0aVD7uIRfAgyyqzWToEPXjErJX4OTCyn9QHXlnK2g+Jgx5640vFqSvCURwcICvIik6tY
         HlMRhJvmf+6JpS5EFSwlR4BPxmkFs5dcV0WQr14dvPJa7q1QpM2sYH8ns0ykon5erkQd
         ITiFJanHL+vp14AMS7EiE0qNb990jYijoTuRpw9Fwpbf/3AEtPqZP8PKA1G4p9NmHIPX
         2UWg==
X-Gm-Message-State: ANhLgQ2PTvwNpGyYQzSr/2dYUbU4Q9rt3cIjQDPRCW2nriauR0oVKLU9
        QmyHT8ftKNvkO/+bJ0kmi2Y=
X-Google-Smtp-Source: ADFU+vvpReba+SrOHFV8IDiL9DR5MPYNAF1Wj+ZdoxMNj9Hk3sknlVnOgnPtKh7S1SLzOSe+3brKmQ==
X-Received: by 2002:a17:902:8549:: with SMTP id d9mr22035273plo.153.1583874545721;
        Tue, 10 Mar 2020 14:09:05 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id s11sm19378807pfh.7.2020.03.10.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:09:05 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org, selinux@vger.kernel.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: [PATCH v2 2/3] libsepol/Makefile: add -fno-semantic-interposition
Date:   Tue, 10 Mar 2020 16:08:53 -0500
Message-Id: <20200310210854.466-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310210854.466-1-william.c.roberts@intel.com>
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Add -fno-semantic-interposition to CFLAGS. This will restore
the DSO infrastructures protections to insure internal callers
of exported symbols call into libselinux and not something loading first
in the library list.

Clang has this enabled by default.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index ccb702338446..8d466f56ed0e 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -19,7 +19,7 @@ LIBMAP=libsepol.map
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(sort $(wildcard *.c)))
 LOBJS= $(patsubst %.c,%.lo,$(sort $(wildcard *.c)))
-CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
+CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2 -fno-semantic-interposition
 
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
-- 
2.17.1

