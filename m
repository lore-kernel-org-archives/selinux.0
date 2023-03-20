Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3CC7618D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 15:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjCTPX1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjCTPXA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 11:23:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FF28226
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 08:16:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a16so8105745pjs.4
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679325387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9+UfFEfrfB6W89xjpqxRCMyCs8p91MgO83BBKOnLyE=;
        b=BDFsaa2iY2yENvBvEIDC1/G+2Hrz1AiEdlJZWX96LT8lyOx9fB0Busb0fN39jaNcRF
         qJJx8umlSbhuHwL5upKzCO1MkaufqvrEgDiDikLR9EtvrkTxGjQ/FQiwqmUJ3qODwJ3/
         GiCCC98itGOtTr2Y8ZMxL3aqpXxha+MzgIFAUbbtxPa9dwh5ixhR0UOXbIlkpGzvMUGq
         vU+n09GVIbkeAWjyWSt5jS0XK8CIqRf8X9zEVz0ehYzd0B00di4F2620HbYXFMuiAM0Y
         TElfa0Cy3W3boawKzjKaMuNGxpoElWZI5bDq4wNDFqnbPwtU/o/NtZlUmM09cfQLCYQk
         /aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9+UfFEfrfB6W89xjpqxRCMyCs8p91MgO83BBKOnLyE=;
        b=1kVxjd393EAGSVs+bx7lDIoKXkLtpRc6bGXzR71NFuRxbuCw1RrTbvtQjgCk6vPA4D
         2A632IBP5BrT+Z2bjhI+JKPiBMjha4Ox8Y/pmHHpa8BmFM2DKRxVHFPlenWYsiq96yXn
         AhT2qjQ7atF/0jO9diH1kT3lAf1+NGc3vK2b0fP+6bPeAyfkHeQDOLogq9NLds29J7Gt
         RYpBqus0XPt3m3x/jn6L5FbVfXa0YkEOXYRaZiHE37t622RbdfqfiSf9ATFT0ZCgNoIN
         /ojBuCevWimFBOPlJQ4K2yKZQoBsBoFer0mUwLRZStnGOa+oEk+DZ57qVpiM0B09Ihbz
         +jSQ==
X-Gm-Message-State: AO0yUKUNY/r4xBdqZ1ja0Vt1DN5qFQZNNCUxv3SmM+RX+AO4OeNgRYfE
        PrbioTjd9GBMRMgCiIpAM8B8C7A6BJWBrMjMZPU=
X-Google-Smtp-Source: AK7set/vizWFCtblbRHVez1L28pLA5oS3aAqTSJLfkYzmCiwCru+yFtcwq2VabsG+ijv3R/XStVyZEPc5Aen/kPmLmA=
X-Received: by 2002:a17:90a:5988:b0:23d:35cd:725 with SMTP id
 l8-20020a17090a598800b0023d35cd0725mr4934893pji.8.1679325387337; Mon, 20 Mar
 2023 08:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
In-Reply-To: <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 11:16:16 -0400
Message-ID: <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 10:46=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> On Mon, Mar 20, 2023 at 3:19=E2=80=AFPM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > Ondrej Mosnacek <omosnace@redhat.com> writes:
> >
> > > On Mon, Mar 20, 2023 at 2:59=E2=80=AFPM Dominick Grift
> > > <dominick.grift@defensec.nl> wrote:
> > >>
> > >> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> > >>
> > >> > On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
> > >> > <dominick.grift@defensec.nl> wrote:
> > >> >>
> > >> >>
> > >> >> Hi,
> > >> >>
> > >> >> I was reading this pull request [1] and looked into how I might b=
e able
> > >> >> to implement this in policy but there seem to be some technical
> > >> >> difficulties.
> > >> >>
> > >> >> * I already use getfscon to seperate the systemd user.slice becau=
se the
> > >> >>   system manager delegates the user.slice to the user manager.
> > >> >>
> > >> >>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
> > >> >>
> > >> >>   In the past the proved to be a racy where systemd attempts to
> > >> >>   write before the object has the context associated with the gen=
fscon.
> > >> >
> > >> > I don't understand how this could be racy - genfscon-assigned cont=
exts
> > >> > should be assigned when the dentry is first instantiated via
> > >> > inode_donit_with_dentry and therefore the inode shouldn't be
> > >> > accessible to userspace prior to this initial assignment AFAIK.
> > >> > Possibly I am missing something.
> > >>
> > >> I recall encountering this sporadically, but I admit that it has bee=
n a
> > >> while since I supressed it in policy. I might try to reproduce. AFAI=
K my
> > >> policy is the only policy that actually labels some trees on cgroup2=
 fs
