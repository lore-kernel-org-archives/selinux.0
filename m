Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E1C4363A
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03CD223C7
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 21:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NH74IkmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506445AbgJUVpB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440457AbgJUVpB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 17:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603316699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHFwt67E4x5cELhVDO2I9M6rMm8JwYGFUwb2olMxZnU=;
        b=NH74IkmSH6oeJQcEpXTkr8Rrz4+udGwARvVBaE7mJLJJwOCl90UtMnpHcqm6wzplp96il4
        RvsypOInhCGl96W11YRLlP6V7G/f+v2Bv6beVz0u6Nc2434wEO5BqfxJUBft1ox+vC8yyh
        8URLeXZOm5lWcf/qIiJKMISs0T5U1GI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-EB9yCjf9MmayaBldzoq9fw-1; Wed, 21 Oct 2020 17:44:57 -0400
X-MC-Unique: EB9yCjf9MmayaBldzoq9fw-1
Received: by mail-wm1-f69.google.com with SMTP id r7so1969234wmr.5
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 14:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHFwt67E4x5cELhVDO2I9M6rMm8JwYGFUwb2olMxZnU=;
        b=N/93jPSR8rPKMx8Dp7p+oa8rVpKMgjWOZjcWumuY0k7Pd2oIv8ritBlEwFt5l+pRB2
         HcPj8qADpyDh2qwo50hRVe5+rtN3pqe7ynmB/mTgnPiSQ5MKHqEqDzuvl32EiP9GW19Q
         yJIdqY1Os8X/ljtR4TMClbDUWp+Fgoo0EkdWz5uPC+kq8ZP8mVA4lin5n+HZoRRRC/xl
         /InSlcbiU7XbYuuoUwGeNxp/eea7JSU8lceuxSVL7Cj2aBAiW0sFBMQd25ja6SqFGfDy
         amI9KXCNeovonfxhYbYjdBawAU8OPXFWUeajQWphLpmzkuz7PuK8hIUjGsB0RlkSGLSy
         KkEg==
X-Gm-Message-State: AOAM53299P7vESvjbY8Wa+SNu7zbTRwOtJjjl254EEHEAa/eMVf2wltY
        sSQL7wwGi3t3HsC7k2RJlkXCY4aoEvw2daHV7iNBzGTJyMYBaIAHVDinmg8E/3QhFTy63ojbQqT
        xy3CxAM4Y3IVPNO9s8w==
X-Received: by 2002:a1c:2581:: with SMTP id l123mr5345121wml.169.1603316696529;
        Wed, 21 Oct 2020 14:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+93VZi4uAKXR810T4B6+CM/8aw0CjxoP67ExYEYpEzcAwfA3nGgAaMplJiwx+nqmvsl1a2Q==
X-Received: by 2002:a1c:2581:: with SMTP id l123mr5345108wml.169.1603316696313;
        Wed, 21 Oct 2020 14:44:56 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id d3sm6466791wrb.66.2020.10.21.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 14:44:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/2] tests/sctp: fix a race condition in the new ASCONF test
Date:   Wed, 21 Oct 2020 23:44:52 +0200
Message-Id: <20201021214453.400811-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021214453.400811-1-omosnace@redhat.com>
References: <20201021214453.400811-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The new ASCONF test introduced recently (see Fixes: tag) is unstable and
can randomly fail on slow machines. The problem seems to be triggered
when the server does the sctp_bindx() calls before the client starts
listening for a new message, so add a 1 second sleep before the bindx
calls.

It is possible that this delay will not be enough on some very slow
machines, but let's start with a small value and see how it goes. The
one second seems to be enough for the Travis CI at least.

Fixes: 841ccaabb366 ("selinux-testsuite: Update SCTP asconf client/server")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/sctp/sctp_asconf_params_server.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/sctp/sctp_asconf_params_server.c b/tests/sctp/sctp_asconf_params_server.c
index 18e2cb2..ded782e 100644
--- a/tests/sctp/sctp_asconf_params_server.c
+++ b/tests/sctp/sctp_asconf_params_server.c
@@ -225,6 +225,13 @@ int main(int argc, char **argv)
 		       ((struct sockaddr_in6 *)
 			new_pri_addr_res->ai_addr)->sin6_scope_id);
 
+	/*
+	 * We can't do the sctp_bindx() calls too fast, otherwise the test
+	 * that checks if these are denied would fail. Therefore, sleep for
+	 * a bit to allow the client to catch up.
+	 */
+	sleep(1);
+
 	/*
 	 * Now call sctp_bindx(3) to add 'new_pri_addr'. This uses Dynamic
 	 * Address Reconfiguration by sending an asconf chunk with
-- 
2.26.2

