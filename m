Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE09C7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCTSay (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjCTSaN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 14:30:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D1AF32
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:22:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ja10so13444799plb.5
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZsU6jpoRKG8SsvoL7eVCGu3VLpRCwf3uFIMJtrqxvI=;
        b=AEs+dnFp6m6wEioDywd14J1Z6sZi8R3Nc8FXLNbbcY+Y1hsBMRhzd6WxHj/5z4gEQ3
         Ev+0BW+7agaCWUL0jCGTp0UUU2X5/0iAyEyznB8PHmJzc8SsOMRuvUmnDdeH0GJN1Skd
         BwlBPEjTYp/cEbw0oJbUKTwxg6DjWdvf01AgpW92JOJCz8elPmTW3U1dk+T9syh4krDJ
         DuL8pDcAqpKx18YXyxcwtIGKkw/8bcqZKsGoC8jIdx912pIlk1FUnIGkDoiMBDa0nPvt
         4vUEx7Qwx1ThO/u0nVHs+005XTlDQOhxtWqwQOxc9BZuXH8oeyXCTCtdSiRVg7k4hNj+
         mv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZsU6jpoRKG8SsvoL7eVCGu3VLpRCwf3uFIMJtrqxvI=;
        b=XH8SxB1MsfrET9EuB1ZdP0WZ3be2G2/Q0dwhZJSiijucvraNs/cG/BnMvOlrKnXW/5
         lmbte1tiMsvV24Ce8V2WiY4keLP2Ee8yaa0oOjSrqMAth/+lPnRy8BXLIzvXmBtTu4CP
         KrMKNebwk/QUUlZnK+ujBJ1BFdEBLfuI4NyCSvPx7sQFDI1/sdJIKwks/XAi0p2JEENU
         7lOdKwewLJTvRmBKp1M+cXD2jfJPi6wjYLmzzgtiCwgeU2e70iw6DPVOMKexyA6iFWIz
         pTXrX5YA44igZbEp1yTlQwvH82adGAIDJ6u8VLbsX4kOXal27VReOWgIcF0NcO886W7W
         eS4Q==
X-Gm-Message-State: AO0yUKUKubFAhvUOeCn8/T5DQx0HFEKXDscCyTkWo31bgoTL8kyZmlg+
        VIpTMlROK+e3lnVVJ3FVHiZENZnb4mQRTwX5usc=
X-Google-Smtp-Source: AK7set9t0udIRDQWIDn4miVxVL2Y21Zul+0BhPYTrBsYLKqCP8ls3HUz20A9c+MNsZmIc3psGaIQS2yCXHaDcMvrtO4=
X-Received: by 2002:a17:903:2797:b0:1a1:cd69:d303 with SMTP id
 jw23-20020a170903279700b001a1cd69d303mr2034036plb.3.1679336549384; Mon, 20
 Mar 2023 11:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl> <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
 <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
 <CAEjxPJ4yUhU05ZY2-6RyisBv4CC8_-ahMWCuwB99rHR6vbKUGQ@mail.gmail.com> <878rfre14s.fsf@defensec.nl>
In-Reply-To: <878rfre14s.fsf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 14:22:18 -0400
Message-ID: <CAEjxPJ7bUD1mrZgCw9WtDrupQFdZBpxfERDvNJ3VRBiqf=VPgw@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 2:19=E2=80=AFPM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Mar 20, 2023 at 1:53=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >> > Hmm...that's interesting. I just tried in Fedora using one of the
> >> > type_transitions already defined in the default policy and although =
it
> >> > appears to use the type_transition to compute the new SID for the
> >> > create check, ls -Z of the file after creation showed it labeled
> >> > cgroup_t instead. So it doesn't appear to be working or I am doing i=
t
> >> > wrong.
> >>
> >> Reproducer, on F34,
> >> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> >> mkdir: cannot create directory
> >> =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permission d=
enied
> >> $ sudo ausearch -m AVC -ts recent -i
> >> ----
> >> type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denied  =
{
> >> associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
> >> scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
> >> tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permissiv=
e=3D0
> >> $ seinfo --fs_use | grep cgroup
> >> $ seinfo --genfscon | grep cgroup
> >>    genfscon cgroup /  system_u:object_r:cgroup_t:s0
> >>    genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> >> $ sesearch -T -s unconfined_t -t cgroup_t -c dir
> >> type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
> >> $ sudo setenforce 0
> >> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> >> $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
> >> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots
> >
> > Unless systemd is coming along after file creation and relabeling it
> > to cgroup_t at that time.
>
> That wouldnt make sense to me, but yes i considered that as well. Ruled
> it out without actually confirming it. I actually added a rule:
>
> auditallow domain cgroup_t:dir create;
>
> and that also does not show grants for all the dirs in /sys/fs/cgroup
> (just some)
>
> voodoo

It wouldn't be create but rather relabelto permission (if systemd is
relabeling the file after the kernel creates it).
