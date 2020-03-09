Return-Path: <SRS0=v7Ke=42=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20799C18E5A
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 15:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E984C20675
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMua+yAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCIPZz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:25:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41461 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgCIPZz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 11:25:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so4840447pgm.8
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w1BLOn/WwCUI6P/iUbnLwRBlX0rkCjebBOdJ2mFB1p8=;
        b=VMua+yAPkEZOv4lC7nvHzZIsICo9+iXMGDXjyuXAG4duBpMPuL5JwcnwC2+gD02Jd8
         PKauqnsclVdEFZvwDiNbe8OWMknZX0qB6e4DUwn9kKKM+5XeHBxCq5iSgFlY4ydJNfBC
         jhTj61HDheF+7sf0IvbxI/QSKDjpihz36JU64k7rx1TO/gRudYyMUeDJkICDtpowm8G6
         KJlXFz2mm4t40pGoQqsspRGwLIaxAMOxSWMKQ0gbOA8Fe8rZgZf9HqLehoBt7HezHOcO
         Ma6jFa+cvQSeJjloYluuOvy6hD03nJ+xvM5XnSRBnqcy/w6TwTTnHdNiYPtVS2BgwHoy
         uNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w1BLOn/WwCUI6P/iUbnLwRBlX0rkCjebBOdJ2mFB1p8=;
        b=mKYnTyBkPL0aY+r4SGdibtRT1AL0eM+7xA+5o/tkSrf0L4hvDDcDPXdwGx/06N2v7U
         N2bML5BmC4rkL6xaSvEW7tdEl0aYON1B1mBYH0PMoLZhFfFegr0ijgjmXlWKGorfKcoY
         B1IvFPg1ET+hT9o0VWAjB2h1MV31yZ5AQWWEo/XYWZPT2Gq5xEiMODRnBTkhvY5noDFS
         dptoEejqSbRhfaCv3Eya67dOZ6AKpn04MDsNKtw9N40tsYpl9JbEBNKz4+9GX8oz7FS8
         fhxMt6FhlaDbs1Lhs4jAkDTt3MBWOyQN0cSoa4uJiZX2uNqwbVR2tbiqUYfZRqxJMJf4
         T4xA==
X-Gm-Message-State: ANhLgQ1nv8kT8UWVP0Sn3xnsCPJgSebdroAE9Wk7BFBYgHreJHsiSZZD
        hWmq0nX7vQJcX5SQ5skghns=
X-Google-Smtp-Source: ADFU+vtrSHSIilmM+i8qedXttdTe9lQxvmoavMq+RmbZfcJl7h5RODpSqXaYxecqi8Pq32YAXIxI2w==
X-Received: by 2002:a63:408:: with SMTP id 8mr16473948pge.285.1583767553096;
        Mon, 09 Mar 2020 08:25:53 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id f4sm9800725pfn.116.2020.03.09.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:25:52 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org, selinux@vger.kernel.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: [PATCH 2/2] libsepol/Makefile: add -fno-semantic-interposition
Date:   Mon,  9 Mar 2020 10:25:39 -0500
Message-Id: <20200309152539.8581-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309152539.8581-1-william.c.roberts@intel.com>
References: <20200309152539.8581-1-william.c.roberts@intel.com>
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

