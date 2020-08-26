Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A8C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3B42075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN+IBsbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHZOFS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgHZOFR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598450716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3V8IV7NwcHe6UO4Kw06ZYUNpP0TSU96ZV2D4w6awGmI=;
        b=iN+IBsbMU7vtmpJcgzMcpfeRMxNbY3M65aOND89RAzEp7qm+iTXP4HJp/5VzLNJODY3v5a
        euDw2bCtPK/zxrnzQ9S3EWOljFZEiMPta6HhD5YxlDQitSDQTvyBiMpFa2crTrswAwadvz
        SabrFcZdG0uF5fot6Yyk7SrBx2VKdVI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-zkAX-YAaMmOLELWtb_SRiA-1; Wed, 26 Aug 2020 09:59:09 -0400
X-MC-Unique: zkAX-YAaMmOLELWtb_SRiA-1
Received: by mail-wm1-f72.google.com with SMTP id p23so813104wmc.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3V8IV7NwcHe6UO4Kw06ZYUNpP0TSU96ZV2D4w6awGmI=;
        b=d8qx/TWz65DvIVv5AYDxUk/fi7D1an7bWcsrPgHxGdCmmfvy5kEkFWC2xoSd/t2GKS
         EEAhUgvN5jNuZ/3Sx7Zt+BCTpDvr4jEWCZyR/7I4CxN1Mibeo0689SNWko8tpu/OKpmr
         BX/dA4QSfYjvdjHhxlO78F8Z2xmKST3ohrD3aX+tP1W4jcaPWFLyUtibGQhQWkjiWNLC
         8yky5YQKhzMCUbZKEKOLTeFM6Sr824pNkeNf3+dZO6Kw+Yg2axfqzWGxxx+Flj0yEU32
         Vb5IuFl64pgVrSEhvoUTYj9R/oq1PhT3DHV8yINBP2UjS1cbttiDdJc3wu4qW/fgoKRo
         fnig==
X-Gm-Message-State: AOAM533jJb81RmcP+/ApZ+1kfbSuUWUoO36rLrGDCT1Pij4CMAeqqnd/
        HWiM9HQlxP12rjV6+V9ZF4IRoRENU67tNfX+jwChBJnz3+ICgDcjwVgOR+FPXMCtGrMlX5w3/4k
        fwqvU+UjaQ0Cu2wHfmw==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr16385273wru.9.1598450348278;
        Wed, 26 Aug 2020 06:59:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx32DSAq1QkFlpwUsz4zSj9p/gvTsdzHUVl0exRnefNyQUD0+2IyPFxwH2bLGi9b9+ItKR9fw==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr16385259wru.9.1598450347985;
        Wed, 26 Aug 2020 06:59:07 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id y24sm5622325wmi.17.2020.08.26.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:59:07 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/3] selinux: RCU conversion follow-ups
Date:   Wed, 26 Aug 2020 15:59:03 +0200
Message-Id: <20200826135906.1912186-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains some follow-up patches for the policy rwlock to RCU
conversion that has been merged recently.

Passed selinux-testsuite under both release and debug Fedora kernel
configs.

v2:
- just dereference the policy pointer directly in security_read_policy()
- add a patch to remove the redundant policycap array from selinux_state
- drop the refcount patch for now and remove the RFC keyword
  - I'd like to check the performance impact before going further with it
  - also, it might be better to continue holding read_lock() in existing
    functions and only use the refcount approach in the IMA policy export
    function (the standard access pattern will work the same also after
    adding the refcount support)

Ondrej Mosnacek (3):
  selinux: simplify away security_policydb_len()
  selinux: eliminate the redundant policycap array
  selinux: remove the 'initialized' flag from selinux_state

 security/selinux/include/security.h | 53 ++++++------------
 security/selinux/selinuxfs.c        | 12 ++--
 security/selinux/ss/services.c      | 85 +++++++----------------------
 3 files changed, 43 insertions(+), 107 deletions(-)

-- 
2.26.2

