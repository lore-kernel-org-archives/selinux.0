Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9CBC35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3721556
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewc5iXXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgBYUDA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:03:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44513 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUDA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:03:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so105089pfb.11
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYDpnOO9HSE5if04ORcNe1FlF4m09kM1ja7Zo3O70HM=;
        b=Ewc5iXXO5HQt1w6INghwn2Je6Ur2jc0qaDHBdxMECBJpzgPxf5tMVoPeFbiO1ctHm2
         LI6pHDd5UPzzf+GxIJp+i+hj2ylEy0ndcnuimfgqd4n3nlkmvCy9a84uDthnwWCe/yxg
         aJ0H1+h8wtP9NLNeFqnQmY2+0LqpktdizSM345s6g+TNNNEMD5fQOmP0cdklOtpp2Vqw
         ZknZIGBERETtOKjQes7o39zDThaVWIxExCZdvH6fAsNGEufgQketl7SWorM+eNp5kzJG
         Er3SfNi3E4LFkucj2Tgm4In9c9+N7qBYIxSU/MWP14eKXz3S1WY482H2EoJp+cFdFeHL
         oN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYDpnOO9HSE5if04ORcNe1FlF4m09kM1ja7Zo3O70HM=;
        b=lFB4jpreER3COr2vNhfnK8Qte8BL8AWU9Gc9fy1XnqO3ECl9qTOzfWUVlsZwJMzm9p
         slgwGONwwHae/8/bqGP5/2X4RmEqndIMNRF3o0w3a4IN4piLvaKkPcevigBOUrjRamC4
         cP4jj13JRGzXCuxIcnmsEjBcr/IxWgQKi0iE3iPAsvJlGYWM/7wzccr9M4eFw8NMCycA
         lxEKSKvzMc3ADRKpP1U+vAWyJVb73nfWL6Egsb5CZ1VNIoQt+D9fnRxccIuidN7C93lH
         QFeQ4a4xvVkrAFvdkfVt1+jCjgIb8x3i+ZYFJzXtFMG1YLIf4ZWhd8YAx1k/sDKDVvpF
         osMA==
X-Gm-Message-State: APjAAAUBWVX8vuLZWhcHW2MAqpabPTqPLeSeTWbkO7/SfDy5REs1f319
        3jS64biITQWshzF0yh2QPew=
X-Google-Smtp-Source: APXvYqyyuN6NZIs7I+PDEwbzt7Lo3H9ae1KgHbDn8MlYVD+Cl+LsjwYnZpdpP5T8vJ9Zmil+qYQUQA==
X-Received: by 2002:a63:175e:: with SMTP id 30mr215834pgx.162.1582660979702;
        Tue, 25 Feb 2020 12:02:59 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:59 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 12/17] avc_init: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:14 -0600
Message-Id: <20200225200219.6163-13-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/avc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 472f6918ca83..7487b62f41c3 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -192,7 +192,8 @@ extern int avc_init(const char *msgprefix,
 		    const struct avc_memory_callback *mem_callbacks,
 		    const struct avc_log_callback *log_callbacks,
 		    const struct avc_thread_callback *thread_callbacks,
-		    const struct avc_lock_callback *lock_callbacks);
+		    const struct avc_lock_callback *lock_callbacks)
+	__attribute__ ((deprecated("Use avc_open and selinux_set_callback")));
 
 /**
  * avc_open - Initialize the AVC.
-- 
2.17.1

