Return-Path: <SRS0=v7Ke=42=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A00C10F27
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 12:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C95920674
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 12:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYLKfKAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIMks (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:40:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42369 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIMks (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 08:40:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id 66so9331430otd.9
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErYw9u39yB++x2Nx3w0GG4Rtf3bptwNbbRQVjYGRQQc=;
        b=uYLKfKAkvUR+LZpcV6TT521PFfsOluDPxrcrFFsgeKLsb0Xl/k6c0C0wKNUIuyOGQQ
         ADSDeLNOQohGhBTCGl4zIeC4GkKF9ENtfZuvZpDuR7P9RzYpquu8UTnMtjAk7ckOb6Xg
         cf/cP7o0IsKZ1sMHgXMGeBaQ9Pf9EdZzp5GsyihFavlTWOivMxa0NV/bBzoZmve4LNW/
         ZkCK443F9vfXZNoSbRsb0DowzU7474k/e8DtRCzPx4bzeDPBw059Ss0k2VMbUDF3/XIK
         JJy4yieioLqFbkUSsE502IjR2UxWlXaNf3PxADLgzGN95z7VHycR1hcoikoS5cPBi1Su
         qCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErYw9u39yB++x2Nx3w0GG4Rtf3bptwNbbRQVjYGRQQc=;
        b=LBtCk/nRjAoU8XSi2tP+luFB/rFQb+DxyBtTRr0+W2F4ZmBngnmIdG8ETlCs2GrDyx
         0jgqUCD3HdAqjQ/hpfsdwpe1UU/XyZP23y/cvWk+eyWXD3jjYrhkBo6kESUyyhTqdWZa
         5TtQ2SAwlPoRAZvXeaRceqYdWRAlhiy3nt8LZEDW/hB5JlI8R9nnG8Ek0oaLQ85DLwEN
         QmSPBVUakPpYfNafXEZyXUaJJmB/ba5pD5n7RagfXZubog6Tp6EvFmo696CvsdESJgS1
         8p6SiJF0mVhxgQX1VCziMgiT4W0D77SeQeyMkFLkep2p9pRqB7ijOsJgxpwjoMx8JK9w
         cPTw==
X-Gm-Message-State: ANhLgQ0g8j1PoU7LKKarrRn4O+RE3+o9hL4rLOCqQZV1JVZie/Z6O5Ns
        WhOtbc1GLhuYP3BROJo48oCR1T4C/eg3MYl8bak=
X-Google-Smtp-Source: ADFU+vstKSnlusoaDlmPqfwYvuK2pNV80ZCVSxe+LX7VL8OjwLu9FrLB4XAyHtscZjp5Yd8mowQLxoIJybUORqYWk3M=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr12819651otl.135.1583757647134;
 Mon, 09 Mar 2020 05:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200303094813.142288-1-omosnace@redhat.com> <CAEjxPJ5rMJZhCE=N8HzbGRUJ+X+e7zwJW=XucUpd7zvaghA=RA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5rMJZhCE=N8HzbGRUJ+X+e7zwJW=XucUpd7zvaghA=RA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 9 Mar 2020 08:42:23 -0400
Message-ID: <CAEjxPJ5zi3PCcRGgaejJvOdK+E5KjzuMrMjqrndtZyDfZ-eHxw@mail.gmail.com>
Subject: Re: [PATCH] Revert "libsepol: cache ebitmap cardinality value"
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 3, 2020 at 2:15 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Mar 3, 2020 at 4:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This reverts commit 542e878690ea1e310bed9adda6dcb28ca8cd1d53.
> >
> > After 6968ea977501 ("libsepol: make ebitmap_cardinality() of linear
> > complexity"), the caching only saves ~0.06 % of total semodule -BN
> > running time (on x86_64 without using the POPCNT instruction), so it's
> > no longer worth the added complexity.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Applied.
