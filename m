Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97ADC433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A6E64E05
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhCRVxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230297AbhCRVxM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 17:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616104390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5wxzv8EhyW12Rk6j2EadZlMt9P57d57X4OZQ9+SvlYo=;
        b=jOZfZuuC3AMAFWHmFUlcVohUKD48w7pndfuwuQxApOF/DfB/d6xUGA5py6eu3t/lB4xuIA
        xbZt3GtkOHsoLipmr6zlTFq2dM3FxT0OVp1nhxYsj7+mTe/l1XtED+RntlmmTPdFMmKiHZ
        H6hgqN7sdy40i9YUvbOil/XoOOtAJOk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-gYg1xJm2Ncm8n89jTrP7-Q-1; Thu, 18 Mar 2021 17:53:08 -0400
X-MC-Unique: gYg1xJm2Ncm8n89jTrP7-Q-1
Received: by mail-ej1-f71.google.com with SMTP id rl7so17216418ejb.16
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 14:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wxzv8EhyW12Rk6j2EadZlMt9P57d57X4OZQ9+SvlYo=;
        b=KuAkzPLQ/5I3cxUm3Hf63fMk3mjVR5G3EfctKXXXsv3fUD6bnFfogKHvFGS846bQ8H
         fXnq31DNypcX2COUeOKzyzfG7gFR/EwM1qwyEnSj92GJWGOJzFQUiovBmhkEh3sl8gLE
         OeUN3SRoTtxepohARNdcALV/PWq038tGVDB7zlmpvw90SXEHw/V2psRpdNVQYVcxObQa
         VZ48LbXrT/gIGgQR58otNTp0+h88pob+tpn4mui0E1x63DmwhQiszQuGbFfdzXLfFgW2
         l3MKWeHU4Z04o9VPXypcu9eDjZgdtOmQz+DA2uK8xVyuziC5QWTiTUiiDoFg4wW1cUVv
         2tzg==
X-Gm-Message-State: AOAM532ZQ6324j7kXB5+MAXGqiGelPLiHzC3crI6DBHwA6+bPVeIrXO9
        gZn9ZMRphgy6Bn7iBbQI1n1A8eGYFKLfpaXja4KCR0a9frjTlR1nkaeYlp591YgPxPg3E3T3/aX
        luBlVwfoa4EIpxa1edWdE7ZYRvEsyarJrylnZztie/v0bQ7VvMbva7ygK6BFAyl0xQ5TanQ==
X-Received: by 2002:a17:906:a049:: with SMTP id bg9mr750568ejb.186.1616104386789;
        Thu, 18 Mar 2021 14:53:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysaRpL6VrJVt0ALD32R7Fwo7maNsWdcxfsq08fSCulBGAq7BgWS5HPySYqWmQIIu2tEju7Qw==
X-Received: by 2002:a17:906:a049:: with SMTP id bg9mr750555ejb.186.1616104386618;
        Thu, 18 Mar 2021 14:53:06 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id a17sm2620255ejf.20.2021.03.18.14.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 14:53:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 0/3] selinux: policy load fixes
Date:   Thu, 18 Mar 2021 22:53:00 +0100
Message-Id: <20210318215303.2578052-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Changes in v3:
- move new struct declarations to the top of services.c
- add another patch to clean up error reporting during policy load

Changes in v2:
- switch to a more minimal fix which allocates the conversion params
  dynamically and passes them between the functions
- split out the MAC_POLICY_LOAD record fix into a separate patch

Ondrej Mosnacek (3):
  selinux: don't log MAC_POLICY_LOAD record on failed policy load
  selinux: fix variable scope issue in live sidtab conversion
  selinuxfs: unify policy load error reporting

 security/selinux/include/security.h | 15 +++++--
 security/selinux/selinuxfs.c        | 22 +++++-----
 security/selinux/ss/services.c      | 63 ++++++++++++++++++-----------
 3 files changed, 59 insertions(+), 41 deletions(-)

-- 
2.30.2

