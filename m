Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB7C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 09:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03DA2084C
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 09:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drbFHwqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgE0JSm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 05:18:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725766AbgE0JSm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 05:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590571121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/K7X0nueefKU0FukYjUdhVAAl+LJIVhTf1PGcDOYBU=;
        b=drbFHwqXmpOzyM0MYDtML/81kRcaKh+e2lxUnwdusOg0QwFmk4KU9N5ojstF+GRgSfy8s4
        gPEvQ++hEKxmFqyp9JNuu3I2IzpaN9eaOG5t9stzny4tIBcZAF7XAKJYEtIbOIgd6xTjTl
        s8G8BC4M82o+6HfG4y1uXgCjtyK0KhI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-Q6Oo9Op_OiSGGpsS_nZadw-1; Wed, 27 May 2020 05:18:39 -0400
X-MC-Unique: Q6Oo9Op_OiSGGpsS_nZadw-1
Received: by mail-ot1-f70.google.com with SMTP id h26so11383320otl.17
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 02:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/K7X0nueefKU0FukYjUdhVAAl+LJIVhTf1PGcDOYBU=;
        b=Es9MBCwcA8tNVfBd0pXFHJgXlgt74xsPVV5YqYmUcavoaSCJ/ecsKTgGorkxjFYW8/
         3mkdD5lAOV/gSEtIqgHTQ81No60dfn/1wpFIBo/fMBnU2VYD7YxQ1VQbWUdaVxfx0UFJ
         Uy5j4ZCbCBvacB9fxi/ahvEPPvIsbAsEGXR/ZvQpSuO/WAE55+xhU1XFBLKXyz+acWoC
         dRV5RuDvA3HtLdGlRUy9kM14rzMdMmkUxjHkLpfLQ1Ly+d/CqRfZtBWpjk6ydNtSETma
         p8p5Rm//1ig9BcQZi8H0mj2LBnrDIN6AeWnLUxvXgAQcyY4wq+2hD4ZXSX2lyrglo/Qi
         y1sQ==
X-Gm-Message-State: AOAM530HLOjDQzKn6qSo8Jonkn6gg3lNRGMnGOfQ96LGax+HWDOY6x0S
        gMPp9fLyy0r47K0+gaUl9kzTvMRC/uJwxoINqmZnDR2zB+5fE7u5TsqSFHAHLjgIl4QJzUUdqZG
        1SGtCNSYGf0UbA+dsIxFgVrotO58vm39LYw==
X-Received: by 2002:a9d:544:: with SMTP id 62mr2122534otw.197.1590571118443;
        Wed, 27 May 2020 02:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp/zG6gMxgU62N2zHH9kkJUTCplWmSzGwfVc3bBEaxtmhEtKsyz1PN5Q0S/IlqZKnEvi5FGLyCBc9GPBYhyhM=
X-Received: by 2002:a9d:544:: with SMTP id 62mr2122498otw.197.1590571118113;
 Wed, 27 May 2020 02:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200521114805.25385-1-richard_c_haines@btinternet.com> <CAFqZXNvcvJKbRTpkg_wm0Ou2rqjenH3r__F9a65Rm60xiFerbw@mail.gmail.com>
In-Reply-To: <CAFqZXNvcvJKbRTpkg_wm0Ou2rqjenH3r__F9a65Rm60xiFerbw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 May 2020 11:18:27 +0200
Message-ID: <CAFqZXNtXxCsV5RxTwH-7McUC2nxNLqGJ7+87pPQg1-mr_6o2Fg@mail.gmail.com>
Subject: Re: [PATCH V5] selinux-testsuite: Add nftables to inet_socket and
 sctp tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 3:30 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, May 21, 2020 at 1:48 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Support secmark tests that require nftables version 9.3 or greater and
> > kernel 4.20 or greater.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > V2 Change:
> > Use common tests for iptables/nftables
> > V3 Change:
> > Use function
> > V4 Changes:
> > Add nftables to README for Debian
> > Use nft -c to determine if SECMARK supported
> > V5 Change:
> > Remove kernel check
> >
> >  README.md                        |  7 ++-
> >  tests/inet_socket/nftables-flush |  2 +
> >  tests/inet_socket/nftables-load  | 74 +++++++++++++++++++++++++
> >  tests/inet_socket/test           | 95 +++++++++++++++++++-------------
> >  tests/sctp/nftables-flush        |  2 +
> >  tests/sctp/nftables-load         | 68 +++++++++++++++++++++++
> >  tests/sctp/test                  | 88 +++++++++++++++++------------
> >  7 files changed, 263 insertions(+), 73 deletions(-)
> >  create mode 100644 tests/inet_socket/nftables-flush
> >  create mode 100644 tests/inet_socket/nftables-load
> >  create mode 100644 tests/sctp/nftables-flush
> >  create mode 100644 tests/sctp/nftables-load
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Now applied, thanks!

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel,
Red Hat, Inc.

