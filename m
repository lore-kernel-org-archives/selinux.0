Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B95C433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 16:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiBRQN6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:13:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiBRQN5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 11:13:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36613C242
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 08:13:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a23so16184145eju.3
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 08:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/gwC4bHRIUcSmFZT9uFBPhpMuizFhmgAEkJI/24KZZA=;
        b=SpNNtNFHQA2/1GYEtVOybDgFDXU1mx66Kr19Or0dQymEGAZ0wnqq5mjyUFd8w7EUPl
         /gYWk/B6lqXCJqEG80bZYsW82GEccd3Ktr91AmA2V3eJhfqVerMf2Hmx/vLOlNg9sQxh
         sR8yqNV9fp++DcQlT8pIebpwYENUpToWZUjrLM2H2meQqLFdwt7cF6aW43n+n9flXoWn
         NBHNSIpaY/cHB+kjs5ExznkuFDcXuwbQtOuPd3WuxCCeHcg6cs38Jp3FPLeycSHNI8xI
         gUNOGibfvVSA7xvyTLG0388qHZcrGVTg9sZJ1/9MTyChKE4Tyz6swWaa3/GKiti41cIV
         uiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/gwC4bHRIUcSmFZT9uFBPhpMuizFhmgAEkJI/24KZZA=;
        b=gY7v6oCcBqAUMj+EvKiwCfcdg05S0ZBCqgIUDa0mKVBBPA5gX+FmwkF5K20tKFN7cQ
         Gwr39PCGxGwgGn0rA6J9q87+JVXYFguZ7/eShiZE6qlezfor04PZh+rDV74P7WTzTSWz
         OTItVNZvCAuTyAR3ip7F5NuRDuv6Hoin8OeFJEt4Y2oGBUmaFQat6tNGJlEeF2NJAn2i
         0biRlGhKa4Zn+481+7rts0GRJmNKQXPUiYdpADRL20LJqdNYGAngmWTR80ZhqyIq8q9L
         R70rprLdWZlatLme/qLAuYf2XgE1PBa4RawiyMJSndC5CgqD67F1oz1ZDas9auxyh2iV
         mSsQ==
X-Gm-Message-State: AOAM531UbCGKOcajW5mKHP1cP29zGJvH5nBSqk/5SwmZLeTxvzA4Le9c
        sqxyt2fOboHCWQ3QWFvD/0gLss2I/XYFoAa0QtLB
X-Google-Smtp-Source: ABdhPJwfLu2AVHkXTP/KsJf25nvpYv+OIT3wySs7qBTBv+dcFHrlzw5xHDR+oh7tnMLK4SVmS000xwXCiaxJ/g/3G5g=
X-Received: by 2002:a17:906:3901:b0:6b2:9fc6:9b2 with SMTP id
 f1-20020a170906390100b006b29fc609b2mr6836636eje.327.1645200818564; Fri, 18
 Feb 2022 08:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-3-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-3-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 11:13:26 -0500
Message-ID: <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: declare data arrays const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The arrays for the policy capability names, the initial sid identifiers
> and the class and permission names are not changed at runtime.  Declare
> them const to avoid accidental modification.
>
> The build time script genheaders needs to be exempted, since it converts
> the entries to uppercase.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  scripts/selinux/genheaders/genheaders.c          | 2 ++
>  scripts/selinux/mdp/mdp.c                        | 4 ++--
>  security/selinux/avc.c                           | 2 +-
>  security/selinux/include/avc_ss.h                | 2 +-
>  security/selinux/include/classmap.h              | 8 +++++++-
>  security/selinux/include/initial_sid_to_string.h | 9 ++++++++-
>  security/selinux/include/policycap.h             | 2 +-
>  security/selinux/include/policycap_names.h       | 2 +-
>  security/selinux/ss/services.c                   | 4 ++--
>  9 files changed, 25 insertions(+), 10 deletions(-)

...

> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/ge=
nheaders/genheaders.c
> index f355b3e0e968..5f7c0b7d9260 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -15,6 +15,8 @@ struct security_class_mapping {
>         const char *perms[sizeof(unsigned) * 8 + 1];
>  };
>
> +/* Allow to convert entries in mappings to uppercase */
> +#define __SELINUX_GENHEADERS__
>  #include "classmap.h"
>  #include "initial_sid_to_string.h"

...

> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 35aac62a662e..07ade4af85ff 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -2,6 +2,12 @@
>  #include <linux/capability.h>
>  #include <linux/socket.h>
>
> +#ifdef __SELINUX_GENHEADERS__
> +# define const_qual
> +#else
> +# define const_qual const
> +#endif
> +
>  #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
>      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", =
"map"
>
> @@ -38,7 +44,7 @@
>   * Note: The name for any socket class should be suffixed by "socket",
>   *      and doesn't contain more than one substr of "socket".
>   */
> -struct security_class_mapping secclass_map[] =3D {
> +const_qual struct security_class_mapping secclass_map[] =3D {
>         { "security",
>           { "compute_av", "compute_create", "compute_member",
>             "check_context", "load_policy", "compute_relabel",

...

> diff --git a/security/selinux/include/initial_sid_to_string.h b/security/=
selinux/include/initial_sid_to_string.h
> index 5d332aeb8b6c..915283cd89bd 100644
> --- a/security/selinux/include/initial_sid_to_string.h
> +++ b/security/selinux/include/initial_sid_to_string.h
> @@ -1,5 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -static const char *initial_sid_to_string[] =3D
> +
> +#ifdef __SELINUX_GENHEADERS__
> +# define const_qual
> +#else
> +# define const_qual const
> +#endif
> +
> +static const char *const_qual initial_sid_to_string[] =3D
>  {
>         NULL,
>         "kernel",

Thanks for this Christian.  I generally like when we can const'ify
things like this, but I'm not excited about the const_qual hack on
core SELinux kernel code to satisfy genheaders.c.  I understand why it
is needed, but I would rather clutter the genheaders.c code than the
core SELinux kernel code.  If we can't cast away the const'ification
in genheaders.c could we simply allocate duplicate arrays in
genheaders.c and store the transformed strings into the new arrays?

--=20
paul-moore.com
