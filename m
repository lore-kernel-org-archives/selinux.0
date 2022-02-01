Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150CEC433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiBAOig (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:38:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239387AbiBAOig (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 09:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643726315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yP1bs/cD6ul5vF2aW3mHYFKWpId1PYYPSFAUCUmS+ys=;
        b=JlSzjvZbIv2eCQUcY1lQqNKW7xrVJG7XwIPBqf0rPUwGu1BJZfRJUBb2T2gMN4E15eSe1i
        fDKDZxiOy68TjE5NiJ12KBx8UW7jkO/n9oclwrUKBo6472/ACyKshglDfPAckLoXPJqRa9
        ObslTB1niOpPrDaZsAO+ymqcKzikzRA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-uZE5T9-vOh-WzLWuGzxTKA-1; Tue, 01 Feb 2022 09:38:34 -0500
X-MC-Unique: uZE5T9-vOh-WzLWuGzxTKA-1
Received: by mail-yb1-f197.google.com with SMTP id e130-20020a255088000000b006126feb051eso33464563ybb.18
        for <selinux@vger.kernel.org>; Tue, 01 Feb 2022 06:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP1bs/cD6ul5vF2aW3mHYFKWpId1PYYPSFAUCUmS+ys=;
        b=3JA+8K4AHeOmpnt0H1HKaPBI5tEr0Qr0GIbcXIZWPBYV5/QDv0MedsmNmtCzPgB4zW
         zNMi8IpFekmfzXdytbTFWa67lIBuKT7Va1ru5K/lIzm0xFSTf2NQf8p0tjAuDN5e743t
         4lIWZZ224QcM9bYUNJv3A4+yhPCMntvSvA5TiQt2c5lglR2wzVnas/KFOt0HP7TAUDoV
         WwTZHV3WXWumS9+ZJPhzlQ9VckFf7ql6V+azvj3ONy3U2Mbh4vk7s5b+RR1WzsFtWTB1
         NyTk8U/Fet1MPB673P7EPdShCNmJbu7pdsc7RifDTE2akvaBoYJHBzY0M98+kNmf3qCc
         W7xA==
X-Gm-Message-State: AOAM530V1T3DsSwv+oHiuE1dXyEzD48e3tuS1yUuRzkpipcko7l6agIR
        xw9xLb0F3uuoYnGcI2JQxMysg9jAWXlHW14xDSgmA/f2MU30NCgB+iSRmUsh4fU+ffocm10UWyT
        S7gC75foKs+ttze+xy1guFtgWu6gXki6bVQ==
X-Received: by 2002:a25:7382:: with SMTP id o124mr34766809ybc.318.1643726313973;
        Tue, 01 Feb 2022 06:38:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxAXD5P65F6JW0OiYGwB7dqy0nRCCl4tn2Upv5lN7vsS5B73WmEMitmQBqmvRWfJpdSzuWlZrc30QHIx/QgY4=
X-Received: by 2002:a25:7382:: with SMTP id o124mr34766786ybc.318.1643726313750;
 Tue, 01 Feb 2022 06:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
 <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
 <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com> <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 1 Feb 2022 15:38:16 +0100
Message-ID: <CAFqZXNs7P+p0B-uZ2owMH1qa04unbq870tMqQ4Kwup7dXJ9z=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 31, 2022 at 5:16 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Jan 31, 2022 at 7:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > I wonder if we could make this all much simpler by *always* doing the
> > > > label parsing in selinux_add_opt() and just returning an error when
> > > > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > > > options were always passed directly to the mount(2) syscall, so it
> > > > wasn't possible to pass any SELinux mount options before the SELinux
> > > > policy was loaded. I don't see why we need to jump through hoops here
> > > > just to support this pseudo-feature of stashing an unparsed label into
> > > > an fs_context before policy is loaded... Userspace should never need
> > > > to do that.
> > >
> > > I could agree with that, although part of my mind is a little nervous
> > > about the "userspace should *never* ..." because that always seems to
> > > bite us.  Although I'm struggling to think of a case where userspace
> > > would need to set explicit SELinux mount options without having a
> > > policy loaded.
> >
> > I get that, but IMO this is enough of an odd "use case" that I
> > wouldn't worry too much ...
>
> I understand, but seeing as I'm the only one that defends these things
> with Linus and others lets do this:

It's not all black and white:
https://lore.kernel.org/lkml/Pine.LNX.4.64.0512291322560.3298@g5.osdl.org/

> 1. Fix what we have now using Scott's patches once he incorporates the feedback.
> 2. Merge another patch (separate patch(set) please!) which does the
> parsing in selinux_add_opt().
>
> ... this was if we have to revert #2 we still have the fixes in #1.

Sounds good to me. I can prepare the simplification patch. If anyone
does come to complain, then by all means, let's revert it.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

