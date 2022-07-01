Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05735C433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Jul 2022 07:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiGAHbF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Jul 2022 03:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiGAHbF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Jul 2022 03:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB5006B832
        for <selinux@vger.kernel.org>; Fri,  1 Jul 2022 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656660663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YF9sUDtmiX7svBps7DZZndb77BBlYWVrKzQQLs+RdR8=;
        b=cNbb9H/cAFACAeezEI3C+31Dwg0lJpV9mAwvz27uxE95YIx4atOrkVdXbRFNjGWcxa/xcL
        KchN16eEn69vkqRU8Bwh7nZL0vTOntemwF94pEXoL/7iWaxUzyk+EWQFs61Ts92Haen11o
        mBDT2Z7OV1M00qLwnNrrEHSsqlI0VEo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-uNm4GGAyN0S66JwNRPt9wg-1; Fri, 01 Jul 2022 03:31:02 -0400
X-MC-Unique: uNm4GGAyN0S66JwNRPt9wg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-31c339f73c3so13441397b3.8
        for <selinux@vger.kernel.org>; Fri, 01 Jul 2022 00:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YF9sUDtmiX7svBps7DZZndb77BBlYWVrKzQQLs+RdR8=;
        b=tv1gxPo2akVPZfTG8pPOTwqaCDcK/jxU/ITCoQuTRqrZRdfCmZ8ENcgN90Uoi95L1r
         hU37uBX+hQPbejMahaEWOBd3IOJq0UUaRRsjKG375I0vZ1afz0bRGILSD4mgpEksOzK+
         SIYAU9LkmaRs5YcOSWDL6f7XGawXxw5x/Mj/LqolWPugUS8Y1TiZvdhNXBWYLlm912sz
         snsZtho4wCUAJ1IibNUgi7lE6EN3RkBVhv8F+w19MchTH4YtU9eFOPxG2SAwtn/uPzcZ
         BTOrXBmPGtqXjuMo3WP9i56fRpEdlJze9ntUJXFMrqBko8z27/3LdscaLoZJhIL5t4Ru
         PhGg==
X-Gm-Message-State: AJIora+LvMD4TLpIT4Babe5HvZLdqWDyOUYemVG+FOP0hz+uEkzGJDm3
        OKyAGsNbp2GJfl0oaiqhpqomxXX756cQa7iqd/ABu3RVj+oIMihawU4wzVRQNOGmUDLX4hsaXr7
        RTMkD1TYob9g+RLNG9S31VJIVKkCSASeXZQ==
X-Received: by 2002:a25:da0b:0:b0:66c:850f:1b71 with SMTP id n11-20020a25da0b000000b0066c850f1b71mr14397081ybf.336.1656660661188;
        Fri, 01 Jul 2022 00:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uo/Lr/FElNEJX7mJHmTymryNmyvFRfFI7kxFCT5hCe46XOYq5G5FPOCEN8HqZGHY2kMS/f0mHMtuHGFgFYcQY=
X-Received: by 2002:a25:da0b:0:b0:66c:850f:1b71 with SMTP id
 n11-20020a25da0b000000b0066c850f1b71mr14397053ybf.336.1656660660796; Fri, 01
 Jul 2022 00:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220628100138.297047-1-omosnace@redhat.com>
In-Reply-To: <20220628100138.297047-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 Jul 2022 09:30:49 +0200
Message-ID: <CAFqZXNsRyGUUtjuhxS1TjFo6p8iESMaYvTgr_mqF=qg5Wx_ApQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/2] Make the keys test pass in FIPS mode
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 28, 2022 at 12:01 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ...and also fix Makefile deps for this subtest while there.
>
> Ondrej Mosnacek (2):
>   tests/keys: use a longer prime in DH params
>   tests/keys: fix Makefile dependencies
>
>  tests/keys/Makefile      |  2 ++
>  tests/keys/keys_common.h | 48 ++++++++++++++++++++++------------------
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> --
> 2.36.1
>

Merged:
https://github.com/SELinuxProject/selinux-testsuite/commit/85832b99b430c48694eb7386a5a1e5957df44416
https://github.com/SELinuxProject/selinux-testsuite/commit/a3becc4a9701784d4d4f7e2d0e1c2296a16dc11e

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

