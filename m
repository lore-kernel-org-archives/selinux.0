Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20BC433FE
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A7360296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhKLPpD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhKLPpC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:02 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09BFC061767
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f4so39242876edx.12
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TxhIoNxNhxpAdljwG1McjlJgpQe7wCkjPNo43yd1RWM=;
        b=TlweuswXJm4/dOeo3Qz8afOBAU3tmw+Sg5rxyMN+SPZNyRc5yvdb6HGISwrUHJF8T0
         /XVMRcWe5sO53zT7BOrYDKxolUZn/tSI+dNJmawf+xsQ+A3QYG95T1n9d6bknuTY0gA1
         xNkqvy/0igjbLOSgn28VdSqnpRMvvIragMJEbZeShRO6blwkBMy0neMfQgIY5XVejvcF
         eTE0tS84jkjk7VT4kxPJ1Ggns6oN/jB4RyfF2cxPfOOF2BtsOsMxVQZbwyiPqrE9lbZ4
         OHszGXbDAP7lV2vDtbY2OAcnRNpXmccEAkIn7Dhgqv4gEaXfJB7yGjkrTl93WgKU4PZO
         JyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxhIoNxNhxpAdljwG1McjlJgpQe7wCkjPNo43yd1RWM=;
        b=WjyIQzqB1LzLgLRgC5EOdPkog8I9UBX+tuE+rc1gPUQidTi6DwFYWJydR4huk+0whR
         2CDlvM/4ZFPa7BWFxZh61flVamcQrNdBkp4pupn9FbeZYI5B0Eo2nLg42iVBpJRrFVMS
         jBaVNqZUQdGGx8j5T3L1tqknwEtgIV2+GD5pQPXrPkKmGW4mmlxFBDWiS1/ypc2et6Ua
         P9Pbs90mklSFgILFI0OklOOK0fT55vKdcyCDHWb6nls4g9bhTRZ8jOpEPxLJypqjmJCx
         fjxMZnFIBuBr8nem31TXX1a83U4iitciCT0cr1VFnoD0E5wk3crw0kxvwBPUdFdJjLik
         Y1TA==
X-Gm-Message-State: AOAM530LBTDE9XqO3mmmcKPUSUARijwQUigdPs9YS9U45O2EBN8lRqxc
        eGKeB8x+qn0rNbIRzYyMUkdlrMn1hC8=
X-Google-Smtp-Source: ABdhPJz1A5/FUMIQam1u6CByJnJdpxE1n04Gv9MsluJ6G6+gnwj5UjtNTvGtCfvqrhWHHWk+kOfjRw==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr20772214ejc.58.1636731730339;
        Fri, 12 Nov 2021 07:42:10 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:10 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 07/12] sandbox: mark local functions static
Date:   Fri, 12 Nov 2021 16:41:56 +0100
Message-Id: <20211112154201.78217-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    seunshare.c:92:6: warning: no previous prototype for ‘handler’ [-Wmissing-prototypes]
       92 | void handler(int sig) {
          |      ^~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 sandbox/seunshare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index d626e98d..8917a0f9 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -89,7 +89,7 @@ static int drop_privs(uid_t uid)
 /**
  * If the user sends a siginto to seunshare, kill the child's session
  */
-void handler(int sig) {
+static void handler(int sig) {
 	if (child > 0) kill(-child,sig);
 }
 
-- 
2.33.1

