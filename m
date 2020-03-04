Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1FFC3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D3220848
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 09:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wl+BfeRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgCDJuD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:50:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726860AbgCDJuD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 04:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583315402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+e9sOAdhDOht/hr6vij0dDX5DZ0z/FvomK+Gt3utpmc=;
        b=Wl+BfeRI9YrNEknxjajgl+o8KVsnlKkJsea/O2hDwONqXylVDA3wKsROLS5ySeRz+mPE99
        7vcM+9IAsZkA5WXJubwJ4x4Z0Rxi31w1D3UBzG0tKML3mQ5ag0D5CZ1IVYeuAd3A7HWMZW
        HJP0uhGSaw3PjtPl4yUK82r7iN0/jDY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-N6Cjh_AIMnSpfak-GpMxlw-1; Wed, 04 Mar 2020 04:50:01 -0500
X-MC-Unique: N6Cjh_AIMnSpfak-GpMxlw-1
Received: by mail-wm1-f70.google.com with SMTP id c5so622393wmd.8
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 01:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+e9sOAdhDOht/hr6vij0dDX5DZ0z/FvomK+Gt3utpmc=;
        b=rvkBBqcD+QNgGItDi0GhWT+8GCYZ3U6GPx2PHQPDuzWvyrjlgVA9k2ImRFjdAUH+Oo
         MMQ3RgqGHewHRUe6FzogFS275BbvctT/4G2GMPsDWarV5igdRqXzVw65mUYxAFuF86e0
         ovpzm3I3e+vSNiTrXbs6qsORnndvvpe4g+PUKGAkVFYZRyFcJSM8dAgN1O+z0TgWAO3p
         1HbKrXVRzBRNDuKQXs2IE6LBUWhPt+1cmhbHG0hBo41Il7lPFtNEFAFLjMyYTqY+2Dn0
         C9YBPAoSg7/O+TBER4Gy1ikJE/Hwv6jtOheNAapBG76uf5Qq/10w4Yn1flCKyEcpqsaY
         oEQQ==
X-Gm-Message-State: ANhLgQ3qMbd3N1TntpGrt4bhC9yjXpNndISgAXTtQsfhY8KHPyNP8wqK
        41U7uFDnfAqdz3LikyXHryT7onjk3V1zARAfZj2v3Bfu+xTgmATqBW/+FQsCA4kXkKIS/SZrr5X
        CmVQQBIb72ELe7I0eXQ==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr3152248wrm.133.1583315397515;
        Wed, 04 Mar 2020 01:49:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsg1zELXsqO2KwGOnzgO1wODktKi7kLXjooWGsKY4nFVCz2yB1wbRTER5omHrNtsD2OyKWUOA==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr3152224wrm.133.1583315397231;
        Wed, 04 Mar 2020 01:49:57 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n2sm40075535wro.96.2020.03.04.01.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 01:49:57 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH] libsepol/cil: raise default attrs_expand_size to 2
Date:   Wed,  4 Mar 2020 10:49:47 +0100
Message-Id: <20200304094947.181153-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Tne value attrs_expand_size == 1 removes all empty attributes, but it
also makes sense to expand all attributes that have only one type. This
removes some redundant rules (there is sometimes the same rule for the
type and the attribute) and reduces the number of attributes that the
kernel has to go through when looking up rules.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/cil/src/cil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index d222ad3a..31380e8b 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
 	(*db)->disable_dontaudit = CIL_FALSE;
 	(*db)->disable_neverallow = CIL_FALSE;
 	(*db)->attrs_expand_generated = CIL_FALSE;
-	(*db)->attrs_expand_size = 1;
+	/* 2 == remove attributes that cointain none or just 1 type */
+	(*db)->attrs_expand_size = 2;
 	(*db)->preserve_tunables = CIL_FALSE;
 	(*db)->handle_unknown = -1;
 	(*db)->mls = -1;
-- 
2.24.1

