Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D7FC6FD1F
	for <selinux@archiver.kernel.org>; Tue, 14 Mar 2023 20:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCNUnE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNUnD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Mar 2023 16:43:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678D72ED4E
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 13:43:01 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z83so13125239ybb.2
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678826580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8ZiyUwMqaH6hdc0I0pob4+o0kDs0oA6H7tWLnrXjkg=;
        b=PdY6T2SN/xxF2nU6QsdrDeQ1PTo7jp8W6OhDcSIPLVmoA+Y+vemeoKskJ69sEHBMl7
         1oNxT6vxdqgyuzAIB5FI+ZucKnqa0QnPNtkYm6WziR4RcrErS6+h2wXe6nHrgF7WNkth
         FCLgNQntDJgukbHbolwyIWD0nKqVqQ9IyL0c/tDytiWKEWJ2/59fQMPEkSZ8spakMa/l
         zfy4rW/4FKMdJ+W5xnPkXKf9M/+L7I4iCl3ACMstXLGL6aWk4GGbGdH7ztk7xk0q85GW
         fzzbhRszwckcAarJW/HeysyaUzBHe6Tbx3sOFLGv0o8Ad2RXIby+6E9ihMDFOEfGld9L
         gNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8ZiyUwMqaH6hdc0I0pob4+o0kDs0oA6H7tWLnrXjkg=;
        b=RqPc2OAwfcOlBFHnEjF4omioeRljzYTcQ+lO0t5khSLJzRZ1QV0ydK/45eMgQXsy4f
         wWj8AhiEvPnJJkzADPe+Gc1hCckwDSjiWWwV02vMe1dtgCf/WzO77wtHF7aeFNrwz6aN
         RNBgEXhx7ZilD91girTlDkALVCgRP0Z4mRLYFiS75oPjH+JIhGHpvZdXJ2xpWZlYLOwk
         d2BoK9BbUGAsGxLThhwFFGkYtuhJNmRuCBa7drYFQ2HlY8SGxmLZkMNPQSUaaLr9NKsq
         R7JhNJTW99Qr5eZdXcPkZmGetfNimjK3nqzjkjiOZyRmXAXn9ovS0TRRI98YMqTBt9B2
         Ec7A==
X-Gm-Message-State: AO0yUKW+uCsUH4Y4rIP1fGliNLFQkyRUAFSxM2KBwMHkMo8PxoEHO78h
        aK+eXuF80Z7SDLDy3azUrgod8RknBN8QJBQvBvn8
X-Google-Smtp-Source: AK7set+aBeH5EB9C3JOjAZUwldYqn7THPplVCWDJ2MOU9V2hsEJgs6eUl2Ha3Rm4u7EzgVipNjTQIQHi5jY7H8tHdt8=
X-Received: by 2002:a5b:7:0:b0:a06:55b5:3cdf with SMTP id a7-20020a5b0007000000b00a0655b53cdfmr19864602ybp.3.1678826580110;
 Tue, 14 Mar 2023 13:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230314125734.19896-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230314125734.19896-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Mar 2023 16:42:49 -0400
Message-ID: <CAHC9VhQ77njhXPvEZ6-3WKVQtLtNXJw69NOGSoNktf7STgKjTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: cache access vector decisions in the
 inode security blob
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 14, 2023 at 9:03=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> I think Linus suggested this a long long time ago but I never got around
> to trying it. Better late than never. Compute the access vector decision
> when the inode security blob is initialized and cache it in the blob.
> Update it on file opens. In selinux_inode_permission and inode_has_perm,
> use this cached decision unless invalidated.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This is relative to "selinux: stop passing selinux_state pointers
> and their offspring" which is not yet merged.

It is now :)

> There is an obvious race here; we need some form of synchronization
> to ensure consistency of isec->task_sid, isec->avdsid, and
> isec->avd since otherwise we could end up using the wrong access
> vector decision if e.g. two tasks with different SIDs are accessing
> the same file. Doing so safely without ending up with worse
> overhead for selinux_inode_permission and inode_has_perm requires
> care; open to suggestions here.

