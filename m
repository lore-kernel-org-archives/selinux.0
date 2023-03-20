Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFF7C76195
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 17:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjCTRds (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjCTRd2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 13:33:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FDC19134
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 10:29:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k2so13233839pll.8
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679333313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKsCXHCgfibTujprItLJR/CCMD9+v+uoJCXLfSOnCsk=;
        b=f328JNrktYfSW2U7Ax3xYF5bQrHTB2hVHD2/nDdnZCkVwSixhIHC8i91oH5gF5fs0E
         D2VqHkk2BlrMIaIGK7F+1XroXsPQoT3PxgdsWI57R4D29AOdCGAyOeHYFnTXBHel7uSV
         GzMVA3SkG6t4nJIZTUY0jobd7eK1l4oG+wvEiQFeUGqHPGQlCIjD1QptboxR7pwK2MBz
         uGAw2VnGv5vY9da549fLvFuHzhd/CpFJ9pFKxAhIUMxhvbK866KkqoCk0+Ww/6+NyMvR
         3C7CdwHRRljqCm6fbavbQFlNB56hL/Nsy+XixQBF4+PqN4aDDkjG/V8aU3Y4TAZAtzD7
         8UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKsCXHCgfibTujprItLJR/CCMD9+v+uoJCXLfSOnCsk=;
        b=cG3Bm5etB6IQKwfmUyc8QrDj3SSzxx1laf6197soCz/twy1AY5LpJYmvGO1V+ROOvz
         1/cpuQIUK7vIu10C4goRyeMjvGxS5bE7U63VlYlD1wsYKURNT5drn/rR/aMx8LuX/NIt
         UN8iAC1VcGZX7J3L4pDlLfsvp9SR+HzXReW3WXxEL9o+hW84QrzYBDwTa/7Age3Ot/gi
         Mi+1Ub4PNDmCq7+QhHUID/sFMON87eXFHk7VDKcInJK//lhoCHFl68gVS05RdoAPThRV
         LAORGvYJb8dYZPAzwzkceZOdeswt+fznLIjYOv9eq8rBYHMZEnJ0AIMOy4sfrR24l/qR
         ZUOQ==
X-Gm-Message-State: AO0yUKVwNgeW/bklOf40iOfhW24UVagNSkPRwvaIHVJOnlH1oO2qSYce
        9UTRyNEGcKjUQPQRWSSDOPUm/CZCd32aDL9jmjA=
X-Google-Smtp-Source: AK7set8f60yjAirh00b06qFHqplHfKtnv42y4o6cbhU8sUHtCAjne6AlVuLAB+kCjdJLeNuxbrCIfQUxzuGMypbUldw=
X-Received: by 2002:a17:902:c94f:b0:19a:f9d9:28d4 with SMTP id
 i15-20020a170902c94f00b0019af9d928d4mr6918644pla.3.1679333313194; Mon, 20 Mar
 2023 10:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl>
In-Reply-To: <87h6ufe5um.fsf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 13:28:21 -0400
Message-ID: <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 12:37=E2=80=AFPM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Mar 20, 2023 at 11:23=E2=80=AFAM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >>
> >> > On Mon, Mar 20, 2023 at 10:46=E2=80=AFAM Ondrej Mosnacek <omosnace@r=
edhat.com> wrote:
> >> >>
> >> >> On Mon, Mar 20, 2023 at 3:19=E2=80=AFPM Dominick Grift
> >> >> <dominick.grift@defensec.nl> wrote:
> >> >> >
> >> >> > Ondrej Mosnacek <omosnace@redhat.com> writes:
> >> >> >
> >> >> > > On Mon, Mar 20, 2023 at 2:59=E2=80=AFPM Dominick Grift
> >> >> > > <dominick.grift@defensec.nl> wrote:
> >> >> > >>
> >> >> > >> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >> >> > >>
> >> >> > >> > On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
> >> >> > >> > <dominick.grift@defensec.nl> wrote:
> >> >> > >> >>
> >> >> > >> >>
> >> >> > >> >> Hi,
> >> >> > >> >>
> >> >> > >> >> I was reading this pull request [1] and looked into how I m=
ight be able
> >> >> > >> >> to implement this in policy but there seem to be some techn=
ical
> >> >> > >> >> difficulties.
> >> >> > >> >>
> >> >> > >> >> * I already use getfscon to seperate the systemd user.slice=
 because the
> >> >> > >> >>   system manager delegates the user.slice to the user manag=
er.
> >> >> > >> >>
> >> >> > >> >>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
> >> >> > >> >>
> >> >> > >> >>   In the past the proved to be a racy where systemd attempt=
s to
> >> >> > >> >>   write before the object has the context associated with t=
he genfscon.
> >> >> > >> >
> >> >> > >> > I don't understand how this could be racy - genfscon-assigne=
d contexts
> >> >> > >> > should be assigned when the dentry is first instantiated via
> >> >> > >> > inode_donit_with_dentry and therefore the inode shouldn't be
> >> >> > >> > accessible to userspace prior to this initial assignment AFA=
IK.
> >> >> > >> > Possibly I am missing something.
> >> >> > >>
> >> >> > >> I recall encountering this sporadically, but I admit that it h=
as been a
> >> >> > >> while since I supressed it in policy. I might try to reproduce=
. AFAIK my
> >> >> > >> policy is the only policy that actually labels some trees on c=
group2 fs
> >> >> > >> with private types currently.
> >> >> > >>
> >> >> > >> >
> >> >> > >> >>   I decided to dontaudit attempts to write to the mislabele=
d object and
> >> >> > >> >>   it *seems* as if systemd retries until it can write it i.=
e. when the
> >> >> > >> >>   object carries the expected label and so that seems to wo=
rk eventually
> >> >> > >> >>   but it looks fragile.
> >> >> > >> >>
> >> >> > >> >> * The challenge with memory pressure implementation [2] is =
that these
> >> >> > >> >>   "memory.pressure" files end up in random locations under
> >> >> > >> >>   "/system.slice" for example:
> >> >> > >> >>
> >> >> > >> >>   /sys/fs/cgroup/system.slice/systemd-journald.service/memo=
ry.pressure
> >> >> > >> >>
> >> >> > >> >>   Where in the above systemd-journald.service might be
> >> >> > >> >>   templated (systemd-journald@FOO.service). Point is that t=
he path is
> >> >> > >> >>   random. genfscon does not support regex and glob. I can't=
 do for example:
> >> >> > >> >>
> >> >> > >> >>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
> >> >> > >> >>   cgroupfile_context)
> >> >> > >> >>
> >> >> > >> >>   Fortunately cgroup2fs supports relabeling but if systemd =
has to
> >> >> > >> >>   manually relabel the cgroup files then I would imagine th=
at this is
> >> >> > >> >>   racy as well, and that does not really solve the underlyi=
ng issue.
> >> >> > >> >>
> >> >> > >> >>   I am looking for ideas and suggestions
> >> >> > >> >
> >> >> > >> > Optimally one of two things would happen:
> >> >> > >> > 1. The kernel would label the inode correctly when it is fir=
st created
> >> >> > >> > (e.g. by augmenting genfscon to support more general matchin=
g), or
> >> >> > >> > 2. The userspace component that creates these files would la=
bel them
> >> >> > >> > correctly at creation (via setfscreatecon() prior to creatio=
n).
> >> >> > >>
> >> >> > >> Agree but 1. would require regex/glob support for genfscon and=
 2. these
