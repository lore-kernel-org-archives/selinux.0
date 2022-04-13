Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C9C433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 16:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiDMQuk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiDMQug (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 12:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17EA1692B5
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649868494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p2fe2OAefXPSN/f4YsLn23PYTAkyurT+ZbIu6mkcR6k=;
        b=WiZrvlPPDXrum8ewNzmgCQrO1iJqf/KcPp1asl6EWpAd81LrEGAJQcyFqVyB13LgOlFKJN
        UulofogFh+jSMLMpWkJB6geGtHlyLAKPeQYIrLqB6hl/N2nAyAY9L42tLz0s6RH/clMFYf
        YF1ncdH0U/OmznRhxk+HtmQyN+CeyyQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-c0hq1GvFPtuf6pcnRKOvUQ-1; Wed, 13 Apr 2022 12:48:12 -0400
X-MC-Unique: c0hq1GvFPtuf6pcnRKOvUQ-1
Received: by mail-wr1-f72.google.com with SMTP id l14-20020adf9f0e000000b002079eeec6b6so521767wrf.22
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2fe2OAefXPSN/f4YsLn23PYTAkyurT+ZbIu6mkcR6k=;
        b=difhmWNV6r0QA9440fV76XnhFKDCNSCjhm86yEf1Kl3TRVx8pKY4AuTyo3aMoZghvz
         xFYkHuVEx6M0QntokRWTlblOVaWsBVXl6fus3BmKH32fxh+Mcpd4O0BTnfoAtA/BXz3h
         9K/cOYf9PSdTxCZ6VT9D2IosGxk6IBhXQHQIJ09rMhBRCg7xX0JaXcIEGU1Ec0LhrvSa
         lP3yMf2YtxVXXHhjljK0gDr/XkiHeKi7VVJzfKQKHGNdnVHxSQB/nC3aZSEawvd0PU2h
         72Ci3Tmjt2pNaW2VJOH/MBIvO2JbGdEZQ++GBjCfrc001jmAq2i/8of4dgQdB/26kKAk
         t3QA==
X-Gm-Message-State: AOAM531CQYspClhFrP0GzV9CURo+SOf2SoOp/W9mdG0ggAPX5iSHPG8T
        YR0F9uRmmK7KVM3aEtB8sbFggCVhhGqr/ARShh6zj39Pu6ih7VATPcln4YCTkNVtfvfdGkw6fL/
        N/vJG8sd9/s8io1FCDQuTq2WD1L4WYsvnPOXEF4Nr5oz6VieuiFWa0Y2mJyWetAx2JyUhoQ==
X-Received: by 2002:adf:e346:0:b0:205:97d0:50db with SMTP id n6-20020adfe346000000b0020597d050dbmr33699396wrj.257.1649868491511;
        Wed, 13 Apr 2022 09:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3gWyV5l82l5iHpbA7sOdkmCSNUGFTvILRdranbPzpWlO1nGOKgCt37DNThYb/MKqnkx+vyQ==
X-Received: by 2002:adf:e346:0:b0:205:97d0:50db with SMTP id n6-20020adfe346000000b0020597d050dbmr33699381wrj.257.1649868491232;
        Wed, 13 Apr 2022 09:48:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2991747wml.10.2022.04.13.09.48.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:48:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/2] Make SCTP and Bluetooth support optional
Date:   Wed, 13 Apr 2022 18:48:08 +0200
Message-Id: <20220413164810.2122305-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SCTP support is already partially auto-detected - improve it to be more
robust. Bluetooth is often disabled on architectures where it couldn't
be used, so add checks for it and skip relevant subtests if it's
disabled.

Ondrej Mosnacek (2):
  tests/extended_socket_class: make Bluetooth support optional
  tests: check more thoroughly for SCTP support

 tests/extended_socket_class/test | 107 +++++++++++++++++++------------
 tests/sctp/test                  |   4 +-
 2 files changed, 68 insertions(+), 43 deletions(-)

-- 
2.35.1

