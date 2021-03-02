Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE68C433E9
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C6264EC9
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbhCCEWk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345113AbhCBRXG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Mar 2021 12:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614705681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/v78tzE1plDPvJnQ1haydwu2yobjLZXc03L6xlpp6iA=;
        b=Y8nkyDQ/dsZnWkrJut/jyhf8n6OpOkNjcz4YwvKoDI2MtJJ9TRjP6pEyz8dtUUqtUtmBpD
        ff5rbLVr3VPLYaXQDcS1Zs8tBGlJZXDEh1uDh/aTv9UeRFPGtkuIz4AAdDBpJ8wUvgxZO5
        r/z1L7TezMr7CowHVqjDTpE+aSwtfmA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Zv2ZF4_lOYKlJB8K8lsPPA-1; Tue, 02 Mar 2021 12:21:19 -0500
X-MC-Unique: Zv2ZF4_lOYKlJB8K8lsPPA-1
Received: by mail-ed1-f69.google.com with SMTP id q1so10785880edv.5
        for <selinux@vger.kernel.org>; Tue, 02 Mar 2021 09:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v78tzE1plDPvJnQ1haydwu2yobjLZXc03L6xlpp6iA=;
        b=LWfQObzaXNDJ9Gxyotle9AkvaAHF88HtnM9JYHl/zNrE0tMDh2pdwrpyO7uZxWXpvu
         f4S1JI/vuK6mQWgFxqdjNcxJq5PNR1932b7LoUk+nmdOQEnYSLTjXg2QFHB15DG4SHyR
         xq4kVy4thCg53tz+0txHDXG08LVCvMHJm/IL3BG0cvMWsnmBMS3ycWMxLBET80AKP26B
         HUJ/RIgmp02h02yQO8xGX+gO0Kdu8yXUf6YyJUEoxwXQ3SGfppQVK/Zc6sgeKlaZQqJy
         LdODiA0CWrr6r9otBk/b279s0zb9qabCi8yyXnJhOE2P7SdrOgwE0vI7FVNAvvL22J8C
         Z2WQ==
X-Gm-Message-State: AOAM532yyoFTeNI1lHppnEq5cFpPUO1ZcMS3LTWnbJiXc0B1AxKTEUrJ
        FNBu9zrbYCHTx2BuYp2sPD+ww7sJxz25gWZr5bC9qIueG4FBt0o3XfYyg8Y5ZesVGrx6ue7xd/y
        tMMrPrpXn8iWxxRxMXM59U6imUF9uv6Fj6oxCAGoVHrtvkET3qmZsR3EXNP9SpGmV3rsg/A==
X-Received: by 2002:a17:906:600f:: with SMTP id o15mr22299544ejj.76.1614705678332;
        Tue, 02 Mar 2021 09:21:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQdxRQzEsH9Yr1N+MK6RNumcpnNWV2atspM7JXJxRlYxMrBtwAdC6rv4RoUitG0WlqroAHIA==
X-Received: by 2002:a17:906:600f:: with SMTP id o15mr22299527ejj.76.1614705678107;
        Tue, 02 Mar 2021 09:21:18 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id pk5sm17922560ejb.119.2021.03.02.09.21.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:21:17 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/3] perf_event: measure CPU 0 rather than CPU 1
Date:   Tue,  2 Mar 2021 18:21:12 +0100
Message-Id: <20210302172114.443689-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302172114.443689-1-omosnace@redhat.com>
References: <20210302172114.443689-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the "cpu" argument of perf_event_open(2) to 0, so that the test
doesn't fail on single-core machines.

This makes the perf_event pass in the GH Actions CI.

Fixes: b9e1eb2db689 ("selinux-testsuite: Add perf_event tests")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/perf_event/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/perf_event/perf_event.c b/tests/perf_event/perf_event.c
index 8983f02..1557303 100644
--- a/tests/perf_event/perf_event.c
+++ b/tests/perf_event/perf_event.c
@@ -82,7 +82,7 @@ int main(int argc, char **argv)
 	pe_attr.disabled = 1;
 	pe_attr.exclude_hv = 1;
 
-	fd = perf_event_open(&pe_attr, -1, 1, -1, 0);
+	fd = perf_event_open(&pe_attr, -1, 0, -1, 0);
 	if (fd < 0) {
 		fprintf(stderr, "Failed perf_event_open(): %s\n",
 			strerror(errno));
-- 
2.29.2

