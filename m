Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3630EE0212
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 22:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjIMWFp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjIMWFo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 18:05:44 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670281981
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 15:05:40 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bdad64411so3312057b3.3
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694642739; x=1695247539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVmZ1wjz2vdbI7NtJ0YI8N3uei5EgQ+dXDf+/tA5ZIE=;
        b=XTFW68ehP3luXdnHU6zrPxVeZoOsdHFCNwwuDZmzD4ZffVEPrvppwKrgASxwPIv/w0
         pfQR02WWbwgU2YOM81tryuEGB7u4JCec0NBoUxlCgxy8FOUqvCPhsgqYjXIfEKr2HnBs
         NXtFXSdLmu0qtXk4DbzlLThZqe/hniz8PeHOJlsSVBxOIJz+WJVbl1un0gstwcPUvStv
         aBjX/pGRJfuvFEgrLbmpPixVp9UXCespOC6oIXtH17/yj6R6u/xrP5rWds3XnT1Vj0ed
         fwzu6xWVwLe1BarLxp3MrVHCKlxMTfxxBSFp7DFAvjVy56oBgOoIazYhaZ7vJaJ3A9aG
         LIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642739; x=1695247539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVmZ1wjz2vdbI7NtJ0YI8N3uei5EgQ+dXDf+/tA5ZIE=;
        b=gHlmW+TPBGGWbAmMlBO0bQ11xAgaNP1Sxj+o7uhEfEwYsRF2vI64BrVOdKmdQuZDDI
         8hCj4o0OIRQmms3q156QBhhnVLx5F2mOZZCfWOml9KX5IxBctDLG2aQR3WU+hSgnlBPt
         PHoPzNdKsDGasdoMpxLQDLoX9ZSaHO7voV66kbdLAYajk+lvXKCdSOmdLt6Gl89mAuA/
         ohiaeCDKQvgoL2oYmjhBg/HnocY4zYIxn8YEXEU09gdBNGaaN1jAluntIDUuJOPiM/XU
         U+V9MAHZGhoQACWFA2KgbvQ4sFKG2mtJr6qYhHd77rPlHsGvn7e1BR6RPFXYmnycwmn1
         VJVQ==
X-Gm-Message-State: AOJu0YxFUbzuCmlL/IltQiqC9Xk+4r60/tGXHe15T/dL5ZyxGUov5O7E
        EZHz32S9hkrI0FswXD2u2V9jG7xis6+2fQzQNoGG
X-Google-Smtp-Source: AGHT+IEv5bGyaGHp/r15bo8eEWH+Hp6YKbglRQ588twqmPBJ6bDDlVdygzQTA/WO7dQpk5ltXfldSTg5qbaUSBo/ga8=
X-Received: by 2002:a0d:dc43:0:b0:56d:43cb:da98 with SMTP id
 f64-20020a0ddc43000000b0056d43cbda98mr3813028ywe.29.1694642739476; Wed, 13
 Sep 2023 15:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZOXIjzLnnbuoLOrF@gmail.com> <20230823.xeiYoo3BuPhu@digikod.net>
In-Reply-To: <20230823.xeiYoo3BuPhu@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 18:05:28 -0400
Message-ID: <CAHC9VhQWcxsatoTtQ031PwL-qKsa10S7vxwzv2g_StNLsJDxfQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: constify 'sb' parameter in security_sb_remount()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 23, 2023 at 8:44=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Hi Khadija,
>
> On Wed, Aug 23, 2023 at 01:51:27PM +0500, Khadija Kamran wrote:
> > The "sb_remount" hook has implementations registered in SELinux and
> > Landlock. Looking at the function implementations we observe that the
> > "sb" parameter is not changing.
> >
> > Mark the "sb" parameter of LSM hook security_sb_remount() as "const"
> > since it will not be changing in the LSM hook.
> >
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  include/linux/security.h      | 2 +-
> >  security/landlock/fs.c        | 2 +-
> >  security/security.c           | 2 +-
> >  security/selinux/hooks.c      | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
>
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 1c0c198f6fdb..fabe324922ec 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -1074,7 +1074,7 @@ static int hook_sb_umount(struct vfsmount *const =
mnt, const int flags)
> >       return -EPERM;
> >  }
> >
> > -static int hook_sb_remount(struct super_block *const sb, void *const m=
nt_opts)
> > +static int hook_sb_remount(const struct super_block *const sb, void *c=
onst mnt_opts)
>
> Please format with clang-format -i security/landlock/*.[ch]

Hi Khadija, can you please format the security/landlock/fs.c change as
requested by Micka=C3=ABl?

You can find information on running clang-format on the Linux kernel
at the link below:
* https://www.kernel.org/doc/html/next/process/clang-format.html

--=20
paul-moore.com
