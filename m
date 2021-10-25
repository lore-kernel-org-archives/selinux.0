Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02A3C433EF
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 13:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A55560E0B
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 13:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhJYN7t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhJYN7t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Oct 2021 09:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635170247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6JQBAKLPnF2LPBdfHWL7fOOI2bPR7zLqCIJ8MkBCC0=;
        b=f/GHic4zYLR4flOh1DqEmo0wgnmFwwfYIvuV8fN0W2YoNkbRbAEkf4WjJvsqWGysj91Wr7
        UG1ICmAptXGBJalFykCGpG6U0k+EhV7TcoQIV+8/S2Z6XXHWMVGxYJM86iY/y59utjMwRo
        LzpA3ke5EsHVYuyqiexPwydPokupw9E=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-99x1yNLGNHCdhYzb_1NHFQ-1; Mon, 25 Oct 2021 09:57:25 -0400
X-MC-Unique: 99x1yNLGNHCdhYzb_1NHFQ-1
Received: by mail-yb1-f198.google.com with SMTP id t7-20020a252d07000000b005c1709e6014so1918690ybt.15
        for <selinux@vger.kernel.org>; Mon, 25 Oct 2021 06:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=i6JQBAKLPnF2LPBdfHWL7fOOI2bPR7zLqCIJ8MkBCC0=;
        b=cEV3s7iYrjvDaOtskXhE9jafU2uiaJ0plMRpHgACI/i80PDiM/OjQYgZ69BLC3Rp2P
         BtolzEIuK0+cMdo0HN3apYI1IFWf6X4WkCSbFczTQN086EgOqxEVuuWK9oRqu+juzbQF
         dXfz5r8WbAfsBceV1yMHMcR26HuE4eVD6cX7bJfhjkHxyZ8wM3FYkFAK85vGI1fXGFpC
         SFYLsGxmEo72E9Aia3MbmHaohxcBL4lEkEsncQGCL4k/JwJKemG515ZeViQW4TEVx96n
         6oL82bPubzNP7A+b3n6O8jFCbf1xsm7ded5UuLuxF4Fz1N5Myi1zz9Gh0oM86w2LxV5L
         lf5A==
X-Gm-Message-State: AOAM533VLNJ5QDgzc40sEyzkpjpvSbtr+FgKJ8WX1WOonJbccCfQdfMq
        cOuMo9Hoh8jL7Y4rZCPReFf1OQqX/TUpOADPsMPmT1I2u4PQKcjlijwrA3mgFO0MeVX6wRU/TTu
        pKU+S5MEoZkADVaFuSNFGyC+aVmrg/C0okg==
X-Received: by 2002:a25:e650:: with SMTP id d77mr18436030ybh.256.1635170244925;
        Mon, 25 Oct 2021 06:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOlIeYvEyHI1kbS9W2FmCkfdF1Cr8mZZMAoR76OBVW6m/YZus44riDGK+DLADjvzHS9G2260EvXLi5TAXen/M=
X-Received: by 2002:a25:e650:: with SMTP id d77mr18436000ybh.256.1635170244660;
 Mon, 25 Oct 2021 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211025124845.179775-1-omosnace@redhat.com>
In-Reply-To: <20211025124845.179775-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 15:57:13 +0200
Message-ID: <CAFqZXNtq+5unxrU+djBwRrw2QQmx1S-G8i2bwqGoHemD0y9fDQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: make kernel iptables support optional
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 25, 2021 at 2:48 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The legacy iptables API is being deprecated in favor of netfilter and
> some distributions are starting to disable it in their kernels (e.g.
> Fedora ELN, RHEL 10+). To allow getting a clean run of the testsuite on
> such kernels, detect the availability of the ip_tables kernel module and
> skip the iptables tests if it's not available (either as a loadable
> module or built in).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/inet_socket/test | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Actually, I missed there are similar iptables/nftables tests under
tests/sctp as well... I'll need to respin this.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

