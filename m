Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7CC7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 18:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCTSXY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCTSXD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 14:23:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4019100
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:16:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d10so7142323pgt.12
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwh7TJ0i7TnD2oA8NtJ+uJpWN5gs/AJgY2lxXpB9iqQ=;
        b=Vw3MEb/txz2ultckFBA2wUtnobpxhQgV2g0a5XK90YsTA5+ZuYw4rqLzfYxHJPHYGo
         HZ5hqxuQhl5lBsk5GF8FxqMNEB2OEvMbqiQpVIbN/Tt/tqBVMU4rmbKFzOy53oeNVg3x
         IRTwLpLf5noGvtEuP4WP0+8FUl1TtRY440I8EkU773w6dEcpJw1LYbBbInPFjH70tNJF
         G25ugUSmdVLm9sIYL2MM3tIX6JcjFiBAi3ZY6MDvXfTK3zrApmy2Az6ZgpmPPWlF3xbn
         OEsyVv88c4zWH/I1EmRCDxAvARguvpq+iDnE17hslzYHf7TZyiQSH4EAzSnLOnpgfptL
         GVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwh7TJ0i7TnD2oA8NtJ+uJpWN5gs/AJgY2lxXpB9iqQ=;
        b=wcaYvgCoQOs72RqR66O5BXPHgqyGukajHYab5zqKDMPD+9U4ks9AKGlOpMsHhWxtKt
         cNA00I59YGG8Fozwmxc8qDQBL1cubu8dVm+djbcExTeBZTNfbX6uHY9zy59Y6935S+Dt
         M/B0z2jl3xpj77Ddf5/5cjYOpbrmeoMfuVCKqIWIljHCuLHHHF/iYnUUBnmpRWTej6c1
         Gz9FGeTMlIV0e9FhxZoAuW0EbNMc7gq1bA0x4i01FYT8uDHvkFWgfIaahDvSI0LOppfx
         oEOLIlTKQCV6YibYLtma2K74BCsSq9TX7IZRaezBi6U7Vd4RJe6AIqGCDnJNDiYhmxPy
         ZSQQ==
X-Gm-Message-State: AO0yUKXahvCZx6aDIBdekYsoFcRMyuR0xFCyh953qLjNQiweyuFvH3Lu
        NAklnXVzWXy1pT7eqqfnaHoCoNuvjlOf5iWs7xo=
X-Google-Smtp-Source: AK7set8ylx2kETKnwyrh5kqlSGELkaUF8ESasJL5U/AvtjOvArI2XVOTsgJblW7a4jkkSkf5XbVhL55SbHYNm/ZrQFY=
X-Received: by 2002:a65:4084:0:b0:50c:bde:50c7 with SMTP id
 t4-20020a654084000000b0050c0bde50c7mr1940908pgp.12.1679336151095; Mon, 20 Mar
 2023 11:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl> <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
 <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 14:15:40 -0400
Message-ID: <CAEjxPJ4yUhU05ZY2-6RyisBv4CC8_-ahMWCuwB99rHR6vbKUGQ@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 1:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Hmm...that's interesting. I just tried in Fedora using one of the
> > type_transitions already defined in the default policy and although it
> > appears to use the type_transition to compute the new SID for the
> > create check, ls -Z of the file after creation showed it labeled
> > cgroup_t instead. So it doesn't appear to be working or I am doing it
> > wrong.
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

Unless systemd is coming along after file creation and relabeling it
to cgroup_t at that time.
