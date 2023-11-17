Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89488C197A0
	for <selinux@archiver.kernel.org>; Fri, 17 Nov 2023 15:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjKQP13 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQP13 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Nov 2023 10:27:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEFA8
        for <selinux@vger.kernel.org>; Fri, 17 Nov 2023 07:27:24 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507adc3381cso2775791e87.3
        for <selinux@vger.kernel.org>; Fri, 17 Nov 2023 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234842; x=1700839642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24s7nqfKSt2+/v87+KvgSDtZoQLvEPiEPqtzHddRv/A=;
        b=abiPBmKwdKKsLII0/YngApYUR2Aj1mOiuvXETIh7DOzggIRgJufdro+8qTEtaWhh1b
         +lI/3phona3KYIjJSmqvCN1osMbtfiBt4c9pBbhZOMgkc7XkK8TXQnOBAGE45d12QwjO
         S1V6WqHlcW8WUD3WBj70Wd+9K+PG3AO/nSO/WyBbMuUwBnT+nofEKHr6/smTveypTsql
         lJnWzmzR1VFiXSOclbfktzfq4hRyqX7PAcTFmkS1SJmOtqMd+TY+3nucD8n6Vf2HLwOI
         6y2PoRIXYYjOFBUPu0AUyBAqj+pruHRvzt87iVpfEVpeXzkqQe+2bV9BDJKq3jbgfOrq
         /Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234842; x=1700839642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24s7nqfKSt2+/v87+KvgSDtZoQLvEPiEPqtzHddRv/A=;
        b=J/8iB1BXYsWordOMManUOAuEUdlhBTNDWdixV5ByFbt0ZenrwjBzjSTLdw6G16bZse
         fpnn8fJD7uLNUZFYLbwBjcsyL1XLaUgmerRvivt3iYRMYCZM/z88B5v4cBCzx/Mz7Kmx
         osnquDiePe3jOu38hXwsPGqJo4mm07s+SlLFgjo6i16bEnHIuFEE04Y9TWgwY3v6L98w
         xPRBotC5GRaKgeEnc8nfThfZuZxVNFurpyisac4NtaLCm97e0mNS9xbBHL2VyoHyfxyj
         U914x25MvBr9Y0fduWY1ZVhSeDfbhUW4OK/7FYcAKmNyJ4hqjHJzvQyBsesbRfpdODY7
         QNMQ==
X-Gm-Message-State: AOJu0YzCKwfXqdewhTYNHR9MWvXQWTbN1T29YeYMnrJYysvxbeiil0UO
        7yZHIJI1k+jz0/olrzjnmR13BIzkoLXB55xKnEQ1HWWJ
X-Google-Smtp-Source: AGHT+IHL8TDlgg83/mQbCCKH9+NMcrJ1XwjihYnMW7QUwjbbSzLvalnRqz41aCHfAZkr2dfPwXxxUqDn8ZZ28MO1O6M=
X-Received: by 2002:a05:6512:3055:b0:50a:a2d6:972a with SMTP id
 b21-20020a056512305500b0050aa2d6972amr626577lfb.33.1700234841778; Fri, 17 Nov
 2023 07:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20231109132944.3338574-1-jwcart2@gmail.com>
In-Reply-To: <20231109132944.3338574-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 17 Nov 2023 10:28:13 -0500
Message-ID: <CAP+JOzTQ=qxb=mAX17PLZizKW4JCepVrGEK1+ZUR5=J-=Q2gvw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/tests: Update the order of neverallow test results
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 9, 2023 at 8:29=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> The patch set [1] by Christian G=C3=B6ttsche <cgzones@googlemail.com> to
> use the DJB2a hash function caused the ordering of the reported
> neverallow failures to change in the libsepol tests.
>
> Change the expected test results to reflect the new ordering.
>
> [1] https://lore.kernel.org/all/20230816123845.80171-1-cgzones@googlemail=
.com/
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Unless there are objections, I plan on merging this patch along with
Christian's hash function patches next week.
Jim

> ---
>  libsepol/tests/test-neverallow.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-never=
allow.c
> index c0a2bfa8..7d6ad00e 100644
> --- a/libsepol/tests/test-neverallow.c
> +++ b/libsepol/tests/test-neverallow.c
> @@ -101,10 +101,10 @@ static void test_neverallow_basic(void)
>                 "neverallow on line 81 of policies/test-neverallow/policy=
.conf.std (or line 81 of policies/test-neverallow/policy.conf.std) violated=
 by allow test5_t test5_t:file { read };",
