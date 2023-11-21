Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914A9C61D85
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 14:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjKUOAz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjKUOAx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 09:00:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35233D70
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:00:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280260db156so4482211a91.2
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575249; x=1701180049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5CRSE/zac5cER39qB2lrYfhsEfAjcugqxCHpKOVXKk=;
        b=eHESxLSaeQa0qJkMKYg0+2ijaLXbo4ytpZCXlSse5Zi8APJ3mhe0WLr8+0lHr5UNN0
         UXnw2OBjpT17IZcxLWJCBvYA/5YvDu9EkX6ZD7zczwxkhlTEg8g9NLZQr+Eflp31sNqU
         GE1eIBmNmSM7D2MpUy2oyRGAQh1eTw9KCplXa0DCW/btOqeMqowuu1Y+aAyxhLJXu1fB
         zGd6mLB/s6C10fuSX/fbgwDo/c1toBnxcn/yzutsRMConXCxLcqhFkTescpbJ3602BO6
         A6uJZSKPHri0w6QjafI7WHak+Z77ywbTFHmnlDkGvu0LeadrFsFxw/1Jvuxa5SQeNMKH
         aT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575249; x=1701180049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5CRSE/zac5cER39qB2lrYfhsEfAjcugqxCHpKOVXKk=;
        b=C9yYtFFK1c+DXQLh54egr3QS4+J7ze9sF7XrIOOo4mqsNoHb1kbd5No5BVxi2KzYpp
         XaVS0KFnPKVsYbfz9csQ3aNYX/djwMtiZ/GwjHKLQmv1YAFghyaNRZkfJ4B7xyLyWPZx
         jKV48YNCExjhE9ENGiAFWPNsY1C8R95kpHmxjXEg1gqsq5biaBHzRqSrXmXXoSJzZXO9
         HIeJUXv2PoMKtw/vxmjP3b55Y7Hbny0y6S2c06Apw1NbqFlz7eSfEwiW58QIQmIXsDU8
         9hDIPx+xZGrdCIeQAjYJmt1Pd0iC5RBkQ6fKTZtVhZHe5yMAlaSj9fVgvIYst/NBDuEt
         xmuQ==
X-Gm-Message-State: AOJu0Yx8zzJ+A9LjRUN5D54ZlBLQ2p0hbOUmetYS/++kLITnmfj/LTZH
        BHCdJa+xs990A64h6/ZUjStorHdh7vFEDqniutg=
X-Google-Smtp-Source: AGHT+IF/g+mWXvTvQffqrMJZVmu6jy1uGMqRqnQP9SFJEDvbZqtHww4StaCLsg/XO375y6g4K/jxNGoCHPg3LFzRcI0=
X-Received: by 2002:a17:90b:38c8:b0:283:2873:8882 with SMTP id
 nn8-20020a17090b38c800b0028328738882mr10148659pjb.10.1700575249266; Tue, 21
 Nov 2023 06:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20231114155116.462883-1-omosnace@redhat.com>
In-Reply-To: <20231114155116.462883-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Nov 2023 09:00:37 -0500
Message-ID: <CAEjxPJ4bSxh0wTar4otZu+PYkb6Aa=tKR_OpF0pBAS-vJf_rTQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 14, 2023 at 10:51=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> Currently, SELinux doesn't allow distinguishing between kernel threads
> and userspace processes that are started before the policy is first
> loaded - both get the label corresponding to the kernel SID. The only
> way a process that persists from early boot can get a meaningful label
> is by doing a voluntary dyntransition or re-executing itself.
>
> Reusing the kernel label for userspace processes is problematic for
> several reasons:
> 1. The kernel is considered to be a privileged domain and generally
>    needs to have a wide range of permissions allowed to work correctly,
>    which prevents the policy writer from effectively hardening against
>    early boot processes that might remain running unintentionally after
>    the policy is loaded (they represent a potential extra attack surface
>    that should be mitigated).
> 2. Despite the kernel being treated as a privileged domain, the policy
>    writer may want to impose certain special limitations on kernel
>    threads that may conflict with the requirements of intentional early
>    boot processes. For example, it is a good hardening practice to limit
>    what executables the kernel can execute as usermode helpers and to
>    confine the resulting usermode helper processes. However, a
>    (legitimate) process surviving from early boot may need to execute a
>    different set of executables.
> 3. As currently implemented, overlayfs remembers the security context of
>    the process that created an overlayfs mount and uses it to bound
>    subsequent operations on files using this context. If an overlayfs
>    mount is created before the SELinux policy is loaded, these "mounter"
>    checks are made against the kernel context, which may clash with
>    restrictions on the kernel domain (see 2.).
>
> To resolve this, introduce a new initial SID (reusing the slot of the
> former "init" initial SID) that will be assigned to any userspace
> process started before the policy is first loaded. This is easy to do,
> as we can simply label any process that goes through the
> bprm_creds_for_exec LSM hook with the new init-SID instead of
> propagating the kernel SID from the parent.
>
> To provide backwards compatibility for existing policies that are
> unaware of this new semantic of the "init" initial SID, introduce a new
> policy capability "userspace_initial_context" and set the "init" SID to
> the same context as the "kernel" SID unless this capability is set by
> the policy.
>
> Another small backwards compatibility measure is needed in
> security_sid_to_context_core() for before the initial SELinux policy
> load - see the code comment for explanation.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---


> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 1eeffc66ea7d7..344c598fc1e74 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1322,8 +1322,19 @@ static int security_sid_to_context_core(u32 sid, c=
har **scontext,
>         if (!selinux_initialized()) {
>                 if (sid <=3D SECINITSID_NUM) {
>                         char *scontextp;
> -                       const char *s =3D initial_sid_to_string[sid];
> +                       const char *s;
>
> +                       /*
> +                        * Before the policy is loaded, translate
> +                        * SECINITSID_INIT to "kernel", because systemd a=
nd
> +                        * libselinux < 2.6 take getcon_raw() !=3D "kerne=
l" to

Don't you mean getcon_raw() =3D=3D "kernel"?
The old test for SELinux-disabled was to check whether policy was not
loaded by checking that we get "kernel" when reading
/proc/thread-self/attr/current.

Other than that,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

And I did test the SELINUX=3Ddisabled case.

> +                        * mean than SELinux is not enabled as the major =
LSM
> +                        * and thus returning "init" would make them misb=
ehave.
> +                        */
> +                       if (sid =3D=3D SECINITSID_INIT)
> +                               sid =3D SECINITSID_KERNEL;
> +
> +                       s =3D initial_sid_to_string[sid];
>                         if (!s)
>                                 return -EINVAL;
>                         *scontext_len =3D strlen(s) + 1;
> --
> 2.41.0
>
