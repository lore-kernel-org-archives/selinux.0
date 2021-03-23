Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE78C433DB
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C3E619C0
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCWRIn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhCWRIi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Mar 2021 13:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616519317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFIa4cgk0W/ljtmFE5KfqiIeffPv2ZpFB5dDiHh6344=;
        b=WEzgEBy4n+BIpVf/DKottKuMBnLpH0kjvLqDhDhqevVN7Qmqb1beOdd/+oex6vPYcbXNiP
        dmUC8QlnJQB9J1xgaPuH5uqA2SpF7qh46l9HAo0eOBGZXy6a5sjuOumD2ejI+2t3mf+zzJ
        H9HzpgOVEwJFOXUiUcOctTOSnG5z13M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-h6n2mEHLP7W4pbAMbyXpqA-1; Tue, 23 Mar 2021 13:08:36 -0400
X-MC-Unique: h6n2mEHLP7W4pbAMbyXpqA-1
Received: by mail-ej1-f70.google.com with SMTP id d6so1351797ejd.15
        for <selinux@vger.kernel.org>; Tue, 23 Mar 2021 10:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFIa4cgk0W/ljtmFE5KfqiIeffPv2ZpFB5dDiHh6344=;
        b=o3rdErHiCMTrCVtEbiIbjJo53kb1U/Xop7ufoZYbTtP313KR8YYT4Jps76SIxkxp1p
         q4nkdLrvlBbVqmnNUa4MDE8PyWAsEYn7pEewocUzT2+cw9N5AnmGrr/0n/UapyET0fqk
         DNhKAF9Kut3xbz6r0VIzWRsrXRiPt5kunr+KmgML0D3Bdh9JwtDUWtqiKuLW4AmEpuyY
         zp2sDRs+l5gC5FMsqfuVh+PWzJfGoy1PaudvyfuBlW8qPcoocMAtocY0agDa1LhZmCB2
         FRE8mAb14tyyVL7eNQaHmBZdeYl98rDPXUeOAGIq1RhVRmwxZzQAe8Ow+Vx8mV4Uo6Nu
         hKKQ==
X-Gm-Message-State: AOAM533bN+w9RVbMfwrGLrc/Wk3SIHM3imoQ4buwRh07Z35a9O672cJQ
        hwGlPFRolq2hoYD4bDlvxdQPDZWsD7Q5RYdYxH0ch37j8JaYyO8iCp3wIcblQzLhcuH62EOH1Xn
        x9TJbZ+Q4CC5HTOXQwvWKgA8JCQ74u7vwGxCBYA4Kv2gh4+g+bAR3fgwslICQbWpH+FOGoQ==
X-Received: by 2002:a17:907:3ea0:: with SMTP id hs32mr5713835ejc.411.1616519313537;
        Tue, 23 Mar 2021 10:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyDv5MQ3u1S55piqRbWbMtdmvfyUMtrmV++WiF6m4ibN88MrALKwYTh1lBK7V61MELijMgqg==
X-Received: by 2002:a17:907:3ea0:: with SMTP id hs32mr5713817ejc.411.1616519313381;
        Tue, 23 Mar 2021 10:08:33 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k9sm13337948edn.68.2021.03.23.10.08.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:08:32 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 1/6] selinux_restorecon: simplify fl_head allocation by using calloc()
Date:   Tue, 23 Mar 2021 18:08:25 +0100
Message-Id: <20210323170830.182553-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323170830.182553-1-omosnace@redhat.com>
References: <20210323170830.182553-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 63fb8dc5..62b54079 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -427,10 +427,9 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 	struct stat64 sb;
 
 	if (!fl_head) {
-		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
+		fl_head = calloc(HASH_BUCKETS, sizeof(file_spec_t));
 		if (!fl_head)
 			goto oom;
-		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
 	}
 
 	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
-- 
2.30.2

