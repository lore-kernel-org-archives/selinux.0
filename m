Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BFC7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 18:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCTSO2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCTSOE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 14:14:04 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B610273
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1679335654;
        bh=f6ld0OsvN58HN/7LHcc9oh3AcaiJbWFXuJNyIYeIvAU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Eb9LU3qQ7oAfMTT7GdJu47eTPa+hFClRMKGgY7CXJw+FFKDHDxW4SaqLgq0qYp92v
         wzAeA9oym8IRqgHWjYv4BnhZBjsNs3CMtuX1oL8jOdnlhROE61CduqTNO7GRRxtVBd
         daA40Uc+tsVpx8qugZfR9kx7z8zF3qo7z2ey4CBs=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 7D7A73CC;
        Mon, 20 Mar 2023 19:07:34 +0100 (CET)
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
        <87lejre9b2.fsf@defensec.nl>
        <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
        <87h6ufe5um.fsf@defensec.nl>
        <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
        <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
Date:   Mon, 20 Mar 2023 19:07:34 +0100
In-Reply-To: <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
        (Stephen Smalley's message of "Mon, 20 Mar 2023 13:53:16 -0400")
Message-ID: <87cz53e1p5.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> Hmm...that's interesting. I just tried in Fedora using one of the
>> type_transitions already defined in the default policy and although it
>> appears to use the type_transition to compute the new SID for the
>> create check, ls -Z of the file after creation showed it labeled
>> cgroup_t instead. So it doesn't appear to be working or I am doing it
>> wrong.

I am totally confused now as well because Christian on IRC say's it
works for him but I cannot get it to work here and I tried various
combinations

>
> Reproducer, on F34,
> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> mkdir: cannot create directory
> =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permission deni=
ed
> $ sudo ausearch -m AVC -ts recent -i
> ----
> type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denied  {
> associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
> scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
> tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permissive=
=3D0
> $ seinfo --fs_use | grep cgroup
> $ seinfo --genfscon | grep cgroup
>    genfscon cgroup /  system_u:object_r:cgroup_t:s0
>    genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> $ sesearch -T -s unconfined_t -t cgroup_t -c dir
> type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
> $ sudo setenforce 0
> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
