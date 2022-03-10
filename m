Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D15C433EF
	for <selinux@archiver.kernel.org>; Thu, 10 Mar 2022 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiCJSed (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiCJSec (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Mar 2022 13:34:32 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C035197B59
        for <selinux@vger.kernel.org>; Thu, 10 Mar 2022 10:33:31 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso7792458ooc.7
        for <selinux@vger.kernel.org>; Thu, 10 Mar 2022 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBGzNBAEZ/o4Hxo+uV30uwr7f7xAZh3RxENsMZgnKwE=;
        b=YWq2YmGPEjPzN/0Anh2o8quUQmd2p8YILYIC3WdSr+dycheGdQ3JgdItX7azDeBm0o
         XHfNWAC7ThFHHfxulTZH9UaEAGsuMt8HN5zDMX3MC1+XELFeTsZqy7ErCTldU0US3Vyf
         Ku8Fm2ekr2bV2Ibx4b2Pr70FDAvLUKNdH3pe3MGZ7a7nbFMQ+CryHNEjaeqzB34s3ekV
         blezwL/Voeo8XdWEMPWrDh/KQzs9t5e2iKnODnVGFjgL0y7YEPsO/Elpg7ihJMp2Ec/H
         QYGpzRm7h11WqEUmRcpHdmq7fK9/zKM6AX7j+lg9yQUR44l+ZUBXZK2QnWRbDaCmIDbh
         gt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBGzNBAEZ/o4Hxo+uV30uwr7f7xAZh3RxENsMZgnKwE=;
        b=xJWKAsiw8aqBsv20dz/FF4w+J882d2gkQEX/VUEb/ekYac84VJuDRb1Ijh88AFvnFi
         7ynhoOdAFTXqrrHqzk8T3T1rF01hpGvCpItU7C7cCXcbEaHfe4purAV4nNdYI3xzccg8
         V7tmR6efTwyVahkLxp0EwNZO393Q0Ef4nhoRgS1gyqxEkJ3XufyBbVmyDLAeAGNCdeVj
         QrELWXF6NdzXW/QBHLwwPACqYFTR+2BBU//xMEHTiluFNthWNsKW3KWxuNpMKab/eeLb
         IW3inkLd74SgwFcQd+Sx/451p93vKB0kSETvtWEoY2eB1Hwfdkr++fmQ6Sb02PaLv8DB
         2Mqw==
X-Gm-Message-State: AOAM530N4gU+UOcfEo6LriC7Ww5CtUnnrAOsJQDlsFG6El+ZGaIR7vXI
        zItvv5PF+twKw0qgKrf9t/8aXYdNTfuB3Y2byLQ7qghdEZE=
X-Google-Smtp-Source: ABdhPJyBIz+l3Tx4UK4jqJtBpzk2aAwVStLqKygE7o7aGv6Ty5Ro0Di3sBs0kEQz9ZUDmJZPQLQOaGwJPJixiJrOtr8=
X-Received: by 2002:a05:6870:5a4:b0:da:b3f:3206 with SMTP id
 m36-20020a05687005a400b000da0b3f3206mr3570177oap.182.1646937210685; Thu, 10
 Mar 2022 10:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20220307105417.11913-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220307105417.11913-1-richard_c_haines@btinternet.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 10 Mar 2022 13:33:19 -0500
Message-ID: <CAP+JOzTa7t-LjQfTSqs5QFRvYaOpR95+jk_Xd5MoLu7otjqrmQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Shorten the policy capability enum names
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 8, 2022 at 10:02 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Shorten "CAPABILITY" to "CAP" following the kernel naming convention.
>
> The SELinux policy capability enum names should now follow the
> "POLICYDB_CAP_XXX" format.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/polcaps.h | 20 ++++++++++----------
>  libsepol/src/polcaps.c                    | 20 ++++++++++----------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> index 39c99839..f5e32e60 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -7,17 +7,17 @@ extern "C" {
>
>  /* Policy capabilities */
>  enum {
> -       POLICYDB_CAPABILITY_NETPEER,
> -       POLICYDB_CAPABILITY_OPENPERM,
> -       POLICYDB_CAPABILITY_EXTSOCKCLASS,
> -       POLICYDB_CAPABILITY_ALWAYSNETWORK,
> -       POLICYDB_CAPABILITY_CGROUPSECLABEL,
> -       POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> -       POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> -       POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
> -       __POLICYDB_CAPABILITY_MAX
> +       POLICYDB_CAP_NETPEER,
> +       POLICYDB_CAP_OPENPERM,
> +       POLICYDB_CAP_EXTSOCKCLASS,
> +       POLICYDB_CAP_ALWAYSNETWORK,
> +       POLICYDB_CAP_CGROUPSECLABEL,
> +       POLICYDB_CAP_NNP_NOSUID_TRANSITION,
> +       POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
> +       POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> +       __POLICYDB_CAP_MAX
>  };
> -#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> +#define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
>
>  /* Convert a capability name to number. */
>  extern int sepol_polcap_getnum(const char *name);
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index a5e515f2..687e971c 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -6,14 +6,14 @@
>  #include <sepol/policydb/polcaps.h>
>
>  static const char * const polcap_names[] = {
> -       "network_peer_controls",        /* POLICYDB_CAPABILITY_NETPEER */
> -       "open_perms",                   /* POLICYDB_CAPABILITY_OPENPERM */
> -       "extended_socket_class",        /* POLICYDB_CAPABILITY_EXTSOCKCLASS */
> -       "always_check_network",         /* POLICYDB_CAPABILITY_ALWAYSNETWORK */
> -       "cgroup_seclabel",              /* POLICYDB_CAPABILITY_SECLABEL */
> -       "nnp_nosuid_transition",        /* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
> -       "genfs_seclabel_symlinks",      /* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
> -       "ioctl_skip_cloexec",           /* POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC */
> +       "network_peer_controls",        /* POLICYDB_CAP_NETPEER */
> +       "open_perms",                   /* POLICYDB_CAP_OPENPERM */
> +       "extended_socket_class",        /* POLICYDB_CAP_EXTSOCKCLASS */
> +       "always_check_network",         /* POLICYDB_CAP_ALWAYSNETWORK */
> +       "cgroup_seclabel",              /* POLICYDB_CAP_SECLABEL */
> +       "nnp_nosuid_transition",        /* POLICYDB_CAP_NNP_NOSUID_TRANSITION */
> +       "genfs_seclabel_symlinks",      /* POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS */
> +       "ioctl_skip_cloexec",           /* POLICYDB_CAP_IOCTL_SKIP_CLOEXEC */
>         NULL
>  };
>
> @@ -21,7 +21,7 @@ int sepol_polcap_getnum(const char *name)
>  {
>         int capnum;
>
> -       for (capnum = 0; capnum <= POLICYDB_CAPABILITY_MAX; capnum++) {
> +       for (capnum = 0; capnum <= POLICYDB_CAP_MAX; capnum++) {
>                 if (polcap_names[capnum] == NULL)
>                         continue;
>                 if (strcasecmp(polcap_names[capnum], name) == 0)
> @@ -32,7 +32,7 @@ int sepol_polcap_getnum(const char *name)
>
>  const char *sepol_polcap_getname(unsigned int capnum)
>  {
> -       if (capnum > POLICYDB_CAPABILITY_MAX)
> +       if (capnum > POLICYDB_CAP_MAX)
>                 return NULL;
>
>         return polcap_names[capnum];
> --
> 2.35.1
>
