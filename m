Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF12C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA61320724
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 11:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AiYIk6Dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDTLq7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726209AbgDTLq7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 07:46:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60ECC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 04:46:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so10589314wma.0
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/LuHm4kUgIOT9y8Ycp2EKKJiBO0VVqKUF02aX32ezk=;
        b=AiYIk6DmtG6BPpkbDYoLKnteZoBCKaah7/4YJsKyhX5G5clTOgP8EsgqvCIw1XQ1xC
         wYoMegPoWdJ4IuSFygLR2Y/qLlfI6sBuH8wc/MAZBN2MfREAaV8dLR/dqWucnt9MiN8j
         //ICnwbDZTLG64anIhp33DghbH/Z21OsFNjzpchsxU8lOvrShDBwSXajNheM1ngiWp2E
         sghEJm0oJgAN27/BnBHLcDHYwoIp9oAXYceJ2pmCm9lJatWlxWDlfDzbtZAOgeVjCMNA
         exozz4yvFmjdElg1908k+7YZK5ms/Ag2pXPBKgQnYvAMkxswVh1+XgW/TCuzP+XJN1wc
         VCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/LuHm4kUgIOT9y8Ycp2EKKJiBO0VVqKUF02aX32ezk=;
        b=BcQwJuZaYIo+1rRy7r4+/QTCL+41yQz0AT17aDKbUJUe/GIO3J+2uesYcmsoJ39ScE
         t9AXB2CzWnOYUwuyjX68+zw0TNZ/sH0WZU2uPadZm2gLTGq4fyn79hX4LEUpGZKqUbTe
         jMHpdg1CcjRlKCs8qmmgBjrpIO8pRSq1EzOp5j8INjOJ75UjXTOUZxO6t6nxo3FdPSuh
         FWI6GI2xPFLEvM5LvEmNayRIknXe7NZQonsvuiYbgIn2MlOacWBMm1tTHRKHtVydTSEd
         qR/GVe0zkrckYciNnxtg3hnO7a3kJR8cLmQpFnXJ/YjtVFP49t6ijvPTqy+12RXVc4CM
         I17A==
X-Gm-Message-State: AGi0PuZcxsYXTdjKoD3Dfxf9zP+P1Dbk8SnYUQynGABLlhBWO72eKMGF
        OcsbDZuWHeD8I65aBEocJNxgWvPn
X-Google-Smtp-Source: APiQypKHATUdvBt+2wPUtl8gWIVBcYaYa2esuLhmuGEraNbenltU1/FilLqRuwv2xatw53ePYqVbrw==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr17290084wmd.95.1587383217308;
        Mon, 20 Apr 2020 04:46:57 -0700 (PDT)
Received: from debianHome.localdomain (x4d063804.dyn.telefonica.de. [77.6.56.4])
        by smtp.gmail.com with ESMTPSA id t8sm859805wrq.88.2020.04.20.04.46.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 04:46:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: mark security_context_t typedef as deprecated
Date:   Mon, 20 Apr 2020 13:46:50 +0200
Message-Id: <20200420114650.19093-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Follow-up of: 9eb9c9327563014ad6a807814e7975424642d5b9 ("Get rid of security_context_t and fix const declarations.")

Use a wrapper macro, because swig does not accept typedef attributes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 6a512b38..f88a0363 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -8,13 +8,21 @@
 extern "C" {
 #endif
 
+#ifndef _selinux_deprecated
+#ifdef __GNUC__
+#define _selinux_deprecated __attribute__ ((deprecated))
+#else
+#define _selinux_deprecated
+#endif
+#endif
+
 /* Return 1 if we are running on a SELinux kernel, or 0 otherwise. */
 extern int is_selinux_enabled(void);
 /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
 extern int is_selinux_mls_enabled(void);
 
 /* No longer used; here for compatibility with legacy callers. */
-typedef char *security_context_t;
+typedef char *security_context_t _selinux_deprecated;
 
 /* Free the memory allocated for a context by any of the below get* calls. */
 extern void freecon(char * con);
-- 
2.26.1