> > >> with private types currently.
> > >>
> > >> >
> > >> >>   I decided to dontaudit attempts to write to the mislabeled obje=
ct and
> > >> >>   it *seems* as if systemd retries until it can write it i.e. whe=
n the
> > >> >>   object carries the expected label and so that seems to work eve=
ntually
> > >> >>   but it looks fragile.
> > >> >>
> > >> >> * The challenge with memory pressure implementation [2] is that t=
hese
> > >> >>   "memory.pressure" files end up in random locations under
> > >> >>   "/system.slice" for example:
> > >> >>
> > >> >>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pre=
ssure
> > >> >>
> > >> >>   Where in the above systemd-journald.service might be
> > >> >>   templated (systemd-journald@FOO.service). Point is that the pat=
h is
> > >> >>   random. genfscon does not support regex and glob. I can't do fo=
r example:
> > >> >>
> > >> >>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
> > >> >>   cgroupfile_context)
> > >> >>
> > >> >>   Fortunately cgroup2fs supports relabeling but if systemd has to
> > >> >>   manually relabel the cgroup files then I would imagine that thi=
s is
> > >> >>   racy as well, and that does not really solve the underlying iss=
ue.
> > >> >>
> > >> >>   I am looking for ideas and suggestions
> > >> >
> > >> > Optimally one of two things would happen:
> > >> > 1. The kernel would label the inode correctly when it is first cre=
ated
> > >> > (e.g. by augmenting genfscon to support more general matching), or
> > >> > 2. The userspace component that creates these files would label th=
em
> > >> > correctly at creation (via setfscreatecon() prior to creation).
> > >>
> > >> Agree but 1. would require regex/glob support for genfscon and 2. th=
ese
> > >> files aren't "created" by userspace AFAIK and so setfscreatecon or
> > >> automatic object type transitions are probably not an option here.
> > >>
> > >> >
> > >> > Pardon my ignorance but what creates these files initially? The ke=
rnel
> > >> > in response to some event or systemd or some other userspace
> > >> > component?
> > >>
> > >> Yes AFAIK it is the former (psuedo filesystem similar to procfs, deb=
ugfs
> > >> in that sense). This is also why I don't think that the PR mentioned=
 is
> > >> tested because cgroup2 fs labeling is done with genfscon and not fsu=
se
> > >> trans or fsuse xattr so even if the files would be created by
> > >> userspace (which I think is not the case) the specified automatic ob=
ject
> > >> type transition rule wouldnt work.
> > >
> > > Actually, type transitions on cgroupfs should work - I added special
> > > hooks for kernfs just for that some time ago - see kernel commits
> > > d0c9c153b4bd6963c8fcccbc0caa12e8fa8d971d..e19dfdc83b60f196e0653d68349=
9f7bc5548128f.
> >
> > Interesting. I will try this out. Would this not require at least a
> > "fsuse trans" statement in policy?
>
> No, it should work alongside genfscon. cgroupfs already was special
> before that as it allowed relabeling despite genfscon being used.
>
> >
> > https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules/=
kernel/filesystem.te#L89
> >
> > Also I am not sure if that support would make much sense on a filesyste=
m
> > where files are created my the kernel in reaction to some event.
>
> It does make sense with named transitions, plus it was needed to make
> even a simple parent-child inheritance work. Also, I believe some
> cgroupfs files/directories (I think only directories?) can be created
> by userspace, too.

We should likely check that the SELinux Notebook and/or other
documentation reflects this support and which filesystem types are
supported, both wrt the filesystem types that support both genfscon +
setxattr and those that support genfscon+setxattr+type_transition
rules.
