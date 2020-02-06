Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E3C352A2
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F86214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGsELpAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgBFNTI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:19:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27017 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727668AbgBFNTI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 08:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580995147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OP6JZoxht20nBhWiZ9jbZWQbKsStcR5o/6mz/4y6yiI=;
        b=bGsELpAb1PDCDZqNnEHsWVvqHFnnAHzax6U8EJjCFJuLfWMwOh6/Q+6GZ/jZmkHrQLLZSe
        M7dnyBZcMe9ZNGb3PCZv3zOnzrcl40k5ZA6Uq1jTTF/pxGaQyJr0itB0m4pVV+VD0HvsyT
        hee6lZOfT3v+oUIpXuULmKTW5M2tIyc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-ENcZnIsTMlahNAc-G54yRQ-1; Thu, 06 Feb 2020 08:19:05 -0500
X-MC-Unique: ENcZnIsTMlahNAc-G54yRQ-1
Received: by mail-wr1-f71.google.com with SMTP id d15so3376245wru.1
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 05:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OP6JZoxht20nBhWiZ9jbZWQbKsStcR5o/6mz/4y6yiI=;
        b=S2TXBSTNkb01d6cRBEASDr7ByxYrDl61OiLilicl7v5M0e8CLoXhlgoiYfxoRb6bdY
         dL8/tDjK7+cWL2QD3h56wBNoo5DAqfqva9ehfBrOe4ij86AGBbRRUU6iNlgpt52IfHzX
         TiNpnqpTC/tXD+uLb1Yj6kQTva9Y1xxffQ5NEfET7BvMKPcWkRhrQV+ebabotLtNuTuC
         GykU/6ktuf0xH+As4q6w1/QXluPdv6LSZqwrQaI9k3qBm2mzHhoihDApGYy4WPe5r2iy
         EV1ueqdbKYsCL5979QtNrkCKDEJkKNraBjIltUGDCuUZ/KkClWxoKPFHDagz7VT0MdFG
         FJCw==
X-Gm-Message-State: APjAAAUh0RYpsUu9HUTgOUzmkkgUqURJxeDUIrBFSJGt4A/tgvln2AIt
        HVM4Qwoq+Byis+jmsd1zJXMHddPnkGYzOjQB7Z2asYjNdILGvl2Si3nVjbi4UwarrfBXDbsDJ8S
        dTMW4ZqiIXIgoSilE5A==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4555244wmc.119.1580995144180;
        Thu, 06 Feb 2020 05:19:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8exW9FpG3Rp4M5V7rkxXPGmyyxEpkb85JyQHivTIFhSmnas3yBkU0m6qoGSoxzN3wNoIjzg==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4555216wmc.119.1580995143919;
        Thu, 06 Feb 2020 05:19:03 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm3668978wme.16.2020.02.06.05.19.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:19:03 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] Travis-CI: test that DEBUG build works
Date:   Thu,  6 Feb 2020 14:19:01 +0100
Message-Id: <20200206131901.535779-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206131901.535779-1-omosnace@redhat.com>
References: <20200206131901.535779-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index e9f86baa..918958ac 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -13,6 +13,7 @@ env:
     # Test the last version of Python and Ruby together, with some linkers
     - PYVER=python3.7 RUBYLIBVER=2.6
     - PYVER=python3.7 RUBYLIBVER=2.6 TEST_FLAGS_OVERRIDE=1
+    - PYVER=python3.7 RUBYLIBVER=2.6 TEST_DEBUG=1
     - PYVER=python3.7 RUBYLIBVER=2.6 LINKER=gold
     - PYVER=python3.7 RUBYLIBVER=2.6 LINKER=bfd
 
@@ -116,6 +117,8 @@ before_script:
 
   # If TEST_FLAGS_OVERRIDE is defined, test that overriding CFLAGS, LDFLAGS and other variables works fine
   - if [ -n "$TEST_FLAGS_OVERRIDE" ]; then EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS=" ; fi
+  # If TEST_DEBUG is defined, test that debug build works fine
+  - if [ -n "$TEST_DEBUG" ]; then EXPLICIT_MAKE_VARS="$EXPLICIT_MAKE_VARS DEBUG=1" ; fi
 
 script:
   # Start by installing everything into $DESTDIR
-- 
2.24.1

