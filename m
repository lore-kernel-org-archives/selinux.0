Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6CBC636CC
	for <selinux@archiver.kernel.org>; Wed, 15 Feb 2023 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBOOaq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOOap (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Feb 2023 09:30:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68AA3431D
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 06:30:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bt4-20020a17090af00400b002341621377cso2372310pjb.2
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 06:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JabI8G42qXwfwWp8DZkt5vwWajoi5ZLnPhNYjWbMNnA=;
        b=h9z2jbh8CcfeNh7aKUnkDG3+BPJ96+M6dqiUzRD23GZ03I4AkpCrT57J1RHSkX0hEs
         rGEtn5RJ29xhpEHHPFqT+Bf7ndH/nEYmKhm7dJxfw82qGFnoocj6xKfuvyowZ8tlZHwd
         YaDu6OCFTgUeVntXvIb/5EN495YYcggK4A3x3dauuS4tPv7zABZi28usjg4gGfw8tb5x
         bpMV7WXLvBBdszFp4YSshD9mX6hR9oH1CNC6cVqRgKnDEijKZT4xusovzasZz9rQVNRD
         eKkvmfyoCfXY9pZ77qLOIuZuiAWyzHgkTuO0MLKb7soEJw67h30jPfwK3Qq97Cf0aoSk
         JZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JabI8G42qXwfwWp8DZkt5vwWajoi5ZLnPhNYjWbMNnA=;
        b=qZfVO1rPJHWYONMumuPJsOEiK158ht1j0qYZYl1rLzK+SZuLGMULiEtBII3fURKIWE
         tTWoEZrHEiSg44uDR7ZXsNucG7oLQwn2OopLVn4ccFttcEiBiX1aa1MNRooOOnXSI04k
         W4NsJg55gkzXhloraRkm1kt6ag7vNyJatHDOrPZ0rH6Y7FBaxkZ2V/nGx/GpI5C6sfsb
         uZ4sd2VKJHhydfNUQUy9sWXCU9GH7h6E1sE7bPAMPnXCpie0jEOYkLHgiXzWPAnXqEZF
         UnuGNw/P6zuZIC6o1ceA+e/cwDteC7k7LrglLb387x2nz3oeJDoH5LB1YkGzR/TXkj6K
         M54Q==
X-Gm-Message-State: AO0yUKWxPSJcKq7PTRzcHOYfUUytyBLS7/pgmSTwLlP9RMaUSbsbw6Mw
        LjVR3jb1Lqco1MF/3yK5jKAb5bj0Kq/Cqgq2DqA94F2Y
X-Google-Smtp-Source: AK7set/NfAOTn4zDhYnNRel0s5qXjlwDTBZsFF5aCS9LK0k90NAd5ZUQc06H0ejn1HsgJJ4mlm5Z6FdgC3Z9UREbojQ=
X-Received: by 2002:a17:90a:d351:b0:233:f6f9:df37 with SMTP id
 i17-20020a17090ad35100b00233f6f9df37mr516763pjx.138.1676471443933; Wed, 15
 Feb 2023 06:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20230215141709.305399-1-omosnace@redhat.com>
In-Reply-To: <20230215141709.305399-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 15 Feb 2023 09:30:32 -0500
Message-ID: <CAEjxPJ7+s-w37GsKesL5SVd4mPctxgrrf1yW=BBjdFghzbtmKA@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow to opt-out from skipping kernel sockets in sock_has_perm()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 15, 2023 at 9:17 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> There is currently a very suspicious condition in sock_has_perm() that
> basically skips any permission checking in sock_has_perm() if the target
> socket is labeled with SECINITSID_KERNEL. This seems bad for several
> reasons:
> 1. If a user-space process somehow gets its hands on such a socket, it
>    will be able to don any socket operation on it without any SELinux
>    restriction, even if it is not allowed to do such operations by the
>    policy.
> 2. The exception is inconsistent, since one can e.g. write to a stream
>    socket not only via send(2)/sendto(2)/..., but also via write(2),
>    which doesn't go through sock_has_perm() and isn't subject to the
>    SECINITSID_KERNEL exception.
> 3. The exception also allows operations on sockets that were created
>    before the SELinux policy was loaded (even by user space), since
>    these will always inherit the SECINITSID_KERNEL label.
>
> Additionally, it's unclear what is the rationale behind this exception.
> For sockets created by the kernel that are expected to be passed to
> user space, it seems better to let them undergo normal access checks to
> avoid misuse. A possible rationale is to skip checking on operations on
> sockets created with kern=1 passed to __sock_create(), which can happen
> under user-space credentials even thogh executed internally by the
> kernel - notice that such sockets are always labeled with
> SECINITSID_KERNEL. However, the operations on these sockets already
> normally bypass LSM checks entirely, so arguably this not necessary. On
> the contrary, it's better if actual user-space operations on these
> sockets go through SELinux checks, since there may be a possibility that
> such a socket accidentally leaks into user space and we definitely want
> SELinux to detect that and prevent privilege escalation.
>
> Since removing this condition could lead to regressions (notably due to
> bullet point (3.) above), add a new policy capability that allows the
> policy to opt-out from the condition. This allows policy writers or
> distributors to test for impact, add any missing rules, and then enable
> the capability.
>
> I tested a kernel with the condition removed on my Fedora workstation
> and noted only one new denial, related to a user-space socket created by
> systemd-journald before the policy is loaded, which is then continued to
> be used by systemd-journald while the system is running.
>
> Also selinux-testsuite is passing without new denials when the check is
> removed.

I'll have to dig a bit in history to fully recover the original
motivation/background but IIRC, this had to do with kernel-internal
sockets created and used by the kernel on behalf of userspace.  For
example, sockets associated with NFS mounting and subsequent RPC. In
these cases, we don't necessarily want to allow the userspace process
to directly create/use such sockets and from the userspace
perspective, it is just acting on NFS files and not performing any
socket I/O. Open to doing it in a better way, or finding out that it
is no longer necessary.

>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c                   | 4 +++-
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 3 ++-
>  security/selinux/include/security.h        | 7 +++++++
>  4 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3c5be76a91991..cf7418df3d4c0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4561,7 +4561,9 @@ static int sock_has_perm(struct sock *sk, u32 perms)
>         struct common_audit_data ad;
>         struct lsm_network_audit net = {0,};
>
> -       if (sksec->sid == SECINITSID_KERNEL)
> +       /* legacy behavior was to not perform checks on kernel sockets */
> +       if (!selinux_policycap_check_kernel_sockets() &&
> +           sksec->sid == SECINITSID_KERNEL)
>                 return 0;
>
>         ad.type = LSM_AUDIT_DATA_NET;
> diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
> index f35d3458e71de..814db520b9d8b 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -12,6 +12,7 @@ enum {
>         POLICYDB_CAP_NNP_NOSUID_TRANSITION,
>         POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
>         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> +       POLICYDB_CAP_CHECK_KERNEL_SOCKETS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
> index 2a87fc3702b81..62de8262f90fe 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -13,7 +13,8 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
>         "cgroup_seclabel",
>         "nnp_nosuid_transition",
>         "genfs_seclabel_symlinks",
> -       "ioctl_skip_cloexec"
> +       "ioctl_skip_cloexec",
> +       "check_kernel_sockets",
>  };
>
>  #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 393aff41d3ef8..1e57c71d067fb 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -230,6 +230,13 @@ static inline bool selinux_policycap_ioctl_skip_cloexec(void)
>         return READ_ONCE(state->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
>  }
>
> +static inline bool selinux_policycap_check_kernel_sockets(void)
> +{
> +       struct selinux_state *state = &selinux_state;
> +
> +       return READ_ONCE(state->policycap[POLICYDB_CAP_CHECK_KERNEL_SOCKETS]);
> +}
> +
>  struct selinux_policy_convert_data;
>
>  struct selinux_load_state {
> --
> 2.39.1
>
