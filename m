Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E0EB64DD
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 02:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjHDCZZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHDCZZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 22:25:25 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2202D70
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 19:25:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-586a3159588so6667187b3.0
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115923; x=1691720723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrP0L+lGTdTmRHVsmEewF/hgRcAvnmY3iuS9eE4jEBk=;
        b=GK302n6uNnxF+hzwnLI09KYgsRGy89xsR93x0irtS5Fz7Mrifbet6fy6o1PfbVoqtD
         1jwdN7DfBvFKuG9c/GLte9xEA2P5cZbm1Q8NqOpNb8tyWMyK+szgHNEPZ2UpTiCJ1AcQ
         phxhRpokiJa6eAZ3qeKD2IbPvgfMgLpdzqjMoXo8MmJb2/Ct/tKaAbaF+KNxaTY9ISDQ
         9MGD2wVBY7tpi/aKFW7fzDn1xNNSszR8su0HgbiN65A4eBy2/xNf/FIzlFSuh/WpM8+2
         Nt8XDxYICHZeRQAcj2DQBGNGq1mwW6Oi1Ju8Q1U0VtDp4iXEvxAJqDMv9/eP9vCDpAXC
         tf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115923; x=1691720723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrP0L+lGTdTmRHVsmEewF/hgRcAvnmY3iuS9eE4jEBk=;
        b=jMvE8cv2+lwnDTvEqx3CNrpZPahGUY2Kipv9JMyO4ps7AEGbi8a50QpH/Uuvd/BCeG
         mNCJYQXi+Hxx7mjs1RUCZgrgDSzHQxzgaqE+MmTIVEtzBPNv8rKPD9JlrrhTCpABLZ/j
         9ibGVIIiAezHb6aawG1oAgUW0AWXK74vegwa74+ibrblUC9bo932dEBQZlxFOgmA9DFQ
         uN0d2J1H/tTEQdSANZQlgCGUiFy5DNnAogDyvb9tgDWsyTa+E0ScuDlY3GljjrXA768b
         4YLX6okRRNIKyvzIlX4M7aR0wOuERbUT3GAhZwHEmPianmwzXkGbC9o7a/bXF6Xk3Hv2
         Y/pw==
X-Gm-Message-State: AOJu0YzoaAfuhWuGB0QOg8f+ANO7aDoAzsZrmSRw+L3z7kFLX/izyYgm
        M070HfsKemPkWuxFMNYv6OcqE1BrZkMOU469x7fg
X-Google-Smtp-Source: AGHT+IHgkBM7g69Vfe87ov6P9CnGf4SZ1JQK3AYt4KZAm5ogE3xygLJET5Vb0h+QcKrDjrwTF3Dyh/w014MGklyp4AE=
X-Received: by 2002:a81:9106:0:b0:577:1bdc:b4d with SMTP id
 i6-20020a819106000000b005771bdc0b4dmr605003ywg.0.1691115923229; Thu, 03 Aug
 2023 19:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230801013718.270018-1-xiujianfeng@huawei.com>
In-Reply-To: <20230801013718.270018-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Aug 2023 22:25:12 -0400
Message-ID: <CAHC9VhSCujzsMDq1W1w0R1rLPdSQrqeuacP25Ob5XBna8hQJUQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: cleanup obsolete comments for selinux_hooks[]
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 31, 2023 at 9:39=E2=80=AFPM Xiu Jianfeng <xiujianfeng@huawei.co=
m> wrote:
>
> After commit f22f9aaf6c3d ("selinux: remove the runtime disable
> functionality"), the order in selinux_hooks[] does not affect
> any selinux function, so remove the comments.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/hooks.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2906fdaf7371..ef813970cb9c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6951,21 +6951,6 @@ static int selinux_uring_cmd(struct io_uring_cmd *=
ioucmd)
>  }
>  #endif /* CONFIG_IO_URING */
>
> -/*
> - * IMPORTANT NOTE: When adding new hooks, please be careful to keep this=
 order:
> - * 1. any hooks that don't belong to (2.) or (3.) below,
> - * 2. hooks that both access structures allocated by other hooks, and al=
locate
> - *    structures that can be later accessed by other hooks (mostly "clon=
ing"
> - *    hooks),
> - * 3. hooks that only allocate structures that can be later accessed by =
other
> - *    hooks ("allocating" hooks).
> - *
> - * Please follow block comment delimiters in the list to keep this order=
.
> - *
> - * This ordering is needed for SELinux runtime disable to work at least =
somewhat
> - * safely. Breaking the ordering rules above might lead to NULL pointer =
derefs
> - * when disabling SELinux at runtime.
> - */

I don't mind the hook ordering message, even if it is not strictly
necessary anymore, so let's keep it for now.  However, if you wanted
to remove that last paragraph about it being needed to support the
runtime disable functionality that would be okay.

>  static struct security_hook_list selinux_hooks[] __ro_after_init =3D {
>         LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_=
mgr),
>         LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -7201,9 +7186,6 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(uring_cmd, selinux_uring_cmd),
>  #endif
>
> -       /*
> -        * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
> -        */
>         LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>         LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_pa=
ram),
>         LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
> @@ -7211,9 +7193,6 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clo=
ne),
>  #endif
>
> -       /*
> -        * PUT "ALLOCATING" HOOKS HERE
> -        */
>         LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_secur=
ity),
>         LSM_HOOK_INIT(msg_queue_alloc_security,
>                       selinux_msg_queue_alloc_security),
> --
> 2.34.1

--=20
paul-moore.com
