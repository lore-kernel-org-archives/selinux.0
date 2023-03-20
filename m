Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A7CC6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 18:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCTSJE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCTSIe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 14:08:34 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074992D14D
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:02:29 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id r7so8527380uaj.2
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB7SEblV5x1i1sJhiymqhLSuzp+bQ8RhBV80eV8Kpo8=;
        b=lmsHyvA5P0kprt3r9QB4Cei3w2kls5WFP9qekgQ85ADICWIA5VMS2WiREry8WW0BbO
         tZNlVyzYW7Kvk8sWuOgXWk+pG9i/592byFXJDrkfQBSkjHHhaZPnbRXq1YOTZCGydBSZ
         bKpmCOSomhvHopByRz+zqoF0aJg3IflMrws549G15lTU3lTki4ao/u/Kq8ltDY5mN7uY
         RrsY6Tijrr014JEMoAK1a8N6ZKDu0Og3f25GvfNjnHD+l1a8Ujo0e65Ym/1d2+39Eh7x
         lgeC0dzsg8zDHNJP58PDC+KW30+7pBojGYRmtP5TkbgsNPE1hW3JMnb8do4bjarZ8+3d
         TjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB7SEblV5x1i1sJhiymqhLSuzp+bQ8RhBV80eV8Kpo8=;
        b=lFGQWXkVCA7LLP0W+xqWgdBbGYjersCLNmRUu5r+7iwHaUpE22WkdX8B1tnKKwb1pP
         279EfgSapkduf41rmt5QQNBH759RynAhhe/R8jOtSOLotrdeUV5NuQ1rKjUQcCoZxsln
         tMgkNWUd+Fm6r/XPJQcaj6fV1udFwf3ZLpP38GDxJEgjb2eRE5JS15pTUIHsMTp8CLVf
         tM9tUhZNfeiMj9J9MCaRc2IqXXbbj/T3AcTh1/Zy8tNRrIRZ1kdAsFsCUW5lsMrJaa3f
         Bk/s58xI88k7Sbg29JZ63y/xr+ZlxXvX1qJ/0g+Jbth9hLG73kbbdCh9/dFcjvDjbJRR
         Mu9w==
X-Gm-Message-State: AO0yUKVpSRtCxWWppPqmHil4IF3yge5lAz5IOQlPNSDk1IkWt5sH0xb/
        u0cSg/BXR2ibv2/dtUWYWk70sxRIvL36ckWKQZvlmcIWNCg=
X-Google-Smtp-Source: AK7set/z5sLWqH0ejGvRo7N1kH3n49aNGJlAENU+YLk/tREKjSN5LoN4fwmQZHn/jDhCwUgO+020zpFgcOXmlCwdtI0=
X-Received: by 2002:a65:644a:0:b0:50b:e5a3:4bd4 with SMTP id
 s10-20020a65644a000000b0050be5a34bd4mr122358pgv.4.1679334807191; Mon, 20 Mar
 2023 10:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl> <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 13:53:16 -0400
Message-ID: <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Hmm...that's interesting. I just tried in Fedora using one of the
> type_transitions already defined in the default policy and although it
> appears to use the type_transition to compute the new SID for the
> create check, ls -Z of the file after creation showed it labeled
> cgroup_t instead. So it doesn't appear to be working or I am doing it
> wrong.

Reproducer, on F34,
$ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
mkdir: cannot create directory
=E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permission denied
$ sudo ausearch -m AVC -ts recent -i
----
type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denied  {
associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permissive=3D0
$ seinfo --fs_use | grep cgroup
$ seinfo --genfscon | grep cgroup
   genfscon cgroup /  system_u:object_r:cgroup_t:s0
   genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
$ sesearch -T -s unconfined_t -t cgroup_t -c dir
type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
$ sudo setenforce 0
$ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
$ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots
