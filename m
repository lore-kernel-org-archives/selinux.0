Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCCC433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 16:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiDFQlk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiDFQlJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 12:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D1241834CA
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649257489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cyjimK819yPxnZHWaFtWitdwwu7f3wgO8V+dYrrbSSE=;
        b=Ae2XWNJSCbzizM/Nbq7+FAoR8v/k0lWduZtST9bdRiPk5ENVvTeynTD8oLz1dD0enbqkWg
        uUj9dUBqhLSXz7FRXzuGicFeQZr2BR0vOGWuPJhEr0t8VqRfWz7PoQB1ppIeUVWsJKNOgi
        V9YP1mkk2druZdUx+LHIzHON+6Pl7WE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-Orv3xsXgOMaV1b9qrFgouQ-1; Wed, 06 Apr 2022 11:04:48 -0400
X-MC-Unique: Orv3xsXgOMaV1b9qrFgouQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-2dc7bdd666fso23429047b3.7
        for <selinux@vger.kernel.org>; Wed, 06 Apr 2022 08:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyjimK819yPxnZHWaFtWitdwwu7f3wgO8V+dYrrbSSE=;
        b=OG+9A6+pXz7qhq0FWpZIBWEQiGFBnkWcX6kBqRZJ7WushH4jWP+s47zRBBUbmdXO76
         pS1R/qCuafF2AWsK6D7zwfK1W6L3AHomQJglz/0bBFuGhZD622O9D2m2kizgPE4yD5Gm
         lHCcllZyN9tpRRfY7G1xZvo7Z0aa/FpwTG0Vo6DOzjh2tWJt5QeNBouVtns9mDsFRVd7
         VcxCcN2Lrmd6r+SAdF/xmnS+qGjhV6apWRNjD7A2iUWInF74yyFZLDSJF4dF/56YYXSk
         hkcnYtHlzprByU32ds6GHIDeSNO+iatkVUgxDHhbSgsYRUPqw1bntD27bnc8CI28KJok
         3iVQ==
X-Gm-Message-State: AOAM532hWjsNJDFDSC/tCzrvYZGbf8VVA+tiJ53IsUuk0V6sFPi3k/dU
        +Me5zxdrA0XN3Bd9fizGKeuBbqQvCVDUaKD+hpNlwsbyxpaMEtH63ckHE7qzvkTv5BDrJ9iOY4U
        Luh4wRAb5mdHGWfRUjFdSaM6hpxrMZ+6R7w==
X-Received: by 2002:a0d:e64d:0:b0:2e6:43f8:234f with SMTP id p74-20020a0de64d000000b002e643f8234fmr7381123ywe.12.1649257482334;
        Wed, 06 Apr 2022 08:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi57EDl8WItb74z/7L8utC2w7SXBqElEsa2UOoaaU9K5V0wWqTxRa9sp4i925j3fbv1x0UwNzKa+BI/yXXXcU=
X-Received: by 2002:a0d:e64d:0:b0:2e6:43f8:234f with SMTP id
 p74-20020a0de64d000000b002e643f8234fmr7380669ywe.12.1649257477489; Wed, 06
 Apr 2022 08:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com>
 <CAFqZXNt=Ca+x7PaYgc1jXq-3cKxin-_=UNCSiyVHjbP7OYUKvA@mail.gmail.com>
 <CADvbK_fTnWhnuxR7JkNYeoSB4a1nSX7O0jg4Mif6V_or-tOy3w@mail.gmail.com>
 <CAFqZXNss=7DMb=75ZBDwL9HrrubkxJK=xu7-kqxX-Mw1FtRuuA@mail.gmail.com> <CADvbK_ciV+evm6JY=uVpsHn1W-Cevp+FRzaQtxJO-CpQ392htQ@mail.gmail.com>
In-Reply-To: <CADvbK_ciV+evm6JY=uVpsHn1W-Cevp+FRzaQtxJO-CpQ392htQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 6 Apr 2022 17:04:25 +0200
Message-ID: <CAFqZXNvk0i+WC8O=BhETCPYgaKm1zE29JQHfMety8CA7EKhDtg@mail.gmail.com>
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

On Wed, Apr 6, 2022 at 4:21 PM Xin Long <lucien.xin@gmail.com> wrote:
> On Wed, Apr 6, 2022 at 9:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Tue, Apr 5, 2022 at 1:58 PM Xin Long <lucien.xin@gmail.com> wrote:
> > > On Mon, Apr 4, 2022 at 6:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Adding LSM and SELinux lists to CC for awareness; the original patch
> > > > is available at:
> > > > https://lore.kernel.org/netdev/a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com/T/
> > > > https://patchwork.kernel.org/project/netdevbpf/patch/a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com/
> > > >
> > > > On Mon, Apr 4, 2022 at 3:53 AM Xin Long <lucien.xin@gmail.com> wrote:
> > > > >
> > > > > Yi Chen reported an unexpected sctp connection abort, and it occurred when
> > > > > COOKIE_ECHO is bundled with DATA Fragment by SCTP HW GSO. As the IP header
> > > > > is included in chunk->head_skb instead of chunk->skb, it failed to check
> > > > > IP header version in security_sctp_assoc_request().
> > > > >
> > > > > According to Ondrej, SELinux only looks at IP header (address and IPsec
> > > > > options) and XFRM state data, and these are all included in head_skb for
> > > > > SCTP HW GSO packets. So fix it by using head_skb when calling
> > > > > security_sctp_assoc_request() in processing COOKIE_ECHO.
> > > >
> > > > The logic looks good to me, but I still have one unanswered concern.
> > > > The head_skb member of struct sctp_chunk is defined inside a union:
> > > >
> > > > struct sctp_chunk {
> > > >         [...]
> > > >         union {
> > > >                 /* In case of GSO packets, this will store the head one */
> > > >                 struct sk_buff *head_skb;
> > > >                 /* In case of auth enabled, this will point to the shkey */
> > > >                 struct sctp_shared_key *shkey;
> > > >         };
> > > >         [...]
> > > > };
> > > >
> > > > What guarantees that this chunk doesn't have "auth enabled" and the
> > > > head_skb pointer isn't actually a non-NULL shkey pointer? Maybe it's
> > > > obvious to a Linux SCTP expert, but at least for me as an outsider it
> > > > isn't - that's usually a good hint that there should be a code comment
> > > > explaining it.
> > > Hi Ondrej,
> > >
> > > shkey is for tx skbs only, while head_skb is for skbs on rx path.
> >
> > That makes sense, thanks. I would still be happier if this was
> > documented, but the comment would best fit in the struct sctp_chunk
> > definition and that wouldn't fit in this patch...
> >
> > Actually I have one more question - what about the
> > security_sctp_assoc_established() call in sctp_sf_do_5_1E_ca()? Is
> > COOKIE ACK guaranteed to be never bundled?
> COOKIE ACK could also be bundled with DATA.
> I didn't change it as it would not break SCTP.
> (security_inet_conn_established() returns void)
> But I don't mind changing it if you think it's necessary.

security_inet_conn_established? Are you looking at an old version of
the code, perhaps? In mainline, sctp_sf_do_5_1E_ca() now calls the new
security_sctp_assoc_established() hook, which may return an error. But
even if it didn't, I believe we want to make sure that an skb with
valid inet headers and XFRM state is passed to the hooks as SELinux
relies on these to correctly process the SCTP association.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

