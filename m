Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9037EC07E95
	for <selinux@archiver.kernel.org>; Fri,  2 Jul 2021 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693DD613D8
	for <selinux@archiver.kernel.org>; Fri,  2 Jul 2021 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhGBUjR convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Fri, 2 Jul 2021 16:39:17 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34902 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhGBUjR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jul 2021 16:39:17 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 74D6A564819
        for <selinux@vger.kernel.org>; Fri,  2 Jul 2021 22:36:42 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id w22so6423487pff.5
        for <selinux@vger.kernel.org>; Fri, 02 Jul 2021 13:36:42 -0700 (PDT)
X-Gm-Message-State: AOAM53006pqnbmvTd7fM+ekJRUhrSUoIWUGVB0rfSAkPWwpmTHzNKs/Z
        DR2Zvkrs4q1VnmfvbMb729+S9nAEWseNplr/sdM=
X-Google-Smtp-Source: ABdhPJy42uwfAH+6/fUvDuFBWKxzuu5oB8ueLHVkGeFKQ93Q69QsVQLWtlrA95hfhNbuPQaLMM/baUl/hElKqJ3vd6s=
X-Received: by 2002:a65:60d3:: with SMTP id r19mr1807448pgv.94.1625258201148;
 Fri, 02 Jul 2021 13:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210701183430.145934-1-cgzones@googlemail.com> <20210701183833.146592-1-cgzones@googlemail.com>
In-Reply-To: <20210701183833.146592-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 2 Jul 2021 22:36:29 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k5+wSxrmBtTH91Fw6AHO4z-=wYqm2OFEzDtQXLei0=eg@mail.gmail.com>
Message-ID: <CAJfZ7=k5+wSxrmBtTH91Fw6AHO4z-=wYqm2OFEzDtQXLei0=eg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: avoid unsigned integer overflow
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Jul  2 22:36:42 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 1, 2021 at 8:38 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Unsigned integer overflow is well-defined and not undefined behavior.
> But it is still useful to enable undefined behavior sanitizer checks on
> unsigned arithmetic to detect possible issues on counters or variables
> with similar purpose.
>
> Use a spaceship operator like comparison instead of subtraction.
>
> Modern compilers will generate a single comparison instruction instead
> of actually perform the subtraction.
>
>     policydb.c:851:24: runtime error: unsigned integer overflow: 801 - 929 cannot be represented in type 'unsigned int'
>
> This is similar to 1537ea84.

While I agree with the change, I still see subtractions in gcc 11.1
and clang 12. What do you call "modern compilers"?

More precisely, I copied the function rangetr_cmp in Godbolt and
compiled it with "x86-64 gcc 11.1" and -O2,
https://godbolt.org/z/5c4jG7eeh . The generated assembly code
contains:

    mov eax, DWORD PTR [rsi]
    cmp DWORD PTR [rdi], eax
    seta al
    movzx eax, al
    sbb eax, 0
    test eax, eax
    jne .L1

This really computes a subtraction, with instruction SBB. For people
not familiar with x86_64 assembly language:

* the first two instructions compare two values,
* SETA sets the 8-bit register AL to 1 if the first value was above
the other one,
* MOVZX ensures that the 32-bit register EAX contains 0 or 1,
* SBB computes the subtraction between EAX and the carry flag, which
is one only if the first value was below the other one.
* TEST checks whether the result of the subtraction is zero.

For information, the previous code generated the following instructions:

    mov eax, DWORD PTR [rdi]
    sub eax, DWORD PTR [rsi]
    jne .L1

So the previous code generated simpler assembler instructions, but
which could trigger an undefined behavior in C.

TL;DR Anyway, as this change is not about performance but about
undefined behaviour in C, it looks good to me. Nevertheless the
sentence "Modern compilers will generate a single comparison
instruction instead of actually perform the subtraction." seems to be
wrong. Could you rephrase it (for example by giving examples of such
compilers), or remove it?

Thanks,
Nicolas

PS: about the integer overflow itself, I read
https://wiki.sei.cmu.edu/confluence/display/c/INT30-C.+Ensure+that+unsigned+integer+operations+do+not+wrap
too, which seems to be clear that subtracting two unsigned integers
and expecting the subtraction to wrap is something which should be
avoided.

> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index ef2217c2..5ee78b4c 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -843,15 +843,15 @@ static int rangetr_cmp(hashtab_t h __attribute__ ((unused)),
>         const struct range_trans *key2 = (const struct range_trans *)k2;
>         int v;
>
> -       v = key1->source_type - key2->source_type;
> +       v = (key1->source_type > key2->source_type) - (key1->source_type < key2->source_type);
>         if (v)
>                 return v;
>
> -       v = key1->target_type - key2->target_type;
> +       v = (key1->target_type > key2->target_type) - (key1->target_type < key2->target_type);
>         if (v)
>                 return v;
>
> -       v = key1->target_class - key2->target_class;
> +       v = (key1->target_class > key2->target_class) - (key1->target_class < key2->target_class);
>
>         return v;
>  }
> --
> 2.32.0
>

