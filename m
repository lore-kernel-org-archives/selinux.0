Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAEBC7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCTOTh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCTOTf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 10:19:35 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528AE86AB
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1679321972;
        bh=hh0u7eD02fZYfU8+WgFyKaQUFeGEPqNO+sA7DVj2TdQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=axVKZj2dNepM23N9IPRInfWyDqOO1OAngcyzpCeoFEDtJgwRbMpMPaDUlzA+PoNas
         4BtHWdRTScuDBDtjU5N1I4Ti6Bs7Uruxcxv2QcP2Ps3s7BLUJYSysHJSU/m+P+1R4e
         WUvPlopdeXOZ1Fu1WYpatWZgIub5RRJbFW9qWYQc=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 4525D3CC;
        Mon, 20 Mar 2023 15:19:32 +0100 (CET)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: cgroup2 labeling question
References: <87mt47ga29.fsf@defensec.nl>
        <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
        <871qljfrtz.fsf@defensec.nl>
        <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
Date:   Mon, 20 Mar 2023 15:19:32 +0100
In-Reply-To: <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
        (Ondrej Mosnacek's message of "Mon, 20 Mar 2023 15:12:42 +0100")
Message-ID: <87wn3bec97.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Mon, Mar 20, 2023 at 2:59=E2=80=AFPM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
>> > <dominick.grift@defensec.nl> wrote:
>> >>
>> >>
>> >> Hi,
>> >>
>> >> I was reading this pull request [1] and looked into how I might be ab=
le
>> >> to implement this in policy but there seem to be some technical
>> >> difficulties.
>> >>
>> >> * I already use getfscon to seperate the systemd user.slice because t=
he
>> >>   system manager delegates the user.slice to the user manager.
>> >>
>> >>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
>> >>
>> >>   In the past the proved to be a racy where systemd attempts to
>> >>   write before the object has the context associated with the genfsco=
n.
>> >
>> > I don't understand how this could be racy - genfscon-assigned contexts
>> > should be assigned when the dentry is first instantiated via
>> > inode_donit_with_dentry and therefore the inode shouldn't be
>> > accessible to userspace prior to this initial assignment AFAIK.
>> > Possibly I am missing something.
>>
>> I recall encountering this sporadically, but I admit that it has been a
>> while since I supressed it in policy. I might try to reproduce. AFAIK my
>> policy is the only policy that actually labels some trees on cgroup2 fs
>> with private types currently.
>>
>> >
>> >>   I decided to dontaudit attempts to write to the mislabeled object a=
nd
>> >>   it *seems* as if systemd retries until it can write it i.e. when the
>> >>   object carries the expected label and so that seems to work eventua=
lly
>> >>   but it looks fragile.
>> >>
>> >> * The challenge with memory pressure implementation [2] is that these
>> >>   "memory.pressure" files end up in random locations under
>> >>   "/system.slice" for example:
>> >>
>> >>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
>> >>
>> >>   Where in the above systemd-journald.service might be
>> >>   templated (systemd-journald@FOO.service). Point is that the path is
>> >>   random. genfscon does not support regex and glob. I can't do for ex=
ample:
>> >>
>> >>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
>> >>   cgroupfile_context)
>> >>
>> >>   Fortunately cgroup2fs supports relabeling but if systemd has to
>> >>   manually relabel the cgroup files then I would imagine that this is
>> >>   racy as well, and that does not really solve the underlying issue.
>> >>
>> >>   I am looking for ideas and suggestions
>> >
>> > Optimally one of two things would happen:
>> > 1. The kernel would label the inode correctly when it is first created
>> > (e.g. by augmenting genfscon to support more general matching), or
>> > 2. The userspace component that creates these files would label them
>> > correctly at creation (via setfscreatecon() prior to creation).
>>
>> Agree but 1. would require regex/glob support for genfscon and 2. these
>> files aren't "created" by userspace AFAIK and so setfscreatecon or
>> automatic object type transitions are probably not an option here.
>>
>> >
>> > Pardon my ignorance but what creates these files initially? The kernel
>> > in response to some event or systemd or some other userspace
>> > component?
>>
>> Yes AFAIK it is the former (psuedo filesystem similar to procfs, debugfs
>> in that sense). This is also why I don't think that the PR mentioned is
>> tested because cgroup2 fs labeling is done with genfscon and not fsuse
>> trans or fsuse xattr so even if the files would be created by
>> userspace (which I think is not the case) the specified automatic object
>> type transition rule wouldnt work.
>
> Actually, type transitions on cgroupfs should work - I added special
> hooks for kernfs just for that some time ago - see kernel commits
> d0c9c153b4bd6963c8fcccbc0caa12e8fa8d971d..e19dfdc83b60f196e0653d683499f7b=
c5548128f.

Interesting. I will try this out. Would this not require at least a
"fsuse trans" statement in policy?

https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules/kern=
el/filesystem.te#L89

Also I am not sure if that support would make much sense on a filesystem
where files are created my the kernel in reaction to some event.

>
> Not sure what's behind the genfscon label assignment race, though.
>
>>
>> I think eventually we currently probably have little choice but to make =
systemd
>> reset the context of said cgroup file manually. Just wanted to see if
>> there are alternatives.
>>
>> >
>> >> [1] https://github.com/SELinuxProject/refpolicy/pull/607
>> >> [2] https://github.com/systemd/systemd/blob/main/docs/MEMORY_PRESSURE=
.md
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl
>> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> Dominick Grift
>>

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
