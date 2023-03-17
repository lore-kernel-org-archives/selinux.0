Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032E7C6FD1D
	for <selinux@archiver.kernel.org>; Fri, 17 Mar 2023 13:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCQNB2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Mar 2023 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCQNB1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Mar 2023 09:01:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488EA9DC7
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 06:01:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id p6so2845068pga.0
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679058085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ0ap9ZW2EX8mn+BiDAQUWzB5dBly5pwEKS9sqdjLlY=;
        b=pPqgMGcCIgSMFy6HUDFV2JyjEgC+CG+rBhy0LvIVmcJSxlOciYTX34hvhJynPWy58j
         3z8owXpKag2XxZP8/szufDO7vjEZpHyq8ZPtfrdWq6d/vgKhqL8CcJXjMEXry603UKCv
         +SjJvvutfivDXBcOcxslWmNDxPHFA1MqSFelY80MuKM8g+04VNdPxB4KqldNPf0Cy56B
         Y0ux6GEQTxy5bETMevs1wCg8cB13HfmabEI5swvdjWEp9CLCnDutBvOR+/nDrzfSdBdD
         2HCEhLQlUI4hkrTkU3rlgzsQjawpJBKh3l3Hmtk9nzyJjo8gWmYZh8OV6Dpb7z2D7KRb
         L56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679058085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ0ap9ZW2EX8mn+BiDAQUWzB5dBly5pwEKS9sqdjLlY=;
        b=vnrRdFdus8gknQU1NlP2SjNJ/DR2pUQHMerGASpOC5lriLAv/+2+fIn56K6LcL5bWH
         gc590xIubR0MX15kWqGSHdtN+11WFAi3xq9YXn/vSlvqQ2TkPLvi/gKfon6j2KP7RayK
         SMX7hXWz7DRaLrds80Ib7+yjZ62welcxx3lJT7ZTJ8LV1cvfu/8Ng/tROfw/pV/K5o/Y
         XPVro1Qy4Tq1GSM4mgjWLO0IfPs49QhVgNPgM2ZM8c9Yqhr5mXYWIT6klwqrcpga6Kur
         dgWw1+csSwkNGh5xMKoP2d9ThIOGFujoJV2SphYwN/RbHQ9AdKJ6rhiKxXkr3TLPcCPI
         rFWA==
X-Gm-Message-State: AO0yUKU/iVic3ELZ3EEhBWWrFEezNKWx+w0/ddhGpaxb939DylVIJVsL
        RvmB8c5oUKEmvpFrqZd6X9fEJ8mbq6pL4NwneHLXBk24
X-Google-Smtp-Source: AK7set8G+kYqJDb4envV9Hukblk4lw4Jckaf+hnwIgNS+Pm3TW3MFbVRlCzDc4oGG6gZzlmWbXGKeD+sJQ18LNRI3OY=
X-Received: by 2002:aa7:9e02:0:b0:625:9327:7686 with SMTP id
 y2-20020aa79e02000000b0062593277686mr1345629pfq.2.1679058084976; Fri, 17 Mar
 2023 06:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230309143741.346749-1-omosnace@redhat.com>
