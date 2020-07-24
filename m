Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D72C433EB
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069BB206D8
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L/xc6Qks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGXR4B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGXR4B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 13:56:01 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF0C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 10:56:00 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i26so4307468edv.4
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UyUPi8n40K6bQjbKwwLz1D1FG2lviIa9F7SF2lVNfcM=;
        b=L/xc6QkskIBp+/q0GgIcsP7g441c1nztJszkTrw323RNIGgxM4JVq9jkVpFFzxnjoW
         kiPts31CszQs5C3YrZkQy0S+5gSZn4uiO9wM97cglvzKrUXRX3Jf3cvj5Op6s6i0OLVH
         aCVY4xTfuw9nEbtMDB206MLN2yyt1VJ5fVkXPCcTTD1/WZKUgVQbnT6acSDPeVN41u3h
         Zqetmzm7dqb3U8uwoP/OATmSnXTUQTyxwplhmk5Fqsjfq0in0C5CKbYOa7jY90YDKKmR
         c+Sf8TLWQbx3jYBHO9RlxKt7TIob6CHJVeWcTORUmzyCLVTxFpESgQixGn9KBnQANjyN
         2VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UyUPi8n40K6bQjbKwwLz1D1FG2lviIa9F7SF2lVNfcM=;
        b=p3NIL7X+zY8TAkcFOu5QyEvEUj/Lf4BbAxWCOHZDFfWuEA6FaX6olgIfxxXHgZmNde
         tGvA93D5SrtEXx7e9Tl4TD0um9f2Kj8+lZO42OTAXXEkRa3JzOEIrg7hmv5a6O5w7IXT
         D3SXmkrKeudy+RgTfZCAwYknpSSArc0WfY9J11YAbWys+deVURo47vKMsZDQ9N7ZSyo3
         x4YTLrC6w4INnJOqExwhoEvEVOsystQDEUjnV4Tme76axLke1QOY/Gcsf3KQQ5ggLIW/
         8wsfLrcg+kFGtOnfw7YIzckVvL5iQ9KgSoOGre5Can9BCK7rkKlLZFC27qYUjCyVPWgi
         DmwQ==
X-Gm-Message-State: AOAM533NeGZebZOo2dRCCwYgSa41lDyM04S2l/OUE6FLDv0ux8lxhpRX
        7HWu5FeG952XJ/pmgRNYLnx9oug5
X-Google-Smtp-Source: ABdhPJxnj1yajiJHbecP23nCQ9Q9BC49IUAqLRltqDRot8JW0AwKg/vSzGBeuCHjc+NudYzDQsM1xA==
X-Received: by 2002:a50:bf09:: with SMTP id f9mr9793021edk.249.1595613357752;
        Fri, 24 Jul 2020 10:55:57 -0700 (PDT)
Received: from debianHome.localdomain (x5f708af0.dyn.telefonica.de. [95.112.138.240])
        by smtp.gmail.com with ESMTPSA id m20sm1099211ejk.90.2020.07.24.10.55.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:55:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] Improve getcon man page
Date:   Fri, 24 Jul 2020 19:55:22 +0200
Message-Id: <20200724175522.39286-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Improve formatting of section DESCRIPTION by adding list points
- Mention errno is set on failure
- Mention the returned context is guaranteed to be non NULL on success
---
I am not an expert writing man pages by hand, so I am not 100% convinced
about the format. (It looked fine on Debian via `man ./getcon.3`)

 libselinux/man/man3/getcon.3 | 38 ++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index 67872a4d..b618691f 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -7,7 +7,7 @@ freecon, freeconary \- free memory associated with SELinux security contexts
 getpeercon \- get security context of a peer socket
 
 setcon \- set current security context of a process
-.
+
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
@@ -34,27 +34,36 @@ setcon \- set current security context of a process
 .BI "int setcon(char *" context );
 .sp
 .BI "int setcon_raw(char *" context );
-.
+
 .SH "DESCRIPTION"
+.TP
 .BR getcon ()
 retrieves the context of the current process, which must be free'd with
-freecon.
+.BR freecon ().
 
+.TP
 .BR getprevcon ()
 same as getcon but gets the context before the last exec.
 
+.TP
 .BR getpidcon ()
-returns the process context for the specified PID.
+returns the process context for the specified PID, which must be free'd with
+.BR freecon ().
 
+.TP
 .BR getpeercon ()
-retrieves context of peer socket, and set
-.BI * context
-to refer to it, which must be free'd with
+retrieves the context of the peer socket, which must be free'd with
 .BR freecon ().
 
+.TP
 .BR freecon ()
 frees the memory allocated for a security context.
 
+If
+.I con
+is NULL, no operation is performed.
+
+.TP
 .BR freeconary ()
 frees the memory allocated for a context array.
 
@@ -62,6 +71,7 @@ If
 .I con
 is NULL, no operation is performed.
 
+.TP
 .BR setcon ()
 sets the current security context of the process to a new value.  Note
 that use of this function requires that the entire application be
@@ -110,6 +120,8 @@ context and the
 .BR setcon ()
 will fail if it is not allowed by policy.
 
+.TP
+.BR *_raw()
 .BR getcon_raw (),
 .BR getprevcon_raw (),
 .BR getpidcon_raw (),
@@ -118,9 +130,15 @@ and
 .BR setcon_raw ()
 behave identically to their non-raw counterparts but do not perform context
 translation.
-.
+
 .SH "RETURN VALUE"
-On error \-1 is returned.  On success 0 is returned.
-.
+On error \-1 is returned with errno set.  On success 0 is returned.
+
+On success all this
+.BR *_get()
+functions guarantee to allocate and set
+.I *context
+to a non\-NULL security context.
+
 .SH "SEE ALSO"
 .BR selinux "(8), " setexeccon "(3)"
-- 
2.28.0.rc2

