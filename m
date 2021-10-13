Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A69C433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB9360F3A
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhJMPm3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMPm2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 11:42:28 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98066C061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:40:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so4204711otr.7
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k+zf7i3EodIarc4aAoTxR5ws+KXKWS4Gg94iFaMd4wE=;
        b=Vbdj8KLlIvrmiRVGp+4/FFrjRhAdJRia8NsqS1Tyko6QN4W1NtVO3Fv/Pz+lpsZtWr
         2a8zlZM/GbQzrDJwm5jV/NPLEFxbpgmxJXjEUlx+J6UbwIu6f8TxinQngqYh44MWmQyq
         oty5b+KpIJ+8Nzf9Ll5iz5BAJLyFj8so+xWyrmT2j0bqSLiPWZoe+bkhMcHj3gl5GgWd
         w9LTO2v0OD54kF3QHzF04uQ4WvsqW/4zy/bw/kVxgcr2Z7FjG8ph3mBD91lKND5eVOuU
         +924axc7ncD5f51FWhr0N/8/64+swNi9y74jCkNM8ZbhciWTsOz/yT/9oimyUnfyChs4
         3C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+zf7i3EodIarc4aAoTxR5ws+KXKWS4Gg94iFaMd4wE=;
        b=dYBcTFpSLFB3nAZKqSplpJwOYjpKP3lriCC9ZDjO0UvFyrx1Gu6WI8F73isHOn6TD3
         JXghYL92BeR7426nXjxqiYQu/6XGyR2wE0MQ9/S8YDyUAll5e3SxJ1WNAG4fBBC7rbwP
         wg0WxYiJdphDGL0jHeFGwOz+P0sUkZ3oLuY4bdLWhQ1jP7tWuSTYZ0wyMUWu7UmRV3yf
         RH60WmyEj2AAWQmcezl4J6q9hmLi5rFLw9SRAfat5+hd0WOjpfyc+7Li0ZqTeFLt25IK
         /K6T1yAfICGYQFhAdS5Ry7+713s96OrRiw6s7GqPb+PlIPx+X09nsmPv8VsoBTXCshRp
         oloA==
X-Gm-Message-State: AOAM532Ft+dYPX252wt0t6fZVebZB9ejchqW0yPBsQJdbkcQfrXTqeGC
        njVO82Y8tx+mRos5V5PxwIuJEVk9lJTS08sl6Go=
X-Google-Smtp-Source: ABdhPJxneY4QLGmxBkCPIOKziCJV+0X+9RF7X1rVzOy3ff8VU+2Y4hJJPA0sY97i8tteQNELvoOjwl+Qu3YZwYq7+fw=
X-Received: by 2002:a9d:7182:: with SMTP id o2mr9507411otj.53.1634139624995;
 Wed, 13 Oct 2021 08:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-34-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-34-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Oct 2021 11:40:14 -0400
Message-ID: <CAP+JOzTXSBcinKpC8tW5Si1z0Z5ThZCMefjVCqrXFS=Pp23W7A@mail.gmail.com>
Subject: Re: [RFC PATCH 33/35] libsepol: validate categories
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check all categories have valid values, especially important for
> aliases.
>
>         =3D=3D7888=3D=3DERROR: AddressSanitizer: SEGV on unknown address =
0x602000400710 (pc 0x00000055debc bp 0x7ffe0ff2a9d0 sp 0x7ffe0ff2a8e0 T0)
>         =3D=3D7888=3D=3DThe signal is caused by a READ memory access.
>         #0 0x55debc in write_category_rules_to_conf ./libsepol/src/kernel=
_to_conf.c:946:9
>         #1 0x55debc in write_mls_rules_to_conf ./libsepol/src/kernel_to_c=
onf.c:1137:7
>         #2 0x55adb1 in sepol_kernel_policydb_to_conf ./libsepol/src/kerne=
l_to_conf.c:3106:7
>         #3 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:37:9
>         #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) fuzzer.o
>         #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) fuzzer.o
>         #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) fuzzer.o
>         #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #8 0x7fe80ccaf7ec in __libc_start_main csu/../csu/libc-start.c:33=
2:16
>         #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 860f9647..063bde18 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -465,6 +465,9 @@ static int validate_datum_arrays(sepol_handle_t *hand=
le, policydb_t *p, validate
>         if (hashtab_map(p->p_levels.table, validate_level, flavors))
>                 goto bad;
>
> +       if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CAT=
S]))
> +               goto bad;
> +

This should not be in this function. See the comments on patch 13.

Thanks,
Jim


>         return 0;
>
>  bad:
> --
> 2.33.0
>