>                 "neverallow on line 89 of policies/test-neverallow/policy=
.conf.std (or line 89 of policies/test-neverallow/policy.conf.std) violated=
 by allow test6_1_t test6_1_t:file { read };",
>                 "neverallow on line 97 of policies/test-neverallow/policy=
.conf.std (or line 97 of policies/test-neverallow/policy.conf.std) violated=
 by allow test7_1_t test7_1_t:file { read };",
> -               "neverallow on line 106 of policies/test-neverallow/polic=
y.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test8_t test8_t:file { write };",
>                 "neverallow on line 106 of policies/test-neverallow/polic=
y.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test8_t test8_t:file { read };",
> -               "neverallow on line 115 of policies/test-neverallow/polic=
y.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test9_t test9_t:file { read };",
> +               "neverallow on line 106 of policies/test-neverallow/polic=
y.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test8_t test8_t:file { write };",
>                 "neverallow on line 115 of policies/test-neverallow/polic=
y.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test9_t test9_t:file { write };",
> +               "neverallow on line 115 of policies/test-neverallow/polic=
y.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test9_t test9_t:file { read };",
>                 "neverallow on line 124 of policies/test-neverallow/polic=
y.conf.std (or line 124 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test10_1_t test10_1_t:file { read };",
>                 "neverallow on line 131 of policies/test-neverallow/polic=
y.conf.std (or line 131 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test11_t test11_t:process { dyntransition transition };",
>                 "neverallow on line 143 of policies/test-neverallow/polic=
y.conf.std (or line 143 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test12_3_t test12_1_t:file { getattr };",
> @@ -162,22 +162,22 @@ static void test_neverallow_minus_self(void)
>                 "33 neverallow failures occurred",
>                 "neverallow on line 77 of policies/test-neverallow/policy=
_minus_self.conf.std (or line 77 of policies/test-neverallow/policy_minus_s=
elf.conf.std) violated by allow test3_1_t test3_2_t:file { read };",
>                 "neverallow on line 85 of policies/test-neverallow/policy=
_minus_self.conf.std (or line 85 of policies/test-neverallow/policy_minus_s=
elf.conf.std) violated by allow test4_1_t test4_2_t:file { read };",
> -               "neverallow on line 93 of policies/test-neverallow/policy=
_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus_s=
elf.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
>                 "neverallow on line 93 of policies/test-neverallow/policy=
_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus_s=
elf.conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
> +               "neverallow on line 93 of policies/test-neverallow/policy=
_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus_s=
elf.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
>                 "neverallow on line 101 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 101 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
>                 "neverallow on line 118 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 118 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
>                 "neverallow on line 127 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 127 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
>                 "neverallow on line 137 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 137 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
>                 "neverallow on line 157 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 157 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
>                 "neverallow on line 166 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 166 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> -               "neverallow on line 175 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
>                 "neverallow on line 175 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
> -               "neverallow on line 193 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
> +               "neverallow on line 175 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
>                 "neverallow on line 193 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
> +               "neverallow on line 193 of policies/test-neverallow/polic=
y_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
>                 "neverallowxperm on line 201 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 201 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioc=
tl };",
>                 "neverallowxperm on line 219 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 219 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioc=
tl { 0x101-0x102 };",
> -               "neverallowxperm on line 231 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioc=
tl { 0x102 };",
>                 "neverallowxperm on line 231 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioc=
tl { 0x103 };",
> +               "neverallowxperm on line 231 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioc=
tl { 0x102 };",
>                 "neverallowxperm on line 261 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 261 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioc=
tl { 0x9511 };",
>                 "neverallowxperm on line 272 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 272 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl=
 { 0x9511 };",
>                 "neverallowxperm on line 283 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 283 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl {=
 0x9511 };",
> @@ -185,10 +185,10 @@ static void test_neverallow_minus_self(void)
>                 "neverallowxperm on line 295 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioc=
tl { 0x9511 };",
>                 "neverallowxperm on line 295 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioc=
tl { 0x9511 };",
>                 "neverallowxperm on line 295 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioc=
tl { 0x9511 };",
> -               "neverallowxperm on line 317 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioc=
tl { 0x9521 };",
>                 "neverallowxperm on line 317 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl =
};",
> -               "neverallowxperm on line 327 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl=
 { 0x9521 };",
