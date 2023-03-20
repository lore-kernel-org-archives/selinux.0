Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82687C7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 16:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCTQi6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjCTQie (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 12:38:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4804C166E0
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:33:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s8so7179798pfk.5
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUINGu69eK9MYtSfLKO4kVYijeR54egNA9uh3Ans/+Q=;
        b=GZpWR/qVnQ+JP0EokkYG0BQD3XuirLutyyoH64PDo4p3nGBP7bN6MPLc4WSsJ7PTqf
         MNPx3sPIg7j7aQAVZHGd7i1LSfFZsdAK8SF1auGwHPvFsb3Xr7/XPZkfrD5r5zdxztky
         op2g2r0ombd9Gr5ofZjDHmsu3Y8RqzVZNkgtMIq2t1i1cr3G4CgaiNheN7uNIItSb8Pl
         p+UB0lo7qdbd9Wnu0UxW3UirPuwjo81ttTL8RmRVpDo24V2x9uyoIJj7aNEtpW9BVY4F
         80WKh02fb6gwXwpYL7Rvc4gaVEcaplHLyTD/f+zFto/iSSbeSw9R9PyXIm+xbamZWMMx
         A5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUINGu69eK9MYtSfLKO4kVYijeR54egNA9uh3Ans/+Q=;
        b=BtTxf4EXcxfKAlKcjF5KTUcwgBFlNSlTrP3NX+Yy5/6dVOJzgIlsgLgVFaI9vZPOgj
         CmI4GqoUd2Y7c8ASVj5jxfILVnq16J26824dUckAHjZYl7vH7WOb3l9inlT/cRy3AKIE
         V6sBw4p4Hke5b/Vd/M4k6BJFt+TLMet7/xEQgw4l7C+yyqL7RrKylwioTmiCJAZ3RY+i
         dw0+dNv5UtBar6QzttoB38qOIRFpqgkf7cDkkAm9b4Y9Q5gei0cpobfdChlMmAwboibV
         FydQ4gNWQxtdcDlJ8GhQDgXxwsqSn1UV138u5M8piML0ybRXCEHm05Fro9eiMVWLW9/1
         Fqow==
X-Gm-Message-State: AO0yUKUhbLOVgdIdP3mPdzU4jus/OVtQqvBHD8hmAbpp4QHD1APVtT6c
        yiO5iNPsv0qBwGSkoNa6oajJ9ePoygc7YHjBu+o=
X-Google-Smtp-Source: AK7set/RzRc5voA2XKGMZEW2MHMSfhpMolaZXm9csME3PpvKg/RINkPzY5sh5sA1e/MeUlxpBn0zdAEHcvOx+D95wPk=
X-Received: by 2002:a05:6a00:1484:b0:625:5949:6dc0 with SMTP id
 v4-20020a056a00148400b0062559496dc0mr7724480pfu.4.1679329983594; Mon, 20 Mar
 2023 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com> <87lejre9b2.fsf@defensec.nl>
In-Reply-To: <87lejre9b2.fsf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 12:32:52 -0400
Message-ID: <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 11:23=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Mar 20, 2023 at 10:46=E2=80=AFAM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> >>
> >> On Mon, Mar 20, 2023 at 3:19=E2=80=AFPM Dominick Grift
> >> <dominick.grift@defensec.nl> wrote:
> >> >
> >> > Ondrej Mosnacek <omosnace@redhat.com> writes:
> >> >
> >> > > On Mon, Mar 20, 2023 at 2:59=E2=80=AFPM Dominick Grift
> >> > > <dominick.grift@defensec.nl> wrote:
> >> > >>
> >> > >> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >> > >>
> >> > >> > On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
> >> > >> > <dominick.grift@defensec.nl> wrote:
> >> > >> >>
> >> > >> >>
> >> > >> >> Hi,
> >> > >> >>
> >> > >> >> I was reading this pull request [1] and looked into how I migh=
t be able
> >> > >> >> to implement this in policy but there seem to be some technica=
l
> >> > >> >> difficulties.
> >> > >> >>
> >> > >> >> * I already use getfscon to seperate the systemd user.slice be=
cause the
> >> > >> >>   system manager delegates the user.slice to the user manager.
> >> > >> >>
> >> > >> >>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
> >> > >> >>
> >> > >> >>   In the past the proved to be a racy where systemd attempts t=
o
> >> > >> >>   write before the object has the context associated with the =
genfscon.
> >> > >> >
> >> > >> > I don't understand how this could be racy - genfscon-assigned c=
ontexts
> >> > >> > should be assigned when the dentry is first instantiated via
> >> > >> > inode_donit_with_dentry and therefore the inode shouldn't be
> >> > >> > accessible to userspace prior to this initial assignment AFAIK.
> >> > >> > Possibly I am missing something.
> >> > >>
> >> > >> I recall encountering this sporadically, but I admit that it has =
been a
> >> > >> while since I supressed it in policy. I might try to reproduce. A=
FAIK my
> >> > >> policy is the only policy that actually labels some trees on cgro=
up2 fs
> >> > >> with private types currently.
> >> > >>
> >> > >> >
> >> > >> >>   I decided to dontaudit attempts to write to the mislabeled o=
bject and
> >> > >> >>   it *seems* as if systemd retries until it can write it i.e. =
when the
> >> > >> >>   object carries the expected label and so that seems to work =
eventually
> >> > >> >>   but it looks fragile.
> >> > >> >>
> >> > >> >> * The challenge with memory pressure implementation [2] is tha=
t these
> >> > >> >>   "memory.pressure" files end up in random locations under
> >> > >> >>   "/system.slice" for example:
> >> > >> >>
> >> > >> >>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.=
pressure
> >> > >> >>
> >> > >> >>   Where in the above systemd-journald.service might be
> >> > >> >>   templated (systemd-journald@FOO.service). Point is that the =
path is
> >> > >> >>   random. genfscon does not support regex and glob. I can't do=
 for example:
> >> > >> >>
> >> > >> >>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
> >> > >> >>   cgroupfile_context)
> >> > >> >>
> >> > >> >>   Fortunately cgroup2fs supports relabeling but if systemd has=
 to
