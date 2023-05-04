Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AD1C77B73
	for <selinux@archiver.kernel.org>; Thu,  4 May 2023 21:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEDVE1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 May 2023 17:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjEDVDw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 May 2023 17:03:52 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E489124A7
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 14:03:23 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55c939fb24dso9231267b3.2
        for <selinux@vger.kernel.org>; Thu, 04 May 2023 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683234194; x=1685826194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p8QdwXfy9ov3/QhS7EIHJer5D5agi1J4KqsRnGeOj8=;
        b=G3gi83WZPh0p3a4pZMiENDx5IcKehFn81+p53FWaYrvn4DnYXw+3lx3nE5PHGim538
         JKqrxjYHHG2osh7TnfwrUGXsx/kpUo11uo1KHmkLkOiGChbDHRyd9RjIaggO7p13thJ6
         QGEpL0GSTvWjYRoEhqiAnnUOFQG4zk4nY13GAEfdbFKMMKbObCVzL/lS1KwLtA6+OV+j
         F9NgK9bDg14NKBnZOOMIxSymioIe4rDSDEt4D+NZJweAgjpkp5Q56tAn/cUqUr1KhHXq
         HSg09J3PgcGIsqu769J460ad/1PXXAU2DR+CPz1U6eu+sy4RxXK9w/N7rLkvY/Tl3Zto
         3yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683234194; x=1685826194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p8QdwXfy9ov3/QhS7EIHJer5D5agi1J4KqsRnGeOj8=;
        b=PX8pF2fHlyHhbw1jr5aqrXCQ35FwPl/G0jsvJ8MzBaxZqwJFZFMgc82z+znT2blin9
         H1tgHVQrLDoFYxpZ6NkH6v8NtNxnh9+xKHHv/LZukFMHA1CWye5V3WUPAAirOpH4N7sK
         3C4V/Hk7d6vlM+E9jyyBzzGecyiOogJO5p9Uo74zNI9WhZCvSbQ8T09Jcfx8Q02TVzX2
         ctuaHiY6fPLOYATUhgfZOlZK6mH7s3gIQWU27C1WzjovXIMwHAUk0ZH821v7k2uY2VhA
         KEZkKDJzIznpvbill9tEB4NaSZQr19TFislUtCFwZzrYUZGfxrfPBc21BIgIn2DTBVFR
         sTmA==
X-Gm-Message-State: AC+VfDxa+FsxORNh5Zb20MfHALKSEq92BH0NGqCznUcidzB2KoMsTRM+
        jXsuGMb8Hdnmen4c/JbgqIEVlktu3JdmpxXhFeR7CN0mOaiWm8I=
X-Google-Smtp-Source: ACHHUZ7mzoVRegpPEHOtK3DAslc6s1i1oFTMtT2//eJtywKothY6zIbc4oW0DGWzboMERBU4yuTcloTTBjoP5f56wWo=
X-Received: by 2002:a05:6902:1888:b0:b8e:e422:aa7e with SMTP id
 cj8-20020a056902188800b00b8ee422aa7emr1751880ybb.14.1683234193709; Thu, 04
 May 2023 14:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230504141330.1557243-1-juraj@jurajmarcin.com>
In-Reply-To: <20230504141330.1557243-1-juraj@jurajmarcin.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 May 2023 17:03:02 -0400
Message-ID: <CAHC9VhSFPpVoJEZx8Gq+5gDU+4BdqqAFv9V5+SLPE1HVx0DMMw@mail.gmail.com>
Subject: Re: [PATCH] selinux: make cleanup on error consistent
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 4, 2023 at 10:14=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> The file security.c contains two functions (security_read_policy() and
> security_read_state_kernel()) that are almost identical, but their
> cleanup conventions differ.
>
> This patch unifies the behavior by adding cleanup to
> security_read_policy() in case some call inside it fails instead of
> relying on the caller to properly free the memory. On top of that, this
> patch future-proofs both functions by adding local variables and
> modifying the pointers only in case of a success.
>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> ---
>  security/selinux/include/security.h |  4 +--
>  security/selinux/selinuxfs.c        |  2 --
>  security/selinux/ss/services.c      | 50 +++++++++++++++++++----------
>  3 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 8746fafeb7789..2990b3d08236d 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -213,8 +213,8 @@ int security_load_policy(void *data, size_t len,
>                          struct selinux_load_state *load_state);
>  void selinux_policy_commit(struct selinux_load_state *load_state);
>  void selinux_policy_cancel(struct selinux_load_state *load_state);
> -int security_read_policy(void **data, size_t *len);
> -int security_read_state_kernel(void **data, size_t *len);
> +int security_read_policy(void **pdata, size_t *plen);
> +int security_read_state_kernel(void **pdata, size_t *plen);
>  int security_policycap_supported(unsigned int req_cap);
>
>  #define SEL_VEC_MAX 32
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 69a583b91fc57..6d4cd66360739 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -406,8 +406,6 @@ static int sel_open_policy(struct inode *inode, struc=
t file *filp)
>  err:
>         mutex_unlock(&selinux_state.policy_mutex);
>
> -       if (plm)
> -               vfree(plm->data);
>         kfree(plm);
>         return rc;
>  }
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index f14d1ffe54c5d..f2fd2b6510560 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3941,12 +3941,16 @@ static int __security_read_policy(struct selinux_=
policy *policy,
>
>  /**
>   * security_read_policy - read the policy.
> - * @data: binary policy data
> - * @len: length of data in bytes
> + * @pdata: binary policy data
> + * @plen: length of data in bytes
>   *
> + * In case of a failure, the pointers are not modified.
>   */
> -int security_read_policy(void **data, size_t *len)
> +int security_read_policy(void **pdata, size_t *plen)
>  {
> +       int err;
> +       void *data;
> +       size_t len;
>         struct selinux_state *state =3D &selinux_state;
>         struct selinux_policy *policy;
>
> @@ -3955,28 +3959,39 @@ int security_read_policy(void **data, size_t *len=
)
>         if (!policy)
>                 return -EINVAL;
>
> -       *len =3D policy->policydb.len;
> -       *data =3D vmalloc_user(*len);
> -       if (!*data)
> +       len =3D policy->policydb.len;
> +       data =3D vmalloc_user(len);
> +       if (!data)
>                 return -ENOMEM;
>
> -       return __security_read_policy(policy, *data, len);
> +       err =3D __security_read_policy(policy, data, &len);
> +       if (err) {
> +               vfree(data);
> +               return err;
> +       }
> +       *pdata =3D data;
> +       *plen =3D len;
> +       return err;
>  }

Hi Juraj,

Thank you for your patch, but I prefer the code as it is currently
written.  I feel it is more maintainable to free the @data buffer at
the same time as we free the policy_load_memory struct which contains
the pointer to the @data buffer.

If there was a possibility that we could unify security_read_policy()
and security_read_state_kernel() then it might be worthwhile to
shuffle some of the allocations, but given the need to allocate a user
pointer in security_read_policy() and a desire preserve a level of
abstraction* between the security server and the rest of the SELinux
code I don't think this change is something I want to merge.  I'm
sorry.

* As time goes on, I'm less and less interested in preserving the
separation between the SELinux security server and the SELinux
Linux/hooks code, however there are some that feel strongly about this
so we'll stick with it for now.

--=20
paul-moore.com
