Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA66C433F5
	for <selinux@archiver.kernel.org>; Mon, 21 Feb 2022 18:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiBUSMr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:12:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiBUSLZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Feb 2022 13:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C418713CF7
        for <selinux@vger.kernel.org>; Mon, 21 Feb 2022 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645466504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41XatzLhvaE9rHmob+cZ8fY8LpjwIPidXSLaJlvbF2I=;
        b=UW2gollL6ZgxATrBH5ty9a0NW64Eak+bfFHUjHXHfqpLvvO663tMp9AOiyD2ewf6gyKVn3
        OhT6pCoaUODLF7dq2xAdMm/qjcqHLjDD+1YlNUclAk/nPbHo1qL/Dc7+ihJBTQTIVpHzrH
        CbSHfgfW2k8GVu0Jo9ExCzdqL8/hvbI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-ApsCBt-wNdqUZDKTLMTX6g-1; Mon, 21 Feb 2022 13:01:42 -0500
X-MC-Unique: ApsCBt-wNdqUZDKTLMTX6g-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-2d07ae11464so117811117b3.14
        for <selinux@vger.kernel.org>; Mon, 21 Feb 2022 10:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=41XatzLhvaE9rHmob+cZ8fY8LpjwIPidXSLaJlvbF2I=;
        b=fkYV1jDisiyWwh4z/W1d6H8JAaRd3soaEupDVLBZlwGbqrhLB3jSRnvA8Tt1qW6ks8
         rBusG4Z2oAVJQaV4WzOE1gJjNHFLay66EyxGT/KGfwkhKEhzr66JSQlfx9Mxq1ol0qbw
         3kdnq76Hik4zXshPRe2Nnb8qRKcm2aDpcB12c1JIk9ihto1C1QYUpl7Vp9Sgork7DmuV
         WXvuwGnAdBRFgajktjWwXUleyGnO4BAmaFSHoRjIkPxmoUqqnyIsTLHWomerzqKms4Fe
         /tSqzH7F25V2RPQIGOThtnogxuXj7uL9zGfEeKy2c/TQYNJIznJwpeYEGRz5OMzFb8ma
         s6fA==
X-Gm-Message-State: AOAM533asSl7lkd+CKYjLtvQ/+qWPFetiFYk1nsQrDQumTexjS8E9VYa
        zhIQhejXtisq9Ee+TwEw1WZCPfDMYjFZSNmVALJdCaZWqA18HHSifKbH8tpLnM+gEmCCnWdYUvC
        hkJN/ObopyPFCPaLSwxg2TpJDGTgpl/oWkg==
X-Received: by 2002:a25:748e:0:b0:624:3bae:fa32 with SMTP id p136-20020a25748e000000b006243baefa32mr18261205ybc.255.1645466501945;
        Mon, 21 Feb 2022 10:01:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9B5jpcKW70Th9lNFZknI5FCU8tcP2qTRsfSssNi/bQ/Lih7JPn8AvuFfH/PTTPOKT51f46k0CLTtK2aFv/fI=
X-Received: by 2002:a25:748e:0:b0:624:3bae:fa32 with SMTP id
 p136-20020a25748e000000b006243baefa32mr18261186ybc.255.1645466501745; Mon, 21
 Feb 2022 10:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20220218210815.107961-1-omosnace@redhat.com>
In-Reply-To: <20220218210815.107961-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 21 Feb 2022 19:01:31 +0100
Message-ID: <CAFqZXNtXx5QsUQcwqDTSWubcro6kXrzzRXhdmFuAv3boR3WPKg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: use new API if version >= 0.6
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 18, 2022 at 10:08 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> In version 0.7 the old API is deprecated and without this patch the
> testsuite fails to build with -Werror with this version.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/bpf/bpf_common.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
> index f499034..88aae2f 100644
> --- a/tests/bpf/bpf_common.c
> +++ b/tests/bpf/bpf_common.c
> @@ -1,12 +1,28 @@
>  #include "bpf_common.h"
>
> +/*
> + * v0.7 deprecates some functions in favor of a new API (introduced in v0.6).
> + * Make this work with both to satisfy -Werror (and older distros).
> + */
> +#if defined(LIBBPF_MAJOR_VERSION)
> +#if LIBBPF_MAJOR_VERSION > 0 || (LIBBPF_MAJOR_VERSION == 0 && \
> +       LIBBPF_MINOR_VERSION > 6)
> +#define USE_NEW_API
> +#endif
> +#endif
> +
>  int create_bpf_map(void)
>  {
>         int map_fd, key;
>         long long value = 0;
>
> +#ifdef USE_NEW_API
> +       map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(key),
> +                               sizeof(value), 256, NULL);
> +#else
>         map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key),
>                                 sizeof(value), 256, 0);
> +#endif
>         if (map_fd < 0) {
>                 fprintf(stderr, "Failed to create BPF map: %s\n",
>                         strerror(errno));
> @@ -18,17 +34,20 @@ int create_bpf_map(void)
>
>  int create_bpf_prog(void)
>  {
> -       int prog_fd;
> -       size_t insns_cnt;
> -
>         struct bpf_insn prog[] = {
>                 BPF_MOV64_IMM(BPF_REG_0, 1),
>                 BPF_EXIT_INSN(),
>         };
> -       insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
> +       size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
> +       int prog_fd;
>
> +#ifdef USE_NEW_API
> +       prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPF",

Now merged, with the "General Protection Fault license" typo fixed :)

https://github.com/SELinuxProject/selinux-testsuite/commit/92c29366dffad9e8b1ef621d4fc07816ed121efe

> +                               prog, insns_cnt, NULL);
> +#else
>         prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
>                                    insns_cnt, "GPL", 0, NULL, 0);
> +#endif
>
>         if (prog_fd < 0) {
>                 fprintf(stderr, "Failed to load BPF prog: %s\n",
> --
> 2.35.1
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

