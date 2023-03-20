Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9728EC6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjCTPbK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjCTPat (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 11:30:49 -0400
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933AD38B5F
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1679325793;
        bh=+ySz2mPcxa9srRP6kSa+uD7AEiMeQRSeCAzzDejNbe4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=X5cnkLLrgZNTDrmbp+4VYiTvU8WT3q49tp47ie6YAm5I9kN4xZeApxYDCCKb8cWbq
         RAPYnwvYeVbKHjZczcPlXm/38/2Sju2Ox3/QwxX5jRpZyTfacr4UVC2a3R9+1dhABj
         OPsy4ny5Kr4FmK+wooTAGtsQxZsg/SZe7pwr5V60=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 778843CC;
        Mon, 20 Mar 2023 16:23:13 +0100 (CET)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: cgroup2 labeling question
References: <87mt47ga29.fsf@defensec.nl>
        <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
        <871qljfrtz.fsf@defensec.nl>
        <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
        <87wn3bec97.fsf@defensec.nl>
        <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
        <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
Date:   Mon, 20 Mar 2023 16:23:13 +0100
In-Reply-To: <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
        (Stephen Smalley's message of "Mon, 20 Mar 2023 11:16:16 -0400")
Message-ID: <87lejre9b2.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Mar 20, 2023 at 10:46=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
>>
>> On Mon, Mar 20, 2023 at 3:19=E2=80=AFPM Dominick Grift
>> <dominick.grift@defensec.nl> wrote:
>> >
>> > Ondrej Mosnacek <omosnace@redhat.com> writes:
>> >
>> > > On Mon, Mar 20, 2023 at 2:59=E2=80=AFPM Dominick Grift
>> > > <dominick.grift@defensec.nl> wrote:
>> > >>
>> > >> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>> > >>
>> > >> > On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
>> > >> > <dominick.grift@defensec.nl> wrote:
>> > >> >>
>> > >> >>
>> > >> >> Hi,
>> > >> >>
>> > >> >> I was reading this pull request [1] and looked into how I might =
be able
>> > >> >> to implement this in policy but there seem to be some technical
>> > >> >> difficulties.
>> > >> >>
>> > >> >> * I already use getfscon to seperate the systemd user.slice beca=
use the
>> > >> >>   system manager delegates the user.slice to the user manager.
>> > >> >>
>> > >> >>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
>> > >> >>
>> > >> >>   In the past the proved to be a racy where systemd attempts to
>> > >> >>   write before the object has the context associated with the ge=
nfscon.
>> > >> >
>> > >> > I don't understand how this could be racy - genfscon-assigned con=
texts
>> > >> > should be assigned when the dentry is first instantiated via
>> > >> > inode_donit_with_dentry and therefore the inode shouldn't be
>> > >> > accessible to userspace prior to this initial assignment AFAIK.
>> > >> > Possibly I am missing something.
>> > >>
>> > >> I recall encountering this sporadically, but I admit that it has be=
en a
>> > >> while since I supressed it in policy. I might try to reproduce. AFA=
IK my
>> > >> policy is the only policy that actually labels some trees on cgroup=
2 fs
>> > >> with private types currently.
>> > >>
>> > >> >
>> > >> >>   I decided to dontaudit attempts to write to the mislabeled obj=
ect and
>> > >> >>   it *seems* as if systemd retries until it can write it i.e. wh=
en the
>> > >> >>   object carries the expected label and so that seems to work ev=
entually
>> > >> >>   but it looks fragile.
>> > >> >>
>> > >> >> * The challenge with memory pressure implementation [2] is that =
these
>> > >> >>   "memory.pressure" files end up in random locations under
>> > >> >>   "/system.slice" for example:
>> > >> >>
>> > >> >>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pr=
essure
>> > >> >>
>> > >> >>   Where in the above systemd-journald.service might be
>> > >> >>   templated (systemd-journald@FOO.service). Point is that the pa=
th is
>> > >> >>   random. genfscon does not support regex and glob. I can't do f=
or example:
>> > >> >>
>> > >> >>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
>> > >> >>   cgroupfile_context)
>> > >> >>
>> > >> >>   Fortunately cgroup2fs supports relabeling but if systemd has to
>> > >> >>   manually relabel the cgroup files then I would imagine that th=
is is
>> > >> >>   racy as well, and that does not really solve the underlying is=
sue.
>> > >> >>
>> > >> >>   I am looking for ideas and suggestions
>> > >> >
>> > >> > Optimally one of two things would happen:
>> > >> > 1. The kernel would label the inode correctly when it is first cr=
eated
>> > >> > (e.g. by augmenting genfscon to support more general matching), or
>> > >> > 2. The userspace component that creates these files would label t=
hem
>> > >> > correctly at creation (via setfscreatecon() prior to creation).
>> > >>
>> > >> Agree but 1. would require regex/glob support for genfscon and 2. t=
hese
>> > >> files aren't "created" by userspace AFAIK and so setfscreatecon or
>> > >> automatic object type transitions are probably not an option here.
>> > >>
>> > >> >
>> > >> > Pardon my ignorance but what creates these files initially? The k=
ernel
>> > >> > in response to some event or systemd or some other userspace
>> > >> > component?
>> > >>
>> > >> Yes AFAIK it is the former (psuedo filesystem similar to procfs, de=
bugfs
>> > >> in that sense). This is also why I don't think that the PR mentione=
d is
>> > >> tested because cgroup2 fs labeling is done with genfscon and not fs=
use
>> > >> trans or fsuse xattr so even if the files would be created by
>> > >> userspace (which I think is not the case) the specified automatic o=
bject
>> > >> type transition rule wouldnt work.
>> > >
>> > > Actually, type transitions on cgroupfs should work - I added special
>> > > hooks for kernfs just for that some time ago - see kernel commits
>> > > d0c9c153b4bd6963c8fcccbc0caa12e8fa8d971d..e19dfdc83b60f196e0653d6834=
99f7bc5548128f.
>> >
>> > Interesting. I will try this out. Would this not require at least a
>> > "fsuse trans" statement in policy?
>>
>> No, it should work alongside genfscon. cgroupfs already was special
>> before that as it allowed relabeling despite genfscon being used.
>>
>> >
>> > https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules=
/kernel/filesystem.te#L89
>> >
>> > Also I am not sure if that support would make much sense on a filesyst=
em
>> > where files are created my the kernel in reaction to some event.
>>
>> It does make sense with named transitions, plus it was needed to make
>> even a simple parent-child inheritance work. Also, I believe some
>> cgroupfs files/directories (I think only directories?) can be created
>> by userspace, too.
>
> We should likely check that the SELinux Notebook and/or other
> documentation reflects this support and which filesystem types are
> supported, both wrt the filesystem types that support both genfscon +
> setxattr and those that support genfscon+setxattr+type_transition
> rules.

I tried this out:

1. yes you can create dirs on cgroup2 fs (but not files)
2. you can have a genfscon "cgroup2" alongside fsuse trans "cgroup2" but
if you do then any genfscon statements you might have like for example
genfscon "cgroup2" "/user.slice" cgroupfile_context) no longer
work. i.e. its pointless to have then both
3. even with a fsuse trans statement I could not make type transitions
work for directories created on cgroup2 fs.

Even if you could create directories on a cgroupfs with a type
transition, and if the files under that directory would inherited the
type of the parent, then that still would not be good enough to address
the memory.pressure file challenge because the point is to allow a
service to write the memory.pressure file but not other files in that
same directory.

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
