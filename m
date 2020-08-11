Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC30C433E0
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 08:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F25E206B2
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 08:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrelLv4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgHKIqH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:46:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728322AbgHKIqH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 04:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597135565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nrwKOQYefmITAw+K/svkqkradvyh/SLbS/l3LL5jg4=;
        b=SrelLv4I3WgraWYXX2gRRdZKb2sDNKyJCDwrroBxknFKGBP13oNiv7ek8yOmfphn0rUVVc
        PukGUDg6rpRvJxpP0PBOdoG3OrBFnaSj/QEfWfSCJkb1vQk7lXlMGztmzurTnWagfB/Mi5
        wfbniA3sM54IkALx6nhTIv8WmlxVC24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-OEHJPgDWPUuJyBFUzTm0pA-1; Tue, 11 Aug 2020 04:46:00 -0400
X-MC-Unique: OEHJPgDWPUuJyBFUzTm0pA-1
Received: by mail-wr1-f71.google.com with SMTP id f7so5306432wrs.8
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 01:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nrwKOQYefmITAw+K/svkqkradvyh/SLbS/l3LL5jg4=;
        b=Huu17IrVWClHywWTKwMnBgAucq74lrDrMzMhzGmm2FwOr+QbTSfQQXokzUwR4dBzWQ
         j7a+pFOxPFCvNRn95LZU3PUIDxKCO0RGEZFsRaHHt/E250v/3I74kIssnq5A7Y/Y1JA+
         ZL0SqOWWE8HrJlHLUvJSVT2gVg+BPqmP3UukHYjjvisbszrorHR8PgY8eQB9rtCjHgYd
         w5zfwIhRFJ1mju8uMaLsJGdbyVs6HBlSs4eEpeVUl3xzHJGg4stK20a5stEMwJ6E/Czm
         A1u9r5ul+5Kb6T1R9fG5QcBwbIO0ft2QJse3W9Zz4h1IFEOu1XXyhCuyc9/8dMOveADX
         OfGg==
X-Gm-Message-State: AOAM530A5HSmELOh2Tq0uDit317CR/ukuHfUx/XIDC6+DW7dfH6FyFtK
        7kagpz1xG3cK2baacavyOQZxGjWH7yHxWofdwd/GtPjYaSVcDEUnArp2rLLiH9/88PXjhrCFxzH
        Ph29eGckQH9Ij3gCtZw==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr3188926wmd.59.1597135558771;
        Tue, 11 Aug 2020 01:45:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz34XJnTw3NwDPLtT84NsqPIWsbncGcO39JsVmw4Fs+JBr24Wwisf2Y+qK63F9B7KWbYvb9A==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr3188914wmd.59.1597135558549;
        Tue, 11 Aug 2020 01:45:58 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:8a6a:ec88:3ed7:44b3])
        by smtp.gmail.com with ESMTPSA id a11sm27674310wrq.0.2020.08.11.01.45.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 01:45:57 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2 1/2] README: add perl-lib as a dependency
Date:   Tue, 11 Aug 2020 10:45:54 +0200
Message-Id: <20200811084555.105374-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200811084555.105374-1-omosnace@redhat.com>
References: <20200811084555.105374-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The `lib` perl module has been split out of the `perl-interpreter`
package in Fedora 33 into `perl-lib`. It is needed for the filesystem
tests. Add it to the dependencies.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 README.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README.md b/README.md
index ff0a0dc..bfd5b17 100644
--- a/README.md
+++ b/README.md
@@ -45,6 +45,7 @@ similar dependencies):
 * perl-Test  _(test harness used by the testsuite)_
 * perl-Test-Harness _(test harness used by the testsuite)_
 * perl-Test-Simple _(for `Test::More`)_
+* perl-lib _(for `lib`; split out from `perl-interpreter` since Fedora 33)_
 * selinux-policy-devel _(to build the test policy)_
 * gcc _(to build the test programs)_
 * libselinux-devel _(to build some of the test programs)_
@@ -65,6 +66,7 @@ following command:
 	# dnf install perl-Test \
 		perl-Test-Harness \
 		perl-Test-Simple \
+		perl-lib \
 		selinux-policy-devel \
 		gcc \
 		libselinux-devel \
-- 
2.26.2

