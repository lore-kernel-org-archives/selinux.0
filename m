Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C8CC6FD1D
	for <selinux@archiver.kernel.org>; Thu, 30 Mar 2023 21:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjC3VQF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjC3VPz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Mar 2023 17:15:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A8EFAD
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 14:15:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id f188so6801362ybb.3
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680210951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF+oDwPkmVm7Qzdori7BA3QXVGteSFkr5JVJlHDMV5M=;
        b=Uyr/tXATNpJkiRXDw5jPhZvgg3yTmAqevZZQdIgzznbFGsdDGcvLYswsrKbDTlEbMp
         0LSn4lVMaDd0wz6FRdC83zkC9WXvs5MZLt8Ezz/yEAUr5XD9sPPFK9RjoAgsIn3U0h4I
         gYuL5Ayy9wn8jZjai/fRYcKSYspooI5ovRLEaMHzzo8NCkszVDJxZmVNhxkVp7ZPUAYe
         6X+7REVFzscjLqZp5XXx+ntsKfb1TTkOJgq8WTSlHnLpbq6nMEoKVm3W8LmnAyFmswVt
         km2jGPsYbdVJAS1gD6b2EUDdbT8pq8TG2onjt1eCr+gUVqqUdyce819NSJz/07NP0ZIj
         4YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF+oDwPkmVm7Qzdori7BA3QXVGteSFkr5JVJlHDMV5M=;
        b=uKfIKmFmRFlDahpi8IUM4Qx+7NH/TGFtCZf+scgVWbYMakKBvffUwaP49vosPEbVO7
         wWGFUqAlXviqRwoFiEq4WDEO/D0uSDlJC/EMEj/xfuPLgUDjbFPiH4oGi3EjXDJkhHsQ
         YPylb8/xHbOHCqwME7KeiGt57K/+5NQ9KpcAYhWaZeD2izYhOVHznQYfzSfzCzAV1z9p
         PV/uLfdOP32quNI8VSx14AtLp7NokzuRvvDCV4KPWIOgB9DNKf1EbJ35GFgHpEP96357
         BkC6UFkYsBnPvYcSfkhxL7IdnLLCoKBK7huRXJdVNE0YchqhefcXccLEFaaAWzHeENqb
         ctbw==
X-Gm-Message-State: AAQBX9cA8qI4vs3HbPeu+RUhXYfN1tq72GZGyib1Cz44+ZB3cJZVdQRL
        07FhDqmR6zvYU+oZtesEYuwAooaQVT497zg/jIgd
X-Google-Smtp-Source: AKy350bjJ+D3+gXwrEw2lcCPM+Y4L8ToBkt7wQW0VhUQUCBX571TFxcGzOeeLA6px4laNdFZKwMWsEs+KGpCrB5zv1s=
X-Received: by 2002:a05:6902:70a:b0:b6e:361a:c86 with SMTP id
 k10-20020a056902070a00b00b6e361a0c86mr13662579ybt.3.1680210950900; Thu, 30
 Mar 2023 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230329130415.2312521-1-roberto.sassu@huaweicloud.com> <20230329130415.2312521-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230329130415.2312521-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Mar 2023 17:15:40 -0400
Message-ID: <CAHC9VhRg7twUWXLH0xTaWc2MeSFExkGr9tJztYopzD0JEM-npw@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] reiserfs: Add security prefix to xattr name in reiserfs_security_write()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 29, 2023 at 9:05=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Reiserfs sets a security xattr at inode creation time in two stages: firs=
t,
> it calls reiserfs_security_init() to obtain the xattr from active LSMs;
> then, it calls reiserfs_security_write() to actually write that xattr.
>
> Unfortunately, it seems there is a wrong expectation that LSMs provide th=
e
> full xattr name in the form 'security.<suffix>'. However, LSMs always
> provided just the suffix, causing reiserfs to not write the xattr at all
> (if the suffix is shorter than the prefix), or to write an xattr with the
> wrong name.
>
> Add a temporary buffer in reiserfs_security_write(), and write to it the
> full xattr name, before passing it to reiserfs_xattr_set_handle().
>
> Since the 'security.' prefix is always prepended, remove the name length
> check.
>
> Cc: stable@vger.kernel.org # v2.6.x
> Fixes: 57fe60df6241 ("reiserfs: add atomic addition of selinux attributes=
 during inode creation")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/reiserfs/xattr_security.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
> index 6bffdf9a4fd..b0c354ab113 100644
> --- a/fs/reiserfs/xattr_security.c
> +++ b/fs/reiserfs/xattr_security.c
> @@ -95,11 +95,13 @@ int reiserfs_security_write(struct reiserfs_transacti=
on_handle *th,
>                             struct inode *inode,
>                             struct reiserfs_security_handle *sec)
>  {
> +       char xattr_name[XATTR_NAME_MAX + 1];
>         int error;
> -       if (strlen(sec->name) < sizeof(XATTR_SECURITY_PREFIX))
> -               return -EINVAL;

If one really wanted to be paranoid they could verify that
'XATTR_SECURITY_PREFIX_LEN + strlen(sec->name) <=3D XATTR_NAME_MAX' and
return EINVAL, but that really shouldn't be an issue and if the
concatenation does result in a xattr name that is too big, the
snprintf() will safely truncate/managle it.

Regardless, this patch is fine with me, but it would be nice if at
least of the reiserfs/VFS folks could provide an ACK/Reviewed-by tag,
although I think we can still move forward on this without one of
those.

> -       error =3D reiserfs_xattr_set_handle(th, inode, sec->name, sec->va=
lue,
> +       snprintf(xattr_name, sizeof(xattr_name), "%s%s", XATTR_SECURITY_P=
REFIX,
> +                sec->name);
> +
> +       error =3D reiserfs_xattr_set_handle(th, inode, xattr_name, sec->v=
alue,
>                                           sec->length, XATTR_CREATE);
>         if (error =3D=3D -ENODATA || error =3D=3D -EOPNOTSUPP)
>                 error =3D 0;
> --
> 2.25.1

--=20
paul-moore.com
