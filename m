Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CFCC433FE
	for <selinux@archiver.kernel.org>; Mon, 31 Jan 2022 16:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380218AbiAaQQY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380155AbiAaQQO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jan 2022 11:16:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34534C061401
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 08:16:14 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jx6so44957716ejb.0
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 08:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmMfeMOSCoAqBhA7BUwY3tTWcLdWTL1PSKYY7qnHSNo=;
        b=GRVTCtzu9/MyTVuHPjTnQ0zxTS6EdpUso5MVxp1FHPJAu+cQfMtGjsj1EGc053Re66
         HJw78dmJitgpCkRH2aNJ79u+EOoEtA475Pp0mIDQRgpMvUauy7YdyKBf1LyvFL9iBpuq
         dVkCxouvtRDEFM5eN6A38VlYveIKLSMqWpJSOacxAwyxO9jptgAi5E6yqr1yGSQXZBpx
         TXQ6z4K8eSo7miaPpr1Mfo0C7GdRius8EJM0YqnCK1WRdRyHuX0jw76vxH18QVaPfOcs
         8Mx91M/OXiYQnO2wAtw7rLcdRF+51Vn/SJafIABc4WKLX6zN9UJ06Ku91Gd/ZTEvj9+X
         KJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmMfeMOSCoAqBhA7BUwY3tTWcLdWTL1PSKYY7qnHSNo=;
        b=2CKILQgrlXael5XrbYpgbKbzUna8ZZf25Bx7S5WGMkt3KL0kIVSvADiQP9+jnWp285
         GZxEFAIWldhlLuDNIaYAspz3xdxUQlsqNr7itBZvh9h46KidUw+DlqnNPEc1bU8w6ZyN
         rMaCx5k6lmEl17HubUi6ZfiRaDX/+l/CslifRA9xy7NjfYjuGLUBJb6EIq9JJeDB83es
         rYyrtYqttN7cQLAo3M6lYk3Ofl2Yim6vwN1rRhuZHjjDbUaZUnhBlShEQSYPALmektfZ
         eiscXkn7oj+W0XH2vOGTUPvn7OuOBOlFu+bLJKEE43x98gyqTHIlbeGcswEqpvu9M8yW
         vMfA==
X-Gm-Message-State: AOAM533Sz9YWIQIXrjWgdKQG2MbR/gba0znGjNZMj6NpsXu6HtAnimVO
        xBzsm0yHZOtI/X68FtBSMzx05PAEmRM29QuXV/B3
X-Google-Smtp-Source: ABdhPJxq72VkfEyMRdYvqdL8DBh09y6vJc7UuNH+cjMYMvqj8xzzu7N5A30X1zKYjBRhbE33sZLKMDvkmFkjAMIsqsA=
X-Received: by 2002:a17:906:1e06:: with SMTP id g6mr17519185ejj.517.1643645772623;
 Mon, 31 Jan 2022 08:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
 <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com> <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Jan 2022 11:16:01 -0500
Message-ID: <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com>
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

On Mon, Jan 31, 2022 at 7:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > I wonder if we could make this all much simpler by *always* doing the
> > > label parsing in selinux_add_opt() and just returning an error when
> > > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > > options were always passed directly to the mount(2) syscall, so it
> > > wasn't possible to pass any SELinux mount options before the SELinux
> > > policy was loaded. I don't see why we need to jump through hoops here
> > > just to support this pseudo-feature of stashing an unparsed label into
> > > an fs_context before policy is loaded... Userspace should never need
> > > to do that.
> >
> > I could agree with that, although part of my mind is a little nervous
> > about the "userspace should *never* ..." because that always seems to
> > bite us.  Although I'm struggling to think of a case where userspace
> > would need to set explicit SELinux mount options without having a
> > policy loaded.
>
> I get that, but IMO this is enough of an odd "use case" that I
> wouldn't worry too much ...

I understand, but seeing as I'm the only one that defends these things
with Linus and others lets do this:

1. Fix what we have now using Scott's patches once he incorporates the feedback.
2. Merge another patch (separate patch(set) please!) which does the
parsing in selinux_add_opt().

... this was if we have to revert #2 we still have the fixes in #1.

-- 
paul-moore.com
