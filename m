Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B289C433E9
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7CF23159
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 16:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbhAFQCQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbhAFQCP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 11:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609948848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsG/0128DEHso7ySIds7bt6NrN3WlFqp1tspYc4qO0U=;
        b=AiX4UDRkMOP1yo7D6zPE/O8A7HQYtiPyrSlAeocR6pJMHPx1OKz4XNgSfd9ww1VsgcD1tE
        zM7K1soTDknl+xFbe1Ja8BMR+BEz6kXYlBsDhWZlIOYHlMD7fAy4TcPltt4RtrEXB5WZim
        d0NKYKVUyx2Vtr1yTWGQ/8eb+p9EkW8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-0kdaEl6SN2aUY11WpV3ARA-1; Wed, 06 Jan 2021 11:00:46 -0500
X-MC-Unique: 0kdaEl6SN2aUY11WpV3ARA-1
Received: by mail-lf1-f69.google.com with SMTP id x186so4607820lff.7
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 08:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsG/0128DEHso7ySIds7bt6NrN3WlFqp1tspYc4qO0U=;
        b=ntFazq17OZg4m5AX8HStR4hgUfmFQYwYq5Mrh+5QI2aUBiAHIJzsouyj5Bm+3BB9Bh
         x4im0go986688ba752+eI9pOO1+QchiGSrEP3QJh0THu+1oKPu8wLzXbHySEV5ebUqD2
         j8Le2uOT+VMRDn2IrgRvr3XCyc7CzqWB5umwPE2mJLmmhuKJ4ciZE3vO6Rk33I21zmQp
         DCjfMchS9HWacvojIQz8oCnD4itGA+lGenygo02bZZc/WIRPrFiBfC0+kh/HURtBTLOm
         zP/2rUEDzBPTbr6faKpFe5XpBM1ED0sIuApkZ7XpkMW6qVOtKUEm4iiNeGT7vLSbz69d
         1Zfw==
X-Gm-Message-State: AOAM531JGkyISGWmmLuB7YYHJBklCH6lSh7tmHXBnhi5MmZlxxz6Ibxe
        PRzBdu/a1fw8EHODzWRD+/npFAQ/f+4ds91ExoaCI0r/2g1+wTBxE+Siqf3sp7v4HcF/bMzyFRQ
        ByBqsEGhOps+BzAuOIUN2lX6ib09s0KHvWw==
X-Received: by 2002:a2e:85c1:: with SMTP id h1mr2252627ljj.127.1609948842969;
        Wed, 06 Jan 2021 08:00:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBWmm8mjZDY27M8q5dj23zvy3wmOQSdwiWDurBpF24MAFfkaWtttIqBIwFVkc4PhyzaNpPXuEqXBxaPRXQimQ=
X-Received: by 2002:a2e:85c1:: with SMTP id h1mr2252621ljj.127.1609948842807;
 Wed, 06 Jan 2021 08:00:42 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
 <ypjlzh1o523g.fsf@defensec.nl> <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
 <ypjlv9cc50hj.fsf@defensec.nl> <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
 <ypjla6tmgoka.fsf@defensec.nl> <CAP2OjcjOEXsWM1H2pkMzhb3y2ss7SCTw8_1Tsb23kUnEDVfx-g@mail.gmail.com>
 <ypjl5z4agmt4.fsf@defensec.nl> <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
 <ypjlsg7ef6nh.fsf@defensec.nl> <CAP2Ojcg5d=i0FKM0f1DTqtT2N3ftKEEqJq4=zdZr4m22xn4zjA@mail.gmail.com>
 <ypjlo8i2f519.fsf@defensec.nl>
In-Reply-To: <ypjlo8i2f519.fsf@defensec.nl>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 6 Jan 2021 17:00:26 +0100
Message-ID: <CAFqZXNuUdij1v4yvSvpLJPi+0KSFSR46k+c52E3=QdF-f_C9yQ@mail.gmail.com>
Subject: Re: Selinux context type is same for root & normal user both
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ashish Mishra <ashishm@mvista.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 4:40 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Ashish Mishra <ashishm@mvista.com> writes:
>
> > Hi Dominick ,
> >
> > Will look at the re-labelling as you suggested.
> > Is there any doc / blog / implementation etc to understand the
> > sequence and commands to do this.
> > To understand this step in a better way.
> >
> > We are working with such a setup freshly so any inputs / guidance will
> > be helpful.
> >
> > Thanks for your time & inputs for this long thread .
>
> For docs i would suggest selinuxproject.org and
> https://github.com/SELinuxProject/selinux-notebook/blob/main/src/toc.md
>
> For implementations i would suggest looking at how OpenWrt implemented
> SELinux as this is a very simple implementation and the target seems to
> be relatively similar to yours with the exception that OpenWrt does not
> use a volatile root but instead uses a read-only squashfs and a overlay.
>
> You can also look at Fedora CoreOS for inspiration, and Googles SEAndroid.
>
> Implementing meaningful SELinux for exotic use cases like yours is not
> trivial though IMHO. Using reference policy as a base-policy might not
> be optimal for your use-case (to say the least) and it would probably be easier to create a
> policy from scratch instead in the longer run.

Well said. I'll just add that you'll at the very least need to remove
the "genfscon" rule for "rootfs" from your policy and replace it with
an appropriate "fs_use_xattr" one to be able to relabel the root
filesystem. (Assuming it uses tmpfs under the hood (or supports
xattrs), otherwise you may need to mount tmpfs somewhere and chroot
into it at the beginning of your init script. Or something like
that...)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

