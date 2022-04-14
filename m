Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ED5C4332F
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiDNOnP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352945AbiDNOea (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 10:34:30 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF08CF482
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 07:25:46 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bj24so95329oib.11
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jj9OEJTyWm3xDCCui8xZy8jF6aYNcjLzHCfjiakGvCU=;
        b=pZRCPMIjTlkZUGKo5UvQc0q6QOepdzihHwTQJD2p9ykGlndp26hRGkLZUXraXfggZ8
         hu9COXl/J3iW8yO7AfPNayHntZbhFXQqPB6HjwU9rZAqeTbWAhSLY4uswI20/tAGy/qv
         7Q1OLAW2CUMruqAURuxzpCvAe4oROQMI7tKq+rolzpfGQ8ZXz9v7Vx4FDe6UMdz6rre+
         cZsCkK73dHffMxtbI51TqSWwqMGXI0/SlRueFXLGXBKBRVeYPROvl1cYTMLtpwpc7yB6
         SqnWwqrNwrdqsHw7qSh5phaMZQyJ8HHFbNERKyohFhvarpw759+X/siSN6MZq99gnPIJ
         xgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jj9OEJTyWm3xDCCui8xZy8jF6aYNcjLzHCfjiakGvCU=;
        b=vBxkjd6Xf06iBiH+NqzIYf24f/blI72y4DxRM7qb3welU0xAroFeSVnKLxu1z90Ln0
         est917OxpeadX0lIke3fI2NPCZSC+ElLPcBIvkgFu8j/MKsnY2P0aAfisRukiQWJC6w0
         6TqDFPjyLnnSfN1C+5kh1JhJ4MmR3hYp5mNzTUMgRvh8imtbu5+mOyjWxaGKOViGowq7
         WBJK2hDdG9ZZk0hz8CdRo5jEFSxXQmq2msETMobhLPGJNBpRLqP/IoeZFoY/sseTG0Bq
         X6Xe32aE4QZAEoRe5/iX2Mc0nCa4UjB2mBgtGtM4YzHoGL91ArDfYWsw7ZsbkvPPhSxX
         euLw==
X-Gm-Message-State: AOAM532eAiZUrPAsI/MpQ8o46sTALVRr1sOYmS8kipZguovznRFpmlHE
        pJTb6TupDQYhjkM2PggSg+2hRmbT30gylb3MjxUeuVoenNA=
X-Google-Smtp-Source: ABdhPJwxDwSSAefUShdeYCFMNmOfz2QhUpDOt/i3MWGX1mlYtcSStdMxBP24neeUsAXw+LApqGKSnK772q4JUS5P1Q4=
X-Received: by 2002:a05:6808:14c1:b0:2fa:72d6:5dfa with SMTP id
 f1-20020a05680814c100b002fa72d65dfamr1436747oiw.182.1649946346155; Thu, 14
 Apr 2022 07:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220413160517.64145-1-cgzones@googlemail.com>
In-Reply-To: <20220413160517.64145-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 14 Apr 2022 10:25:35 -0400
Message-ID: <CAP+JOzTsbTBE9BC5+Oku_wQysYzcgcA63JBppb0zNWHaSM9knA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/tests: adjust IPv6 netmasks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 13, 2022 at 9:25 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> checkpolicy(8) since 01b88ac3 ("checkpolicy: warn on bogus IP address or
> netmask in nodecon statement") warns about host bits set in IPv6
> addresses.
> Adjust IPv6 netmasks in the libsepol tests so that the used address ::1
> does not set any host bits and running the tests does not print several
> of the following warnings:
>
>     net_contexts:15:WARNING 'host bits in ipv6 address set' at token '' o=
n line 594:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/tests/policies/test-deps/base-metreq.conf    | 2 +-
>  libsepol/tests/policies/test-deps/base-notmetreq.conf | 2 +-
>  libsepol/tests/policies/test-deps/small-base.conf     | 2 +-
>  libsepol/tests/policies/test-expander/alias-base.conf | 2 +-
>  libsepol/tests/policies/test-expander/role-base.conf  | 2 +-
>  libsepol/tests/policies/test-expander/small-base.conf | 2 +-
>  libsepol/tests/policies/test-expander/user-base.conf  | 2 +-
>  libsepol/tests/policies/test-hooks/cmp_policy.conf    | 2 +-
>  libsepol/tests/policies/test-hooks/small-base.conf    | 2 +-
>  libsepol/tests/policies/test-linker/small-base.conf   | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/libsepol/tests/policies/test-deps/base-metreq.conf b/libsepo=
l/tests/policies/test-deps/base-metreq.conf
> index 3e2f8407..b7528dde 100644
> --- a/libsepol/tests/policies/test-deps/base-metreq.conf
> +++ b/libsepol/tests/policies/test-deps/base-metreq.conf
> @@ -516,7 +516,7 @@ genfscon proc /                             gen_conte=
xt(system_u:object_r:sys_foo_t, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_=
t, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u=
:object_r:net_foo_t, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-deps/base-notmetreq.conf b/libs=
epol/tests/policies/test-deps/base-notmetreq.conf
> index 8ff3d204..eee36dca 100644
> --- a/libsepol/tests/policies/test-deps/base-notmetreq.conf
> +++ b/libsepol/tests/policies/test-deps/base-notmetreq.conf
> @@ -503,7 +503,7 @@ genfscon proc /                             gen_conte=
xt(system_u:object_r:sys_foo_t, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_=
t, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u=
:object_r:net_foo_t, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-deps/small-base.conf b/libsepol=
/tests/policies/test-deps/small-base.conf
> index 1411e624..98f49c23 100644
> --- a/libsepol/tests/policies/test-deps/small-base.conf
> +++ b/libsepol/tests/policies/test-deps/small-base.conf
> @@ -504,7 +504,7 @@ genfscon proc /                             gen_conte=
xt(system_u:object_r:sys_foo_t, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_=
t, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u=
:object_r:net_foo_t, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-expander/alias-base.conf b/libs=
epol/tests/policies/test-expander/alias-base.conf
> index 57d4520e..b950039d 100644
> --- a/libsepol/tests/policies/test-expander/alias-base.conf
> +++ b/libsepol/tests/policies/test-expander/alias-base.conf
> @@ -494,7 +494,7 @@ genfscon proc /                             gen_conte=
xt(system_u:object_r:system_t, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system_t=
, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u=
:object_r:system_t, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-expander/role-base.conf b/libse=
pol/tests/policies/test-expander/role-base.conf
> index a603390b..8e88b4be 100644
> --- a/libsepol/tests/policies/test-expander/role-base.conf
> +++ b/libsepol/tests/policies/test-expander/role-base.conf
> @@ -476,7 +476,7 @@ genfscon proc /                             gen_conte=
xt(system_u:object_r:system_t, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system_t=
, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u=
:object_r:system_t, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-expander/small-base.conf b/libs=
epol/tests/policies/test-expander/small-base.conf
> index 20005e3f..055ea054 100644
> --- a/libsepol/tests/policies/test-expander/small-base.conf
> +++ b/libsepol/tests/policies/test-expander/small-base.conf
> @@ -714,7 +714,7 @@ genfscon proc /                             gen_conte=
xt(system_u:object_r:sys_foo_t, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_=
t, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u=
:object_r:net_foo_t, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-expander/user-base.conf b/libse=
pol/tests/policies/test-expander/user-base.conf
> index 1f84fd76..b31ee8cd 100644
> --- a/libsepol/tests/policies/test-expander/user-base.conf
> +++ b/libsepol/tests/policies/test-expander/user-base.conf
> @@ -480,7 +480,7 @@ genfscon proc /                             gen_conte=
xt(system_u:object_r:system_t, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system_t=
, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u=
:object_r:system_t, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-hooks/cmp_policy.conf b/libsepo=
l/tests/policies/test-hooks/cmp_policy.conf
> index 1eccf4a8..9082b333 100644
> --- a/libsepol/tests/policies/test-hooks/cmp_policy.conf
> +++ b/libsepol/tests/policies/test-hooks/cmp_policy.conf
> @@ -464,7 +464,7 @@ genfscon proc /                             gen_conte=
xt(g_b_user_1:object_r:g_b_type_1, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_ty=
pe_1, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_user=
_1:object_r:g_b_type_1, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-hooks/small-base.conf b/libsepo=
l/tests/policies/test-hooks/small-base.conf
> index 1eccf4a8..9082b333 100644
> --- a/libsepol/tests/policies/test-hooks/small-base.conf
> +++ b/libsepol/tests/policies/test-hooks/small-base.conf
> @@ -464,7 +464,7 @@ genfscon proc /                             gen_conte=
xt(g_b_user_1:object_r:g_b_type_1, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_ty=
pe_1, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_user=
_1:object_r:g_b_type_1, s0)
>
>
>
> diff --git a/libsepol/tests/policies/test-linker/small-base.conf b/libsep=
ol/tests/policies/test-linker/small-base.conf
> index 2bc14656..890ebbeb 100644
> --- a/libsepol/tests/policies/test-linker/small-base.conf
> +++ b/libsepol/tests/policies/test-linker/small-base.conf
> @@ -593,7 +593,7 @@ genfscon proc /                             gen_conte=
xt(g_b_user_1:object_r:g_b_type_1, s0)
>  #
>  #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
>
> -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_ty=
pe_1, s0)
> +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_user=
_1:object_r:g_b_type_1, s0)
>
>
>
> --
> 2.35.2
>
