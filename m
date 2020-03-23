Return-Path: <SRS0=0U01=5I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FF5C54EEB
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9F52072E
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHdf2XRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCWRuw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:50:52 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36639 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgCWRuw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Mar 2020 13:50:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so168836pjb.1
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2020 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ACtqKXqFKHpniSvG0SIRdpsEalF2udu1D1oYl1GXF8s=;
        b=qHdf2XRpp8nKZ9yehiT3rkM9rPssPHNk80wht0WHz/LpQxjpmgeneMYQRmFPs0vXhA
         WMomtqZoRAPDTcK7xDLrXY55GxbHFeRHRBGkPGNhVGInAmGxS5v3m0J0Q9Ovy+vRmTQu
         kbC6HdvSRB+md3v8C+OrjuzKWBwwjKznjroDS94X0zlG74Zm8erJ9byNwmgaU8I2kBql
         eWavUIlCuoLaVDS651MhUEXhGtps8iELeXsLeQUmHh1nlfKCRJ2apzmVbz9N9FnQV5Rp
         6NMaQkjRdxe/jrfPQ/hFQuUswQ3Gc8IUAhwkL50vcEd5Y2kDIApEBerG2gWl/XmZYUDU
         04pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ACtqKXqFKHpniSvG0SIRdpsEalF2udu1D1oYl1GXF8s=;
        b=Yk2XnvMU/QMkqCL5Awt/Lj5kjFVVHR65MhdA5chYp76aPPW5vfhT430A1nfRVDetYH
         Z3cZlJch7xc1NaScinoyUCMjvucTzbmUSXbIibqLoxyMh0z8hknl6ZgZhYVg540hvv1p
         HJTHhw9n53tcZ79UwqOdde5hRMIsoCTqw+1TDMEA5bnQs9pLvXIQtrwLF8w6ZFWbkbB9
         ppMSF90ofCqL55Mo5qF8WGy8+p/JiXE/+V/uqFELk1TpcX4ITirpYczzqfc+QZ/n5VAc
         mNKacYKlEd9q/Mj9vpEiHugHvDy5O8LP5Bd1ND/WNi8ElL1v181UHxojuB2e0+XIDGLq
         qACw==
X-Gm-Message-State: ANhLgQ1/dVRa1v3KzAENzQKnCoeK4DUBWSJhU5YUekXZvQfYWW/HmlAV
        uqd/v5+FOUBEyYoiGYBEU5Q=
X-Google-Smtp-Source: ADFU+vsIGPdZKA811EhMHnbUYYk9+MLIChKK88AES5k/IIVBV49l24n9d3C1del6dnM5YAuDNIkiuQ==
X-Received: by 2002:a17:90a:fa08:: with SMTP id cm8mr550903pjb.144.1584985851137;
        Mon, 23 Mar 2020 10:50:51 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id j126sm13963979pfg.60.2020.03.23.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:50:50 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     drepper@redhat.com, nicolas.iooss@m4x.org, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH 2/4] libsemanage/Makefile: add -fno-semantic-interposition
Date:   Mon, 23 Mar 2020 12:50:35 -0500
Message-Id: <20200323175037.19170-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323175037.19170-1-william.c.roberts@intel.com>
References: <20200323175037.19170-1-william.c.roberts@intel.com>
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
 libsemanage/src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index f6780dc6048e..606ce1c6152a 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -53,7 +53,8 @@ SRCS= $(filter-out $(GENERATED),$(sort $(wildcard *.c)))
 
 OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
 LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
-CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
+CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute \
+	  -fno-semantic-interposition
 
 SWIG_CFLAGS += -Wno-error -Wno-unused-but-set-variable -Wno-unused-variable -Wno-shadow \
 		-Wno-unused-parameter
-- 
2.17.1

