Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AFBEB64DA
	for <selinux@archiver.kernel.org>; Fri, 16 Jun 2023 20:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjFPUnb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjFPUn2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Jun 2023 16:43:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9363A91
        for <selinux@vger.kernel.org>; Fri, 16 Jun 2023 13:43:26 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5704fce0f23so13415597b3.3
        for <selinux@vger.kernel.org>; Fri, 16 Jun 2023 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686948206; x=1689540206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MfB4vAsE+paFtRmVm47qvorv9QjwKwGCNsi8Wh9N4c=;
        b=XpRk5uNvUXzArrZZ3HgT20gxW6Ka4jyH5kJmbtxw5Xvkwy53xigRBBpnQM+MNp57by
         pUU2MTRdOd0VtyqBgu7FiwQFMYNNmp5+1/kJak3MbYd4vHASVhfnogwW+ZcNCFVpfU8Y
         PULae/e6KkSFjp/vSbWSty7FejpgqDA9B6aRX1ZOF2qXLtoGVKG7cq1bHMf9ib/bayQG
         ZurB4k54DTBBLFnzs9hvkSEhIeCsfbZdRUBfgMa13k+YTzeQBqDrffHvsQr26o1MkNet
         7dP61Kniz9R0ct8AJbE49pyiz1sQdNXvK53gofa/8YR1zVprmFMJtlKq+ZkP9sIoZjmY
         dLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948206; x=1689540206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MfB4vAsE+paFtRmVm47qvorv9QjwKwGCNsi8Wh9N4c=;
        b=li/eHon3ArZoUSKc2/mRo45rfoNp1lq0M6k6eoFsVQIXP9fqwdPHRYkcNPMwHqNuDk
         f/eGSyScomZF1gGagntx9rLbbsfoRrC4i1vCixjV0rEHXwokCTJqEIMCfoAAJV+l8gXS
         s9imuGv3ZehnvVldxqdns9wsvxI0UfcfXT62/XprfqWVWPcXKRTIiJwM3QKv1wVE1yEx
         afyskieD2OfsjmFcVraFUo3JHpzAnkUT4NAoBdMiQsASQupbJ5DDsshvquMy+VDAyCZp
         AS0Fi2FxdkTZ3hMsVS3OG3tGxEUsYT9DHLp7MAU9WkPQoaJFcQg7lFyHImH2FNAR2s0S
         FaLw==
X-Gm-Message-State: AC+VfDzqro34JQjE80QjJZQPNBYt+c3ukOyHnOXgcFhyMCWnLXl8qErk
        xutz8UnbfhT0ui1siVcBVdsQc2QzPR8iYRww4jD+Nkxhq5P6pwk=
X-Google-Smtp-Source: ACHHUZ5J71gS+5BaU2cjneJ1y0zoLxY8T03SIomgKEWzRknLyT1Ew95Amn716LtV0vaRQidSh+ZwuifgcVBxSRgWrl8=
X-Received: by 2002:a0d:f5c2:0:b0:565:a3d1:be19 with SMTP id
 e185-20020a0df5c2000000b00565a3d1be19mr2935269ywf.31.1686948205692; Fri, 16
 Jun 2023 13:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090145.1059245-1-omosnace@redhat.com>
In-Reply-To: <20230612090145.1059245-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 16 Jun 2023 16:43:14 -0400
Message-ID: <CAHC9VhQg3ThH4A5+MggCqNxGnUOsEEgawbTmb4VO1XTWSAKCPg@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 12, 2023 at 5:01=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
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
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c                      | 27 +++++++++++++++++++
>  .../selinux/include/initial_sid_to_string.h   |  2 +-
>  security/selinux/include/policycap.h          |  1 +
>  security/selinux/include/policycap_names.h    |  3 ++-
>  security/selinux/include/security.h           |  7 +++++
>  security/selinux/ss/policydb.c                | 27 +++++++++++++++++++
>  6 files changed, 65 insertions(+), 2 deletions(-)

Thanks Ondrej, this looks pretty good to me.  There is some minor
nitpicky stuff below, but those comments are mainly FYIs for future
reference.  Given where we are at in the -rcX cycle, I am going to
hold off on merging this until after the upcoming merge window.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 99ded60a6b911..dd410ceb178cb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2264,6 +2264,18 @@ static int selinux_bprm_creds_for_exec(struct linu=
x_binprm *bprm)
>         new_tsec->keycreate_sid =3D 0;
>         new_tsec->sockcreate_sid =3D 0;
>
> +       /*
> +        * Before policy is loaded, label any task outside kernel space
> +        * as SECINITSID_INIT, so that any userspace tasks surviving from
> +        * early boot end up with a label different from SECINITSID_KERNE=
L
> +        * (if the policy chooses to set SECINITSID_INIT !=3D SECINITSID_=
KERNEL).
> +        */
> +       if (!selinux_initialized()) {
> +               new_tsec->sid =3D SECINITSID_INIT;
> +               new_tsec->exec_sid =3D 0; /* just in case */

Style nit, I don't like placing trailing comments on the same line as
code.  Don't respin this patch just for this, but remember this for
future submissions.

> +               return 0;
> +       }
> +
>         if (old_tsec->exec_sid) {
>                 new_tsec->sid =3D old_tsec->exec_sid;
>                 /* Reset exec SID on execve. */

...

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 97c0074f9312a..240e0fb1d57f9 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -863,6 +863,8 @@ void policydb_destroy(struct policydb *p)
>  int policydb_load_isids(struct policydb *p, struct sidtab *s)
>  {
>         struct ocontext *head, *c;
> +       bool secsid_init_supported =3D ebitmap_get_bit(&p->policycaps,
> +                                                    POLICYDB_CAP_USERSPA=
CE_INITIAL_CONTEXT);

This is another "please don't respin for this", but if you have to
respin for any reason can you change the variable name to
"isid_init_supported" or something similar?  The "secsid" portion of
the name looks wrong to me.

--=20
paul-moore.com
