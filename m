Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE7C4363A
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 21:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35641223C7
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 21:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE0b+HwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440487AbgJUVo7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440457AbgJUVo7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 17:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603316698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8CgkSLCNz4yENN/guES2lvrg6vN+eg/lqwtLNkqbrDA=;
        b=XE0b+HwKnuhHgM+MnBmxHUIUd7AoSSKRxt0ldgmNKU0wxeJ0dBnyGpZm81En2h/Tl2jQuU
        aFCF+r2vMp03jXTMGwdTWthzGvPCT4EZVEWgck3muljuNcHGHA099yd6ETZ2lE6mBcxwRa
        DBlqcdF/JtWjfQahfepUH1fuH3Byi3s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-kQNaz176NEWl77zzi2JU1w-1; Wed, 21 Oct 2020 17:44:56 -0400
X-MC-Unique: kQNaz176NEWl77zzi2JU1w-1
Received: by mail-wm1-f71.google.com with SMTP id f2so1978726wml.6
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 14:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CgkSLCNz4yENN/guES2lvrg6vN+eg/lqwtLNkqbrDA=;
        b=g+AR1+qM4RLckmrfkzXk7c4s8VqHZTR5RcPv8WYQJLKl1e1kQ2jSkMHSuEvrNH30JQ
         WKuTlXtu48WbkNgQ4InysPGqOzRrzAiFf6wFgqPpLLfXSmGqb5G1zK/NQV4vHkqgUZy4
         Tsp2fz7sgh8TPYdhrqYq7v6fK8Wpw8T/FglRO1gyhC/DBi2KwWfJbXTwXKvuYKkJZeKu
         Z7l0MKw0iHp3A0tifJiNLu6xl4vHatI+ZgoQduAAefp6COu5KWo6+p3wiED51PE3ygdE
         Pz8jJSF59Fv+pVv2mSdu9zSMk5qeiwehAVL+niEk+ZDuywr6RnorWCV7B0t2uw0e7FWF
         KoQQ==
X-Gm-Message-State: AOAM533wKAF2z8XNVeFRhStDXsy+6SuXJK9Xd59StYiaVUpeup6q6mKC
        hwZFOaLHRGCVfkcM+ZvMiPHsKOoJ72gMTkN1q/OJGFWOpsRwCgif8IR22cXo58OOfSJj7BEmUtx
        c+EHZkDDySsEg3dwHOQ==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr5100740wmj.80.1603316695421;
        Wed, 21 Oct 2020 14:44:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR20/BET3XXbyHDeforiEtZPuv3Xz5hkTljUQoFgC8ERi8e6ZsE296+0LH6HziVuaFegHbqQ==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr5100731wmj.80.1603316695201;
        Wed, 21 Oct 2020 14:44:55 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id d3sm6466791wrb.66.2020.10.21.14.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 14:44:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/2] Fix ASCONF test and ensure it can be always run
Date:   Wed, 21 Oct 2020 23:44:51 +0200
Message-Id: <20201021214453.400811-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

First fix the unreliable ASCONF test and then make the SCTP test create
a GRE interface with an additional IPv4 address so that the ASCONF tests
can be run even on a machine with just one global IPv4 address.

Ondrej Mosnacek (2):
  tests/sctp: fix a race condition in the new ASCONF test
  tests/sctp: set up a GRE tunnel to activate ASCONF tests

 tests/sctp/sctp_asconf_params_server.c | 7 +++++++
 tests/sctp/test                        | 8 ++++++++
 2 files changed, 15 insertions(+)

-- 
2.26.2

