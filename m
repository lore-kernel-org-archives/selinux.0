Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287D5C34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F164F20801
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar1ti4nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSNp3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:45:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgBSNp3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 08:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582119928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cW7BVVhMX0pStihipSg5G4Xq1gyUcr5hkUNC9YH5V64=;
        b=Ar1ti4nktd8Wbx7g5hCg/Efu4XPsxdwX7trVTEiogprVqZNehGvuyOkCCL4C4aJ9vLiwPj
        WpU9/ZTq+vY3pctdaZQqdATbrr6ene8udBe7r0/I8nsZ/BZZpPfxJa+qPJTu9N/m264A6h
        5Nvix+9P+iWK5mEqfi5ONAm44vlSU9M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-FEQWqimLOFCDySwIaV5cGA-1; Wed, 19 Feb 2020 08:45:26 -0500
X-MC-Unique: FEQWqimLOFCDySwIaV5cGA-1
Received: by mail-wr1-f69.google.com with SMTP id d7so71122wrx.9
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 05:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cW7BVVhMX0pStihipSg5G4Xq1gyUcr5hkUNC9YH5V64=;
        b=V4wzdEdOwL1pqoo4t3/KURDe83e6i8/TZvVsgWpePaKXtWXgGEQ1NzBC3Fo6xjOe5a
         BYfr2kC0dweEeZMFeD9e7lL56PFDSA1iebUC2TaXAo91YAF2Atu/8YXT25TaCO57yZc0
         FDtSpXZ/bW8Qosd0X5/B1kb7Gv3ouOatxaffkAUTJoa0leUpvCIWBuRRc1WAWELU9VCs
         //vZ7LVPz23BfyDX8CzMODNCsjO2BvJFsfESnoUHQs8VgcdpZcbtsTnPx499vISiHQpr
         nwTykZX/P/Frb5wqID9PGII8GHaUhn6F1tNm4dmKFopy5sMh5chTNP0dxVVCGg+NUHrR
         lDYQ==
X-Gm-Message-State: APjAAAU+aXI3qWWZWTEIJ0iNGBEghUA87NK/5FXsubjxlFTAelNQmTwY
        bZWU7m2stBm8f1Y3V93065+Y5DCINLbiH4qlNTTvmwl7q4s/K5VDu+89VqviWp9LaHQLZ5PfVjY
        if22xaGfps6EnNgN/0Q==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr38115422wrn.254.1582119924775;
        Wed, 19 Feb 2020 05:45:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/+YRUMUSD1v2rKJsJhW6bGaWvLwisnltCT3JJQS/GdUKW67OguyXIycTNHpNWDY1WQmltiQ==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr38115402wrn.254.1582119924550;
        Wed, 19 Feb 2020 05:45:24 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f11sm3036558wml.3.2020.02.19.05.45.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:45:23 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/2] libsepol: Grow hashtab dynamically
Date:   Wed, 19 Feb 2020 14:45:20 +0100
Message-Id: <20200219134522.230822-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The first patch is just a cleanup to have a single hashtab function that
can add elements, simplifying slightly the second patch, which
implements the actual auto-growing of hash tables.

Please see the log messages of the patches for more details.

Ondrej Mosnacek (2):
  libsepol,newrole: remove unused hashtab functions
  libsepol: grow hashtab dynamically

 libsepol/include/sepol/policydb/hashtab.h |  28 -----
 libsepol/src/hashtab.c                    | 127 +++++++---------------
 policycoreutils/newrole/hashtab.c         |  85 ---------------
 policycoreutils/newrole/hashtab.h         |  28 -----
 4 files changed, 42 insertions(+), 226 deletions(-)

-- 
2.24.1

