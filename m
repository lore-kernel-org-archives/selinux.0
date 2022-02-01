Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E11C433EF
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiBAQTv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 11:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbiBAQTu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 11:19:50 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CBC06173D
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 08:19:50 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so55822428eje.10
        for <selinux@vger.kernel.org>; Tue, 01 Feb 2022 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/EA0AhkWiFaOwwty7mH2hCCiTOvQntxOFT+Uv9r6mI=;
        b=lmzPqOHdxn0hc7dFBLY3SQkUuN8/E5zgkhWuFYNNCZY80fRqKvZZiHLjCZFSELf5wt
         fBfAaoq3b5L6sfZamRJ4r9as5w9m2yn2x5kjVQH91u5qzkU4B0X3l8pb4YSIgvY2YQoU
         hLYOHsig6gFhE8uLZXKQjCQGUZdYl3Z4dWDXS94KelY+TVFaf6ZQT+FTU8h0b8OgyVSF
         +vMc/E1jLaqNPkoLezOjgnDMC9VeuCZPuSrCLTTlT2tOaNLt4ZbNIDH7tRFJJF+KWag/
         wG5J3E4/omZOqv7+krqB1k+rt7bzjHGeCvrcOEBpozUkZsDcRNHQwrGH26s3VqMOjExc
         cGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/EA0AhkWiFaOwwty7mH2hCCiTOvQntxOFT+Uv9r6mI=;
        b=KpZoGICe6t7ceeLNtJMuSNjJVnhEGyJR4blZTl0WcyLxO2qfA0IfRz1g0avD0V6d6b
         RiCa4RpgPvMAuxRx7x9jEmXGFbYuR8rWEt0JHJG2z/6nRq9iQz4C6/pw61MTmCXqCXhi
         BVQbIy5FNtP8iUK8v35Pf7smohelrB5PpHYE4WHV9pDxAd6I2hgHwKbsITl7MRbcN80J
         OgPCSX00Zc6SIjIobj9F+EmyEkBILD7NqdQDkHl6UijIPqBnbEaD9ULMIx8qtzZhWX2O
         XXO7ZbLE20IfsLvFWqBYFUi8vfVvCWvXCtdSW9xltMP8wJIxB32O/nD9ervv6aBSCkL7
         SRUg==
X-Gm-Message-State: AOAM532Re4zv6NG796CeYbRac+IrzFOycW0fzlNWUSZVH1o5vmmyRKiZ
        iKQVjdNUQu4AmgxD0MFOGLeVTRpQ3DfVsGH/9318
X-Google-Smtp-Source: ABdhPJyY2QWbw9iTiEYwXUoRKlv8CqDxjUmVAK+5MN19fpdlGU198KTmUcBPwAV5FDqPW4wyhtc7GkW+of0Vio0Kkrg=
X-Received: by 2002:a17:906:2ed0:: with SMTP id s16mr21589608eji.327.1643732388897;
 Tue, 01 Feb 2022 08:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
 <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
 <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com>
 <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com> <CAFqZXNs7P+p0B-uZ2owMH1qa04unbq870tMqQ4Kwup7dXJ9z=g@mail.gmail.com>
In-Reply-To: <CAFqZXNs7P+p0B-uZ2owMH1qa04unbq870tMqQ4Kwup7dXJ9z=g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 11:19:37 -0500
Message-ID: <CAHC9VhRAPb8PV08fYd-GOY+ZeKX6r+rmGw_Okrwwj6ESTVDYmA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 1, 2022 at 9:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Jan 31, 2022 at 5:16 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Jan 31, 2022 at 7:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > I wonder if we could make this all much simpler by *always* doing the
> > > > > label parsing in selinux_add_opt() and just returning an error when
> > > > > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > > > > options were always passed directly to the mount(2) syscall, so it
> > > > > wasn't possible to pass any SELinux mount options before the SELinux
> > > > > policy was loaded. I don't see why we need to jump through hoops here
> > > > > just to support this pseudo-feature of stashing an unparsed label into
> > > > > an fs_context before policy is loaded... Userspace should never need
> > > > > to do that.
> > > >
> > > > I could agree with that, although part of my mind is a little nervous
> > > > about the "userspace should *never* ..." because that always seems to
> > > > bite us.  Although I'm struggling to think of a case where userspace
> > > > would need to set explicit SELinux mount options without having a
> > > > policy loaded.
> > >
> > > I get that, but IMO this is enough of an odd "use case" that I
> > > wouldn't worry too much ...
> >
> > I understand, but seeing as I'm the only one that defends these things
> > with Linus and others lets do this:
>
> It's not all black and white:
> https://lore.kernel.org/lkml/Pine.LNX.4.64.0512291322560.3298@g5.osdl.org/

I made my statement above not to ask your opinion, but rather to make a point.

-- 
paul-moore.com
