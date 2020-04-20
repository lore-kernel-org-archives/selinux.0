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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67267C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469812082E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg02tcUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgDTPqM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgDTPqL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C012C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o185so4710717pgo.3
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C+dBKk4sABQjXVUTCO4ckp0agCDAnLVwhF1NHIjUJOw=;
        b=Eg02tcUEcj6BX/c6HcaE4Wa+3spMh17r2m9z/8xxV9Eci+6bPag840abNkXtuercyX
         Qw1BKOTvPv8tvat9TBR3FqvBW9f4LEu8knjw9z8J/8YOqi8+2JHmJsLbvUlwukcqPyOY
         u7rKujK6VgUFcrIDV7pY8AvvoWRGX4QIEL9YATRm7yeeKjU/bQcDIQnfAB1V0WEA11ZM
         5ZT+LYC92VBfAimFU65XOet45XUYWbW7/sRKBIOxktPsT6Og8cirRrKsInOEAUeSOoTc
         vbQeJdiLLYoIFen9WW8z7dCKWTJz/11yF5CFwUSBxyyg224Z21bRIyo6Bi4ua7iNWzR0
         vjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C+dBKk4sABQjXVUTCO4ckp0agCDAnLVwhF1NHIjUJOw=;
        b=VAfzLAjA2kMT4cOlm0hGJKF3kOEcw4d9VyHDBkIOd0pLBCGjbteQzUd9PHsIgEjiDo
         0/cd7fXisisSTzTcQOWydrbl/BBBDZ58CmTv3NbRUwwjB9dhGVsyEi6KNlUIVofoE1sV
         j8J/joeTfiW8rogLkQ6vKMMvbTVgYTIB/Z+uxahkm03vqbhMKS3NqvnxDBkJC+9mDstz
         a5efJI0NU9qAGf/8hInhsYXTEhzLjfiofIS46vmQXTIhGMclhYbyMGB+W0bvkd4nPEaV
         Amlr3+K4b8c8oDugICFd8Tx3nOSRYt7SqwWy+H0RnY7cekjPPyWKf9EgoDGSmX+vcU0o
         RKLA==
X-Gm-Message-State: AGi0PuZ7zjVlu/mtWRnh4XSHwGArawiH37R96DChl8i+lvisP9js4Bcp
        /QEWw22hKIHweWfnfoaiS+U=
X-Google-Smtp-Source: APiQypL8KXG3bfp1fgX2iwkVwVXswpg1orseHsKQTkCP9vvAcpSBwEO/KpcpYRgpvvGqD18kd2WR2Q==
X-Received: by 2002:a63:581e:: with SMTP id m30mr16721066pgb.295.1587397569662;
        Mon, 20 Apr 2020 08:46:09 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:09 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 12/19] avc_init: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:30 -0500
Message-Id: <20200420154537.30879-13-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/avc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index c732824129cb..9b23357ad17f 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -200,7 +200,11 @@ extern int avc_init(const char *msgprefix,
 		    const struct avc_memory_callback *mem_callbacks,
 		    const struct avc_log_callback *log_callbacks,
 		    const struct avc_thread_callback *thread_callbacks,
-		    const struct avc_lock_callback *lock_callbacks);
+		    const struct avc_lock_callback *lock_callbacks)
+#ifdef __GNUC__
+	__attribute__ ((deprecated("Use avc_open and selinux_set_callback")))
+#endif
+;
 
 /**
  * avc_open - Initialize the AVC.
-- 
2.17.1

