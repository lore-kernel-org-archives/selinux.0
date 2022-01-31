Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62769C433EF
	for <selinux@archiver.kernel.org>; Mon, 31 Jan 2022 12:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377935AbiAaMqw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jan 2022 07:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378050AbiAaMqw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jan 2022 07:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643633211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbb7oKj7pGqcFFQvVLEG96fF5LM89XRk6kAiNWwlPYQ=;
        b=M0Ar9MCOE2xJFnUP6eN2Hp8grewCNTM0SrC2DaNhW1UN03H1NibZnGy1zlAST681H7X58y
        H8JhYBvuHOAgEbsY/zX1bmGN3PLpfiRBwJaa6OTw7dXwXx2NHHZvYkmY0+C30O/sqc4z+Z
        eDu+SOpFgw0W9YloCeFsJ0m2a5CSzXc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-GHRwQ7WkOOGoEbzWqpQ8Lw-1; Mon, 31 Jan 2022 07:46:50 -0500
X-MC-Unique: GHRwQ7WkOOGoEbzWqpQ8Lw-1
Received: by mail-yb1-f197.google.com with SMTP id v70-20020a25c549000000b006130de5790aso26518100ybe.4
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 04:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbb7oKj7pGqcFFQvVLEG96fF5LM89XRk6kAiNWwlPYQ=;
        b=6CrtMJDqz2o+8aPEn0YT0kLWzvhU5j6VH89TNOzvOv/SXhyXJzJjieRcrzbiVqUDpS
         IoRkl2SasVvBf/8mfIyuTQiL/B+8yhBvr73DrQrhnPQvPhVOm3K7EZlW1ZjYyaFrTrFC
         fkCbSTE6juIoMlX4QY3xSqliWLgv58rSgFsC6LNjYjVLT5kkdekY0iQf8B7E1xg3KZAA
         vp5NRe/PFQWFMPzp1lVW+cb24AJA3wz8rN7+7T3GCK7qS4K76Wag/aOI8VvFx3yxRzv5
         MYyeJNPjXvvnvRABoPTOLnKW9TDL/8dmV6GrOT76RVZrJzvLf/1EEKC99C3w8lW+tSa/
         I2mA==
X-Gm-Message-State: AOAM533n6dvphVIPvxb1xmn5fHz23fykVkUGyTxtiY/GuSdQT654vYO8
        X5jlfHewIcoY1JpTUXvHRpjhuiOVm0E13dkJn8SB1vZWEf4Rq3pK0jUg0KY6wgdB/1R80fQOhhh
        35vxldC7vLxhbh6dn59kFKC+BKIz5N0+BBw==
X-Received: by 2002:a25:b003:: with SMTP id q3mr26931231ybf.767.1643633209484;
        Mon, 31 Jan 2022 04:46:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXf5DsrdCafeJ+jbkokGucWXiUD4d5CaBpbjPavzB13XtyY3keprMZq0LSYrIY7UgOHJXQUOmX4OcssUPQW5A=
X-Received: by 2002:a25:b003:: with SMTP id q3mr26931208ybf.767.1643633209321;
 Mon, 31 Jan 2022 04:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com> <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
In-Reply-To: <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 31 Jan 2022 13:46:32 +0100
Message-ID: <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com>
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

On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > I wonder if we could make this all much simpler by *always* doing the
> > label parsing in selinux_add_opt() and just returning an error when
> > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > options were always passed directly to the mount(2) syscall, so it
> > wasn't possible to pass any SELinux mount options before the SELinux
> > policy was loaded. I don't see why we need to jump through hoops here
> > just to support this pseudo-feature of stashing an unparsed label into
> > an fs_context before policy is loaded... Userspace should never need
> > to do that.
>
> I could agree with that, although part of my mind is a little nervous
> about the "userspace should *never* ..." because that always seems to
> bite us.  Although I'm struggling to think of a case where userspace
> would need to set explicit SELinux mount options without having a
> policy loaded.

I get that, but IMO this is enough of an odd "use case" that I
wouldn't worry too much. To be affected by this, someone would need
to:
1. Use the new mount API, which:
    a) doesn't even have man pages yet,
    b) isn't even used by the mount(8) utility yet.
2. Call fsconfig(2) with a SELinux mount option before policy is loaded.
3. Call fsmount(2) with the same fd after policy is loaded.

And racing with the policy load doesn't count - that could fail
randomly with or without the change. I honestly can't imagine any
realistic scenario where someone would do this...

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

