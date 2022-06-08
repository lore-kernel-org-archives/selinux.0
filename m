Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF77EC433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 17:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiFHRwK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiFHRwK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 13:52:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350C1038
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 10:52:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s8so23736825oib.6
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iUsNZk6WBVBqJY6hlv8/dtp5xEv4tV2ozWKO2I7G6eQ=;
        b=YS8qu+ZbjalnVcmtKHVhTYK6B8DMyhNZbGatccsqyc8m0g0Smsd6x1PKHp1tlkvpuq
         FHhk5N1YpFrj8NYhy8VTqbPhRyAPEt6lJYT4L5PZHHoPSFV3CfVJffDxYgFlBWkhzqDK
         1SlGFS9etdqLnBNQDomr3z1G1p4jympLiDfCHCW9fl0LPpEWqw0wVPgTrlfaz8q5EHtT
         iUenzk/LcCANi2tnyT9CYIxa/od1EgRu8WIIEj78aCNZWdiE+H1uMFtFQiARZzYRQTQl
         hb8AB3NPbsiwigMK4FZXKOIuQgn5+0Qx9HZAOl2YP4e5GjW69mwjymcEBwieMdtxBtys
         rJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iUsNZk6WBVBqJY6hlv8/dtp5xEv4tV2ozWKO2I7G6eQ=;
        b=vuSIK+HeejhY2SmaWuWIS8+qkbUriDWhiNOks7jcvzFl7DOqb/wpzPh+G6eJWa858P
         mrQ9t8PlRbXJvyUC5Jj1zn6kPfJwdZ5wBfBe1HfHzeByoFAQM/bz1Iv3hWmN8sKkxNJ9
         +gZAmZqRsYAmRDy0DGypWrfNUkRPq7lr2OllN+3faepAg+6zVd72GgwzO2QsvJxhpsEO
         Fuvk3LSAf1i/3A4IEsnWWrdwm6rfLuCik1J05tHYvE9Rf8vA+fT+awHSRWzn798aUl9G
         qhL01O+LhJ6GbT+Ay1YYwMAiqpBMawcAJAA53AAKtyXPVnJROM+KsQ53cXS8KC6vOPkM
         2uPg==
X-Gm-Message-State: AOAM533BWOsCKaoR1dFj6HDIn5UpEQBdx4cRVMxN41FRZ9HzPNWKoodC
        2Su4nkzAidLBXdaIzbhZHqWqNwbTiIjGnKezpF74efGQPR4=
X-Google-Smtp-Source: ABdhPJwG6yR3Fm0jR7FoQB89T5rzrCNQTkIKVxWvGSLWPT35bAIiuaj6laJfYbQtR71dO1RKwZJI8gd9UxtKneN3YkE=
X-Received: by 2002:a05:6808:208c:b0:32b:91e4:32e1 with SMTP id
 s12-20020a056808208c00b0032b91e432e1mr3111086oiw.182.1654710728518; Wed, 08
 Jun 2022 10:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220520130847.10958-1-cgzones@googlemail.com>
In-Reply-To: <20220520130847.10958-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 8 Jun 2022 13:51:57 -0400
Message-ID: <CAP+JOzSmYALmPjrKYaL4kLJY7RaY8+ypzR9evHmrWUih58vyHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: add man page redirections
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 20, 2022 at 9:36 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The following interfaces are documented but do not have a redirection:
>
>   - context_str(3)
>   - security_get_checkreqprot(3)
>   - security_set_boolean_list(3)
>   - selinux_sepgsql_context_path(3)
>   - setexecfilecon(3)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/man/man3/context_str.3                  | 1 +
>  libselinux/man/man3/security_get_checkreqprot.3    | 1 +
>  libselinux/man/man3/security_set_boolean_list.3    | 1 +
>  libselinux/man/man3/selinux_sepgsql_context_path.3 | 1 +
>  libselinux/man/man3/setexecfilecon.3               | 1 +
>  5 files changed, 5 insertions(+)
>  create mode 100644 libselinux/man/man3/context_str.3
>  create mode 100644 libselinux/man/man3/security_get_checkreqprot.3
>  create mode 100644 libselinux/man/man3/security_set_boolean_list.3
>  create mode 100644 libselinux/man/man3/selinux_sepgsql_context_path.3
>  create mode 100644 libselinux/man/man3/setexecfilecon.3
>
> diff --git a/libselinux/man/man3/context_str.3 b/libselinux/man/man3/cont=
ext_str.3
> new file mode 100644
> index 00000000..f4f03a6d
> --- /dev/null
> +++ b/libselinux/man/man3/context_str.3
> @@ -0,0 +1 @@
> +.so man3/context_new.3
> diff --git a/libselinux/man/man3/security_get_checkreqprot.3 b/libselinux=
/man/man3/security_get_checkreqprot.3
> new file mode 100644
> index 00000000..d59e5c2c
> --- /dev/null
> +++ b/libselinux/man/man3/security_get_checkreqprot.3
> @@ -0,0 +1 @@
> +.so man3/security_getenforce.3
> diff --git a/libselinux/man/man3/security_set_boolean_list.3 b/libselinux=
/man/man3/security_set_boolean_list.3
> new file mode 100644
> index 00000000..29731efa
> --- /dev/null
> +++ b/libselinux/man/man3/security_set_boolean_list.3
> @@ -0,0 +1 @@
> +.so man3/security_load_booleans.3
> diff --git a/libselinux/man/man3/selinux_sepgsql_context_path.3 b/libseli=
nux/man/man3/selinux_sepgsql_context_path.3
> new file mode 100644
> index 00000000..175a611a
> --- /dev/null
> +++ b/libselinux/man/man3/selinux_sepgsql_context_path.3
> @@ -0,0 +1 @@
> +.so man3/selinux_binary_policy_path.3
> diff --git a/libselinux/man/man3/setexecfilecon.3 b/libselinux/man/man3/s=
etexecfilecon.3
> new file mode 100644
> index 00000000..b2e6ab81
> --- /dev/null
> +++ b/libselinux/man/man3/setexecfilecon.3
> @@ -0,0 +1 @@
> +.so man3/getexeccon.3
> --
> 2.36.1
>