In-Reply-To: <20230309143741.346749-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 17 Mar 2023 09:01:13 -0400
Message-ID: <CAEjxPJ6Ft_BZ2pLAdhgS+XPZdKgVrxGYUdZM=VZQ0THR0RQvvw@mail.gmail.com>
Subject: Re: [PATCH userspace] libsemanage: include more parameters in the
 module checksum
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 9, 2023 at 9:41=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> The check_ext_changes option currently assumes that as long as the
> module content is unchanged, it is safe to assume that the policy.linked
> file doesn't need to be rebuilt. However, there are some additional
> parameters that can affect the content of this policy file, namely:
> * the disable_dontaudit and preserve_tunables flags
> * the target_platform and policyvers configuration values
>
> Include these in the checksum so that the option works correctly when
> only some of these input values are changed versus the current state.
>
> Fixes: 286a679fadc4 ("libsemanage: optionally rebuild policy when modules=
 are changed externally")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Feel free to merge it. I was wondering if we ought to somehow unify
the logic around do_rebuild and check_ext_changes to ensure that an
update to one is also reflected in the other but that can be done
later. I don't think do_rebuild currently is set based on
target_platform or policyvers, likely because we don't ever change the
former and we only change the latter for libsepol upgrades that
support newer kernel policy versions and the kernel will cheerfully
accept the older policy versions (and the new policy version likely
won't be leveraged until there is an actual change to a policy module
to use some new feature).

> ---
>  libsemanage/src/direct_api.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 7aa081ab..d740070d 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -863,6 +863,14 @@ static void update_checksum_with_len(Sha256Context *=
context, size_t s)
>         Sha256Update(context, buffer, 8);
>  }
>
> +static void update_checksum_with_bool(Sha256Context *context, bool b)
> +{
> +       uint8_t byte;
> +
> +       byte =3D b ? UINT8_C(1) : UINT8_C(0);
> +       Sha256Update(context, &byte, 1);
> +}
> +
>  static int semanage_compile_module(semanage_handle_t *sh,
>                                    semanage_module_info_t *modinfo,
>                                    Sha256Context *context)
> @@ -977,13 +985,21 @@ static int modinfo_cmp(const void *a, const void *b=
)
>         return strcmp(ma->name, mb->name);
>  }
>
> +struct extra_checksum_params {
> +       int disable_dontaudit;
> +       int preserve_tunables;
> +       int target_platform;
> +       int policyvers;
> +};
> +
>  static int semanage_compile_hll_modules(semanage_handle_t *sh,
>                                         semanage_module_info_t *modinfos,
>                                         int num_modinfos,
> +                                       const struct extra_checksum_param=
s *extra,
>                                         char *cil_checksum)
>  {
>         /* to be incremented when checksum input data format changes */
> -       static const size_t CHECKSUM_EPOCH =3D 1;
> +       static const size_t CHECKSUM_EPOCH =3D 2;
>
>         int i, status =3D 0;
>         char cil_path[PATH_MAX];
> @@ -1000,6 +1016,10 @@ static int semanage_compile_hll_modules(semanage_h=
andle_t *sh,
>
>         Sha256Initialise(&context);
>         update_checksum_with_len(&context, CHECKSUM_EPOCH);
> +       update_checksum_with_bool(&context, !!extra->disable_dontaudit);
> +       update_checksum_with_bool(&context, !!extra->preserve_tunables);
> +       update_checksum_with_len(&context, (size_t)extra->target_platform=
);
> +       update_checksum_with_len(&context, (size_t)extra->policyvers);
>
>         /* prefix with module count to avoid collisions */
>         update_checksum_with_len(&context, num_modinfos);
> @@ -1134,6 +1154,7 @@ static int semanage_direct_commit(semanage_handle_t=
 * sh)
>         mode_t mask =3D umask(0077);
>         struct stat sb;
>         char modules_checksum[CHECKSUM_CONTENT_SIZE + 1 /* '\0' */];
> +       struct extra_checksum_params extra;
>
>         int do_rebuild, do_write_kernel, do_install;
>         int fcontexts_modified, ports_modified, seusers_modified,
> @@ -1274,8 +1295,14 @@ static int semanage_direct_commit(semanage_handle_=
t * sh)
>                         goto cleanup;
>                 }
>
> +               extra =3D (struct extra_checksum_params){
> +                       .disable_dontaudit =3D sepol_get_disable_dontaudi=
t(sh->sepolh),
> +                       .preserve_tunables =3D sepol_get_preserve_tunable=
s(sh->sepolh),
> +                       .target_platform =3D sh->conf->target_platform,
> +                       .policyvers =3D sh->conf->policyvers,
> +               };
>                 retval =3D semanage_compile_hll_modules(sh, modinfos, num=
_modinfos,
> -                                                     modules_checksum);
> +                                                     &extra, modules_che=
cksum);
>                 if (retval < 0) {
>                         ERR(sh, "Failed to compile hll files into cil fil=
es.\n");
>                         goto cleanup;
> --
> 2.39.2
>
