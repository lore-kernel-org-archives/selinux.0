Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D01C2D0A3
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 21:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFF3223C7
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXMSu6O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440457AbgJUVpC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506408AbgJUVpC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 17:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603316700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuAtozTQfnJbcFRP3Plb2pGNYALi9DoVjiH8gr957Vw=;
        b=OXMSu6O0VGdBmNKkDf2Vrk4nRISJJvXj2DmOn56Ik5ap+NKicng6ticPKEw7D0ceXjFwuk
        pfyS/vjzlBNo//7upndDbRO4Db4kM+GZIZ2sxWOmvqmkUvYg8CyPlAB1BQmMBAcfhVrzaP
        DN9OOphO9+hQu1RmCEQfgKR0K2emnS0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Ye2_ZH2JPaqXS87R1HczJg-1; Wed, 21 Oct 2020 17:44:58 -0400
X-MC-Unique: Ye2_ZH2JPaqXS87R1HczJg-1
Received: by mail-wm1-f70.google.com with SMTP id r19so2116094wmh.9
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 14:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iuAtozTQfnJbcFRP3Plb2pGNYALi9DoVjiH8gr957Vw=;
        b=nfmhcogcyQjyDEkp5UCxiXwLOijzCVNpLc0YtQgXyAlArIVPJGN43gQjsfUSHxtHIA
         xd+dePw+inRK11QOWLvoqnm5yCHTM/DZHtcnR028QGdGxlj8lLsBG+TQXSrValqlhc9A
         JfqhYBp3iHUS1rK2/ueGVebkXm4kydOBr//t6D6O7ptSCQkXoR4Hq+KoSFQe2fUmM8ze
         gg6u8wND3gFdDzqjFAeHlHVywLCRyPJIKMwprg7L0Xzip8TlhGo8J8S3J8FxKwzFpYPq
         TNxSgoaOsJIdWqb7YNpkP3aknKr5C0GXX5rG18h0ncuxX2zpL3bzU0O3lbGhKbemyZyY
         7HJg==
X-Gm-Message-State: AOAM530izI4xudL3CWvDGvLmOKp2x6vc+KtPpJ/WbS4Rk36K41OUn7x1
        ncC8Awok1Jbp0zBzrKZQH2rOP6gDw7zwbSgPVUJcoYuGUnAARH0K10jPtP6sjLgJKS5ThE8dHY6
        Jbx4d61JwM4zjvOh4xQ==
X-Received: by 2002:a05:600c:228a:: with SMTP id 10mr5426410wmf.123.1603316697538;
        Wed, 21 Oct 2020 14:44:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+jf92id+4nOtL7gY8/MsOT4ckn+4HtI17o1MvGdwDieULWFDG57X/BnztxL8ZeG4BmXl59A==
X-Received: by 2002:a05:600c:228a:: with SMTP id 10mr5426404wmf.123.1603316697374;
        Wed, 21 Oct 2020 14:44:57 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id d3sm6466791wrb.66.2020.10.21.14.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 14:44:56 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 2/2] tests/sctp: set up a GRE tunnel to activate ASCONF tests
Date:   Wed, 21 Oct 2020 23:44:53 +0200
Message-Id: <20201021214453.400811-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021214453.400811-1-omosnace@redhat.com>
References: <20201021214453.400811-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, the ASCONF tests will activate only if the test system has
two global IPv4 addresses, otherwise they are just skipped. Most
systems, including the VM in CI, don't fulfill this condition.

As it turns out, this second IPv4 address can be set up very easily by
creating a GRE trunnel interface over loopback. So make the SCTP test
create such interface so that the ASCONF tests can be always run.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/sctp/test | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/sctp/test b/tests/sctp/test
index eede42f..1170921 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -35,6 +35,12 @@ BEGIN {
     else {
         $test_count = 75;
 
+        # Set up a GRE tunnel over loopback to ensure we have enough addresses
+        # for the ASCONF tests.
+        system "ip link add mygre type gretap local 127.0.0.1 remote 127.0.0.1";
+        system "ip addr add 10.123.123.123 dev mygre";
+        system "ip link set mygre up";
+
         # asconf parameter tests require two local non-loopback addresses.
         $ipaddress_list = `ip -o addr show up scope global`;
         $test_asconf    = 0;
@@ -909,4 +915,6 @@ if ($test_nft) {
     system "nft -f $basedir/nftables-flush";
 }
 
+system "ip link del mygre";
+
 exit;
-- 
2.26.2

