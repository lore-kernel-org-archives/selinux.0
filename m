Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8423C433E0
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B492E207FB
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6EgXfai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgEZNbO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 09:31:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46489 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbgEZNbM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 09:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590499871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnAIdFCq+rwIb4IKl0E5LqedsgQ9Xl2pY6ih3sd1BHA=;
        b=Q6EgXfaiusDiDyUK57YoiHdLFWVSzhzvhUWLsxYg3q8u/8gI68F0viXUELZLHGV3cSIwVd
        GRdFNlomZiIpkuC4qHBSGFQvAYdYHdoRvAiXBCTtc03Y/Ho6Vh3Vx/+t2v8I/H4KIz5MLI
        TVwozXEuMLJHqudZ/GTNoulUNPgDy0s=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-cFH15tQNOPKyLfKUVzRKoA-1; Tue, 26 May 2020 09:31:05 -0400
X-MC-Unique: cFH15tQNOPKyLfKUVzRKoA-1
Received: by mail-oo1-f69.google.com with SMTP id z24so11394721ook.13
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnAIdFCq+rwIb4IKl0E5LqedsgQ9Xl2pY6ih3sd1BHA=;
        b=th0H2vXum637d11E1KeHrGFzKbie2FLH4zMETzFfnRE/W78cqd4JGIoUC06Sq/TgA8
         qjIzFpriXDlqmZ9I86PwD2ym+sdiYnW1HhZCz8hGN8eumdHNDN8257u/wronniCPPf2B
         7FItojNxazhTTy1RTdK20VfPV1mq9ijBFVZ+vztVSTaDO+/B3AgkMsDVORnx/DipiIfj
         aovqnZpip04Ui7r6OQyINqhJtXP+H4dMx/SQTlv6UJEkLJU7B8AmPErvKYP621GbWoB3
         E1nBNK4NdPSDw2djcw4mPs2tg0BGnzTKufZhcG0YSKNjlcl9uJee9yKKyFvncCvIR3VB
         j8Rg==
X-Gm-Message-State: AOAM533429Xb5Fajb99A2HRNlQsaomaHflFYwa7I01XTxJPtF3K+tPVL
        Tdr25k7Ds+IO2BqeEQDOXkWzcUGAWNrWyhxc7JblnKNGNmf7Or79cy2pTvgT2tT0Vl12pekY/Yq
        YOfGLnFMQPlRcP9F/QoQFe5fQ5IW7Mi9Bpg==
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr872996otb.66.1590499863730;
        Tue, 26 May 2020 06:31:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynjHKQyZHQtKmyUM/FczfxezdxaLgmT6/1zsm+APowun+ViRgWahVQLkbUmG5G71eJzh2Su6nF/H05jCy0/z0=
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr872975otb.66.1590499863483;
 Tue, 26 May 2020 06:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200521114805.25385-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200521114805.25385-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 May 2020 15:30:52 +0200
Message-ID: <CAFqZXNvcvJKbRTpkg_wm0Ou2rqjenH3r__F9a65Rm60xiFerbw@mail.gmail.com>
Subject: Re: [PATCH V5] selinux-testsuite: Add nftables to inet_socket and
 sctp tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 1:48 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Support secmark tests that require nftables version 9.3 or greater and
> kernel 4.20 or greater.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change:
> Use common tests for iptables/nftables
> V3 Change:
> Use function
> V4 Changes:
> Add nftables to README for Debian
> Use nft -c to determine if SECMARK supported
> V5 Change:
> Remove kernel check
>
>  README.md                        |  7 ++-
>  tests/inet_socket/nftables-flush |  2 +
>  tests/inet_socket/nftables-load  | 74 +++++++++++++++++++++++++
>  tests/inet_socket/test           | 95 +++++++++++++++++++-------------
>  tests/sctp/nftables-flush        |  2 +
>  tests/sctp/nftables-load         | 68 +++++++++++++++++++++++
>  tests/sctp/test                  | 88 +++++++++++++++++------------
>  7 files changed, 263 insertions(+), 73 deletions(-)
>  create mode 100644 tests/inet_socket/nftables-flush
>  create mode 100644 tests/inet_socket/nftables-load
>  create mode 100644 tests/sctp/nftables-flush
>  create mode 100644 tests/sctp/nftables-load

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel,
Red Hat, Inc.

