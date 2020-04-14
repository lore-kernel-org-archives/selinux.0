Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69594C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 14:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4607A206D5
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 14:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhYprU32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbgDNO1L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:27:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36949 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390719AbgDNO1E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x/0+vwYkAkGwLqyU8Am+58gXz9eL0US4RO+0Aor9Ch4=;
        b=AhYprU32ohHv43uYnauNgn/LpuerIaTi3pktCoAw08iukCyr5szBniHOo+0NT8cpbkiIuH
        Q1QACwVlwNcqcMgJPzoOkYem4E0F2NScOiNUArfV1lGsHjkGMow8JxfNSiMbIRkhEogNB1
        zmad1KWJX0CXlcbuTiqfd52mp0S8HNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-rfy0WPqiM9SD_JXRNYvZvg-1; Tue, 14 Apr 2020 10:23:56 -0400
X-MC-Unique: rfy0WPqiM9SD_JXRNYvZvg-1
Received: by mail-wm1-f70.google.com with SMTP id h6so3843715wmi.7
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 07:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x/0+vwYkAkGwLqyU8Am+58gXz9eL0US4RO+0Aor9Ch4=;
        b=ps1yIyy2h0aApfzHW96+hjCbsfVlpL850cBnvs81s+bWByFl75Z0/4vJwMwpos353K
         qOQBdzFHszLM6fupzmZcMIECbTVM4RUX5WCZAPTFsU852RR+l1cXOQYNm10KVSTaU77Y
         rCrbk2DgPqLPLud5vqeEqvdjrB1VUy681mjXOmU1bAK3h6eeGWipEIhtawssbYXwO5gc
         q009jcZumJT3m9Xp6RFmsjpR+lzGiti3/qc8O9qNt1zK12VMqXKDIBqLR/7ABO/56jCU
         mQFcCsfwL1pJtYkWOqg8IBa9EZTmpSKbr71llkRAZWg/4TB2ZOOV8d09qBCiQwvoqBYj
         RXnQ==
X-Gm-Message-State: AGi0PuazZrhgDcf9i63xxuPXCJF+aUk/v3xyRC5PF+wQJbBOGxgNOUYl
        2iSgWenVYSCETUXcVv01zn+glUbyaZfXLrHidz2j9rYRogt+GC40GFnON66tGNj+xmI/hz7tSDH
        L5PlCrqZS5fj6vAF4TQ==
X-Received: by 2002:adf:eb88:: with SMTP id t8mr23555027wrn.224.1586874234918;
        Tue, 14 Apr 2020 07:23:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLS4kBzNealtGJohiPK8FkscFgY4BVrrX3zYojB10yWmNk6rLgn2TVqowtBG4o6MitxdJddvw==
X-Received: by 2002:adf:eb88:: with SMTP id t8mr23555013wrn.224.1586874234717;
        Tue, 14 Apr 2020 07:23:54 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id w3sm416300wrc.18.2020.04.14.07.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:23:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     coverity-bot <keescook+coverity-bot@chromium.org>
Subject: [PATCH] selinux: free str on error in str_read()
Date:   Tue, 14 Apr 2020 16:23:51 +0200
Message-Id: <20200414142351.162526-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In [see "Fixes:"] I missed the fact that str_read() may give back an
allocated pointer even if it returns an error, causing a potential
memory leak in filename_trans_read_one(). Fix this by making the
function free the allocated string whenever it returns a non-zero value,
which also makes its behavior more obvious and prevents repeating the
same mistake in the future.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1461665 ("Resource leaks")
Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 70ecdc78efbd..c21b922e5ebe 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1035,14 +1035,14 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	if (!str)
 		return -ENOMEM;
 
-	/* it's expected the caller should free the str */
-	*strp = str;
-
 	rc = next_entry(str, fp, len);
-	if (rc)
+	if (rc) {
+		kfree(str);
 		return rc;
+	}
 
 	str[len] = '\0';
+	*strp = str;
 	return 0;
 }
 
-- 
2.25.2

