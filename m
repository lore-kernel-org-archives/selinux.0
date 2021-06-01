Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC9FC4708F
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A89D610C8
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhFAPhB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFAPhA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Jun 2021 11:37:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97EC061574
        for <selinux@vger.kernel.org>; Tue,  1 Jun 2021 08:35:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cb9so6017007edb.1
        for <selinux@vger.kernel.org>; Tue, 01 Jun 2021 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSpQElwG390KHxM+KXxPf9g6kpfGgcYGSwyIYUB9xXs=;
        b=s/HNbDbfl0o5+KKIIMFyBRRZ8vwZ/65WcOBTZulxO896tCwbANHgihZkOLZc4oiOis
         RPfIa+bB1EFo8yDyPOiFof29l2dyDtYitaCO1EfdvgIsOUrsxpURX2wSBrOKUQyHvxjD
         fNQcaG4d//PcRdP4KD/zl5qS43KAf6EN2uSpEVpRgQ+kD9lPTehvnwm14ZFxradxFW7h
         I9M9fjf49PXa4XOp6pNQE250mvA7aCYg2+nWCK39rvoCPidNwS9EMMEJh4GsbNagqIZh
         xZtZzKNMOL0wExbu0CoKKcTjTRTh2gjBSeZ5detLgzXeqQ0ZAl0jCD0EJ6cEf3DpMPmj
         coKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSpQElwG390KHxM+KXxPf9g6kpfGgcYGSwyIYUB9xXs=;
        b=Y+sAsqfY17h0IGV37zWPXUiWpH/U8kCeaypx4sAIBYREQPnGaWpRAlzvWmEGjTm+As
         NRXDe/1irfrcrac8tEe+C6Ok1Ro6eGG8ne3itehvxW3KrAkYkAvR8X5uyrsoF4BoB290
         oAN1DyMhMP7X6Fv0iM0Qq5Rd7JHOGmRPDKl4DPOaq+6U+maTqZk1ZwcWYx1ez9PS3uZk
         zh/VvYPt+ZhrjiRzQU8WVyFVK+aB28AIZg9NlxejcNWmhN6JYuYXdJHugat+4CzD85pD
         OZ3xMnepqAWWUqXEMG+v7ZE6ZxaDIRJSL6dIo1yCLHFvyTjrf8nGOTVTW273weSVRV7l
         bdjA==
X-Gm-Message-State: AOAM5328OEmeUWGuuHz0Hdw06kq8k0iPIo6eDT2IIDjjn9q1s3nwtoZ3
        lHmB/wtLq6kNhxItfPH9uzhFrxbgHLg=
X-Google-Smtp-Source: ABdhPJwUZPIkEMZ+NvVHro6aqI92xwksK1XFdOyMeoi/YkXHayrtu/hs93IuxZ95UWoONMRvpn85LA==
X-Received: by 2002:a50:bec1:: with SMTP id e1mr33397156edk.116.1622561716392;
        Tue, 01 Jun 2021 08:35:16 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-198-161.77.0.pool.telefonica.de. [77.0.198.161])
        by smtp.gmail.com with ESMTPSA id r12sm8738823edv.82.2021.06.01.08.35.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:35:16 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: improve getcon(3) man page
Date:   Tue,  1 Jun 2021 17:35:09 +0200
Message-Id: <20210601153509.12594-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Improve formatting of section DESCRIPTION by adding list points.
Mention errno is set on failure.
Mention the returned context might be NULL if SELinux is not enabled.
Align setcon/_raw parameter by adding const.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/getcon.3 | 41 +++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index 67872a4d..e7e394f3 100644
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
@@ -31,30 +31,39 @@ setcon \- set current security context of a process
 .sp
 .BI "void freeconary(char **" con );
 .sp
-.BI "int setcon(char *" context );
+.BI "int setcon(const char *" context );
 .sp
-.BI "int setcon_raw(char *" context );
-.
+.BI "int setcon_raw(const char *" context );
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
@@ -118,9 +130,14 @@ and
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
+.SH "NOTES"
+The retrieval functions might return success and set
+.I *context
+to NULL if and only if SELinux is not enabled.
+
 .SH "SEE ALSO"
 .BR selinux "(8), " setexeccon "(3)"
-- 
2.32.0.rc2

