Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D8BC433EF
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4183363217
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbhKOWyy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353336AbhKOWfi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 17:35:38 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF4C04A4A3
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 13:48:48 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m6so37780429oim.2
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 13:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=py/CXex18SAcFRZJmvl67h4q/xDxVFNRc6DMs/MUloI=;
        b=VTtzAiIhSpbrUYRcpVTLayO02ulbSCV/dFgiJCxdO3EprzSccODG1iq5H5mhCWnZ6a
         ju9nPuXhIgm0lenufamt7IRnqkAPkXkgc1FmuPDS//e4O4Dt63lMDNdALOWt4ILex/rx
         zOcSikiMQIcyEjTQOVMT1uN3VqMbDOR8wJ2BwnIhG2wG8pwmOHb3RRNGhsNkmSIkhNLn
         5JC1qL0CtIb10kFdZ0pBO2wrHl4k+a75o7c2PeFtkJ8dSdVtG1twQh7TI1x0QUy2ffDa
         yzIJsXke7rl/363M/AizZLkpZJjzxwZf9qC0mhCvFhjPVmD63zi8tD4+jN/iyXyoHJff
         Gimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=py/CXex18SAcFRZJmvl67h4q/xDxVFNRc6DMs/MUloI=;
        b=P0q1DwIcSCYt8RRqnSfcs+p4ccmgK5NiRwRVLL0O4+Aey3QO6Jg3MLHY7HzQrIgd6o
         /KLCEy0d4/j9wJ6qFkCwYL1NVCiF9hU5GL6qZrrkrBGAqcFW3RylMb0hm/6ZozudGfA2
         SWCMThPGBafM8ru3OdsdetJxzoOFWk3/Wkdkx/4o7lqfNL4fXRlxFVLMdK87wl55NHwP
         nQC+4fdpdkanLy7NFblptMdJw2rUHOAS5In+rGM6jnuHyspEKLWMMn3TObKrNioToNfh
         Pwnqi2Ri448L5aLlaIkJkSmL1kblHYwoe09Zmb3GqiMa49aZGl2sAAOsqmArz32rTwjw
         obSw==
X-Gm-Message-State: AOAM530eomKhT1eBTbsd0xOQHRZgdVII17EVYullqrT3xjyYLQDZItJD
        sa5OL/Xd/7LaTlWz5ihS+FNI8u3ZbOzgNnrclU0=
X-Google-Smtp-Source: ABdhPJxMiYLBQvlMViS7lJV2nRU6g8N8xxs3N3MCgU5DDlnfdAUa6tdmBNtjAP3P5Nq4Z6Xlc28DUIjiK4WPA/ICmV8=
X-Received: by 2002:a54:4d05:: with SMTP id v5mr1903096oix.16.1637012927673;
 Mon, 15 Nov 2021 13:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20211112154201.78217-1-cgzones@googlemail.com>
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Nov 2021 16:48:36 -0500
Message-ID: <CAP+JOzSNQbg_a+0Yu4NU0ki_0zrXBU_R_fh9Zrn_Twf8=_HTJw@mail.gmail.com>
Subject: Re: [PATCH 01/12] checkpolicy: use correct unsigned format specifiers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 12, 2021 at 10:42 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The two variables policydb_lineno and source_lineno are both of the type
> unsigned long; use the appropriate format specifier.
>
> Found by Cppcheck
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For all 12 patches.
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_scan.l | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 129a8a2a..ef9f1899 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -308,11 +308,11 @@ GLBLUB                            { return(GLBLUB);=
 }
>  int yyerror(const char *msg)
>  {
>         if (source_file[0])
> -               fprintf(stderr, "%s:%ld:",
> +               fprintf(stderr, "%s:%lu:",
>                         source_file, source_lineno);
>         else
>                 fprintf(stderr, "(unknown source)::");
> -       fprintf(stderr, "ERROR '%s' at token '%s' on line %ld:\n%s\n%s\n"=
,
> +       fprintf(stderr, "ERROR '%s' at token '%s' on line %lu:\n%s\n%s\n"=
,
>                         msg,
>                         yytext,
>                         policydb_lineno,
> @@ -327,11 +327,11 @@ int yywarn(const char *msg)
>                 return yyerror(msg);
>
>         if (source_file[0])
> -               fprintf(stderr, "%s:%ld:",
> +               fprintf(stderr, "%s:%lu:",
>                         source_file, source_lineno);
>         else
>                 fprintf(stderr, "(unknown source)::");
> -       fprintf(stderr, "WARNING '%s' at token '%s' on line %ld:\n%s\n%s\=
n",
> +       fprintf(stderr, "WARNING '%s' at token '%s' on line %lu:\n%s\n%s\=
n",
>                         msg,
>                         yytext,
>                         policydb_lineno,
> --
> 2.33.1
>
