Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0775C433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCDF619BF
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWRIp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230041AbhCWRIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Mar 2021 13:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616519320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWlLcLYJa2dEQ7oAa+m9wPMNeHbRvEZAQGwbu1ooBpI=;
        b=is66XjI+CbpPBt12BCLeDMH3M3TYXVm6xjMu8UhsI5YabwNqZ1NN88TXWnsRrPufLRJYtu
        gtywVD6pz1mpQs2/7EU4bvD78qRl08wxpiSMC6vtbVMee1bcuKwy5e6QI1PQXQ2pNHhJwn
        DWk4s7jeV4JX1JtYnVbM7P3hMM38CTw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Sv4FyXSINa6S62ha67UsfQ-1; Tue, 23 Mar 2021 13:08:38 -0400
X-MC-Unique: Sv4FyXSINa6S62ha67UsfQ-1
Received: by mail-ej1-f71.google.com with SMTP id 11so1346617ejz.20
        for <selinux@vger.kernel.org>; Tue, 23 Mar 2021 10:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWlLcLYJa2dEQ7oAa+m9wPMNeHbRvEZAQGwbu1ooBpI=;
        b=W1dC0jdeUdsg1uzVKfdKEe4X+8NFP91uYsFprK40FwnQE1kcRABeNc/5p85JE0H4vS
         drpIfh3dC7OKZ2dD4YRJX7g1iAyCZNjZeEKxTzfS4v5ELIlmbRG+kS1o+xeTP6+AXEM4
         rN27zZk2YIje4NAYl9qhNwDYYKlv/mcfQb2/QfpVxHL3AhCSrWd7K94kxP7EbVV7b81H
         DfTP3+JWrqRHktK/cBAu220yOIo17TlpsID6a5g1FTaoPHxBpSArUK3Rnj9Nc2/rZhwk
         EdYTDrbMSMRTqFXnZENAsAlse7OiSIz7joC9y0PGP01/dgS/Y8AVhTT7iOT5lCjTIHZH
         ZZwQ==
X-Gm-Message-State: AOAM533lHYctyR9EN7mnGt9ksB7w+bXs7SmF2B5y1S2Kq9/aP7gxUzwZ
        2v+U7MH3GdbsQP04NzbxfA5rJSSWSweH2N1DGJwvMGV4KKzB8TUuBNba6U+Rk+6PUlcuhZjTjs5
        nflPyG+XbK2IgvO8ySyS6Gxoj7YV4gCkc+s2qV9IntyTPbg5O2yHV5oHslg75/dLl6H2sQw==
X-Received: by 2002:a17:907:76c7:: with SMTP id kf7mr5787906ejc.470.1616519316675;
        Tue, 23 Mar 2021 10:08:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlyRPSjXmb8yDcI31LkKTo3MU88GW/6v0Rlx8RG9vdNTEuZK0+VVaZqp6f+RTJdhW136VUEg==
X-Received: by 2002:a17:907:76c7:: with SMTP id kf7mr5787884ejc.470.1616519316453;
        Tue, 23 Mar 2021 10:08:36 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k9sm13337948edn.68.2021.03.23.10.08.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:08:35 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 4/6] selinux_restorecon: add a global mutex to synchronize progress output
Date:   Tue, 23 Mar 2021 18:08:28 +0100
Message-Id: <20210323170830.182553-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323170830.182553-1-omosnace@redhat.com>
References: <20210323170830.182553-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Another small incremental change to pave the way for a parallel
selinux_restorecon() function.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 0ebe56b1..3f3ac2e6 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -69,6 +69,7 @@ static int exclude_count = 0;
 static struct edir *exclude_lst = NULL;
 static uint64_t fc_count = 0;	/* Number of files processed so far */
 static uint64_t efile_count;	/* Estimated total number of files */
+static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 /* Store information on directories with xattr's. */
 struct dir_xattr *dir_xattr_list;
@@ -658,6 +659,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (flags->progress) {
+		__pthread_mutex_lock(&progress_mutex);
 		fc_count++;
 		if (fc_count % STAR_COUNT == 0) {
 			if (flags->mass_relabel && efile_count > 0) {
@@ -669,6 +671,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			}
 			fflush(stdout);
 		}
+		__pthread_mutex_unlock(&progress_mutex);
 	}
 
 	if (flags->add_assoc) {
-- 
2.30.2