> >> >> > >> files aren't "created" by userspace AFAIK and so setfscreateco=
n or
> >> >> > >> automatic object type transitions are probably not an option h=
ere.
> >> >> > >>
> >> >> > >> >
> >> >> > >> > Pardon my ignorance but what creates these files initially? =
The kernel
> >> >> > >> > in response to some event or systemd or some other userspace
> >> >> > >> > component?
> >> >> > >>
> >> >> > >> Yes AFAIK it is the former (psuedo filesystem similar to procf=
s, debugfs
> >> >> > >> in that sense). This is also why I don't think that the PR men=
tioned is
> >> >> > >> tested because cgroup2 fs labeling is done with genfscon and n=
ot fsuse
> >> >> > >> trans or fsuse xattr so even if the files would be created by
> >> >> > >> userspace (which I think is not the case) the specified automa=
tic object
> >> >> > >> type transition rule wouldnt work.
> >> >> > >
> >> >> > > Actually, type transitions on cgroupfs should work - I added sp=
ecial
> >> >> > > hooks for kernfs just for that some time ago - see kernel commi=
ts
> >> >> > > d0c9c153b4bd6963c8fcccbc0caa12e8fa8d971d..e19dfdc83b60f196e0653=
d683499f7bc5548128f.
> >> >> >
> >> >> > Interesting. I will try this out. Would this not require at least=
 a
> >> >> > "fsuse trans" statement in policy?
> >> >>
> >> >> No, it should work alongside genfscon. cgroupfs already was special
> >> >> before that as it allowed relabeling despite genfscon being used.
> >> >>
> >> >> >
> >> >> > https://github.com/SELinuxProject/refpolicy/blob/master/policy/mo=
dules/kernel/filesystem.te#L89
> >> >> >
> >> >> > Also I am not sure if that support would make much sense on a fil=
esystem
> >> >> > where files are created my the kernel in reaction to some event.
> >> >>
> >> >> It does make sense with named transitions, plus it was needed to ma=
ke
> >> >> even a simple parent-child inheritance work. Also, I believe some
> >> >> cgroupfs files/directories (I think only directories?) can be creat=
ed
> >> >> by userspace, too.
> >> >
> >> > We should likely check that the SELinux Notebook and/or other
> >> > documentation reflects this support and which filesystem types are
> >> > supported, both wrt the filesystem types that support both genfscon =
+
> >> > setxattr and those that support genfscon+setxattr+type_transition
> >> > rules.
> >>
> >> I tried this out:
> >>
> >> 1. yes you can create dirs on cgroup2 fs (but not files)
> >> 2. you can have a genfscon "cgroup2" alongside fsuse trans "cgroup2" b=
ut
> >> if you do then any genfscon statements you might have like for example
> >> genfscon "cgroup2" "/user.slice" cgroupfile_context) no longer
> >> work. i.e. its pointless to have then both
> >> 3. even with a fsuse trans statement I could not make type transitions
> >> work for directories created on cgroup2 fs.
> >>
> >> Even if you could create directories on a cgroupfs with a type
> >> transition, and if the files under that directory would inherited the
> >> type of the parent, then that still would not be good enough to addres=
s
> >> the memory.pressure file challenge because the point is to allow a
> >> service to write the memory.pressure file but not other files in that
> >> same directory.
> >
> > You don't want a fs_use_trans statement in your policy for cgroup2.
> > Just genfscon statements. The kernel will still check for
> > type_transition rules and apply them to files at creation time without
> > having a fs_use_trans, but having a fs_use_trans will override
> > genfscon.
>
> Thanks for clarification. to reiterate I could not get type_transition
> to work with only genfscon either when creating a directory on cgroup2
> fs but maybe I was overlooking something.

Hmm...that's interesting. I just tried in Fedora using one of the
type_transitions already defined in the default policy and although it
appears to use the type_transition to compute the new SID for the
create check, ls -Z of the file after creation showed it labeled
cgroup_t instead. So it doesn't appear to be working or I am doing it
wrong.