> +               "neverallowxperm on line 317 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioc=
tl { 0x9521 };",
>                 "neverallowxperm on line 327 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl =
};",
> +               "neverallowxperm on line 327 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl=
 { 0x9521 };",
>                 "neverallowxperm on line 337 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl {=
 0x9521 };",
>                 "neverallowxperm on line 337 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl {=
 0x9521 };",
>                 "neverallowxperm on line 348 of policies/test-neverallow/=
policy_minus_self.conf.std (or line 348 of policies/test-neverallow/policy_=
minus_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioc=
tl { 0x9521 };",
> @@ -231,23 +231,23 @@ static void test_neverallow_not_self(void)
>                 "34 neverallow failures occurred",
>                 "neverallow on line 78 of policies/test-neverallow/policy=
_not_self.conf.std (or line 78 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test3_1_t test3_2_t:file { read };",
>                 "neverallow on line 86 of policies/test-neverallow/policy=
_not_self.conf.std (or line 86 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test4_1_t test4_2_t:file { read };",
> -               "neverallow on line 94 of policies/test-neverallow/policy=
_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
>                 "neverallow on line 94 of policies/test-neverallow/policy=
_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
> +               "neverallow on line 94 of policies/test-neverallow/policy=
_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
>                 "neverallow on line 102 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 102 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
>                 "neverallow on line 119 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 119 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
>                 "neverallow on line 128 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 128 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
>                 "neverallow on line 138 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 138 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
>                 "neverallow on line 158 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 158 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
>                 "neverallow on line 167 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 167 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> -               "neverallow on line 176 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
>                 "neverallow on line 176 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
> +               "neverallow on line 176 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
>                 "neverallow on line 185 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 185 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> -               "neverallow on line 194 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
>                 "neverallow on line 194 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
> +               "neverallow on line 194 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
>                 "neverallowxperm on line 202 of policies/test-neverallow/=
policy_not_self.conf.std (or line 202 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioctl }=
;",
>                 "neverallowxperm on line 220 of policies/test-neverallow/=
policy_not_self.conf.std (or line 220 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioctl {=
 0x101-0x102 };",
> -               "neverallowxperm on line 232 of policies/test-neverallow/=
policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl {=
 0x102 };",
>                 "neverallowxperm on line 232 of policies/test-neverallow/=
policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioctl {=
 0x103 };",
> +               "neverallowxperm on line 232 of policies/test-neverallow/=
policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl {=
 0x102 };",
>                 "neverallowxperm on line 262 of policies/test-neverallow/=
policy_not_self.conf.std (or line 262 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioctl {=
 0x9511 };",
>                 "neverallowxperm on line 273 of policies/test-neverallow/=
policy_not_self.conf.std (or line 273 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl { 0=
x9511 };",
>                 "neverallowxperm on line 284 of policies/test-neverallow/=
policy_not_self.conf.std (or line 284 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl { 0x9=
511 };",
> @@ -255,10 +255,10 @@ static void test_neverallow_not_self(void)
>                 "neverallowxperm on line 296 of policies/test-neverallow/=
policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl {=
 0x9511 };",
>                 "neverallowxperm on line 296 of policies/test-neverallow/=
policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl {=
 0x9511 };",
>                 "neverallowxperm on line 296 of policies/test-neverallow/=
policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl {=
 0x9511 };",
> -               "neverallowxperm on line 318 of policies/test-neverallow/=
policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl {=
 0x9521 };",
>                 "neverallowxperm on line 318 of policies/test-neverallow/=
policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl };",
> -               "neverallowxperm on line 328 of policies/test-neverallow/=
policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0=
x9521 };",
> +               "neverallowxperm on line 318 of policies/test-neverallow/=
policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl {=
 0x9521 };",
>                 "neverallowxperm on line 328 of policies/test-neverallow/=
policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl };",
> +               "neverallowxperm on line 328 of policies/test-neverallow/=
policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0=
x9521 };",
>                 "neverallowxperm on line 338 of policies/test-neverallow/=
policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9=
521 };",
>                 "neverallowxperm on line 338 of policies/test-neverallow/=
policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9=
521 };",
>                 "neverallowxperm on line 349 of policies/test-neverallow/=
policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl {=
 0x9521 };",
> --
> 2.41.0
>
