Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C422C433DB
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 11:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC9B20760
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 11:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404921AbhASK4p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 05:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731946AbhASJI0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jan 2021 04:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611047216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zVUJ7kbDn90ZpTqcQb9enz8Kp1J7QV2qHZMzrJo3Z/k=;
        b=gw6inXJfdsudDuIQyouQ6qDbHkpzX9l+2FbZp3UFTLdlPfM+OWHJmUTQyj+0q3aWGNnhAA
        mCQ814iphodXcF6ckVu9rUYMGjWJgfe5kaSDkjtzXf5vynoIixdwyOIT2T9Dwm3C9TTv/k
        3vUuy9aTa/cuGvfn63ShFhMrnR3zfeo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-fQKi1_8MMp-yb5KVhHtbTQ-1; Tue, 19 Jan 2021 04:06:55 -0500
X-MC-Unique: fQKi1_8MMp-yb5KVhHtbTQ-1
Received: by mail-ed1-f70.google.com with SMTP id y6so7183941edc.17
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 01:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVUJ7kbDn90ZpTqcQb9enz8Kp1J7QV2qHZMzrJo3Z/k=;
        b=Rmg22mNreeed/SBRkOw18BaUzOVtKfTTgZhCEz/Np6aRGz+D6wQZEyaNg4WBmzEMVv
         mYkwSCrIitN0gLFtg3gVuW+UjHdXVFXLAVHvsGal8VDyFUDv4+imj/eYJ1tSd/qzH/xb
         dJC7J/10xF6/Lg/3SmTM9U6Il7HGmeAygfje0HsatKkbIqu5V40/UcDP5ZjqePZtFucr
         IhBTEQD/r9JkTs2k7mVNArJdh01mya7SUHE3DOogGGx4GWY8N77jKxzQtPZnV5Z2l14S
         AahJZfJu6mgV7npQEELKrFMsC0jJyFQ8k536G/UeauSSWzK9Z83jPOKA96NJsBb/+p/K
         HZ0w==
X-Gm-Message-State: AOAM531TmB+S2NOzltiR0IkeTXbVdwIUVWpq0A10RHVtOPQXE9/R6M/R
        qZf1NIetbiSsqTkTId7IWFpoQYedq8WuHENdP7KjRIuQB6nMF1obFCKdHEZVh2cfXNpp9kPJap+
        QTRtg6gtamrOLa23D0RSjTLRHLq+pL7HNVOK7pFWenbxi8Gr3G3xwTSI677CTSj+RxDZWAQ==
X-Received: by 2002:a17:906:3fc4:: with SMTP id k4mr2275062ejj.137.1611047213855;
        Tue, 19 Jan 2021 01:06:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQaXOpBbPDJcJTp/GHBrdODMQzrxsDheZfuBuG1Eh8UL7Gy9Nlu/37MGW9H4Y93H/m7HHfLg==
X-Received: by 2002:a17:906:3fc4:: with SMTP id k4mr2275053ejj.137.1611047213625;
        Tue, 19 Jan 2021 01:06:53 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id v15sm1214655ejj.4.2021.01.19.01.06.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 01:06:52 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] Makefile: unload policy when testsuite fails
Date:   Tue, 19 Jan 2021 10:06:51 +0100
Message-Id: <20210119090651.321390-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make sure that the test policy is properly unloaded when `make test`
fails, to prevent it from accidentally lingering on the system after a
failed test.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9081406..8efe15c 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,11 @@ all:
 
 test:
 	make -C policy load
-	make -C tests test
+	make -C tests test || { \
+		res=$$?; \
+		make -C policy unload; \
+		exit $$res; \
+	}
 	make -C policy unload
 
 check-syntax:
-- 
2.29.2

