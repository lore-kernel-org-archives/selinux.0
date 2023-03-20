Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD1C6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCTSj1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCTSi7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 14:38:59 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C759FA
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1679336763;
        bh=xdDCNPMJre8NBYzGVmcvrUOGg7IR8NJ+xqnELfPBrt8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TiecJ/oZ5IdCcnpzW0uqqpoDeG8IL1df7ju5tH4TJmJwQl2qI73ttBoRCq32lbNoB
         b8LQ6q55z2QihCxQcA73U6+VW6ewpGnAqxZop3s9GV7Ui5eVDnE4TfgqHFme9pfVsk
         HfcWF3RE98Q6FOek02kK/OAhtCJjs4axcawmB/xw=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id A423B3CC;
        Mon, 20 Mar 2023 19:26:03 +0100 (CET)
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
        <CAEjxPJ4yUhU05ZY2-6RyisBv4CC8_-ahMWCuwB99rHR6vbKUGQ@mail.gmail.com>
        <878rfre14s.fsf@defensec.nl>
        <CAEjxPJ7bUD1mrZgCw9WtDrupQFdZBpxfERDvNJ3VRBiqf=VPgw@mail.gmail.com>
Date:   Mon, 20 Mar 2023 19:26:03 +0100
In-Reply-To: <CAEjxPJ7bUD1mrZgCw9WtDrupQFdZBpxfERDvNJ3VRBiqf=VPgw@mail.gmail.com>
        (Stephen Smalley's message of "Mon, 20 Mar 2023 14:22:18 -0400")
Message-ID: <874jqfe0uc.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Mar 20, 2023 at 2:19=E2=80=AFPM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Mon, Mar 20, 2023 at 1:53=E2=80=AFPM Stephen Smalley
>> > <stephen.smalley.work@gmail.com> wrote:
>> >>
>> >> On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
>> >> <stephen.smalley.work@gmail.com> wrote:
>> >> > Hmm...that's interesting. I just tried in Fedora using one of the
>> >> > type_transitions already defined in the default policy and although=
 it
>> >> > appears to use the type_transition to compute the new SID for the
>> >> > create check, ls -Z of the file after creation showed it labeled
>> >> > cgroup_t instead. So it doesn't appear to be working or I am doing =
it
>> >> > wrong.
>> >>
>> >> Reproducer, on F34,
>> >> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
>> >> mkdir: cannot create directory
>> >> =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permission =
denied
>> >> $ sudo ausearch -m AVC -ts recent -i
>> >> ----
>> >> type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denied =
 {
>> >> associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
>> >> scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
>> >> tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permissi=
ve=3D0
>> >> $ seinfo --fs_use | grep cgroup
>> >> $ seinfo --genfscon | grep cgroup
>> >>    genfscon cgroup /  system_u:object_r:cgroup_t:s0
>> >>    genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
>> >> $ sesearch -T -s unconfined_t -t cgroup_t -c dir
>> >> type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
>> >> $ sudo setenforce 0
>> >> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
>> >> $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
>> >> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots
>> >
>> > Unless systemd is coming along after file creation and relabeling it
>> > to cgroup_t at that time.
>>
>> That wouldnt make sense to me, but yes i considered that as well. Ruled
>> it out without actually confirming it. I actually added a rule:
>>
>> auditallow domain cgroup_t:dir create;
>>
>> and that also does not show grants for all the dirs in /sys/fs/cgroup
>> (just some)
>>
>> voodoo
>
> It wouldn't be create but rather relabelto permission (if systemd is
> relabeling the file after the kernel creates it).

Yes I know but I didn't add it to audit relabelto, i added it to audit
the create since the dirs are created there in the first place (i guess).

Even though I doubt that a relabel resets it - I will try it out just to
confirm. Something does not add up.

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
