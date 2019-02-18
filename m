Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E55C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 03:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5632B218DE
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 03:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ooCavhmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfBRDNG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:13:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37313 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfBRDNG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Feb 2019 22:13:06 -0500
Received: by mail-lf1-f65.google.com with SMTP id n23so11185189lfl.4
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 19:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ge5n1Y0QT2y2QGjZxgdz2zR0jHBLlxtaW6nlXHRqMhQ=;
        b=ooCavhmN40myDkRf7lmFTv8SJVhfVvpZRouZzjim0vv+a/5YbKuJR6D6aiNYqtAO5b
         TtmmT8IPiZIl1NEVuKULPmiKVOA0wbsQax4+5fjBP7kDg0Gbn4YST7O76FoTC8VrdXCc
         UQU7+dTjI8BwKmtdJlj5Lu4HlJGPbZySKxsbZt+/4uxbEfGO2vcMUSm2oitzTbpt9k7D
         a+YMecTa2L2eWaHCyOcUqfsLOFOsqlo/76DmcdBawgbpziEyMFQqDHNS1oiM1rnsQ5Sy
         +6dpe4zd4k4lFCxl72gzRdVtbHCbbC36GWbvZx3CIBPohCw2guIxWOTCLebpKPhXuJoN
         tERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ge5n1Y0QT2y2QGjZxgdz2zR0jHBLlxtaW6nlXHRqMhQ=;
        b=HcufdcKNa4TC02L0/tzIGbmLftlU5ajC1MIgfbOz+4p6rVOhlW6usHFjtnP0SCAjgn
         mWmemTZ+0G+DQOAC54YsynBEu7GDaZKfe7Tf8r6XBQOlA3RG786i3ZH+r0oMKPTOAVH9
         J6SX1WWfgOAM4fB1YsQjl+JBAtmRuB+Hg2yQAT/ryPx3vunUNc64IkYYgAHskt8JXgKi
         crXHd3UsZ8TK87pqUwILMwXXHrGYUIpCwCfv0KmjW938Kq6NAARFQuep6X/trq8Zx5ZC
         6N+XYSg6EGh8cCB8AN6mt5Sqh8uuu+rwaEB8sunwnMvI31n3Dh2S9T+GZEOyZEH1C2Up
         n+/Q==
X-Gm-Message-State: AHQUAuaw8LEus8X1VEKrx8z1M1da8UISkyrqnZIaIsZ7J7Br2i6hjw81
        8988yVCC+adQyA3zjX7ePyziUZ4OI3ggsEAXy8ZbndGH8w==
X-Google-Smtp-Source: AHgI3IY1n1fVlGJ2tPz+Qlc3Jwib1sS8pzLI5o/Ih4zV4RT1Vp2amO1RcNry+9HGFtVdl3YTSKHIe5rRalWj2FiNtIc=
X-Received: by 2002:ac2:5205:: with SMTP id a5mr12690740lfl.135.1550459584250;
 Sun, 17 Feb 2019 19:13:04 -0800 (PST)
MIME-Version: 1.0
References: <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
 <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov> <87zhqxkn8a.fsf@gmail.com>
 <87r2c9klrh.fsf@gmail.com> <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
 <87lg2g97sr.fsf@gmail.com> <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
 <87h8d4974p.fsf@gmail.com> <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
 <20190216120412.GA11908@brutus.lan> <20190216121256.GB11908@brutus.lan>
In-Reply-To: <20190216121256.GB11908@brutus.lan>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 17 Feb 2019 22:12:53 -0500
Message-ID: <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift <dac.override@gmail.com> wrote:
>
> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift wrote:
> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley wrote:
> > <snip>
> >
> > >
> > > Oh, I see: scripts/selinux/install_policy.sh just invokes checkpolicy
> > > without specifying -U / --handle-unknown, so the policy defaults to deny,
> > > and that would indeed render dbus-daemon and systemd broken with that
> > > policy.  Might be as simple to fix as passing -U allow.
> >
> > I have looked a litte into this and here are some observations:
> >
> > 1. You can boot mdp as-is in permissive mode if you use `checkpolicy` with `-U allow`
> >
> > 2. You need *at least* an `/etc/selinux/dummy/seusers` with `__default__:user_u` and an accompanying `/etc/selinux/dummy/contexts/failsafe_context` with `base_r:base_t` to boot mdp in enforcing

Wow.  I didn't expect we would get to this point so quickly.

Originally my plan had been to just merge the mdp changes that Stephen
submitted, and leave the rest for some other time.  Although based on
everything in this thread, it looks like we are really close to having
something that you can build and boot without too many hacks.

> > 3. There is an issue with checkpolicy and object_r:
> >
> > PAM libselinux clients such as `login` try to associate `object_r` with the tty and fail.
> >
> > if you try to append: `role object_r; role object_r types base_t;` to policy.conf and compile that with `checkpolicy` then the `roletype-rule` does *not* end up in the compiled policy for some reason.

This sounds like a bug in checkpolicy ... ?

> > thus, you cannot log in because object_r:base_t is not valid.
> >
> > To hack around this add `default_role * source` rules to policy.conf and recompile.
> >
> > This will allow you to log into the system locally in enforcing mode.
> >
> > 4. I also noticed that fedoras' ssh seems to hardcode `sshd_net_t` for its "privsep" functionality so, while untested, you probably need an `openssh_contexts` with `privsep_preauth=base_t`

Petr, what's the deal with ssh on Fedora?

> The `install_policy.sh` script should probably also do a bash file test for `checkpolicy` and fail gracefully if its not found

-- 
paul moore
www.paul-moore.com