> >> > >> >>   manually relabel the cgroup files then I would imagine that =
this is
> >> > >> >>   racy as well, and that does not really solve the underlying =
issue.
> >> > >> >>
> >> > >> >>   I am looking for ideas and suggestions
> >> > >> >
> >> > >> > Optimally one of two things would happen:
> >> > >> > 1. The kernel would label the inode correctly when it is first =
created
> >> > >> > (e.g. by augmenting genfscon to support more general matching),=
 or
> >> > >> > 2. The userspace component that creates these files would label=
 them
> >> > >> > correctly at creation (via setfscreatecon() prior to creation).
> >> > >>
> >> > >> Agree but 1. would require regex/glob support for genfscon and 2.=
 these
> >> > >> files aren't "created" by userspace AFAIK and so setfscreatecon o=
r
> >> > >> automatic object type transitions are probably not an option here=
.
> >> > >>
> >> > >> >
> >> > >> > Pardon my ignorance but what creates these files initially? The=
 kernel
> >> > >> > in response to some event or systemd or some other userspace
> >> > >> > component?
> >> > >>
> >> > >> Yes AFAIK it is the former (psuedo filesystem similar to procfs, =
debugfs
> >> > >> in that sense). This is also why I don't think that the PR mentio=
ned is
> >> > >> tested because cgroup2 fs labeling is done with genfscon and not =
fsuse
> >> > >> trans or fsuse xattr so even if the files would be created by
> >> > >> userspace (which I think is not the case) the specified automatic=
 object
> >> > >> type transition rule wouldnt work.
> >> > >
> >> > > Actually, type transitions on cgroupfs should work - I added speci=
al
> >> > > hooks for kernfs just for that some time ago - see kernel commits
> >> > > d0c9c153b4bd6963c8fcccbc0caa12e8fa8d971d..e19dfdc83b60f196e0653d68=
3499f7bc5548128f.
> >> >
> >> > Interesting. I will try this out. Would this not require at least a
> >> > "fsuse trans" statement in policy?
> >>
> >> No, it should work alongside genfscon. cgroupfs already was special
> >> before that as it allowed relabeling despite genfscon being used.
> >>
> >> >
> >> > https://github.com/SELinuxProject/refpolicy/blob/master/policy/modul=
es/kernel/filesystem.te#L89
> >> >
> >> > Also I am not sure if that support would make much sense on a filesy=
stem
> >> > where files are created my the kernel in reaction to some event.
> >>
> >> It does make sense with named transitions, plus it was needed to make
> >> even a simple parent-child inheritance work. Also, I believe some
> >> cgroupfs files/directories (I think only directories?) can be created
> >> by userspace, too.
> >
> > We should likely check that the SELinux Notebook and/or other
> > documentation reflects this support and which filesystem types are
> > supported, both wrt the filesystem types that support both genfscon +
> > setxattr and those that support genfscon+setxattr+type_transition
> > rules.
>
> I tried this out:
>
> 1. yes you can create dirs on cgroup2 fs (but not files)
> 2. you can have a genfscon "cgroup2" alongside fsuse trans "cgroup2" but
> if you do then any genfscon statements you might have like for example
> genfscon "cgroup2" "/user.slice" cgroupfile_context) no longer
> work. i.e. its pointless to have then both
> 3. even with a fsuse trans statement I could not make type transitions
> work for directories created on cgroup2 fs.
>
> Even if you could create directories on a cgroupfs with a type
> transition, and if the files under that directory would inherited the
> type of the parent, then that still would not be good enough to address
> the memory.pressure file challenge because the point is to allow a
> service to write the memory.pressure file but not other files in that
> same directory.

You don't want a fs_use_trans statement in your policy for cgroup2.
Just genfscon statements. The kernel will still check for
type_transition rules and apply them to files at creation time without
having a fs_use_trans, but having a fs_use_trans will override
genfscon.
