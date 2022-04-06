Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B37C433FE
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiDFQDY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiDFQDK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 12:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 362FF4781DE
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649252051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqJrO6dmU5SvkPcGw8UCuWuh5/5NxvMZsaumTowIu8c=;
        b=XayyjZV8LUoA1PLyX9HsXMdMLGZaFEXs0y+MHC/k2malIRQa8pIxqmDgyGvWDCDryJrUpc
        Enc/tNBWsdHmbB9EHf2l0XJCfsFvXaJl7RKNzwGy3O4DMM+g7mtqAEEbaq2dU9Dukiwd+j
        /qgYJoKIZpq+sZAiLqas7cSpOBdoH8o=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-sFrwPoH1N6OzBIh6UQHJlQ-1; Wed, 06 Apr 2022 09:34:09 -0400
X-MC-Unique: sFrwPoH1N6OzBIh6UQHJlQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-2eb689106e3so20817847b3.16
        for <selinux@vger.kernel.org>; Wed, 06 Apr 2022 06:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqJrO6dmU5SvkPcGw8UCuWuh5/5NxvMZsaumTowIu8c=;
        b=Y+1wGzBlvK0LL/Ci1QSaZ87zHPlg9oZBndIr61GdNCovwhdlo3CBOu2BXNWK68MP5h
         hK3Huh+6amCyA2qJ2BtaDNs2cXOumhf8xYGzGw2AxQ0xlIJfh2SLo+I/qIlJkhfl1cEr
         H4bX3FvKTm3Hi2W5MKR1yVEu3zSCLR1zPKnuxfjZSiOajaTjFLaKSCLrwu5iiarLqwfp
         +eSSR+xSr9d01yDf5gt/u7gama7rKkFyAAJL2KOFx2+BcmrRrervAKIJm6ikFtLCVFI0
         K2wgCBpLH9IRBCpezb1y1txPy9I8Q2mF1r1scP1/kYsh1XZsQPjxjr+pw1N6L8MYdv8S
         /qGg==
X-Gm-Message-State: AOAM532BFoPcH1MvH0FbeJKuMzCzeh5DDBzA0xCd8uIBk0uowIjVE89x
        vQKyJd1ihAo5RsCEvGChbKBvy/O4CneZf+uo1p0cai1S+Cjm4oMtgGO5+Bw/w6ZyJy0TojGs8DO
        ChDqT238xc6HZMd/s/RQRGHOibMHCEGr3vg==
X-Received: by 2002:a0d:e64d:0:b0:2e6:43f8:234f with SMTP id p74-20020a0de64d000000b002e643f8234fmr7012366ywe.12.1649252049386;
        Wed, 06 Apr 2022 06:34:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVRyzw7tB7nHauTQeSQg7Hj0WMwzeDSc4tOVfXZNCRQWMlZ043KzTYBmx0XGbMf0eIBPqtGUja+rJ6sTcquoA=
X-Received: by 2002:a0d:e64d:0:b0:2e6:43f8:234f with SMTP id
 p74-20020a0de64d000000b002e643f8234fmr7012342ywe.12.1649252049081; Wed, 06
 Apr 2022 06:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com>
 <CAFqZXNt=Ca+x7PaYgc1jXq-3cKxin-_=UNCSiyVHjbP7OYUKvA@mail.gmail.com> <CADvbK_fTnWhnuxR7JkNYeoSB4a1nSX7O0jg4Mif6V_or-tOy3w@mail.gmail.com>
In-Reply-To: <CADvbK_fTnWhnuxR7JkNYeoSB4a1nSX7O0jg4Mif6V_or-tOy3w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 6 Apr 2022 15:33:57 +0200
Message-ID: <CAFqZXNss=7DMb=75ZBDwL9HrrubkxJK=xu7-kqxX-Mw1FtRuuA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: use the correct skb for security_sctp_assoc_request
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 5, 2022 at 1:58 PM Xin Long <lucien.xin@gmail.com> wrote:
> On Mon, Apr 4, 2022 at 6:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Adding LSM and SELinux lists to CC for awareness; the original patch
> > is available at:
> > https://lore.kernel.org/netdev/a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com/T/
> > https://patchwork.kernel.org/project/netdevbpf/patch/a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com/
> >
> > On Mon, Apr 4, 2022 at 3:53 AM Xin Long <lucien.xin@gmail.com> wrote:
> > >
> > > Yi Chen reported an unexpected sctp connection abort, and it occurred when
> > > COOKIE_ECHO is bundled with DATA Fragment by SCTP HW GSO. As the IP header
> > > is included in chunk->head_skb instead of chunk->skb, it failed to check
> > > IP header version in security_sctp_assoc_request().
> > >
> > > According to Ondrej, SELinux only looks at IP header (address and IPsec
> > > options) and XFRM state data, and these are all included in head_skb for
> > > SCTP HW GSO packets. So fix it by using head_skb when calling
> > > security_sctp_assoc_request() in processing COOKIE_ECHO.
> >
> > The logic looks good to me, but I still have one unanswered concern.
> > The head_skb member of struct sctp_chunk is defined inside a union:
> >
> > struct sctp_chunk {
> >         [...]
> >         union {
> >                 /* In case of GSO packets, this will store the head one */
> >                 struct sk_buff *head_skb;
> >                 /* In case of auth enabled, this will point to the shkey */
> >                 struct sctp_shared_key *shkey;
> >         };
> >         [...]
> > };
> >
> > What guarantees that this chunk doesn't have "auth enabled" and the
> > head_skb pointer isn't actually a non-NULL shkey pointer? Maybe it's
> > obvious to a Linux SCTP expert, but at least for me as an outsider it
> > isn't - that's usually a good hint that there should be a code comment
> > explaining it.
> Hi Ondrej,
>
> shkey is for tx skbs only, while head_skb is for skbs on rx path.

That makes sense, thanks. I would still be happier if this was
documented, but the comment would best fit in the struct sctp_chunk
definition and that wouldn't fit in this patch...

Actually I have one more question - what about the
security_sctp_assoc_established() call in sctp_sf_do_5_1E_ca()? Is
COOKIE ACK guaranteed to be never bundled?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