Unfortunately, I think we're stuck having to take the
inode_security_struct's spinlock to synchronize updates; or rather,
nothing clever is coming to mind that doesn't introduce a bunch of
unwanted complexity/overhead.

With that in mind, I'm thinking more about where we might do an update
when we already have the spinlock held.  The obvious first candidate
is inode_doinit_with_dentry(), but I believe you previously mentioned
that inode_doinit_with_dentry() alone didn't have much of an impact.
The other place that comes to mind is in __inode_security_revalidate()
as this is already called from a fair number of places that I think we
would care about, and it has the advantage of a parameter which
signals if it is safe to sleep.  We already call
inode_doinit_with_dentry() there when it is safe and the inode needs
to be revalidated, why not update the cached AVC related fields if it
is safe and the inode is already valid?  I'm not sure if this will
result in too much cache thrashing in the inode_security_struct, or if
the spinlock overhead will be unwanted in all the
__inode_security_revalidate() callers, but I figured it was worth
mentioning in case you hadn't already played with it.

>  security/selinux/avc.c            | 45 +++++++++++++++---
>  security/selinux/hooks.c          | 79 ++++++++++++++++++++++++++-----
>  security/selinux/include/avc.h    |  7 +++
>  security/selinux/include/objsec.h |  2 +
>  security/selinux/ss/services.c    |  3 +-
>  5 files changed, 118 insertions(+), 18 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index c162e51fb43c..c74bdd76b38a 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -357,6 +357,8 @@ static int avc_xperms_populate(struct avc_node *node,
>         struct avc_xperms_decision_node *dest_xpd;
>         struct avc_xperms_decision_node *src_xpd;
>
> +       if (!src)
> +               return 0;

This feels like something that we might want to do anyway, although I
would probably combine it with the check immediately below:

  if (!src || src->xp.len =3D=3D 0)
    return 0;

>         if (src->xp.len =3D=3D 0)
>                 return 0;
>         dest =3D avc_xperms_alloc();

...

> @@ -1121,6 +1125,35 @@ static noinline int avc_perm_nonode(u32 ssid, u32 =
tsid, u16 tclass,
>         return 0;
>  }
>
> +/**
> + * avc_get_avd - Get access vector decisions
> + * @ssid: source security identifier
> + * @tsid: target security identifier
> + * @tclass: target security class
> + * @avd: access vector decisions
> + *
> + * Get access vector decisions for the specified (@ssid, @tsid, @tclass)
> + * triple, fetching them from the access vector cache if present or
> + * calling the security server to compute them on a miss. Unlike
> + * avc_has_perm_noaudit(), this function does not check any
> + * requested permission; it just returns the entire decision vector.
> + */
> +void avc_get_avd(u32 ssid, u32 tsid, u16 tclass, struct av_decision *avd=
)
> +{
> +       struct avc_node *node;
> +
> +       rcu_read_lock();
> +       node =3D avc_lookup(ssid, tsid, tclass);
> +       if (unlikely(!node)) {
> +               rcu_read_unlock();
> +               avc_compute_av(ssid, tsid, tclass, avd, NULL);
> +               return;

Out of curiosity, did you do any measurements without the
avc_compute_av() call, relying solely on a previously computed entry
in the AVC?

> +       }
> +       memcpy(avd, &node->ae.avd, sizeof(*avd));
> +       rcu_read_unlock();
> +}
> +
> +
>  /**
>   * avc_has_perm_noaudit - Check permissions but perform no auditing.
>   * @ssid: source security identifier

...

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index f14d1ffe54c5..7353c027c389 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1107,7 +1107,8 @@ void security_compute_av(u32 ssid,
>         rcu_read_lock();
>         policy =3D rcu_dereference(selinux_state.policy);
>         avd_init(policy, avd);
> -       xperms->len =3D 0;
> +       if (xperms)
> +               xperms->len =3D 0;

Similar to the comment for avc_xperms_populate(), I wonder if this is
something we want to check regardless.

>         if (!selinux_initialized())
>                 goto allow;
>
> --
> 2.39.2

--=20
paul-moore.com
