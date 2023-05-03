Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFFBC77B78
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 18:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjECSgS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 14:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECSgR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 14:36:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3A12680
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 11:36:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so58147931fa.0
        for <selinux@vger.kernel.org>; Wed, 03 May 2023 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138974; x=1685730974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzFBjHA9/WyOIBGv96GMBXK4aNIGloMXnUJbAtJaHNA=;
        b=rj/FYQRufw/PAArKxaFEJ1CNwvN6hc4v3WEj4xkrzfH0LS0QkSruYGiArnJdAxVTQJ
         8ujaCCxC7pcrcaQC9SHXPVMpPZwC6gTh4ycKOGF020yjk2qquxRWd/bxG+s4js0hoVF/
         3Mynt903KzGnYHUqrndl8vwLNSkt8u95LBLQQbhcggFk5HMl+E6Ea2Z7RD+5swsAfJSm
         kxvvCCpu5FSjgnvOv1t1D/VZzChSPEyEWVbEAb7JEK9Xp5YNPwiT75TZ/J/4wf4m8Qwk
         rFZRjzty4L/hPj0L/1tUvkGWofncyrHdxHN4StANav6yH55RJQYVkAGe/4UXgAfvNVhY
         xB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138974; x=1685730974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzFBjHA9/WyOIBGv96GMBXK4aNIGloMXnUJbAtJaHNA=;
        b=SV7rYB6VC4TLQ5KzhvKQ3iuyFAq/Zhv48P4yClsU0fuCPTu3d89Q0095PkEcsaZiyI
         8+8ZVmiQRwx+edtm7rZQKavJlAN/QVTR/4UzbnXF/gDWLUCXE/zU62Gh0LLXcg/7USBB
         rztQX6kOPEZ6+oESwQmMNkLiM4wsT/SkSNHxYyjXSx3W9Hmm0SlN3YG4skXau2Ip8ysm
         Gs5wLvGnKFGqy1IhQ0vGHoTqItR/mEYnDbwSzNg/bbcNxB9OuHOb9Et6/xAOd4WY2ReQ
         u1i4gx/9o+VHDr/g2LkQC82oOAPE+Gnw6QaVDKNM0BOHAfeo9y3f+lyV7TiPXm18nsW4
         lmeA==
X-Gm-Message-State: AC+VfDw7O+mg7BNLGoHxtvCs6ckdLyaTG7ZWiKPSGXzeOBpy/WrLWE04
        4Xt2B4y/7yGha04zlSgDBEIPTvWLzIpFU07nxvc=
X-Google-Smtp-Source: ACHHUZ7mkCbXhc59IVg9nPZUpMY/CpHwaAF94FUtPkzLDSdyHoIoZNERuiP/BjfxbIvclIK5VGqjsBFUqem+9zAQRFU=
X-Received: by 2002:a2e:9bc4:0:b0:2a8:b129:f735 with SMTP id
 w4-20020a2e9bc4000000b002a8b129f735mr238187ljj.28.1683138973649; Wed, 03 May
 2023 11:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230503120332.699464-1-vmojzis@redhat.com> <20230503120332.699464-3-vmojzis@redhat.com>
In-Reply-To: <20230503120332.699464-3-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 3 May 2023 14:36:02 -0400
Message-ID: <CAP+JOzRMumhq7ycQhQcFXef1DMhR73LxoQR9VL+GCm=p0au+Kw@mail.gmail.com>
Subject: Re: [PATCH 2/3] python/audit2allow: Add missing options to man page
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 3, 2023 at 8:11=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> ---
>  python/audit2allow/audit2allow.1 | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2=
allow.1
> index 04ec3239..b7d30918 100644
> --- a/python/audit2allow/audit2allow.1
> +++ b/python/audit2allow/audit2allow.1
> @@ -40,26 +40,36 @@
>  Read input from audit and message log, conflicts with \-i
>  .TP
>  .B "\-b" | "\-\-boot"
> -Read input from audit messages since last boot conflicts with \-i
> +Read input from audit messages since last boot, conflicts with \-i
>  .TP
>  .B "\-d" | "\-\-dmesg"
> -Read input from output of
> +Read input from output of
>  .I /bin/dmesg.
>  Note that all audit messages are not available via dmesg when
>  auditd is running; use "ausearch \-m avc | audit2allow"  or "\-a" instea=
d.
>  .TP
> +.B "\-\-debug"
> +Leave generated modules for -M

I know that this is what it says in the usage of audit2allow, but I
have no idea what it means or what "--debug" actually does.
Thanks,
Jim

> +.TP
>  .B "\-D" | "\-\-dontaudit"
>  Generate dontaudit rules (Default: allow)
>  .TP
> +.B "\-e" | "\-\-explain"
> +Fully explain generated output
> +.TP
>  .B "\-h" | "\-\-help"
>  Print a short usage message
>  .TP
>  .B "\-i  <inputfile>" | "\-\-input <inputfile>"
> -read input from
> +Read input from
>  .I <inputfile>
>  .TP
> +.B "\-\-interface-info=3D<interface_info_file>"
> +Read interface information from
> +.I <interface_info_file>
> +.TP
>  .B "\-l" | "\-\-lastreload"
> -read input only after last policy reload
> +Read input only after last policy reload
>  .TP
>  .B "\-m <modulename>" | "\-\-module <modulename>"
>  Generate module/require output <modulename>
> @@ -70,8 +80,12 @@ Generate loadable module package, conflicts with \-o
>  .B "\-p <policyfile>"  | "\-\-policy <policyfile>"
>  Policy file to use for analysis
>  .TP
> +.B "\-\-perm-map <perm_map_file>"
> +Read permission map from
> +.I <perm_map_file>
> +.TP
>  .B "\-o <outputfile>"  | "\-\-output <outputfile>"
> -append output to
> +Append output to
>  .I <outputfile>
>  .TP
>  .B "\-r" | "\-\-requires"
> @@ -85,6 +99,9 @@ This is the default behavior.
>  Generate reference policy using installed macros.
>  This attempts to match denials against interfaces and may be inaccurate.
>  .TP
> +.B "\-t <type_regex>" | "\-\-type=3D<type_regex>"
> +Only process messages with a type that matches this regex
> +.TP
>  .B "\-x" | "\-\-xperms"
>  Generate extended permission access vector rules
>  .TP
> --
> 2.40.0
>
