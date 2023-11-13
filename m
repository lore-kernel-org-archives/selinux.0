Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0283C4167D
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 03:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjKMDtF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Nov 2023 22:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjKMDtE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Nov 2023 22:49:04 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB02172B
        for <selinux@vger.kernel.org>; Sun, 12 Nov 2023 19:48:59 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a82f176860so46048847b3.1
        for <selinux@vger.kernel.org>; Sun, 12 Nov 2023 19:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699847339; x=1700452139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VECjXZvEz9F/cziS1IeNLo8/3SZHswbem1JCZfRASWA=;
        b=ZnbXTZQfAUPiNt/IUDOFeBFaiYo2DGpmTa8MAlUPYUkb8AUFuB7OUHd6V5Q/yfdAqw
         yS8E3yBTw11xDB+iZk3zT9ynnC9EdEc+rvdvtii0FbwNCVu03i5WyOzYkOLc5cbiHTqm
         at11SDD20MGQSV4Lcn4YGDndH7OgdyiZHvjCbSScvjP/pvNr3NT8VIIubd0M2BQwtVl+
         qCxg0CZshrsvgReCqNbcs8eZLxdxcY23eOHLGcbAY/MSstO5pP/Ib1Mw1uMZmzMoO+uJ
         vG27l/HOZMIla4+WdcsBgtsAa1Zt+81MCCkxci8LmcJnyW8BDRV4lNpyLPnIjqLqWkxs
         bTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699847339; x=1700452139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VECjXZvEz9F/cziS1IeNLo8/3SZHswbem1JCZfRASWA=;
        b=saVcpNqCE0toQeOjoRL+N0NEU2D1miLj6+pkMFcVVbRT9Xh8RdVUicSYC8NgmSx2+i
         5FSUe6mxZMUYaS/RUiqG2Fe6SvEmhP+wMMEef6cjE3vTiqcdklRemPszRjMXRn9jK09X
         obDupiECncPDgqYKPlR8jkaIpzoIF5swxgmI+WOaN/vizJ7IE8gVsBI4gbYQnYrgJsa3
         IZbKDbRdTGIRwt/vP4aNLDPgoWnzqufBDTuMxJymIStm3eVFZ0XSMUE5Ty93Hih0jjbp
         7VWtbLp2AKz18/nAgrBXK2IwqC5NNhSqNx++RMOl0XmGQQfgTncYvbXGVarCzW8xV3Ux
         qj0g==
X-Gm-Message-State: AOJu0YxvElQvSyLKOip4dcwhNKgqMYzVXWdeo45FNVwroblEsFeLQN7u
        wAHxm0YMwkhJPvBhP2wvgmjNqL1Byt16S+9a41Y/
X-Google-Smtp-Source: AGHT+IHJ2P1y2xo1Cet4L5ZfvkWuVLiWBQQ/A8LeQYJMga3tSnL4pKwHB5qBHcraxVL+wij0UVbabpG6UEM9GUHFmyQ=
X-Received: by 2002:a25:69c7:0:b0:d9b:87f3:54f9 with SMTP id
 e190-20020a2569c7000000b00d9b87f354f9mr5022379ybc.28.1699847338744; Sun, 12
 Nov 2023 19:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTToc-rELe0EyOV4kRtOJuAmPzPB_QNn8Lw_EfMg+Edzw@mail.gmail.com>
 <20231018043532.GS800259@ZenIV> <CAEjxPJ6W8170OtXxyxM2VH+hChtey6Ny814wzpd2Cda+Cmepew@mail.gmail.com>
In-Reply-To: <CAEjxPJ6W8170OtXxyxM2VH+hChtey6Ny814wzpd2Cda+Cmepew@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 22:48:48 -0500
Message-ID: <CAHC9VhRLYUR+PyZ9hmNZxYQysXWFA0Wz6L50GV+UOts20jJJmg@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 19, 2023 at 9:10=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Oct 18, 2023 at 12:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> >
> > On Tue, Oct 17, 2023 at 04:28:53PM -0400, Paul Moore wrote:
> > > Thanks Al.
> > >
> > > Giving this a very quick look, I like the code simplifications that
> > > come out of this change and I'll trust you on the idea that this
> > > approach is better from a VFS perspective.
> > >
> > > While the reject_all() permission hammer is good, I do want to make
> > > sure we are covered from a file labeling perspective; even though the
> > > DAC/reject_all() check hits first and avoids the LSM inode permission
> > > hook, we still want to make sure the files are labeled properly.  It
> > > looks like given the current SELinux Reference Policy this shouldn't
> > > be a problem, it will be labeled like most everything else in
> > > selinuxfs via genfscon (SELinux policy construct).  I expect those
> > > with custom SELinux policies will have something similar in place wit=
h
> > > a sane default that would cover the /sys/fs/selinux/.swapover
> > > directory but I did add the selinux-refpol list to the CC line just i=
n
> > > case I'm being dumb and forgetting something important with respect t=
o
> > > policy.
> > >
> > > The next step is to actually boot up a kernel with this patch and mak=
e
> > > sure it doesn't break anything.  Simply booting up a SELinux system
> > > and running 'load_policy' a handful of times should exercise the
> > > policy (re)load path, and if you want a (relatively) simple SELinux
> > > test suite you can find one here:
> > >
> > > * https://github.com/SELinuxProject/selinux-testsuite
> > >
> > > The README.md should have the instructions necessary to get it
> > > running.  If you can't do that, and no one else on the mailing list i=
s
> > > able to test this out, I'll give it a go but expect it to take a whil=
e
> > > as I'm currently swamped with reviews and other stuff.
> >
> > It does survive repeated load_policy (as well as semodule -d/semodule -=
e,
> > with expected effect on /booleans, AFAICS).  As for the testsuite...
> > No regressions compared to clean -rc5, but then there are (identical)
> > failures on both - "Failed 8/76 test programs. 88/1046 subtests failed.=
"
> > Incomplete defconfig, at a guess...
>
> All tests passed for me using the defconfig fragment from the selinux-tes=
tsuite.

I just merged this into selinux/dev, thanks everyone.

--=20
paul-moore.com
