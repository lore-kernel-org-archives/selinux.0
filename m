Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED63C2BB1D
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6E920644
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 08:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQBOPpJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgDQIMH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:12:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30747 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729176AbgDQIMH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 04:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587111125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uGyISG7vtzihMeHXne96dyb6R3cjToExgHqbgDGu5Ok=;
        b=XQBOPpJIPbe5FfvrDhoZitH7kQYMu4RxI75lKt/UGVSgpBsE8Ilr0M2yLsSLNvAgODdn1z
        0WCuTs+nYzTloU9m0eSHIOFZEEGGRJJUeRhdGd7UQSpr/NDmp/5zP/lOiu5w4qd4V/nwnS
        EjExUR6b5zd8lo/e36XWS9QVkD80Yw8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-AQ5Kn1H9MZ-SBVLDF_cYzw-1; Fri, 17 Apr 2020 04:12:04 -0400
X-MC-Unique: AQ5Kn1H9MZ-SBVLDF_cYzw-1
Received: by mail-wm1-f72.google.com with SMTP id f128so629237wmf.8
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 01:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGyISG7vtzihMeHXne96dyb6R3cjToExgHqbgDGu5Ok=;
        b=lx9N75DehcYyO1HSg1H+a5n76pP5R/3Fel7xT+Sfa4/febbM3/YrVchB2ONYWZVD8o
         XX3233R2U/kDJfaPfkjiXeb7j4YBZ4GejE2aR6JwPg16QaamBzzJz03Nd7KUof+RNFbp
         hYvi2Jqf5z7WdC0C+N4dWIhsDoAhFpSUfQ9/cEMIx5PwqwcIcTB7aFWgR0aCGlYep0/T
         ktMat6D9obCXK4+RuNWwX9OgiDjOxXI8mnPNsUMABOoHyH/EhoOg6HIp0ox5wa/wnkb1
         ai8zQsxxsO4Chku9dmOT4KjY8LTOhCh8aqTn8rIltjoQY09+ZWDdAgcftemgFgRLIRk/
         Cb7w==
X-Gm-Message-State: AGi0PuZ01mXtp+wDfkvlaygyOVHP6KlehNJq/e93mcrW75cDf4mHDQRj
        gYH39wF0my1BhG6l5CmHeeuQSIQkZhM8hIQukWLJR1dpIkpdgFf7VrPjgmab0ZghwuAWCeyrBzG
        RS8f4Qci4dprl5qnUFw==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr2779004wro.166.1587111122474;
        Fri, 17 Apr 2020 01:12:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ62CkNNrYDhcQehjPauvXRrXX6pjt0kan4mnPLMZtYZjfW3YJRL86w/fpxxcJibDqLJE1+4Q==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr2778982wro.166.1587111122191;
        Fri, 17 Apr 2020 01:12:02 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id i17sm20862398wru.39.2020.04.17.01.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:12:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH v3 0/2] Hash context structures directly
Date:   Fri, 17 Apr 2020 10:11:55 +0200
Message-Id: <20200417081157.606789-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Converting a valid context to string and hashing that is inefficient
because the conversion is slow. Instead we can hash the stucture
contents directly, which is about 10 times faster.

After that, it is possible to move the hashing under sidtab.c, which
avoids the complexity of calling context_add_hash() all over the place.

Changes in v3:
 - fix copyright year in ss/context.c (for real this time)
 - move explanation of valid vs. invalid context hashing from commit msg
   to the code

Changes in v2:
 - extract mls hashing into mls_range_hash() and put it in mls.h
 - move some changes from patch 1 into patch 2

Ondrej Mosnacek (2):
  selinux: hash context structure directly
  selinux: move context hashing under sidtab

 security/selinux/Makefile      |  2 +-
 security/selinux/ss/context.c  | 32 +++++++++++++
 security/selinux/ss/context.h  | 11 +----
 security/selinux/ss/ebitmap.c  | 14 ++++++
 security/selinux/ss/ebitmap.h  |  1 +
 security/selinux/ss/mls.h      | 11 +++++
 security/selinux/ss/policydb.c |  5 --
 security/selinux/ss/services.c | 86 ++++++++++------------------------
 security/selinux/ss/services.h |  3 --
 security/selinux/ss/sidtab.c   | 32 ++++++++-----
 security/selinux/ss/sidtab.h   |  1 +
 11 files changed, 107 insertions(+), 91 deletions(-)
 create mode 100644 security/selinux/ss/context.c

-- 
2.25.2

