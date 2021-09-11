Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778BC433F5
	for <selinux@archiver.kernel.org>; Sat, 11 Sep 2021 18:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE90760F43
	for <selinux@archiver.kernel.org>; Sat, 11 Sep 2021 18:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhIKSgp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233539AbhIKSgo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Sep 2021 14:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631385331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEnNLGFohRrYOCPCpEIoXOphDFkjq1X/RKfbRfeqnOo=;
        b=bFHVsCuIcTZw9CzhwsU9RC0tuadxUeIb75JgEwENei/k5O7Gl54oYKvGxRvypoR7TlJmd7
        SDCn24C7F5tURUReF/RokPnyem4+BRDjYAOUhh3GvUnAtplLIeBcK+W/ZIhI2ojkm11lcf
        JeR5pP5cLGg0ygCwcYv1d99o92Zb1Rg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-hc5w8XE4OHS5BDg8--BWwQ-1; Sat, 11 Sep 2021 14:35:30 -0400
X-MC-Unique: hc5w8XE4OHS5BDg8--BWwQ-1
Received: by mail-yb1-f199.google.com with SMTP id j4-20020a258b84000000b005a203c5e066so7117098ybl.19
        for <selinux@vger.kernel.org>; Sat, 11 Sep 2021 11:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mEnNLGFohRrYOCPCpEIoXOphDFkjq1X/RKfbRfeqnOo=;
        b=Vqbav7WkJq7muL++R6NUpZSTCDakQlnMqqlMwahuZTLkRL1YaOIxw6nSrSOhiHtiS5
         tUVgg1Q6opK4nJftWMFAkBjQrsS41ExkydOKJ6JLbgNB5L71MdgxKdCkxy7jFqGTg0HJ
         j1ShUa2QagLf94CfG47BltE8njwUz+0l8NAhA+FUjHFbBLZ+snd/4pHyYggJpqpI4WVt
         ZqBDov87ifT2hdK4bGyfCWwf611tEj07dJnhiEMLS5gaVk7IjfOMhSxMaykDGGzIWcTf
         eyuAKqlp89zkZX0u3meqvmrfmcmje8NmlscZYw5tpfwl7Lph28wuohPcBH8FD7kWOLQ0
         4zww==
X-Gm-Message-State: AOAM530bGmfxeAqKPGaGi7PinIk4kHAIrtqreRXf9pDQs216WVhzgJM+
        XeUh542h+dkltjKlCxQ8V5qp2OZ6n6XQvwg/2Q5iGC8T52aBIMTBi9imC7FIJpakAEwGx9pI0mx
        gAggtou48P272X9MBPV3JDfcmd3OenshNyA==
X-Received: by 2002:a25:bb8b:: with SMTP id y11mr4907283ybg.384.1631385329563;
        Sat, 11 Sep 2021 11:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtcAqEs+XRCONeQ/WhRmwLo0npIepSfW6ybS91T1vqMwyo1mz4BVNs0Y099CLLpzAfGpaBqNmNvRW+k9pOJKk=
X-Received: by 2002:a25:bb8b:: with SMTP id y11mr4907267ybg.384.1631385329357;
 Sat, 11 Sep 2021 11:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210908110725.258108-1-omosnace@redhat.com>
In-Reply-To: <20210908110725.258108-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 11 Sep 2021 20:35:16 +0200
Message-ID: <CAFqZXNucc2ZV4uxfQ2Lnny8gJ1gBuGzB0096kPNvsbt1_Ff8ZQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests: exclude vsock_socket test where it
 wouldn't build
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 8, 2021 at 1:07 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The test requires the <linux/vm_sockets.h> header to be available and
> contain th definition for VMADDR_CID_LOCAL, so wrap it in a check for
> these preconditions.
>
> Likewise, the vsock_socket test policy requires the vsock_socket class
> to be defined in the base policy, so wrap the policy bit and test in a
> check for this, too.
>
> Without this patch the testsuite wouldn't build on older distros such as
> RHEL-7.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: also check for vsock_socket class in policy
>
>  policy/Makefile | 6 +++++-
>  tests/Makefile  | 8 +++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)

This patch is also applied now.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

