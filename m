Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04446C6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 14:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCTONm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCTONl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 10:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE622128
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679321577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq8p7PRzTvFgsGBUkgAMRPWUYmN2kFzstaZWSqrTJXs=;
        b=WYftMf/8hn0UzDhBk+5qSacaYLtuJLdyHZ9DIzpBM917xsLJYx3ae02iS8mFu2TQgK7/hF
        yoCbr7Y1/oS/PEqqSpTJf2guEieg77tahtVnamQnPKmGlX0EK58HZJLqAZ1uTDU7QCd1xl
        48tRzCPPCb/i/3NsOFKC6uvWarIgC8I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-99vcc1JoMDyaOAE-fRGfiw-1; Mon, 20 Mar 2023 10:12:55 -0400
X-MC-Unique: 99vcc1JoMDyaOAE-fRGfiw-1
Received: by mail-pj1-f70.google.com with SMTP id cp21-20020a17090afb9500b0023c061f2bd0so6937132pjb.5
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 07:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq8p7PRzTvFgsGBUkgAMRPWUYmN2kFzstaZWSqrTJXs=;
        b=AUvL8gvtgAi5cNYXwh9WA2MEXbjDl7XmSYC/LlqepKcXFl23RUfTIFu2HuxJSjgcqm
         OsFhVkYAxy+UvHww20QzKvv67fw7OFcQrYcAJF+MtG0LwAvJQy/Xzc+uMBGeUQ5CB+Xv
         qe9j3e492LvJPv8eHOGUFuBFSDCHTsB5H6F6xo7gCPwwxMfWpjZnyEBC2Btzv0a7XYfN
         hs7rxJC6tIggj84BBCC7PVqFixOMYnd7YN/m6VGxiSko/u7hh0JN7IQMRnRSDCuQpRB9
         rgmvb9Zc1WZv/VQ1a/mgV2u44BTPTfL3iCV3NhVbvz7Q6fBhvjDcLC367I5oLFgZi4qO
         6ZgQ==
X-Gm-Message-State: AO0yUKUChgK1gxL/v5MIM+X57uHdYDbId8z18vnFe6sjMHVeDupRYbE1
        mNlZ1385jlxJLWzWcMT9Xh4cPAcvtJ+aFktHrpY17aN7SkGSyT/JiU25kKBS17n54paVOShZTL8
        DktOAoVBgPc4hGszD65f1VdTtWkOCs+qKAfkBW//2WZajYps=
X-Received: by 2002:a17:902:ecc6:b0:1a1:c7ea:969f with SMTP id a6-20020a170902ecc600b001a1c7ea969fmr2181655plh.2.1679321574505;
        Mon, 20 Mar 2023 07:12:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+9aCUG+w4H2cV5VHaLu8LO4tiK8CJgUflKj2I6+eFvn0SScCUwfd6s6xuaO2anpQR+xZP0Capqpa/x5W2mf+g=
X-Received: by 2002:a17:902:ecc6:b0:1a1:c7ea:969f with SMTP id
 a6-20020a170902ecc600b001a1c7ea969fmr2181645plh.2.1679321574234; Mon, 20 Mar
 2023 07:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl>
In-Reply-To: <871qljfrtz.fsf@defensec.nl>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 20 Mar 2023 15:12:42 +0100
Message-ID: <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 2:59=E2=80=AFPM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >>
> >> Hi,
> >>
> >> I was reading this pull request [1] and looked into how I might be abl=
e
> >> to implement this in policy but there seem to be some technical
> >> difficulties.
> >>
> >> * I already use getfscon to seperate the systemd user.slice because th=
e
> >>   system manager delegates the user.slice to the user manager.
> >>
> >>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
> >>
> >>   In the past the proved to be a racy where systemd attempts to
> >>   write before the object has the context associated with the genfscon=
.
> >
> > I don't understand how this could be racy - genfscon-assigned contexts
> > should be assigned when the dentry is first instantiated via
> > inode_donit_with_dentry and therefore the inode shouldn't be
> > accessible to userspace prior to this initial assignment AFAIK.
> > Possibly I am missing something.
>
> I recall encountering this sporadically, but I admit that it has been a
> while since I supressed it in policy. I might try to reproduce. AFAIK my
> policy is the only policy that actually labels some trees on cgroup2 fs
> with private types currently.
>
> >
> >>   I decided to dontaudit attempts to write to the mislabeled object an=
d
> >>   it *seems* as if systemd retries until it can write it i.e. when the
> >>   object carries the expected label and so that seems to work eventual=
ly
> >>   but it looks fragile.
> >>
> >> * The challenge with memory pressure implementation [2] is that these
> >>   "memory.pressure" files end up in random locations under
> >>   "/system.slice" for example:
> >>
> >>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
> >>
> >>   Where in the above systemd-journald.service might be
> >>   templated (systemd-journald@FOO.service). Point is that the path is
> >>   random. genfscon does not support regex and glob. I can't do for exa=
mple:
> >>
> >>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
> >>   cgroupfile_context)
> >>
> >>   Fortunately cgroup2fs supports relabeling but if systemd has to
> >>   manually relabel the cgroup files then I would imagine that this is
> >>   racy as well, and that does not really solve the underlying issue.
> >>
> >>   I am looking for ideas and suggestions
> >
> > Optimally one of two things would happen:
> > 1. The kernel would label the inode correctly when it is first created
> > (e.g. by augmenting genfscon to support more general matching), or
> > 2. The userspace component that creates these files would label them
> > correctly at creation (via setfscreatecon() prior to creation).
>
> Agree but 1. would require regex/glob support for genfscon and 2. these
> files aren't "created" by userspace AFAIK and so setfscreatecon or
> automatic object type transitions are probably not an option here.
>
> >
> > Pardon my ignorance but what creates these files initially? The kernel
> > in response to some event or systemd or some other userspace
> > component?
>
> Yes AFAIK it is the former (psuedo filesystem similar to procfs, debugfs
> in that sense). This is also why I don't think that the PR mentioned is
> tested because cgroup2 fs labeling is done with genfscon and not fsuse
> trans or fsuse xattr so even if the files would be created by
> userspace (which I think is not the case) the specified automatic object
> type transition rule wouldnt work.

Actually, type transitions on cgroupfs should work - I added special
hooks for kernfs just for that some time ago - see kernel commits
d0c9c153b4bd6963c8fcccbc0caa12e8fa8d971d..e19dfdc83b60f196e0653d683499f7bc5=
548128f.

Not sure what's behind the genfscon label assignment race, though.

>
> I think eventually we currently probably have little choice but to make s=
ystemd
> reset the context of said cgroup file manually. Just wanted to see if
> there are alternatives.
>
> >
> >> [1] https://github.com/SELinuxProject/refpolicy/pull/607
> >> [2] https://github.com/systemd/systemd/blob/main/docs/MEMORY_PRESSURE.=
md
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
>


--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

