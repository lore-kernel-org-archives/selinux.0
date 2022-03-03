Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF90C433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 18:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiCCSVQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiCCSVQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 13:21:16 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515891A39D5
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 10:20:30 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso5334082otq.4
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjTOJyWEObqzTfROYvJ8FsNRs0hhG+KAmSmDaDdmlW0=;
        b=Mz2QTB0JhnUd+xHvBsEUdWsgMnhb3J6ExmW8NeX4kdSNsabHaw5M9yzi8ZfVFxrBU5
         Ly4uU2tWAQP2WVvtMslpYNtMAHCv4a8pRi7dKPa3U3Sc0lEjYIfPe/lU+awOpzMIQs5L
         kZby3KLGnDwxK+GteFjb6aT29wo4KYiCoj0HvKZuZO0MEcmHth80SdvioOJP+YaLaozv
         5vOirzxTgh4WnCG+pVHSqQxjoaKFEKVleoQ74CGbojC5yNrzhsoGyNhG9x05wUV821MM
         5n720hEEzWyRLvCPms8/2Lccb7xHauvZPqoLWI+6pucir7p4ZaYOp9wMRZjIJjNjBEIU
         UMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjTOJyWEObqzTfROYvJ8FsNRs0hhG+KAmSmDaDdmlW0=;
        b=4po7g4DTJWyaDmilB/TuqVW8iOqN7XOALPaK/spcjNE61em3TQDLEf2AalRTpOCtPo
         3lc90ODaajcuXzU/76sL66PWm2OoUczgK6Hr7tozKkUmWoT906NmCXyW5m8Kwed6MRYO
         +c0XWTIYxujfxrxi7T7VbLsDQk+qryC8kxwZnJFc85ZT2hUEU9yvm8xqpfYlZ6UzNq4V
         CAbp64/EvMHob8QKkPEGj6o/F4KEz/vbKJoP31YjNuN3NvllzV7cLs81l8g3IZ7PjLqQ
         nmdzW8eSdSVrLFKZx1SWTPz62TdWoQiWM7Yo8E/nLxfEOm0jbjb6Dfwbjfm7zrRW8GAk
         6wxA==
X-Gm-Message-State: AOAM533UXH+Mx4xBQTYHhSiE0GuaYPUU/PfgeCMJOobC+ooAw+ioceUu
        VToaDOj73aF6SXOQsHB2GgEXDbEw0j3/KQ4qtOw=
X-Google-Smtp-Source: ABdhPJzwndHZDWJ/edn8Fmmt7c0IancrSQMCSWg6Bp7sOoaDY2XL+tFkGhKvDp86lVsNUN7bOwMnfpVAYZPiWhgHAhA=
X-Received: by 2002:a9d:6c8:0:b0:5ad:5a1e:f79d with SMTP id
 66-20020a9d06c8000000b005ad5a1ef79dmr19875188otx.154.1646331629683; Thu, 03
 Mar 2022 10:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20220225175549.302386-1-richard_c_haines@btinternet.com> <CAP+JOzR0=zN-dpe=iL+MMxjD9WHvZPmECDo+56skwwGTy5NFNQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR0=zN-dpe=iL+MMxjD9WHvZPmECDo+56skwwGTy5NFNQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Mar 2022 13:20:18 -0500
Message-ID: <CAP+JOzTcMBHfp+RkHbj8uzMk_c1P-=e_Avau5RCVP075E7ChJw@mail.gmail.com>
Subject: Re: [PATCH V2] libsepol: Add 'ioctl_skip_cloexec' policy capability
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, demiobenour@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 28, 2022 at 4:43 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Feb 25, 2022 at 4:38 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > If 'ioctl_skip_cloexec' set, kernel will always allow FIOCLEX and FIONCLEX
> > ioctls.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > V2 Change: Use POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC
> >
> >  libsepol/include/sepol/policydb/polcaps.h | 1 +
> >  libsepol/src/polcaps.c                    | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> > index 40669fb5..39c99839 100644
> > --- a/libsepol/include/sepol/policydb/polcaps.h
> > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > @@ -14,6 +14,7 @@ enum {
> >         POLICYDB_CAPABILITY_CGROUPSECLABEL,
> >         POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> >         POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> > +       POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
> >         __POLICYDB_CAPABILITY_MAX
> >  };
> >  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > index 6a74ec7d..a5e515f2 100644
> > --- a/libsepol/src/polcaps.c
> > +++ b/libsepol/src/polcaps.c
> > @@ -13,6 +13,7 @@ static const char * const polcap_names[] = {
> >         "cgroup_seclabel",              /* POLICYDB_CAPABILITY_SECLABEL */
> >         "nnp_nosuid_transition",        /* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
> >         "genfs_seclabel_symlinks",      /* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
> > +       "ioctl_skip_cloexec",           /* POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC */
> >         NULL
> >  };
> >
> > --
> > 2.35.1
> >
