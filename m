Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39610C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F026217F4
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nja68TOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgAVPrG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:47:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29104 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725924AbgAVPrG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 10:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579708025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u/EWoj4l2UimsmxGrBSf979ivapbEtFIdPcsOEO1JCs=;
        b=Nja68TOcE4TQZseVvGyDrt7NTnHnJ1A426lqjfVUO3deZTxJ0sTuvpVnPkeZu+er0oRcGh
        w0KLckwoukCULjKShrh3vcB986sG6ga70wkZh/arHVP9Mgc6uFNXOjrxfLs/BPrTWYad2d
        XuUI/uwG/vs09uhpVIFGHwnVHYcgohs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-o8PiipvfNsuv8IP4p7d1sg-1; Wed, 22 Jan 2020 10:46:59 -0500
X-MC-Unique: o8PiipvfNsuv8IP4p7d1sg-1
Received: by mail-wm1-f70.google.com with SMTP id s13so1119610wme.7
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2020 07:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/EWoj4l2UimsmxGrBSf979ivapbEtFIdPcsOEO1JCs=;
        b=WL0Ga9XH6vofrKy+9zvYH3aZSuosW9QOtJZ5jIolNCQy4j5ML0MB7d4558eya1yKg8
         OKwCImBI5+iifnhuTHDMk+/N+bGe29iZnZpQ/ej4KM2cGeT8JpBE+JISPU3fAgCAEVHo
         +gmJ2e/gGvMLumCPKw7XPMtQk4KDGpPXWov8/BObR3BiXorstYUa6rJJwxfkQ5oFHIXB
         S9Ys5Hs9cCCCEX+OlmXlIPo+ZzPKfLOzyOBBVgb77GOz6dGmmy/xKNkKaYm2WHwGMUGJ
         0Ri5WF3BCPNfBitwmOSRUDob1WC05/23fu5wUf6YA+RWoT2DYV9m/tWr9e6MF+8tsKPJ
         TQzw==
X-Gm-Message-State: APjAAAVL6wRjCZ9mEPkg3EMGJxeyI17fi+eSdGd3Q39x11QV4cQTulmi
        /CavLsoYrKgsJGIYQAtJrIrj91D33Iv/bPgL88wl09FqGLmPEmU22LIYsBTvWTBLpX3nv1EfDsH
        NyojD+ZKdqFUFhr9UwQ==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr3600788wma.121.1579708018033;
        Wed, 22 Jan 2020 07:46:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcXtV40N6K3fyqAvqp0rf4zF7KsblZG0uC1PO/UKP02mr9N+5rSZe0H3Xbmnmeu2dr7DnmaQ==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr3600776wma.121.1579708017797;
        Wed, 22 Jan 2020 07:46:57 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c5sm4811788wmb.9.2020.01.22.07.46.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 07:46:57 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 0/4] Fix build with -fno-common
Date:   Wed, 22 Jan 2020 16:46:51 +0100
Message-Id: <20200122154655.257233-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GCC 10 is going to enable -fno-common by default [1], so fix all build
errors uncovered by it and add it to global CFLAGS to avoid introducing
new bugs.

Travis build: [2]

[1] https://gcc.gnu.org/gcc-10/porting_to.html#common
[2] https://travis-ci.org/WOnder93/selinux/builds/640506702

Ondrej Mosnacek (4):
  libsepol: fix CIL_KEY_* build errors with -fno-common
  libsepol: remove unused cil_mem_error_handler
  checkpolicy: remove unused te_assertions
  Makefile: always build with -fno-common

 Makefile                        |   3 +-
 checkpolicy/checkpolicy.h       |   2 -
 libsepol/cil/src/cil.c          | 162 ++++++++++++++++
 libsepol/cil/src/cil_internal.h | 322 ++++++++++++++++----------------
 libsepol/cil/src/cil_mem.h      |   1 -
 libsepol/cil/src/cil_strpool.c  |   2 -
 6 files changed, 325 insertions(+), 167 deletions(-)

-- 
2.24.1

